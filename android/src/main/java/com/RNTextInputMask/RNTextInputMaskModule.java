package com.RNTextInputMask;

import android.text.TextWatcher;
import android.view.View;
import android.widget.EditText;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.uimanager.NativeViewHierarchyManager;
import com.facebook.react.uimanager.UIBlock;
import com.facebook.react.uimanager.UIManagerModule;
import com.redmadrobot.inputmask.MaskedTextChangedListener;
import com.redmadrobot.inputmask.helper.AffinityCalculationStrategy;
import com.redmadrobot.inputmask.helper.Mask;
import com.redmadrobot.inputmask.model.CaretString;
import com.redmadrobot.inputmask.model.Notation;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.Collections;

public class RNTextInputMaskModule extends ReactContextBaseJavaModule {
    ReactApplicationContext reactContext;

    public RNTextInputMaskModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "RNTextInputMask";
    }

    @ReactMethod
    public void mask(final String maskString,
                     final String inputValue,
                     final boolean autocomplete,
                     final Promise promise) {
      final Mask mask = new Mask(maskString);
      final String input = inputValue;
      final Mask.Result result = mask.apply(
          new CaretString(
              input,
              input.length(),
              new CaretString.CaretGravity.FORWARD(autocomplete)
          )
      );
      final String output = result.getFormattedText().getString();
      promise.resolve(output);
    }

    @ReactMethod
    public void unmask(final String maskString,
                       final String inputValue,
                       final boolean autocomplete,
                       final Promise promise) {
      final Mask mask = new Mask(maskString);
      final String input = inputValue;
      final Mask.Result result = mask.apply(
          new CaretString(
              input,
              input.length(),
              new CaretString.CaretGravity.FORWARD(autocomplete)
          )
      );
      final String output = result.getExtractedValue();
      promise.resolve(output);
    }

    @ReactMethod
    public void setMask(final int tag, final String mask, final boolean autocomplete, final boolean autoskip) {
        // We need to use prependUIBlock instead of addUIBlock since subsequent UI operations in
        // the queue might be removing the view we're looking to update.
        reactContext.getNativeModule(UIManagerModule.class).prependUIBlock(new UIBlock() {
            @Override
            public void execute(NativeViewHierarchyManager nativeViewHierarchyManager) {
                // The view needs to be resolved before running on the UI thread because there's
                // a delay before the UI queue can pick up the runnable.
                final EditText editText = (EditText) nativeViewHierarchyManager.resolveView(tag);

                reactContext.runOnUiQueueThread(new Runnable() {
                    @Override
                    public void run() {
                        OnlyChangeIfRequiredMaskedTextChangedListener.install(editText, mask, autocomplete, autoskip);
                    }
                });
            }
        });
    }
}

/**
 * Need to extend MaskedTextChangedListener to ignore re-masking previous text (causes weird input behavior in React Native)
 */
class OnlyChangeIfRequiredMaskedTextChangedListener extends MaskedTextChangedListener {
    private static final int TEXT_CHANGE_LISTENER_TAG_KEY = 123456789;

    private String previousText;
    private View.OnFocusChangeListener focusChangeListener;
    public OnlyChangeIfRequiredMaskedTextChangedListener(@NotNull String primaryFormat, boolean autocomplete, boolean autoskip, @NotNull EditText field, View.OnFocusChangeListener focusChangeListener) {
        super(primaryFormat, Collections.<String>emptyList(), Collections.<Notation>emptyList(), AffinityCalculationStrategy.WHOLE_STRING, autocomplete, autoskip, field, null, null, false);
        this.focusChangeListener = focusChangeListener;
    }

    @Override
    public void beforeTextChanged(@Nullable CharSequence s, int start, int count, int after) {
        previousText = s.toString();
        super.beforeTextChanged(s, start, count, after);
    }

    @Override
    public void onTextChanged(@NotNull final CharSequence s, final int start, final int before, final int count) {
        if (count == 0 && before == 0) {
            return;
        }

        String newText = s.toString().substring(start, start + count);
        String oldText = previousText.substring(start, start + before);

        if (count == before && newText.equals(oldText)) {
            return;
        }
        super.onTextChanged(s, start, before, count);
    }

    @Override
    public void onFocusChange(@Nullable View view, boolean hasFocus) {
        super.onFocusChange(view, hasFocus);
        this.focusChangeListener.onFocusChange(view, hasFocus);
    }

    public static void install(EditText editText, @NotNull String primaryFormat, boolean autocomplete, boolean autoskip) {
        if (editText.getTag(TEXT_CHANGE_LISTENER_TAG_KEY) != null) {
            editText.removeTextChangedListener((TextWatcher) editText.getTag(TEXT_CHANGE_LISTENER_TAG_KEY));
        }
        MaskedTextChangedListener listener = new OnlyChangeIfRequiredMaskedTextChangedListener(primaryFormat, autocomplete, autoskip, editText, editText.getOnFocusChangeListener());
        editText.addTextChangedListener(listener);
        editText.setOnFocusChangeListener(listener);
        editText.setTag(TEXT_CHANGE_LISTENER_TAG_KEY, listener);
    }
}
