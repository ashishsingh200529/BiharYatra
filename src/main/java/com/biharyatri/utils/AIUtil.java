package com.biharyatri.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class AIUtil {

    private static final Map<String, String> chatbotKnowledge = new LinkedHashMap<>();

    static {
        // --- 1. GREETINGS & PERSONALITY ---
        chatbotKnowledge.put("hello", "Namaste! Welcome to BiharYatra. I am Yatra Mitra, your AI tour assistant. How can I help you explore Bihar today?");
        chatbotKnowledge.put("hi", "Namaste! Welcome to BiharYatra. I am Yatra Mitra, your AI tour assistant. What places would you like to explore today?");
        chatbotKnowledge.put("hey", "Hello! I am Yatra Mitra, your personal guide for Bihar tourism. Ask me about tour packages, places, food, or booking!");
        chatbotKnowledge.put("namaste", "Namaste! Shubh Aagaman. How can I assist you with your Bihar travel plans today?");
        chatbotKnowledge.put("who are you", "I am Yatra Mitra, an intelligent AI travel guide designed to help tourists explore Bihar's heritage, temples, nature reserves, food, and tour packages!");
        chatbotKnowledge.put("what can you do", "I can help you discover Bihar's top destinations (Bodh Gaya, Rajgir, Nalanda, Patna, Valmiki), recommend tour packages, assist with online booking, provide food & hotel details, and answer travel queries!");
        chatbotKnowledge.put("thank", "You are most welcome! Let me know if you need any more recommendations or help with your travel booking. Happy Yatra!");
        chatbotKnowledge.put("bye", "Thank you for chatting with Yatra Mitra! Wish you a wonderful and blessed journey through Bihar. Namaste!");

        // --- 2. INTENT: WHERE TO GO / PLACES RECOMMENDATIONS ---
        chatbotKnowledge.put("where i go", "For an incredible Bihar experience, we recommend these top highlights based on your preference:\n1. 🛕 Bodh Gaya: World-famous Mahabodhi Temple & Bodhi Tree.\n2. 🏛️ Rajgir & Nalanda: Ancient University Ruins, Ropeway & Glass Suspension Bridge.\n3. 🏙️ Patna: Golghar, Takht Sri Patna Sahib & Ganga River Cruise.\n4. 🐅 Valmiki Reserve: Jungle Safari & Tiger Reserve in nature.\nClick 'Tour Packages' in the menu to book a guided trip!");
        chatbotKnowledge.put("where to go", "For an incredible Bihar experience, we recommend these top highlights based on your preference:\n1. 🛕 Bodh Gaya: World-famous Mahabodhi Temple & Bodhi Tree.\n2. 🏛️ Rajgir & Nalanda: Ancient University Ruins, Ropeway & Glass Suspension Bridge.\n3. 🏙️ Patna: Golghar, Takht Sri Patna Sahib & Ganga River Cruise.\n4. 🐅 Valmiki Reserve: Jungle Safari & Tiger Reserve in nature.\nClick 'Tour Packages' in the menu to book a guided trip!");
        chatbotKnowledge.put("where should i go", "For an incredible Bihar experience, we recommend these top highlights based on your preference:\n1. 🛕 Bodh Gaya: World-famous Mahabodhi Temple & Bodhi Tree.\n2. 🏛️ Rajgir & Nalanda: Ancient University Ruins, Ropeway & Glass Suspension Bridge.\n3. 🏙️ Patna: Golghar, Takht Sri Patna Sahib & Ganga River Cruise.\n4. 🐅 Valmiki Reserve: Jungle Safari & Tiger Reserve in nature.\nClick 'Tour Packages' in the menu to book a guided trip!");
        chatbotKnowledge.put("recommend", "Here are our top recommended travel circuits in Bihar:\n• Spiritual Seekers: Bodh Gaya & Gaya (Mahabodhi Temple, Vishnupad)\n• History & Architecture: Rajgir & Nalanda Ruins\n• Nature & Eco-Tourism: Valmiki Tiger Reserve (West Champaran)\n• City & Heritage: Patna Capital Tour (Golghar, Patna Sahib, Ganga Ghat)");

        // --- 3. DESTINATIONS & MONUMENTS ---
        chatbotKnowledge.put("bodh gaya", "Bodh Gaya is one of the most sacred pilgrimage sites in the world. Key attractions include the UNESCO World Heritage Mahabodhi Temple, the sacred Bodhi Tree under which Lord Buddha attained enlightenment, the 80-foot Giant Buddha Statue, and international monasteries.");
        chatbotKnowledge.put("gaya", "Gaya is a major spiritual center located on the banks of the Falgu River. It is famous for the Vishnupad Temple (featuring a 40cm footprint of Lord Vishnu) where millions perform 'Pind Daan' rituals for ancestors.");
        chatbotKnowledge.put("rajgir", "Rajgir was the ancient capital of Magadha. Key attractions include the Vishwa Shanti Stupa (Peace Pagoda) accessible via aerial ropeway, Saptaparni Caves, natural Brahmakund Hot Springs, Bimbisara Jail, and the scenic Glass Cabin Suspension Bridge!");
        chatbotKnowledge.put("glass bridge", "The Rajgir Glass Cabin Suspension Bridge is 85 feet long and suspended over a lush valley in the Rajgir Nature Safari! It offers a thrilling panoramic view. Advance booking via BiharYatra is recommended.");
        chatbotKnowledge.put("nalanda", "Nalanda is world-renowned for the ancient Nalanda University Ruins (5th century CE), one of the world's first residential universities. Visit the Monastery stupas, the Nalanda Archaeological Museum, and the Xuanzang Memorial Hall.");
        chatbotKnowledge.put("patna", "Patna (ancient Pataliputra) is the vibrant capital of Bihar. Main spots include Golghar (granary with panoramic river views), Takht Sri Patna Sahib (birthplace of Guru Gobind Singh Ji), Bihar Museum, and evening Ganga Aarti at NIT Ghat.");
        chatbotKnowledge.put("valmiki", "Valmiki National Park in West Champaran is Bihar's sole Tiger Reserve. Nestled along the Himalayan foothills and Gandak river, it is famous for Royal Bengal Tigers, leopards, jungle jeep safaris, and eco-lodges.");
        chatbotKnowledge.put("vaishali", "Vaishali is a historic land of democracy and spirituality. It is the birthplace of Lord Mahavira (24th Jain Tirthankara) and features the Ashokan Pillar, Buddha Relic Stupa, and Coronation Tank.");
        chatbotKnowledge.put("sasaram", "Sasaram in Rohtas district is famous for the magnificent Sher Shah Suri Tomb, an architectural masterpiece of red sandstone standing in the middle of a square lake.");
        chatbotKnowledge.put("pawapuri", "Pawapuri (or Apapuri) is a holy pilgrimage site for Jains near Rajgir. It is the place where Lord Mahavira attained Nirvana. The beautiful Jal Mandir stands inside a lotus pond.");

        // --- 4. FOOD & CUISINE ---
        chatbotKnowledge.put("litti", "Litti Chokha is Bihar's iconic signature dish! Baked wheat flour balls stuffed with spiced Sattu (roasted gram flour), dipped in pure ghee, and served with smoky brinjal, tomato & potato mash (Chokha). A must-try!");
        chatbotKnowledge.put("food", "Bihar's famous local dishes include:\n• Savoury: Litti Chokha, Sattu Paratha, Dal Pitha, Ghugni Chura.\n• Sweets: Silao Khaja (GI Tagged), Tilkut from Gaya, Anarsa, and Balushahi from Runni Saidpur.");
        chatbotKnowledge.put("khaja", "Silao Khaja is a famous crispy multi-layered sweet delicacy from Silao near Nalanda. It has been granted the geographical indication (GI) tag!");

        // --- 5. BOOKING, PAYMENTS & REFUNDS ---
        chatbotKnowledge.put("book", "Booking a tour on BiharYatra is easy:\n1. Click Tour Packages in the top navigation.\n2. Select your desired package.\n3. Pick your Travel Date & Traveler Count.\n4. Click Proceed to Payment Gateway.\n5. Pay using UPI / Cards / Razorpay to download your PDF Ticket with QR Pass!");
        chatbotKnowledge.put("payment", "We support 100% secure payments via Razorpay (UPI, GPay, PhonePe, Paytm, Credit/Debit Cards, NetBanking). You get an instant PDF ticket with entry QR code right after payment!");
        chatbotKnowledge.put("price", "Our packages are budget-friendly and all-inclusive:\n• Patna City Tour: Rs. 2,499\n• Rajgir-Nalanda Heritage: Rs. 3,999\n• Gaya & Bodh Gaya: Rs. 4,499\n• Valmiki Tiger Safari: Rs. 7,999\nCheck the 'Tour Packages' section for exact inclusions!");
        chatbotKnowledge.put("cost", "Package prices start from Rs. 2,499 for 2-Day tours up to Rs. 7,999 for 4-Day Tiger Safaris including hotel stay, guided transfers, and entry passes.");
        chatbotKnowledge.put("ticket", "After payment completion, a Boarding Pass PDF ticket is automatically generated for you. It contains an Entry Gate QR Pass which you can scan at monument entry gates or present to your tour guide.");
        chatbotKnowledge.put("refund", "Cancellations made at least 48 hours before the travel date receive a 100% full refund. You can check and manage your bookings in your Profile Dashboard under 'My Bookings'.");
        chatbotKnowledge.put("cancel", "You can manage or cancel your bookings from your Profile Dashboard -> My Bookings tab, or email us at support@biharyatri.com for assistance.");

        // --- 6. LOGISTICS, WEATHER & TRAVEL TIPS ---
        chatbotKnowledge.put("best time", "The best season to visit Bihar is during the autumn and winter months from October to March, when the weather is pleasant (15°C to 25°C). Festival times like Chhath Puja (Oct/Nov) offer a rich cultural vibe!");
        chatbotKnowledge.put("weather", "Bihar experiences hot summers (April-June, 35-42°C), monsoon rains (July-Sept), and cool pleasant winters (Oct-March, 10-22°C). Winter is the peak tourist season!");
        chatbotKnowledge.put("reach", "Bihar is well-connected by Air (Jay Prakash Narayan International Airport, Patna & Gaya Airport), Rail (Patna Junction, Gaya Jn, Rajgir), and National Highways (NH-19, NH-31).");
        chatbotKnowledge.put("train", "Major railway junctions in Bihar include Patna Junction (PNBE), Gaya Junction (GAYA), Rajgir (RGD), and Muzaffarpur (MFP) connecting all major Indian cities.");
        chatbotKnowledge.put("flight", "You can fly directly to Patna Airport (PAT) or Gaya International Airport (GAY) with direct flights from Delhi, Mumbai, Kolkata, Bengaluru, and international flights from Bangkok/Yangon.");
        chatbotKnowledge.put("hotel", "All our packages include comfortable stays at handpicked partner hotels & resorts (e.g. Bodh Gaya Nirvana Hotel, Rajgir Heritage Resort, Valmiki Eco Lodges) with AC rooms and Wi-Fi.");
        chatbotKnowledge.put("safe", "Yes, Bihar is safe for tourists and families! Major tourist circuits (Bodh Gaya, Rajgir, Nalanda, Patna) have dedicated Tourism Police, well-lit plazas, and active helpdesks.");
        chatbotKnowledge.put("family", "All our tour itineraries are 100% family-friendly and suitable for senior citizens and children, featuring comfortable AC vehicles, guided tours, and clean dining.");
        chatbotKnowledge.put("chhath", "Chhath Puja is Bihar's grandest festival dedicated to the Sun God (Surya). Celebrated in Oct/Nov, devotees offer prayers at river banks during sunset and sunrise in a pure spiritual atmosphere.");
        chatbotKnowledge.put("contact", "You can reach our 24/7 BiharYatra Tourist Helpdesk at:\n📧 Email: support@biharyatri.com\n📞 Phone: +91-612-YATRA (92872)\n📍 Address: Bihar Tourism Corp, Gandhi Maidan, Patna.");
    }

    /**
     * Advanced Natural Language Intent Engine.
     */
    public static String getChatbotResponse(String message) {
        if (message == null || message.trim().isEmpty()) {
            return "Namaste! Please type a question about Bihar places, food, packages, or booking, and I will guide you immediately!";
        }

        String raw = message.trim();
        String lower = raw.toLowerCase();

        // 1. Check exact intent matchers
        for (Map.Entry<String, String> entry : chatbotKnowledge.entrySet()) {
            if (lower.contains(entry.getKey())) {
                return entry.getValue();
            }
        }

        // 2. Multi-word Semantic Intent Parsing
        if (lower.contains("how") && (lower.contains("reach") || lower.contains("go") || lower.contains("travel"))) {
            return chatbotKnowledge.get("reach");
        }
        if (lower.contains("where") && (lower.contains("stay") || lower.contains("sleep") || lower.contains("room"))) {
            return chatbotKnowledge.get("hotel");
        }
        if (lower.contains("how") && (lower.contains("pay") || lower.contains("money"))) {
            return chatbotKnowledge.get("payment");
        }
        if (lower.contains("how") && (lower.contains("book") || lower.contains("buy"))) {
            return chatbotKnowledge.get("book");
        }
        if (lower.contains("when") && (lower.contains("visit") || lower.contains("go") || lower.contains("travel"))) {
            return chatbotKnowledge.get("best time");
        }
        if (lower.contains("phone") || lower.contains("call") || lower.contains("email") || lower.contains("helpdesk")) {
            return chatbotKnowledge.get("contact");
        }
        if (lower.contains("what") && (lower.contains("eat") || lower.contains("dish") || lower.contains("dinner") || lower.contains("lunch"))) {
            return chatbotKnowledge.get("food");
        }

        // 3. Smart Conversational Fallback with Helpful Suggestions
        return "Namaste! I am Yatra Mitra, your AI assistant. Here is what I can help you with right now:\n"
             + "• Places: Ask about Bodh Gaya, Rajgir, Nalanda, Patna, or Valmiki Tiger Safari.\n"
             + "• Booking: Ask 'How to book' or 'Ticket prices'.\n"
             + "• Food & Stay: Ask 'Famous food in Bihar' or 'Hotels'.\n"
             + "• Helpdesk: Type 'Contact' or 'Best time to visit'.\n\n"
             + "How can I assist your trip today?";
    }

    /**
     * Smart Package Recommender.
     * Evaluates user criteria (travel interests, duration, budget) to suggest the most relevant package.
     */
    public static List<Integer> getRecommendations(String interest, String budgetLevel, int daysAvailable) {
        // Recommendations logic using IDs:
        // Package 1: Rajgir-Nalanda (Heritage, Rs. 3999, 3 Days)
        // Package 2: Gaya & Bodh Gaya (Spiritual, Rs. 4499, 3 Days)
        // Package 3: Patna Tour (Capital/Short, Rs. 2499, 2 Days)
        // Package 4: Valmiki Safari (Eco-Adventure, Rs. 7999, 4 Days)
        
        List<Integer> recommendedIds = new ArrayList<>();
        
        if ("spiritual".equalsIgnoreCase(interest)) {
            recommendedIds.add(2); // Gaya spiritual
            recommendedIds.add(1); // Rajgir (also has Buddhist/Jain relevance)
        } else if ("heritage".equalsIgnoreCase(interest) || "history".equalsIgnoreCase(interest)) {
            recommendedIds.add(1); // Nalanda/Rajgir heritage
            recommendedIds.add(3); // Patna history
        } else if ("nature".equalsIgnoreCase(interest) || "adventure".equalsIgnoreCase(interest)) {
            recommendedIds.add(4); // Valmiki tiger safari
            recommendedIds.add(1); // Rajgir (nature hills)
        }
        
        // Budget constraints
        if ("low".equalsIgnoreCase(budgetLevel)) {
            recommendedIds.add(3); // Patna is low budget (Rs. 2499)
        } else if ("medium".equalsIgnoreCase(budgetLevel)) {
            if (!recommendedIds.contains(1)) recommendedIds.add(1);
            if (!recommendedIds.contains(2)) recommendedIds.add(2);
        } else {
            if (!recommendedIds.contains(4)) recommendedIds.add(4); // Valmiki high budget (Rs. 7999)
        }

        // Ensure we always have at least some fallback options
        if (recommendedIds.isEmpty()) {
            recommendedIds.add(1); // Default to featured
            recommendedIds.add(2);
        }

        return recommendedIds;
    }
}
