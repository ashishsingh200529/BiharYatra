/* BiharYatra Smart Tourism - Interactive Javascript Module */

document.addEventListener("DOMContentLoaded", function() {
    
    // ==========================================
    // 1. AI CHATBOT FUNCTIONALITY
    // ==========================================
    const chatbotToggler = document.querySelector(".chatbot-toggler");
    const chatbotBox = document.querySelector(".chatbot-box");
    const closeChatBtn = document.querySelector(".close-chat-btn");
    const sendChatBtn = document.getElementById("send-chat-btn");
    const chatInput = document.getElementById("chat-input");
    const chatMessages = document.querySelector(".chatbot-messages");

    if (chatbotToggler && chatbotBox) {
        // Toggle Chat Window
        chatbotToggler.addEventListener("click", () => {
            chatbotBox.classList.toggle("show");
            if (chatbotBox.classList.contains("show")) {
                chatInput.focus();
            }
        });

        // Close Chat Window
        if (closeChatBtn) {
            closeChatBtn.addEventListener("click", () => chatbotBox.classList.remove("show"));
        }

        // Send message event handler
        const handleSendMessage = () => {
            const message = chatInput.value.trim();
            if (!message) return;

            // Clear input
            chatInput.value = "";

            // Append User Message
            appendChatBubble(message, "user");

            // Scroll to bottom
            chatMessages.scrollTop = chatMessages.scrollHeight;

            // Fetch AJAX response
            fetchChatbotResponse(message);
        };

        // Click event on send
        if (sendChatBtn) {
            sendChatBtn.addEventListener("click", handleSendMessage);
        }

        // Enter key press event
        if (chatInput) {
            chatInput.addEventListener("keydown", (e) => {
                if (e.key === "Enter") {
                    handleSendMessage();
                }
            });
        }
    }

    function appendChatBubble(msg, sender) {
        const bubble = document.createElement("div");
        bubble.classList.add("chat-bubble", sender);
        
        if (sender === "bot") {
            const textSpan = document.createElement("span");
            textSpan.textContent = msg;
            
            const speakBtn = document.createElement("button");
            speakBtn.className = "btn btn-sm text-warning p-0 ms-2 border-0 bg-transparent";
            speakBtn.innerHTML = '<i class="bi bi-volume-up-fill" title="Listen to answer"></i>';
            speakBtn.onclick = function(e) {
                e.stopPropagation();
                if ('speechSynthesis' in window) {
                    window.speechSynthesis.cancel();
                    const utterance = new SpeechSynthesisUtterance(msg.replace(/<[^>]*>/g, ''));
                    utterance.rate = 1.0;
                    utterance.pitch = 1.0;
                    window.speechSynthesis.speak(utterance);
                }
            };
            
            bubble.appendChild(textSpan);
            bubble.appendChild(speakBtn);
        } else {
            bubble.textContent = msg;
        }
        
        chatMessages.appendChild(bubble);
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }

    function fetchChatbotResponse(message) {
        // Show Typing indicator
        const typingBubble = document.createElement("div");
        typingBubble.classList.add("chat-bubble", "bot", "typing-indicator");
        typingBubble.textContent = "Writing reply...";
        chatMessages.appendChild(typingBubble);
        chatMessages.scrollTop = chatMessages.scrollHeight;

        const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf('/', 1));
        const url = (contextPath === "" ? "" : contextPath) + "/api/chatbot";

        const params = new URLSearchParams();
        params.append("message", message);

        fetch(url, {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
            },
            body: params
        })
        .then(response => response.json())
        .then(data => {
            // Remove typing indicator
            typingBubble.remove();
            appendChatBubble(data.response, "bot");
        })
        .catch(err => {
            console.error("Chatbot Fetch Error: ", err);
            typingBubble.remove();
            appendChatBubble("Apologies, I am experiencing temporary connectivity issues. You can try asking again or contact us at support@biharyatri.com.", "bot");
        });
    }

    // ==========================================
    // 2. WEATHER DISPLAY WIDGET
    // ==========================================
    const districtSelect = document.getElementById("weather-district-select");
    if (districtSelect) {
        districtSelect.addEventListener("change", function() {
            const district = this.value;
            fetchWeatherData(district);
        });

        // Load default district weather on initialization
        fetchWeatherData(districtSelect.value);
    }

    function fetchWeatherData(district) {
        const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf('/', 1));
        const url = (contextPath === "" ? "" : contextPath) + "/api/weather?district=" + encodeURIComponent(district);

        const tempVal = document.getElementById("weather-temp");
        const condVal = document.getElementById("weather-condition");
        const humidityVal = document.getElementById("weather-humidity");
        const cityVal = document.getElementById("weather-city");

        if (tempVal) tempVal.textContent = "...";

        fetch(url)
        .then(response => response.json())
        .then(data => {
            if (cityVal) cityVal.textContent = data.city;
            if (tempVal) tempVal.textContent = data.temp + "°C";
            if (condVal) condVal.textContent = data.condition;
            if (humidityVal) humidityVal.textContent = "Humidity: " + data.humidity + "%";
        })
        .catch(err => {
            console.error("Weather Fetch Error: ", err);
            if (tempVal) tempVal.textContent = "N/A";
        });
    }

    // ==========================================
    // 3. BOOKING CALCULATOR & PASSENGER MULTIPLIER
    // ==========================================
    const travelersInput = document.getElementById("numTravelersInput");
    const travelerDetailsContainer = document.getElementById("travelerDetailsContainer");

    if (travelersInput && travelerDetailsContainer) {
        travelersInput.addEventListener("change", function() {
            const count = parseInt(this.value);
            updateTravelerInputFields(count);
            calculateBookingCost();
        });

        // Initialize traveler fields on load
        updateTravelerInputFields(parseInt(travelersInput.value));
    }

    // Add upgrades listeners
    const hotelUpgrade = document.getElementById("hotelSelect");
    const vehicleUpgrade = document.getElementById("vehicleSelect");
    const foodUpgrade = document.getElementById("foodSelect");

    if (hotelUpgrade) hotelUpgrade.addEventListener("change", calculateBookingCost);
    if (vehicleUpgrade) vehicleUpgrade.addEventListener("change", calculateBookingCost);
    if (foodUpgrade) foodUpgrade.addEventListener("change", calculateBookingCost);

    function updateTravelerInputFields(count) {
        if (!travelerDetailsContainer) return;
        
        // Save existing entries if possible to prevent wiping entries on minor updates
        const existingDetails = [];
        const rows = travelerDetailsContainer.querySelectorAll(".traveler-row");
        rows.forEach((row, i) => {
            const name = row.querySelector("input[name='traveler_name[]']").value;
            const age = row.querySelector("input[name='traveler_age[]']").value;
            const gender = row.querySelector("select[name='traveler_gender[]']").value;
            existingDetails.push({ name, age, gender });
        });

        travelerDetailsContainer.innerHTML = "";

        for (let i = 1; i <= count; i++) {
            const previous = existingDetails[i - 1] || { name: "", age: "", gender: "Male" };
            
            const div = document.createElement("div");
            div.classList.add("row", "g-3", "mb-3", "p-3", "border", "rounded", "bg-white", "traveler-row");
            div.innerHTML = `
                <div class="col-md-5">
                    <label class="form-label font-semibold">Traveler #${i} Full Name</label>
                    <input type="text" name="traveler_name[]" class="form-control" placeholder="Enter full name" value="${previous.name}" required />
                </div>
                <div class="col-md-3">
                    <label class="form-label">Age</label>
                    <input type="number" name="traveler_age[]" class="form-control" placeholder="Age" min="1" max="110" value="${previous.age}" required />
                </div>
                <div class="col-md-4">
                    <label class="form-label">Gender</label>
                    <select name="traveler_gender[]" class="form-select">
                        <option value="Male" ${previous.gender === 'Male' ? 'selected' : ''}>Male</option>
                        <option value="Female" ${previous.gender === 'Female' ? 'selected' : ''}>Female</option>
                        <option value="Other" ${previous.gender === 'Other' ? 'selected' : ''}>Other</option>
                    </select>
                </div>
            `;
            travelerDetailsContainer.appendChild(div);
        }
    }

    function calculateBookingCost() {
        const basePriceVal = document.getElementById("basePriceVal");
        if (!basePriceVal) return;

        const basePrice = parseFloat(basePriceVal.value);
        const count = parseInt(travelersInput.value) || 1;
        
        const durationNightsVal = document.getElementById("durationNightsVal");
        const durationDaysVal = document.getElementById("durationDaysVal");
        const nights = parseInt(durationNightsVal.value) || 0;
        const days = parseInt(durationDaysVal.value) || 0;

        // Upgrade values
        let hotelUpgradePrice = 0;
        let vehicleUpgradePrice = 0;
        let foodUpgradePrice = 0;

        if (hotelUpgrade && hotelUpgrade.value) {
            hotelUpgradePrice = parseFloat(hotelUpgrade.options[hotelUpgrade.selectedIndex].getAttribute("data-price")) || 0;
            const hotelPriceHidden = document.getElementById("hotelUpgradePriceHidden");
            if (hotelPriceHidden) hotelPriceHidden.value = hotelUpgradePrice;
        }

        if (vehicleUpgrade && vehicleUpgrade.value) {
            vehicleUpgradePrice = parseFloat(vehicleUpgrade.options[vehicleUpgrade.selectedIndex].getAttribute("data-price")) || 0;
            const vehiclePriceHidden = document.getElementById("vehicleUpgradePriceHidden");
            if (vehiclePriceHidden) vehiclePriceHidden.value = vehicleUpgradePrice;
        }

        if (foodUpgrade && foodUpgrade.value) {
            foodUpgradePrice = parseFloat(foodUpgrade.options[foodUpgrade.selectedIndex].getAttribute("data-price")) || 0;
            const foodPriceHidden = document.getElementById("foodUpgradePriceHidden");
            if (foodPriceHidden) foodPriceHidden.value = foodUpgradePrice;
        }

        // Live math: Total = (base * count) + (hotel * nights) + (car * days) + (food * count * days)
        const total = (basePrice * count) 
                    + (hotelUpgradePrice * nights) 
                    + (vehicleUpgradePrice * days) 
                    + (foodUpgradePrice * count * days);

        // Render values in HTML summaries
        const summaryCount = document.getElementById("summary-travelers");
        const summaryBase = document.getElementById("summary-base-cost");
        const summaryUpgrades = document.getElementById("summary-upgrade-cost");
        const summaryTotal = document.getElementById("summary-total-cost");

        if (summaryCount) summaryCount.textContent = count;
        if (summaryBase) summaryBase.textContent = "Rs. " + (basePrice * count).toFixed(2);
        
        const upgradeCostVal = (hotelUpgradePrice * nights) + (vehicleUpgradePrice * days) + (foodUpgradePrice * count * days);
        if (summaryUpgrades) summaryUpgrades.textContent = "Rs. " + upgradeCostVal.toFixed(2);
        if (summaryTotal) summaryTotal.textContent = "Rs. " + total.toFixed(2);
    }
});
