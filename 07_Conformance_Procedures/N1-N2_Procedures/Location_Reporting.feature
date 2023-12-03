@location-reporting-ue-presence-in-area-of-interest @07-conformance-procedure @location-reporting @23502-5gs @5g-core-sanity @5g-core

Feature: Location Reporting

  Scenario:Location Reporting Report Type - to Report UE Presence in Area of Interest

    Given the steps below will be executed at the end
    When I run the SSH command {abotprop.SUT.DEFAULT.GENB.CONFIG} at node gNodeB1
    When I run the SSH command {abotprop.SUT.DEFAULT.AMF.CONFIG} at node AMF1
    Then the ending steps are complete

    Given the test data is in file /featureFiles/MESSAGE_BUNDLES/EPC_MESSAGES.xml

    When I run the SSH command {abotprop.SUT.CUSTOM.GENB.CONFIG} and pause for {abotprop.WAIT_5_SEC} seconds at node gNodeB1
    When I run the SSH command {abotprop.SUT.CUSTOM.ENB.CONFIG} and pause for {abotprop.WAIT_5_SEC} seconds at node AMF1

    Given all configured endpoints for EPC are connected successfully

### UE Initial Registration with 5G AKA Procedure

    Given that I execute dependency feature /featureFiles/3GPP-23502-5G/02_Registration_Management_Procedures/5GS_UE_Initial_Registration_With_5G_AKA_Authentication.feature
      
####### Location Reporting
    
    When I send NGAP message NG_LOCATION_REPORTING_CONTROL on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                   | value             |
      | amf_ue_ngap_id                              | $(AMF_UE_NGAP_ID) |
      | ran_ue_ngap_id                              | $(RAN_UE_NGAP_ID) |
      | location_reporting_request_type.event_type  | 2                 |
      | location_reporting_request_type.report_area | 0                 |
      
    Then I receive and validate NGAP message NG_LOCATION_REPORTING_CONTROL on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                   | value                |
      | amf_ue_ngap_id                              | save(AMF_UE_NGAP_ID) |
      | ran_ue_ngap_id                              | save(RAN_UE_NGAP_ID) |
      | location_reporting_request_type.event_type  | {string:eq}(2)       |
      | location_reporting_request_type.report_area | {string:eq}(0)       |
      
    When I send NGAP message NG_LOCATION_REPORT on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                  | value             |
      | amf_ue_ngap_id                                                                             | $(AMF_UE_NGAP_ID) |
      | ran_ue_ngap_id                                                                             | $(RAN_UE_NGAP_ID) |
      | location_reporting_request_type.event_type                                                 | 2                 |
      | location_reporting_request_type.report_area                                                | 0                 |
      | user_location_information.e_utra_user_location_information.tai.plmn_identity.mcc           | 404               |
      | user_location_information.e_utra_user_location_information.tai.plmn_identity.mnc           | 30                |
      | user_location_information.e_utra_user_location_information.tai.tac                         | 0x100101          |
      | user_location_information.e_utra_user_location_information.e_utra_cgi.plmn_identity.mcc    | 404               |
      | user_location_information.e_utra_user_location_information.e_utra_cgi.plmn_identity.mnc    | 30                |
      | user_location_information.e_utra_user_location_information.e_utra_cgi.e_utra_cell_identity | 3584              |
      
    Then I receive and validate NGAP message NG_LOCATION_REPORT on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                  | value                 |
      | amf_ue_ngap_id                                                                             | save(AMF_UE_NGAP_ID)  |
      | ran_ue_ngap_id                                                                             | save(RAN_UE_NGAP_ID)  |
      | location_reporting_request_type.event_type                                                 | {string:eq}(2)        |
      | location_reporting_request_type.report_area                                                | {string:eq}(0)        |
      | user_location_information.e_utra_user_location_information.tai.plmn_identity.mcc           | {string:eq}(404)      |
      | user_location_information.e_utra_user_location_information.tai.plmn_identity.mnc           | {string:eq}(30)       |
      | user_location_information.e_utra_user_location_information.tai.tac                         | {string:eq}(0x100101) |
      | user_location_information.e_utra_user_location_information.e_utra_cgi.plmn_identity.mcc    | {string:eq}(404)      |
      | user_location_information.e_utra_user_location_information.e_utra_cgi.plmn_identity.mnc    | {string:eq}(30)       |
      | user_location_information.e_utra_user_location_information.e_utra_cgi.e_utra_cell_identity | {string:eq}(3584)     |
      
