package com.biharyatri.utils;

import java.io.ByteArrayOutputStream;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

public class QRUtil {

    /**
     * Generates a QR Code as a Base64 PNG image string.
     * @param data The text data to encode inside the QR code.
     * @param width The width in pixels.
     * @param height The height in pixels.
     * @return Base64-encoded string representing the PNG image.
     */
    public static String generateQRCodeBase64(String data, int width, int height) {
        try {
            Map<EncodeHintType, Object> hints = new HashMap<>();
            hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
            hints.put(EncodeHintType.MARGIN, 1);

            MultiFormatWriter writer = new MultiFormatWriter();
            BitMatrix bitMatrix = writer.encode(data, BarcodeFormat.QR_CODE, width, height, hints);

            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            MatrixToImageWriter.writeToStream(bitMatrix, "PNG", outputStream);
            byte[] qrBytes = outputStream.toByteArray();

            return Base64.getEncoder().encodeToString(qrBytes);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
