
# Rack-and-Pinion Steering System | Arduino, MATLAB & Xbox Controller

**Mechanical Design, Kinematic Modeling, MATLAB Simulation, and Wireless Control of an RC Vehicle**

This project focuses on the design, mathematical modeling, simulation, and implementation of a rack-and-pinion steering system using a LEGO Technic-based RC vehicle.

The main objective was to understand how a rack-and-pinion mechanism converts **rotational motion into linear displacement and subsequently into angular steering motion**, validating its behavior through MATLAB simulations and a functional physical prototype.

The final system integrates an Arduino Uno, an SG90 servomotor, an HC-05 Bluetooth module, and an Xbox Elite Series 2 controller, allowing both manual operation of the steering mechanism and remote vehicle control.

---

## Project Demonstration

The following video presents the mechanical design, mathematical model, MATLAB simulations, electronic integration, and experimental results.

[![Watch the Project Demonstration](https://img.youtube.com/vi/i3wTJrrLtWw/maxresdefault.jpg)](https://youtu.be/i3wTJrrLtWw)

**[Watch the Full Project Video on YouTube](https://youtu.be/i3wTJrrLtWw?si=BdRsbmmFcRoS6zGR)**

---

## 1. Project Objectives

- Design and implement a functional rack-and-pinion steering mechanism.
- Analyze the conversion of angular motion into linear displacement.
- Develop mathematical models describing the steering system.
- Simulate the mechanism's behavior using MATLAB.
- Compare theoretical results with the physical prototype.
- Integrate an Arduino-based electronic control system.
- Implement wireless steering and propulsion using an Xbox controller.

---

## 2. System Overview

The system consists of three main subsystems:

### Mechanical System

The steering mechanism was constructed using LEGO Technic components.

Its main elements include:

- Steering input and rotational transmission
- Pinion gear
- Rack
- Steering linkages
- Front wheels

The pinion converts rotational motion into linear rack displacement. The steering linkages then transform this displacement into angular movement of the front wheels.

### Electronic System

An Arduino Uno controls the vehicle's propulsion motors and steering servomotor.

The main components include:

| Component | Function |
|-----------|----------|
| Arduino Uno | Main controller |
| SG90 Servomotor | Steering actuation |
| HC-05 Bluetooth Module | Wireless communication |
| H-Bridge Motor Driver | DC motor control |
| DC Motors | Vehicle propulsion |
| Xbox Elite Series 2 | Remote control |
| LEGO Technic | Mechanical structure |

### Software System

The software architecture combines:

- **Arduino C++:** Motor and servomotor control.
- **Python:** Xbox controller input processing and Bluetooth communication.
- **MATLAB:** Mathematical modeling, simulation, and visualization.

### Communication Architecture

```text
Xbox Elite Series 2
         |
         v
   Python (pygame)
         |
         v
 Bluetooth Serial
         |
         v
      HC-05
         |
         v
    Arduino Uno
      /      \
     v        v
 H-Bridge   SG90 Servo
     |          |
 DC Motors   Pinion
                |
                v
              Rack
                |
                v
          Front Wheels
```

---

## 3. Mechanical Design

The steering mechanism is based on the rack-and-pinion principle commonly used in automotive steering systems.

The mechanical transmission consists of three stages:

**Angular Motion → Linear Motion → Angular Motion**

### Stage 1: Pinion Rotation

The steering input produces rotational motion, which is transmitted to the pinion.

### Stage 2: Rack Displacement

The pinion teeth engage with the rack, transforming angular rotation into linear displacement.

### Stage 3: Wheel Steering

The rack displacement is transmitted through the steering linkages, changing the orientation of the front wheels.

The LEGO Technic structure allows the mechanism to be physically inspected and manually operated.

---

## 4. Mathematical Modeling

The mathematical model describes the kinematic relationship between pinion rotation and rack displacement.

### 4.1 Angular Motion

For constant angular velocity:

\[
\theta(t) = \omega t
\]

Where:

- \(\theta\): Pinion angular displacement (rad)
- \(\omega\): Angular velocity (rad/s)
- \(t\): Time (s)

### 4.2 Angular-to-Linear Conversion

The rack displacement is calculated using:

\[
x = r\theta
\]

Where:

- \(x\): Rack displacement (m)
- \(r\): Pinion radius (m)
- \(\theta\): Pinion rotation (rad)

This equation establishes a proportional relationship between pinion rotation and rack displacement under ideal conditions.

### 4.3 Prototype Parameters

The following parameters were obtained from the physical prototype:

| Parameter | Value |
|-----------|-------|
| Pinion diameter | 1.4 cm |
| Pinion radius | 0.007 m |
| Total rack travel | 0.025 m |
| Maximum displacement from center | ±0.0125 m |
| Maximum theoretical pinion rotation | ±102.3° |
| Approximate wheel steering range | −40° to +40° |

The maximum pinion rotation is calculated as:

\[
\theta_{\max} = \frac{x_{\max}}{r}
\]

Substituting the measured values:

\[
\theta_{\max} = \frac{0.0125}{0.007}
\]

\[
\theta_{\max} \approx 1.786 \text{ rad}
\]

\[
\boxed{\theta_{\max} \approx 102.3^\circ}
\]

This value represents the theoretical pinion rotation required to reach the maximum rack displacement.

**Important:** The pinion rotation angle is not equivalent to the front-wheel steering angle.

The wheel steering angle depends on the geometry of the steering linkages.

---

## 5. MATLAB Simulation

Two mathematical models were implemented in MATLAB to analyze the steering mechanism.

### 5.1 Pinion-to-Rack Simulation

The first simulation represents the conversion from angular motion to linear displacement.

The main parameters include:

```matlab
R_pinion = 0.007;
x_max = 0.0125;

t_final = 2;
t = 0:0.05:t_final;

theta_max = x_max / R_pinion;
omega_pinion = theta_max / t_final;

theta_pinion = omega_pinion * t;

x_cremallera = R_pinion * theta_pinion;
```

The simulation generates two main plots:

**Pinion Angular Displacement**

Represents the angular motion of the pinion over time.

Under constant angular velocity, the angular displacement increases linearly.

**Rack Linear Displacement**

Represents the displacement produced by the pinion rotation.

The results confirm the expected relationship:

\[
x = r\theta
\]

### 5.2 Complete Steering Simulation

The second model represents the complete steering behavior.

An oscillatory pinion input simulates steering toward the left and right.

The model relates:

1. Pinion angular displacement
2. Rack linear displacement
3. Front-wheel steering angle

The approximate experimental steering range of ±40° was used as a reference to adjust the geometric model.

The resulting graphs illustrate how changes in pinion rotation affect rack displacement and wheel orientation.

### Simulation Limitations

The MATLAB models describe idealized kinematic behavior.

They do not fully account for:

- Mechanical friction
- Gear backlash
- Component deformation
- Servo positioning errors
- Nonlinearities introduced by mechanical linkages

Therefore, the simulations provide a theoretical representation rather than an exact measurement of the physical steering response.

---

## 6. Arduino Control System

The vehicle uses an Arduino Uno to control propulsion and steering.

The Arduino receives wireless commands from the HC-05 Bluetooth module.

### 6.1 Bluetooth Communication

The HC-05 communicates with the Arduino using the `SoftwareSerial` library.

```cpp
#include <SoftwareSerial.h>
#include <Servo.h>

SoftwareSerial bluetooth(4, 5);
Servo direccionServo;
```

The communication baud rate is:

```cpp
bluetooth.begin(9600);
```

The Arduino receives commands in the following format:

```text
speed,steering
```

Both values range from -255 to 255.

Example:

```text
120,-180
0,0
-100,150
```

### 6.2 Servomotor Control

An SG90 servomotor actuates the rack-and-pinion steering mechanism.

The final calibration parameters were:

```cpp
const int SERVO_IZQUIERDA = 175;
const int SERVO_CENTRO    = 155;
const int SERVO_DERECHA   = 125;

const int ZONA_DIRECCION = 30;
```

These values correspond to servo position commands, not directly to the physical wheel steering angles.

The steering function uses `map()` to convert joystick inputs into servo commands.

A dead zone prevents small joystick variations from producing unintended movements.

### 6.3 Steering Position Memory

The firmware preserves the last commanded steering position.

When the joystick returns to its neutral position, the servo maintains its previous angle instead of automatically returning to center.

### 6.4 Servo Startup Behavior

The servomotor is not attached immediately during system startup.

Instead, the Arduino activates servo control only after receiving a valid, non-neutral steering command.

This reduces unwanted steering movements when the vehicle is powered on.

### 6.5 Motor Control

Two DC motors provide propulsion.

The Arduino controls their direction and speed through an H-bridge driver.

PWM signals regulate motor speed.

### 6.6 Safety Mechanism

The firmware includes a communication timeout:

```cpp
const unsigned long TIMEOUT_CONTROL = 500;
```

If no commands are received for 500 milliseconds, the propulsion motors stop automatically.

The steering system retains its last commanded position.

### Arduino Pin Configuration

| Component | Arduino Pin |
|-----------|-------------|
| HC-05 RX SoftwareSerial | D4 |
| HC-05 TX SoftwareSerial | D5 |
| SG90 Servo Signal | D6 |
| Left Motor ENA | D11 |
| Left Motor IN1 | D12 |
| Left Motor IN2 | D10 |
| Right Motor ENB | D3 |
| Right Motor IN3 | D8 |
| Right Motor IN4 | D7 |

**Note:** The standard Arduino `Servo.h` library uses Timer1 on the Arduino Uno, affecting PWM operation on pins 9 and 10. Therefore, the right motor's PWM enable signal was assigned to pin 3.

---

## 7. Xbox Wireless Control

The vehicle is operated using an Xbox Elite Series 2 controller.

The communication process is:

1. The Xbox controller connects to a computer.
2. Python reads joystick inputs using `pygame`.
3. The program converts the inputs into speed and steering commands.
4. Commands are transmitted through Bluetooth using `pyserial`.
5. The HC-05 receives the serial data.
6. The Arduino controls the motors and steering servo.

The left joystick controls propulsion, while the right joystick controls steering.

This architecture enables wireless operation without requiring a direct connection between the Xbox controller and the Arduino.

---

## 8. Repository Structure

The recommended project organization is:

```text
rack-and-pinion-steering/
│
├── README.md
│
├── arduino/
│   └── steering_controller.ino
│
├── python/
│   └── xbox_bluetooth_control.py
│
├── matlab/
│   ├── pinion_to_rack.m
│   └── steering_response.m
│
└── media/
    └── README.md
```

File names can be adjusted to match the final project scripts.

---

## 9. Installation and Execution

### Requirements

- Arduino IDE
- Python 3
- MATLAB
- Arduino Uno
- HC-05 Bluetooth module
- Xbox-compatible controller

### Python Dependencies

Install the required libraries:

```bash
python -m pip install pygame pyserial
```

### Arduino Setup

1. Connect the electronic components according to the pin configuration.
2. Verify that the servo has a suitable power supply and shares a common ground with the Arduino.
3. Open the Arduino sketch in the Arduino IDE.
4. Select the Arduino Uno board and its corresponding port.
5. Upload the firmware.

### Bluetooth Configuration

1. Pair the HC-05 with the computer.
2. Identify its assigned serial port.
3. Configure the correct port in the Python script.
4. Verify that the baud rate is 9600.

### Running the Vehicle

1. Power the vehicle.
2. Connect the Xbox controller to the computer.
3. Execute the Python control script.
4. Use the joysticks to control propulsion and steering.
5. Verify that the vehicle responds correctly.

### Running MATLAB Simulations

1. Open MATLAB.
2. Load the corresponding `.m` script.
3. Execute the simulation.
4. Analyze the generated plots.
5. Compare the simulated behavior with the physical prototype.

---

## 10. Experimental Results

The final prototype successfully demonstrated the mechanical conversion:

**Pinion Rotation → Rack Translation → Front-Wheel Steering**

The MATLAB simulations reproduced the expected kinematic behavior using the measured prototype dimensions.

The electronic system also enabled remote propulsion and steering through the Xbox controller.

### Main Achievements

- Functional LEGO Technic rack-and-pinion mechanism.
- Mathematical modeling using measured dimensions.
- MATLAB simulation of steering behavior.
- Wireless communication using Bluetooth.
- Arduino-based motor and steering control.
- Integration of an SG90 servomotor.
- Manual and remote steering operation.

### Physical Steering Limitations

Although the servomotor successfully actuates the mechanism, its commanded angle does not correspond exactly to the physical wheel steering angle.

This difference is influenced by:

- Mechanical alignment
- Steering linkage geometry
- Gear backlash
- Servo mounting position
- Physical travel limits

Nevertheless, the prototype reproduces the expected general steering behavior and demonstrates the relationship between the theoretical model and the physical mechanism.

---

## 11. Future Improvements

Potential improvements include:

- Experimental calibration of servo angle versus wheel steering angle.
- Measurement of rack displacement using position sensors.
- Closed-loop steering control.
- Reduction of mechanical backlash.
- Improved servo mounting and steering symmetry.
- Dynamic modeling of transmitted forces and torque.
- Quantitative comparison between MATLAB simulations and experimental measurements.

---

## 12. Conclusions

This project demonstrates the integration of mechanical design, mathematical modeling, simulation, embedded programming, and wireless control.

The rack-and-pinion mechanism successfully transforms rotational motion into linear displacement and subsequently into angular steering motion.

The MATLAB simulations provided a theoretical representation of the mechanism using measured prototype parameters.

Finally, the integration of the SG90 servomotor and Xbox wireless control transformed the mechanical prototype into a remotely operated vehicle.

Although the steering response is not perfectly calibrated, the resulting behavior is consistent with the expected operation of a rack-and-pinion steering system.

The project highlights the importance of combining theoretical analysis, computational simulation, and experimental implementation in engineering development.

---

## Project Video

**[Watch the Complete Technical Presentation and Demonstration](https://youtu.be/i3wTJrrLtWw?si=BdRsbmmFcRoS6zGR)**

---

**Technologies:** Arduino · MATLAB · Python · Bluetooth · Embedded Systems · Mechanical Design · Kinematic Modeling · Robotics

**Project Type:** Academic Robotics and Mechatronics Project
