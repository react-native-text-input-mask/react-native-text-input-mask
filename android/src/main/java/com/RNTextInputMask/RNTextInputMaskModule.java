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
          true
      );
      final String output = result.getFormattedText().getString();
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
    public void setMask(final int tag, final String mask) {
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
                        MaskedTextChangedListener listener = new MaskedTextChangedListener(
                                mask,
                                true,
                                editText,
                                null,
                                null
                        );

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
}
