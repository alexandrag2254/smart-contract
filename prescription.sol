contract Prescription {
  
  /**
   * It is helpful to think of
   * smart contracts as state machine.
   * In this example:
   * State 1: Deploy new smart contract for prescription
   * State 2: Set prescription details;
   * State 3: Smart contract is accepted by pharmacist
   * State 4: Prescription is filled - funds paid to pharmacist by patient
   */


  address physician;
  address pharmacist; //when the pharmacist signs tx - signed message match address of the correct pharmacist within the private server
  address patient; //send tx signed by private that corresponds with public address

  // global variables
  uint eth = 1000000000000000000;
  string stateMessage;

  // global prescription variables
  uint prescription_price;
  string license;
  string drug_name;
  uint drug_quantity;
  uint drug_units;
  uint drug_refills;
  string message;
  uint stateInt;


  // PATIENT AND PHYSICIAN DETAILS THAT NEED TO BE SECURED IN THE PRIVATE SERVER off chain not within the contract
    // dea = dea; // secure ?
    // patientName = patient_name; // secure ?
    // medicalrecordnumber = medicalrecordnumber; // secure?

   // FOR PRIVACY: need a private server - government server where sensitive records held - receive message - address of contract - find pharmacist
   // red cross, refugee, border control analogy

   // 1) Physician creates contract via html form
   // 2) Pharmacist accepts prescription contract have private key to gain sensitive information from the private server
   // 3) Patient brings private key to sign request for prescription 

// ----------

  function Prescription() {
    physician = msg.sender;
    stateMessage = "Uploaded prescription smart contract";
    stateInt = 1;
    message = stateMessage;

  }


  // patient identity: name, patient id number

// doctor: dea, name

// prescription request details: 1) drug name, dosage, units, refills, use direction


  /**
   * Set the details specific to this prescription 
   */
  function setUpPrescriptionDetails(string drug, uint quantity, address pharmacistaddress) {
    
    stateMessage = "Prescription details set";
    message = stateMessage;
    pharmacist = pharmacistaddress;
    stateInt = 2;

    //details of the prescription
    //prescription_price = price;
    //license = lic;
    drug_name = drug;
    drug_quantity = quantity;
    //drug_units = units;
    //drug_refills = refills;
    // dea = dea; secure ?
    // patientName = patient_name; // secure ?
    // medicalrecordnumber = medicalrecordnumber; //secure?

  }


  /**
   * Fund the prescription contract to accept it
   */
  function pharmacistAcceptsPrescriptionContract() {
    if (msg.sender == pharmacist && stateInt == 2 ) {
      pharmacist = msg.sender;
      stateInt = 3;
      stateMessage = "Pharmacist successfully accepting contract";
      message = stateMessage;
    } else {
      message = "Pharmacist did not accept prescription";
    }
  }


  /**
   * patient requests prescription to be filled and pays pharmacist
   */

  function patientRequestFill() {
    if ( msg.sender == patient && stateInt == 3 && msg.value == prescription_price ) {
      stateInt = 4;
      stateMessage = "Prescription Filled";
      message = stateMessage;
      pharmacist.send(this.balance);
    } else {
      msg.sender.send(msg.value);
      message = "Pharmacist needs to accept prescription first";
    }
  }


}
