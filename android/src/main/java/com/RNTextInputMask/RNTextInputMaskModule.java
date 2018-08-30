package com.RNTextInputMask;

import android.widget.EditText;
import android.text.TextWatcher;

import com.facebook.react.uimanager.UIManagerModule;
import com.facebook.react.uimanager.UIBlock;
import com.facebook.react.uimanager.NativeViewHierarchyManager;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

import com.redmadrobot.inputmask.MaskedTextChangedListener;

import com.redmadrobot.inputmask.model.CaretString;
import com.redmadrobot.inputmask.helper.Mask;

import android.support.annotation.NonNull;

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
                     final int precision,
                     final Callback onResult) {
        String output;
        String[] strings = maskString.split("/");

        if ("currency".equalsIgnoreCase(strings[0])) {
            String prefix = "";
            if (strings.length > 1) {
                prefix = strings[1];
            }

            output = MoneyTextWatcher.Helper.instance.formatCurrency(inputValue, precision, prefix);
        }
        else {
            final Mask mask = new Mask(maskString);
            final String input = inputValue;
            final Mask.Result result = mask.apply(
                    new CaretString(
                            input,
                            input.length()
                    ),
                    false
            );
            output = result.getFormattedText().getString();
        }
        onResult.invoke(output);
    }

    @ReactMethod
    public void unmask(final String maskString,
                       final String inputValue,
                       final Callback onResult) {
        final Mask mask = new Mask(maskString);
        final String input = inputValue;
        final Mask.Result result = mask.apply(
                new CaretString(
                        input,
                        input.length()
                ),
                true
        );
        final String output = result.getExtractedValue();
        onResult.invoke(output);
    }

    @ReactMethod
    public void setMask(final int tag, final String mask, final int precision) {
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
                        if (editText.getTag() != null) {
                            editText.removeTextChangedListener((TextWatcher) editText.getTag());
                        }

                        String[] strings = mask.split("/");

                        if ("currency".equalsIgnoreCase(strings[0])) {
                            String currency = "";
                            if (strings.length > 1) {
                                currency = strings[1];
                            }
                            MoneyTextWatcher listener = new MoneyTextWatcher(editText, currency, precision);
                            editText.setTag(listener);
                            editText.addTextChangedListener(listener);
                        } else {
                            MaskedTextChangedListener listener = new MaskedTextChangedListener(
                                    mask,
                                    false,
                                    editText,
                                    null,
                                    new MaskedTextChangedListener.ValueListener() {
                                        @Override
                                        public void onTextChanged(boolean maskFilled, @NonNull final String extractedValue) {

                                        }
                                    }
                            );
                            editText.setTag(listener);
                            editText.addTextChangedListener(listener);
                        }
                    }
                });
            }
        });
    }
}
