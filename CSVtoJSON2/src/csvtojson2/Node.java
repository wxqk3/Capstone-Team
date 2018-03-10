/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package csvtojson2;
import java.lang.reflect.Field;
/**
 *
 * @author SBWin
 */
public class Node
{
    private String time = "";
    private String longAccel = "";
    private String latAccel = "";
    private String vectorAccel = "";
    private String vertAccel = "";
    private String rpm = "";
    private String speed = "";
    private String wheelSpeed = "";
    private String distance = "";
    private String powerOutput = "";
    private String torqueOutput = "";
    private String gear = "";
    private String positionX = "";
    private String positionY = "";
    private String timeSlip = "";
    private String timeSlipRate = "";
    private String cornerRadius = "";
    private String yawRate = "";
    private String rollRate = "";
    private String buffer = "";
    private String flpot = "";
    private String frpot = "";
    private String rrpot = "";
    private String rlpot = "";
    private String analog5 = "";
    private String analog6 = "";
    private String analog7 = "";
    private String analog8 = "";
    private String analog9 = "";
    private String analog20 = "";
    private String analog29 = "";
    private String analog30 = "";
    private String analog31 = "";
    private String analog32 = "";
    private String flws = "";
    private String frws = "";
    private String rlws = "";
    private String rrws = "";
    private String gpsAltitude = "";
    private String gpsHeading = "";
    private String gpsTime = "";
    private String gpsPosAcc = "";
    private String gpsVelAcc = "";
    private String gpsHeadAcc = "";
    private String gpsAltAcc = "";
    private String gpsVelRaw = "";
    private String gpsLong = "";
    private String gpsLat = "";
    private String temperature1 = "";
    private String waterTemp = "";
    private String gearboxPostCooler = "";
    private String exhaust1Temp = "";
    private String exhaust2Temp = "";
    private String exhaust3Temp = "";
    private String exhaust4Temp = "";
    private String throttlePosition = "";
    private String fuelInj1PW = "";
    private String auxiliary1 = "";
    private String ignitionAngle = "";
    private String steeringAngle = "";
    private String ambientAirPressure = "";
    private String boostPressure = "";
    private String lambda1 = "";
    private String batteryVoltage = "";
    private String flShockVelo = "";
    private String frShockVelo = "";
    private String rlShockVelo = "";
    private String rrShockVelo = "";
    private String flWheelPos = "";
    private String frWheelPos = "";
    private String rlWheelPosition = "";
    private String rrWheelPosition = "";
    private String slipRL = "";
    private String slipRR = "";
    private String longSlip = "";
    private String hpAtWheels = "";
    private String brakeBias = "";
    private String combinedG = "";
    private String deltaT = "";
    private String simLongAccel = "";
    private String simLatAccel = "";
    private String simSpeed = "";
    private String simPowerOutput = "";
    private String simGear = "";
    private String simTimeSlip = "";
    private String simTimeSlipRate = "";
    
    public Node(){
        
    }
    //The masochists constructor
    public Node(String time, String longAccel, String latAccel, String vectorAccel, String vertAccel, String rpm, String speed, String wheelSpeed, String distance, String powerOutput, String torqueOutput, String gear, String positionX, String positionY, String timeSlip, String timeSlipRate, String cornerRadius, String yawRate, String rollRate, String buffer, String flpot, String frpot, String rrpot, String rlpot, String analog5, String analog6, String analog7, String analog8, String analog9, String analog20, String analog29, String analog30, String analog31, String analog32, String flws, String frws, String rlws, String rrws, String gpsAltitude, String gpsHeading, String gpsTime, String gpsPosAcc, String gpsVelAcc, String gpsHeadAcc, String gpsAltAcc, String gpsVelRaw, String gpsLong, String gpsLat, String temperature1, String waterTemp, String gearboxPostCooler, String exhaust1Temp, String exhaust2Temp, String exhaust3Temp, String exhaust4Temp, String throttlePosition, String fuelInj1PW, String auxiliary1, String ignitionAngle, String steeringAngle, String ambientAirPressure, String boostPressure, String lambda1, String batteryVoltage, String flShockVelo, String frShockVelo, String rlShockVelo, String rrShockVelo, String flWheelPos, String frWheelPos, String rlWheelPosition, String rrWheelPosition, String slipRL, String slipRR, String longSlip, String hpAtWheels, String brakeBias, String combinedG, String deltaT, String simLongAccel, String simLatAccel, String simSpeed, String simPowerOutput, String simGear, String simTimeSlip, String simTimeSlipRate){
        this.time = time;
        this.longAccel = longAccel;
        this.latAccel = latAccel;
        this.vectorAccel = vectorAccel;
        this.vertAccel = vertAccel;
        this.rpm = rpm;
        this.speed = speed;
        this.wheelSpeed = wheelSpeed;
        this.distance = distance;
        this.powerOutput = powerOutput;
        this.torqueOutput = torqueOutput;
        this.gear = gear;
        this.positionX = positionX;
        this.positionY = positionY;
        this.timeSlip = timeSlip;
        this.timeSlipRate = timeSlipRate;
        this.cornerRadius = cornerRadius;
        this.yawRate = yawRate;
        this.rollRate = rollRate;
        this.buffer = buffer;
        this.flpot = flpot;
        this.frpot = frpot;
        this.rrpot = rrpot;
        this.rlpot = rlpot;
        this.analog5 = analog5;
        this.analog6 = analog6;
        this.analog7 = analog7;
        this.analog8 = analog8;
        this.analog9 = analog9;
        this.analog20 = analog20;
        this.analog29 = analog29;
        this.analog30 = analog30;
        this.analog31 = analog31;
        this.analog32 = analog32;
        this.flws = flws;
        this.frws = frws;
        this.rlws = rlws;
        this.rrws = rrws;
        this.gpsAltitude = gpsAltitude;
        this.gpsHeading = gpsHeading;
        this.gpsTime = gpsTime;
        this.gpsPosAcc = gpsPosAcc;
        this.gpsVelAcc = gpsVelAcc;
        this.gpsHeadAcc = gpsHeadAcc;
        this.gpsAltAcc = gpsAltAcc;
        this.gpsVelRaw = gpsVelRaw;
        this.gpsLong = gpsLong;
        this.gpsLat = gpsLat;
        this.temperature1 = temperature1;
        this.waterTemp = waterTemp;
        this.gearboxPostCooler = gearboxPostCooler;
        this.exhaust1Temp = exhaust1Temp;
        this.exhaust2Temp = exhaust2Temp;
        this.exhaust3Temp = exhaust3Temp;
        this.exhaust4Temp = exhaust4Temp;
        this.throttlePosition = throttlePosition;
        this.fuelInj1PW = fuelInj1PW;
        this.auxiliary1 = auxiliary1;
        this.ignitionAngle = ignitionAngle;
        this.steeringAngle = steeringAngle;
        this.ambientAirPressure = ambientAirPressure;
        this.boostPressure = boostPressure;
        this.lambda1 = lambda1;
        this.batteryVoltage = batteryVoltage;
        this.flShockVelo = flShockVelo;
        this.frShockVelo = frShockVelo;
        this.rlShockVelo = rlShockVelo;
        this.rrShockVelo = rrShockVelo;
        this.flWheelPos = flWheelPos;
        this.frWheelPos = frWheelPos;
        this.rlWheelPosition = rlWheelPosition;
        this.rrWheelPosition = rrWheelPosition;
        this.slipRL = slipRL;
        this.slipRR = slipRR;
        this.longSlip = longSlip;
        this.hpAtWheels = hpAtWheels;
        this.brakeBias = brakeBias;
        this.combinedG = combinedG;
        this.deltaT = deltaT;
        this.simLongAccel = simLongAccel;
        this.simLatAccel = simLatAccel;
        this.simSpeed = simSpeed;
        this.simPowerOutput = simPowerOutput;
        this.simGear = simGear;
        this.simTimeSlip = simTimeSlip;
        this.simTimeSlipRate = simTimeSlipRate;
    }
    //the I-don't-hate-myself constructor
    public Node(String[] values){
        try{
            int i = 0;
            for(Field f: this.getClass().getDeclaredFields()){
                f.set(this, values[i]);
                i++;
            }
        }catch(IllegalAccessException | IllegalArgumentException | SecurityException e){
            System.out.println("Error constructing object");
        }
    }
    
    
}
