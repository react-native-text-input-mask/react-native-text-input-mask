package com.RNTextInputMask;

import android.app.Activity;
import android.text.Editable;
import android.widget.EditText;
import android.text.TextWatcher;
import com.facebook.react.uimanager.UIManagerModule;
import com.facebook.react.uimanager.UIBlock;
import com.facebook.react.uimanager.NativeViewHierarchyManager;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.Callback;

import com.redmadrobot.inputmask.MaskedTextChangedListener;
import com.redmadrobot.inputmask.PolyMaskTextChangedListener;

import com.redmadrobot.inputmask.model.CaretString;
import com.redmadrobot.inputmask.helper.Mask;
import android.support.annotation.NonNull;


import java.math.BigDecimal;
import java.text.NumberFormat;

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
      final Mask mask = new Mask(maskString);
      final String input = inputValue;
      final Mask.Result result = mask.apply(
          new CaretString(
              input,
              input.length()
          ),
          true
      );
      final String output = format(inputValue, precision);//result.getFormattedText().getString();
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
      final String output = inputValue.replaceAll(",", "");//result.getExtractedValue();
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
                        TextWatcher listener = new TextWatcher() {
                            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
                            }

                            @Override
                            public void onTextChanged(CharSequence s, int start, int before, int count) {
                            }

                            @Override
                            public void afterTextChanged(Editable editable) {
                                String s = editable.toString();
                                editText.removeTextChangedListener(this);

                                try {
                                    String formatted = format(s, precision);
                                    editText.setText(formatted);
                                    editText.setSelection(formatted.length());
                                } catch (Exception e) {
                                    // noop
                                }

                                editText.addTextChangedListener(this);
                            }
                        };

                        if (editText.getTag() != null) {
                            editText.removeTextChangedListener((TextWatcher) editText.getTag());
                        }

                        editText.setTag(listener);
                        editText.addTextChangedListener(listener);
                    }
                });
            }
        });
    }

    public String format(String input, int precision) {
        String result = input;
            input = input.replaceAll("[^\\d\\.]", "");
        String naturalPart = "";
        String decimalPart = "";

        int dotIndex = input.indexOf(".");
        if (dotIndex >= 0) {
          naturalPart = input.substring(0, dotIndex);
          decimalPart = input.substring(dotIndex + 1);
          decimalPart = decimalPart.replaceAll("\\.", "");
          if (decimalPart.length() > precision) {
            decimalPart = decimalPart.substring(0,  precision);
          }
        } else {
          naturalPart = input;
          decimalPart = "";
        }

        try {
            BigDecimal parsed = new BigDecimal(naturalPart);
            NumberFormat defaultFormat = null;
            defaultFormat = NumberFormat.getInstance();
            defaultFormat.setMaximumFractionDigits(0);
            // defaultFormat.setMinimumFractionDigits(3);
            result = defaultFormat.format(parsed);
            if (!decimalPart.isEmpty()) {
              result += "." + decimalPart;
            } else if (precision > 0 && input.endsWith(".")) {
              result += ".";
            }
        } catch (Exception e) {
            // noop
        }

        return result;
    }
}
