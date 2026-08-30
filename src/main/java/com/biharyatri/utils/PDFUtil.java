package com.biharyatri.utils;

import java.io.OutputStream;
import java.util.Base64;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class PDFUtil {

    public static void generateTicketPDF(
            OutputStream outputStream,
            String bookingNo,
            String userName,
            String userEmail,
            String packageTitle,
            String travelDate,
            int travelersCount,
            double totalPrice,
            String paymentStatus,
            String qrBase64) {
        
        Document document = new Document();
        try {
            PdfWriter.getInstance(document, outputStream);
            document.open();

            // Font styles
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 22, new BaseColor(26, 35, 126)); // Deep Indigo
            Font subTitleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.DARK_GRAY);
            Font headingFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.WHITE);
            Font bodyFont = FontFactory.getFont(FontFactory.HELVETICA, 10, BaseColor.BLACK);
            Font boldBodyFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, BaseColor.BLACK);
            Font footerFont = FontFactory.getFont(FontFactory.HELVETICA, 8, Font.ITALIC, BaseColor.GRAY);

            // Title
            Paragraph brand = new Paragraph("BIHAR YATRA", titleFont);
            brand.setAlignment(Element.ALIGN_CENTER);
            document.add(brand);

            Paragraph subtitle = new Paragraph("Smart Tourism & Travel Booking Platform", subTitleFont);
            subtitle.setAlignment(Element.ALIGN_CENTER);
            subtitle.setSpacingAfter(20);
            document.add(subtitle);

            // horizontal rule line
            Paragraph separator = new Paragraph("--------------------------------------------------------------------------------------------------------", subTitleFont);
            separator.setAlignment(Element.ALIGN_CENTER);
            separator.setSpacingAfter(15);
            document.add(separator);

            // Main layout using a table (Left: details, Right: QR Code)
            PdfPTable mainLayout = new PdfPTable(2);
            mainLayout.setWidthPercentage(100);
            mainLayout.setWidths(new float[]{70, 30});

            // Left Cell: Booking Details
            PdfPCell detailsCell = new PdfPCell();
            detailsCell.setBorder(PdfPCell.NO_BORDER);

            detailsCell.addElement(new Paragraph("Booking Reference: " + bookingNo, boldBodyFont));
            detailsCell.addElement(new Paragraph("Customer Name: " + userName, bodyFont));
            detailsCell.addElement(new Paragraph("Customer Email: " + userEmail, bodyFont));
            detailsCell.addElement(new Paragraph("Tour Package: " + packageTitle, bodyFont));
            detailsCell.addElement(new Paragraph("Travel Date: " + travelDate, bodyFont));
            detailsCell.addElement(new Paragraph("Total Travelers: " + travelersCount, bodyFont));
            detailsCell.addElement(new Paragraph("Total Paid: Rs. " + String.format("%.2f", totalPrice), boldBodyFont));
            
            // Payment Badge representation
            String pStatus = "Payment Status: " + paymentStatus.toUpperCase();
            Paragraph paymentPara = new Paragraph(pStatus, boldBodyFont);
            if ("PAID".equalsIgnoreCase(paymentStatus)) {
                paymentPara.setFont(FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, new BaseColor(46, 125, 50))); // Forest Green
            } else {
                paymentPara.setFont(FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, new BaseColor(198, 40, 40))); // Red
            }
            detailsCell.addElement(paymentPara);

            mainLayout.addCell(detailsCell);

            // Right Cell: QR Code
            PdfPCell qrCell = new PdfPCell();
            qrCell.setBorder(PdfPCell.NO_BORDER);
            qrCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            qrCell.setVerticalAlignment(Element.ALIGN_MIDDLE);

            if (qrBase64 != null && !qrBase64.isEmpty()) {
                byte[] qrBytes = Base64.getDecoder().decode(qrBase64);
                Image qrImage = Image.getInstance(qrBytes);
                qrImage.scaleToFit(110, 110);
                qrImage.setAlignment(Element.ALIGN_CENTER);
                qrCell.addElement(qrImage);
                Paragraph qrLabel = new Paragraph("Scan at Landmark", footerFont);
                qrLabel.setAlignment(Element.ALIGN_CENTER);
                qrCell.addElement(qrLabel);
            } else {
                qrCell.addElement(new Paragraph("[QR Code]", bodyFont));
            }

            mainLayout.addCell(qrCell);
            document.add(mainLayout);

            // Add table of travelers list / itinerary guidelines
            Paragraph tableHeader = new Paragraph("Travel Information & Guidelines", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, new BaseColor(26, 35, 126)));
            tableHeader.setSpacingBefore(30);
            tableHeader.setSpacingAfter(10);
            document.add(tableHeader);

            PdfPTable infoTable = new PdfPTable(2);
            infoTable.setWidthPercentage(100);
            infoTable.setSpacingBefore(10);

            // Headers
            PdfPCell h1 = new PdfPCell(new Phrase("Guideline", headingFont));
            h1.setBackgroundColor(new BaseColor(26, 35, 126));
            h1.setPadding(6);
            PdfPCell h2 = new PdfPCell(new Phrase("Description", headingFont));
            h2.setBackgroundColor(new BaseColor(26, 35, 126));
            h2.setPadding(6);

            infoTable.addCell(h1);
            infoTable.addCell(h2);

            // Rows
            infoTable.addCell(new PdfPCell(new Phrase("Reporting Time", boldBodyFont)));
            infoTable.addCell(new PdfPCell(new Phrase("08:00 AM at the starting location (Patna Junction / Airport).", bodyFont)));

            infoTable.addCell(new PdfPCell(new Phrase("Documents Required", boldBodyFont)));
            infoTable.addCell(new PdfPCell(new Phrase("Aadhaar Card, Driver License or Passport. Carry a printout of this ticket.", bodyFont)));

            infoTable.addCell(new PdfPCell(new Phrase("Inclusions", boldBodyFont)));
            infoTable.addCell(new PdfPCell(new Phrase("Hotel stay, private vehicle transport, guided tours, and breakfast/dinner as selected.", bodyFont)));

            infoTable.addCell(new PdfPCell(new Phrase("Cancellation Policy", boldBodyFont)));
            infoTable.addCell(new PdfPCell(new Phrase("Cancel up to 48 hours in advance for a full refund (subject to standard bank fees).", bodyFont)));

            document.add(infoTable);

            // Footer / Thank You Note
            Paragraph footer = new Paragraph("\n\nThank you for choosing BiharYatra! Wish you a happy and blessed journey.\nFor assistance, email us at support@biharyatri.com or call +91-612-YATRA", footerFont);
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (document.isOpen()) {
                document.close();
            }
        }
    }
}
