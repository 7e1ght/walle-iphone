//
//  BluetoothController.swift
//  walle
//
//  Created by Владислав Разводовский on 09.06.2023.
//

import CoreBluetooth

enum Direction: Int{
    case IDLE
    case LEFT
    case FORWARD
    case BACKWARD
    case RIGHT
}

class WalleBluetoothController: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate{
    var manager: CBCentralManager!
    var device: CBPeripheral!
    var UI: ViewController!
    var writeCharacteristic: CBCharacteristic!
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if (central.state == .poweredOn)
        {
            manager.scanForPeripherals(withServices: nil)
        }
    }
    
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if(peripheral.identifier == UUID(uuidString: "73F4C9D6-6052-0822-D0C2-45A5A96FCA52"))
        {
            device = peripheral
            manager.connect(device)
            manager.stopScan()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        
        UI.setBTConnectEstablished()
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            if(characteristic.properties.contains(.write)) {
                writeCharacteristic = characteristic
                break
            }
        }
    }
    
    func setDirection(dir: Direction)
    {
        device.writeValue(Data((String(dir.rawValue) + ";").utf8), for: writeCharacteristic, type: .withoutResponse)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
    }
    
    init(view: ViewController)
    {
        super.init()
        self.UI = view
        self.manager = CBCentralManager(delegate: self, queue: nil)
    }
}
