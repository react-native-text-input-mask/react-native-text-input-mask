package com.RNTextInputMask;

import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.widget.EditText;

import java.lang.ref.WeakReference;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;
import java.math.RoundingMode;

public class MoneyTextWatcher implements TextWatcher {
    private final WeakReference<EditText> editText;
    private String previousCleanString;
    private String prefix;

    private static final int MAX_DECIMAL = 5;

    public MoneyTextWatcher(EditText editText, String prefix) {
        this.editText = new WeakReference<>(editText);
        this.prefix = prefix;
    }

    public MoneyTextWatcher(EditText editText) {
        this.editText = new WeakReference<>(editText);
        this.prefix = "";
    }

    @Override
    public void beforeTextChanged(CharSequence s, int start, int count, int after) {
        // do nothing
    }

    @Override
    public void onTextChanged(CharSequence s, int start, int before, int count) {
        // do nothing
    }

    @Override
    public void afterTextChanged(Editable editable) {
        EditText editText = this.editText.get();
        if (editText == null) return;

        if (editText.getTag() == null) {
            editText.addTextChangedListener(this); // Add back the listener
            editText.setTag(0);
        }

        String str = editable.toString();
        if (!TextUtils.isEmpty(prefix) && str.length() < prefix.length()) {
            editText.setText(prefix);
            editText.setSelection(prefix.length());
            return;
        }
        if (!TextUtils.isEmpty(prefix) && str.equals(prefix)) {
            return;
        }

        // cleanString this the string which not contain prefix and ,
        String cleanString = str.replace(prefix, "").replaceAll("[,]", "");
        // for prevent afterTextChanged recursive call
        if (cleanString.equals(previousCleanString) || cleanString.isEmpty()) {
            return;
        }
        previousCleanString = cleanString;

        String formattedString;
        if (cleanString.contains(".")) {
            formattedString = formatDecimal(cleanString);
        } else {
            formattedString = formatInteger(cleanString);
        }

        editText.setText(formattedString);
        editText.setSelection(formattedString.length());
    }

    private String formatInteger(String str) {
        BigDecimal parsed = new BigDecimal(str);
        DecimalFormat formatter =
                new DecimalFormat(prefix + "#,###", new DecimalFormatSymbols(Locale.getDefault()));
        return formatter.format(parsed);
    }

    private String formatDecimal(String str) {
        if (str.equals(".")) {
            return prefix + ".";
        }
        BigDecimal parsed = new BigDecimal(str);
        // example pattern VND #,###.00
        DecimalFormat formatter = new DecimalFormat(prefix + "#,###." + getDecimalPattern(str),
                new DecimalFormatSymbols(Locale.getDefault()));
        formatter.setRoundingMode(RoundingMode.DOWN);
        return formatter.format(parsed);
    }

    /**
     * It will return suitable pattern for format decimal
     * For example: 10.2 -> return 0 | 10.23 -> return 00, | 10.235 -> return 000
     */
    private String getDecimalPattern(String str) {
        int decimalCount = str.length() - str.indexOf(".") - 1;
        StringBuilder decimalPattern = new StringBuilder();
        for (int i = 0; i < Math.min(decimalCount, MAX_DECIMAL); i++) {
            decimalPattern.append("0");
        }
        return decimalPattern.toString();
    }
}
