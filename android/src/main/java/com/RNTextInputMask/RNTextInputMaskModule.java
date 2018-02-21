package com.RNTextInputMask;

import android.app.Activity;
import android.widget.EditText;
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

import java.text.NumberFormat;
import java.util.Locale;

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
                     final Callback onResult) {
      final Mask mask = new Mask(maskString);
      final String input = inputValue;
      final Mask.Result result = mask.apply(
          new CaretString(
              input,
              input.length()
          ),
          false
      );

      String output = result.getFormattedText().getString();
      if("currency$".equalsIgnoreCase(maskString)) {
         output = currencyInputFormatting(inputValue, true);
      } else if("currency".equalsIgnoreCase(maskString)) {
         output = currencyInputFormatting(inputValue, false);
      }

      onResult.invoke(output);
    }

    private String currencyInputFormatting(String inputString, Boolean showCurrency) {

            NumberFormat defaultFormat = null;
            if(showCurrency == true) {
                defaultFormat = NumberFormat.getCurrencyInstance();
            } else {
                defaultFormat = NumberFormat.getInstance(Locale.US);
                defaultFormat.setMinimumFractionDigits(2);
            }
            String dirtyString = inputString;
            dirtyString = dirtyString.replaceAll("[^0-9]", "");
            Double dollars = 0.00;
            String formattedDollars = "";
            try{
                Double cents = Double.parseDouble(dirtyString);
                dollars = cents/100;
                formattedDollars = defaultFormat.format(dollars);
            }catch(Exception e){
                formattedDollars = "";
            }

            return formattedDollars;
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
    public void setMask(final int view, final String mask) {
      final Activity currentActivity = this.reactContext.getCurrentActivity();
      final ReactApplicationContext rctx = this.reactContext;

      currentActivity.runOnUiThread(new Runnable() {
        @Override
        public void run() {
          UIManagerModule uiManager = rctx.getNativeModule(UIManagerModule.class);
          uiManager.addUIBlock(new UIBlock() {
              @Override
              public void execute(NativeViewHierarchyManager nativeViewHierarchyManager) {
                  final EditText editText = (EditText)nativeViewHierarchyManager.resolveView(view);

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

                    if("currency".equalsIgnoreCase(mask)) {
                       editText.addTextChangedListener(new MoneyTextWatcher(editText, false));
                    } else if("currency$".equalsIgnoreCase(mask)) {
                         editText.addTextChangedListener(new MoneyTextWatcher(editText, true));
                    } else {
                        editText.addTextChangedListener(listener);
                    }
              }
          });
        }
      });
    }
}
