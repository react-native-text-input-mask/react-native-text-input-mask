package com.RNTextInputMask

import android.text.TextWatcher
import android.view.View
import android.view.View.OnFocusChangeListener
import android.widget.EditText
import com.facebook.react.bridge.*
import com.facebook.react.uimanager.UIManagerModule
import com.redmadrobot.inputmask.MaskedTextChangedListener
import com.redmadrobot.inputmask.helper.AffinityCalculationStrategy
import com.redmadrobot.inputmask.helper.Mask
import com.redmadrobot.inputmask.model.CaretString
import com.redmadrobot.inputmask.model.CaretString.CaretGravity.*
import com.redmadrobot.inputmask.model.Notation
import java.lang.IllegalArgumentException
import java.lang.NullPointerException

class RNTextInputMaskModule(private val context: ReactApplicationContext) : ReactContextBaseJavaModule(context) {
    override fun getName() = "RNTextInputMask"

    @ReactMethod
    fun mask(maskString: String?,
             inputValue: String,
             autocomplete: Boolean,
             promise: Promise) {
        val mask = Mask(maskString!!)
        val result = mask.apply(
            CaretString(
                inputValue,
                inputValue.length,
                FORWARD(autocomplete)
            )
        )
        val output: String = result.formattedText.string
        promise.resolve(output)
    }

    @ReactMethod
    fun unmask(maskString: String?,
               inputValue: String,
               autocomplete: Boolean,
               promise: Promise) {
        val mask = Mask(maskString!!)
        val result = mask.apply(
            CaretString(
                inputValue,
                inputValue.length,
                FORWARD(autocomplete)
            )
        )
        val output: String = result.extractedValue
        promise.resolve(output)
    }

    @ReactMethod
    fun setMask(tag: Int, primaryFormat: String, options: ReadableMap) {
        // We need to use prependUIBlock instead of addUIBlock since subsequent UI operations in
        // the queue might be removing the view we're looking to update.
        context.getNativeModule(UIManagerModule::class.java)!!.prependUIBlock { nativeViewHierarchyManager -> // The view needs to be resolved before running on the UI thread because there's
            // a delay before the UI queue can pick up the runnable.
            val editText = nativeViewHierarchyManager.resolveView(tag) as EditText
            val affineFormats = options.stringList("affineFormats")
            val customNotations = options.list("customNotations") { array, index ->
                val raw = array.getMap(index) ?: throw IllegalArgumentException("could not parse notation")
                Notation(
                    character = raw.string("character")?.first()
                        ?: throw IllegalArgumentException("character is required for notation"),
                    characterSet = raw.string("characterSet")
                        ?: throw IllegalArgumentException("characterSet is required for notation"),
                    isOptional = raw.boolean("isOptional")
                        ?: throw IllegalArgumentException("isOptional is required for notation")
                )
            }
            val affinityCalculationStrategy = options.getString("affinityCalculationStrategy")?.let { AffinityCalculationStrategy.valueOf(it) }
            val autocomplete = options.boolean("autocomplete")
            val autoskip = options.boolean("autoskip")
            val rightToLeft = options.boolean("rightToLeft")
            context.runOnUiQueueThread {
                OnlyChangeIfRequiredMaskedTextChangedListener.install(
                    primaryFormat = primaryFormat,
                    affineFormats = affineFormats ?: emptyList(),
                    customNotations = customNotations ?: emptyList(),
                    affinityCalculationStrategy = affinityCalculationStrategy
                        ?: AffinityCalculationStrategy.WHOLE_STRING,
                    autocomplete = autocomplete ?: true,
                    autoskip = autoskip ?: false,
                    field = editText,
                    rightToLeft = rightToLeft ?: false
                )
            }
        }
    }
}

fun ReadableMap.string(key: String): String? = this.getString(key)
fun ReadableMap.boolean(key: String): Boolean? = if (this.hasKey(key)) this.getBoolean(key) else null
fun <T> ReadableMap.list(key: String, mapper: (array: ReadableArray, index: Int) -> T): List<T>? {
    val array = this.getArray(key) ?: return null
    return (0 until array.size()).map { mapper(array, it) }
}

fun ReadableMap.stringList(key: String): List<String>? {
    return this.list(key) { array, index ->
        array.getString(index) ?: throw NullPointerException()
    }
}

/**
 * Need to extend MaskedTextChangedListener to ignore re-masking previous text (causes weird input behavior in React Native)
 */
internal class OnlyChangeIfRequiredMaskedTextChangedListener(
    primaryFormat: String,
    affineFormats: List<String>,
    customNotations: List<Notation>,
    affinityCalculationStrategy: AffinityCalculationStrategy,
    autocomplete: Boolean,
    autoskip: Boolean,
    field: EditText,
    rightToLeft: Boolean,
    private val focusChangeListener: OnFocusChangeListener
) : MaskedTextChangedListener(
    primaryFormat = primaryFormat,
    affineFormats = affineFormats,
    customNotations = customNotations,
    affinityCalculationStrategy = affinityCalculationStrategy,
    autocomplete = autocomplete,
    autoskip = autoskip,
    field = field,
    rightToLeft = rightToLeft
) {
    private var previousText: String? = null
    override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
        previousText = s?.toString()
        super.beforeTextChanged(s, start, count, after)
    }

    override fun onTextChanged(text: CharSequence, cursorPosition: Int, before: Int, count: Int) {
        val newText = text.substring(cursorPosition, cursorPosition + count)
        val oldText = previousText?.substring(cursorPosition, cursorPosition + before)
        // temporarily disable autocomplete if updated text is same as previous text,
        // this is to prevent autocomplete when deleting as value is set multiple times from RN
        val disableAutoComplete = this.autocomplete && count == before && newText == oldText
        if (disableAutoComplete) {
            this.autocomplete = false
        }
        super.onTextChanged(text, cursorPosition, before, count)
        if (disableAutoComplete) {
            this.autocomplete = true
        }
    }

    override fun onFocusChange(view: View?, hasFocus: Boolean) {
        super.onFocusChange(view, hasFocus)
        focusChangeListener.onFocusChange(view, hasFocus)
    }

    companion object {
        private const val TEXT_CHANGE_LISTENER_TAG_KEY = 123456789
        fun install(
            primaryFormat: String,
            affineFormats: List<String> = emptyList(),
            customNotations: List<Notation> = emptyList(),
            affinityCalculationStrategy: AffinityCalculationStrategy = AffinityCalculationStrategy.WHOLE_STRING,
            autocomplete: Boolean = true,
            autoskip: Boolean = false,
            field: EditText,
            rightToLeft: Boolean = false
        ) {
            if (field.getTag(TEXT_CHANGE_LISTENER_TAG_KEY) != null) {
                field.removeTextChangedListener(field.getTag(TEXT_CHANGE_LISTENER_TAG_KEY) as TextWatcher)
            }
            val listener: MaskedTextChangedListener = OnlyChangeIfRequiredMaskedTextChangedListener(
                primaryFormat = primaryFormat,
                affineFormats = affineFormats,
                customNotations = customNotations,
                affinityCalculationStrategy = affinityCalculationStrategy,
                autocomplete = autocomplete,
                autoskip = autoskip,
                field = field,
                rightToLeft = rightToLeft,
                focusChangeListener = field.onFocusChangeListener
            )
            field.addTextChangedListener(listener)
            field.onFocusChangeListener = listener
            field.setTag(TEXT_CHANGE_LISTENER_TAG_KEY, listener)
        }
    }
}
