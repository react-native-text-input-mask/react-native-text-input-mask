package com.RNTextInputMask;

import java.text.DecimalFormat;
import java.text.ParseException;

import android.text.Editable;
import android.text.TextWatcher;
import android.widget.EditText;
import java.lang.ref.WeakReference;
import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.Locale;



public class MoneyTextWatcher implements TextWatcher {
    private final WeakReference<EditText> editTextWeakReference;
    private final Boolean showCurrency;

    public MoneyTextWatcher(EditText editText, Boolean showDollaBills) {
        editTextWeakReference = new WeakReference<EditText>(editText);
        showCurrency = showDollaBills;
    }

    @Override
    public void beforeTextChanged(CharSequence s, int start, int count, int after) {
    }

    @Override
    public void onTextChanged(CharSequence s, int start, int before, int count) {
    }

    @Override
    public void afterTextChanged(Editable editable) {
        EditText editText = editTextWeakReference.get();
        if (editText == null) return;
        String s = editable.toString();
        editText.removeTextChangedListener(this);
        String cleanString = s.toString().replaceAll("[$,.]", "");
        BigDecimal parsed = new BigDecimal(cleanString).setScale(2, BigDecimal.ROUND_FLOOR).divide(new BigDecimal(100), BigDecimal.ROUND_FLOOR);
        NumberFormat defaultFormat = null;
        if(showCurrency == true) {
            defaultFormat = NumberFormat.getCurrencyInstance();
        } else {
            defaultFormat = NumberFormat.getInstance(Locale.US);
            defaultFormat.setMinimumFractionDigits(2);
        }
        String formatted = defaultFormat.format(parsed);
        editText.setText(formatted);
        editText.setSelection(formatted.length());
        editText.addTextChangedListener(this);
    }
}