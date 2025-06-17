# Motor Control System with Alarm and Shutdown Timer (PLC Program)

This project implements a PLC-based motor control system using Structured Text (ST) that includes:

- **Start/Stop logic** with contactor latching
- **Alarm detection** based on auxiliary contact feedback
- **Timed shutdown** on alarm persistence
- **Manual reset** of alarm latch
- **Status indicators** for Alarm and Stop conditions

The logic ensures **safe motor operation**, preventing motor run conditions if feedback contacts fail or wiring issues occur.

## 🚀 Features

- ✅ Start and Stop push button support
- ✅ Alarm condition if motor contact is on but auxiliary feedback is missing
- ✅ 5-second timer before triggering alarm shutdown
- ✅ Latching logic for Start and Alarm states
- ✅ Manual Reset via pushbutton
- ✅ Alarm and Stop indicator lamps

## 🔧 How It Works

1. **Start Button** energizes motor contactor (`Motor_Contact_Latch`)
2. **Stop Button** or **Alarm Latch** de-energizes motor
3. **Auxiliary Contact** must close after motor contactor is energized
4. If feedback is missing:
   - A **5-second timer** starts
   - On expiry, **Alarm Latch** is triggered
   - Alarm Lamp Turns ON
   - Motor is forcefully stopped
5. **Alarm Reset** button clears the latch
6. If NO **Alarm Indicated** Motor is Running (Functioanl)

**Author:** [Okere Prince N.]
**Contact:** [https://www.linkedin.com/in/prince-okere-686912177/]
