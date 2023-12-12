@cp-dos-attack

Feature: DDoS_Attack

  Scenario:Generate SCTP traffic at a very high rate

    Given the steps below will be executed at the end
    When I run the SSH command {abotprop.SUT.DEFAULT.AMF.CONFIG} at node AMF1
    When I run the SSH command {abotprop.SUT.DEFAULT.gNodeB.CONFIG} at node gNodeB1
    Then the ending steps are complete

    When I run the SSH command {abotprop.SUT.CUSTOM.AMF.CONFIG} and pause for {abotprop.WAIT_5_SEC} seconds at node AMF1
    When I run the SSH command {abotprop.SUT.CUSTOM.gNodeB.CONFIG} and pause for {abotprop.WAIT_5_SEC} seconds at node gNodeB1

    Given the test data is in file /featureFiles/MESSAGE_BUNDLES/EPC_MESSAGES.xml
    Given all configured endpoints for EPC are connected successfully
    
    Given that I execute dependency feature /featureFiles/3GPP-23502-5G/01_Interface_Management_Procedures/01_gNB_AMF_procedures/01_NG_Setup_Procedure/NG_Setup_Request.feature
    
    Given I iterate 10 times      
    #Registration Process
    When I send NGAP message NG_INIT_UE_MSG_NAS_REGIS_REQ on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                         | value                                     |
      | ran_ue_ngap_id                                                                    | incr({abotprop.SUT.RAN.UE.NGAP.ID.1},1)     |
      | nas_pdu.extended_protocol_discriminator                                           | {abotprop.SUT.NAS.EDP}                    |
      | nas_pdu.security_header_type                                                      | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}         |
      | nas_pdu.message_type                                                              | {abotprop.SUT.NAS.REG.REQ.MSG}            |
      | nas_pdu.registration_request.5gs_registration_type                                | {abotprop.SUT.NAS.5GS.REG.TYPE.INI.REG}   |
      | nas_pdu.registration_request.nas_key_set_identifier                               | {abotprop.SUT.NAS.KSI}                    |
      | nas_pdu.registration_request.5gs_mob_id_choice.type_of_id                         | 0x01                                      |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_format                   | 0x00                                      |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_netwrk_id.mcc  | {abotprop.SUT.MCC}                        |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_netwrk_id.mnc  | {abotprop.SUT.MNC}                        |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.routing_ind         | 0                                         |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.prot_scheme_id      | 0                                         |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_net_pub_key_id | 0                                         |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.msin                | incr({abotprop.SUT.NAS.5GS.MOB.MSIN.1},1)   |
      | nas_pdu.registration_request.ue_security_capability                               | {abotprop.SUT.NAS.UE.SEC.CAPA}            |
      | nas_pdu.registration_request.ue_status                                            | {abotprop.SUT.NAS.UE.STAT}                |
      | rrc_establishment_cause                                                           | {abotprop.SUT.RRC.ESTD.CAUSE}             |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc      | {abotprop.SUT.MCC}                        |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc      | {abotprop.SUT.MNC}                        |
      | user_location_information.nr_user_location_information.tai.tac                    | {abotprop.SUT.TAC}                        |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc   | {abotprop.SUT.MCC}                        |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc   | {abotprop.SUT.MNC}                        |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity    | {abotprop.SUT.NR.CELL.IDN}                |
      | ue_context_request                                                                | 0                                         |

    Then I receive and validate NGAP message NG_INIT_UE_MSG_NAS_REGIS_REQ on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                       | value                                                  |
      | ran_ue_ngap_id                                                                  | save(RAN_UE_NGAP_ID)                                   |
      | nas_pdu.extended_protocol_discriminator                                         | {string:eq}({abotprop.SUT.NAS.EDP})                    |
      | nas_pdu.security_header_type                                                    | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.PLAIN})         |
      | nas_pdu.message_type                                                            | {string:eq}({abotprop.SUT.NAS.REG.REQ.MSG})            |
      | nas_pdu.registration_request.5gs_registration_type                              | {string:eq}({abotprop.SUT.NAS.5GS.REG.TYPE.INI.REG})   |
      | nas_pdu.registration_request.5gs_mobile_identity                                | save(MOBILE_IDENTITY_5GS)                              |
      | nas_pdu.registration_request.ue_security_capability                             | {string:eq}({abotprop.SUT.NAS.UE.SEC.CAPA})            |
      | nas_pdu.registration_request.ue_status                                          | {string:eq}({abotprop.SUT.NAS.UE.STAT})                |
      | rrc_establishment_cause                                                         | {string:eq}({abotprop.SUT.RRC.ESTD.CAUSE})             |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {string:eq}({abotprop.SUT.MCC})                        |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {string:eq}({abotprop.SUT.MNC})                        |
      | user_location_information.nr_user_location_information.tai.tac                  | {string:eq}({abotprop.SUT.TAC})                        |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {string:eq}({abotprop.SUT.MCC})                        |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {string:eq}({abotprop.SUT.MNC})                        |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {string:eq}({abotprop.SUT.NR.CELL.IDN})                |
      | ue_context_request                                                              | {string:eq}(0)                                         |

    When I send NGAP message NG_DOWNLINK_NAS_AUTHENTICATION_REQ on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                                    | value                                                            |
      | amf_ue_ngap_id                                               | {abotprop.SUT.AMF.UE.NGAP.ID.1}                                    |
      | ran_ue_ngap_id                                               | {abotprop.SUT.RAN.UE.NGAP.ID.1}                                    |
      | nas_pdu.extended_protocol_discriminator                      | {abotprop.SUT.NAS.EDP}                                           |
      | nas_pdu.security_header_type                                 | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}                                |
      | nas_pdu.message_type                                         | {abotprop.SUT.NAS.AUTN.REQ.MSG}                                  |
      | nas_pdu.authentication_request.nas_key_set_identifier        | {abotprop.SUT.NAS.KSI}                                           |
      | nas_pdu.authentication_request.abba                          | 0x0000                                                           |
      | nas_pdu.authentication_request.authentication_parameter_autn | AC955A53F63880018C5749D20450A72B                                 |
      | nas_pdu.authentication_request.authentication_parameter_rand | b78c030000000000b78c030000000000                                 |
      | nas_pdu.authentication_request.supi                          | incr({abotprop.SUT.SUPI.1},1)                                    |
      | nas_pdu.authentication_request.kseaf                         | 98cb7b7f3be2497d47c320ffa683b75a5a0822bd9c786facf6be7e22eae58df7 |

    Then I receive and validate NGAP message NG_DOWNLINK_NAS_AUTHENTICATION_REQ on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                                    | value                                          |
      | amf_ue_ngap_id                                               | save(AMF_UE_NGAP_ID)                           |
      | ran_ue_ngap_id                                               | save(RAN_UE_NGAP_ID)                           |
      | nas_pdu.extended_protocol_discriminator                      | {string:eq}({abotprop.SUT.NAS.EDP})            |
      | nas_pdu.security_header_type                                 | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.PLAIN}) |
      | nas_pdu.message_type                                         | {string:eq}({abotprop.SUT.NAS.AUTN.REQ.MSG})   |
      | nas_pdu.authentication_request.nas_key_set_identifier        | {string:eq}({abotprop.SUT.NAS.KSI})            |
      | nas_pdu.authentication_request.abba                          | {string:eq}(0x0000)                            |
      | nas_pdu.authentication_request.authentication_parameter_autn | save(5G_AKA_AUTN_AT_GNB1)                      |
      | nas_pdu.authentication_request.authentication_parameter_rand | save(5G_AKA_RAND_AT_GNB1)                      |
      | nas_pdu.authentication_request.K                             | 8baf473f2f8fd09487cccbd7097c6862               |
      | nas_pdu.authentication_request.OP                            | 1006020f0a478bf6b699f15c062e42b3               |
      | nas_pdu.authentication_request.serving_network_name          | 5G:mnc030.mcc404.3gppnetwork.org               |
      | nas_pdu.authentication_request.supi                          | incr({abotprop.SUT.SUPI.1},1)                  |

    When I send NGAP message NG_UPLINK_NAS_AUTHENTICATION_RES on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                       | value                              |
      | amf_ue_ngap_id                                                                  | $(AMF_UE_NGAP_ID)                  |
      | ran_ue_ngap_id                                                                  | {abotprop.SUT.RAN.UE.NGAP.ID.1}      |
      | nas_pdu.extended_protocol_discriminator                                         | {abotprop.SUT.NAS.EDP}             |
      | nas_pdu.security_header_type                                                    | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}  |
      | nas_pdu.message_type                                                            | {abotprop.SUT.NAS.AUTN.RES.MSG}    |
      | nas_pdu.authentication_response.authentication_response_parameter               | 0x00000000000000000000000000000000 |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {abotprop.SUT.MCC}                 |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {abotprop.SUT.MNC}                 |
      | user_location_information.nr_user_location_information.tai.tac                  | {abotprop.SUT.TAC}                 |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {abotprop.SUT.MCC}                 |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {abotprop.SUT.MNC}                 |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {abotprop.SUT.NR.CELL.IDN}         |

    Then I receive and validate NGAP message NG_UPLINK_NAS_AUTHENTICATION_RES on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                       | value                                          |
      | amf_ue_ngap_id                                                                  | save(AMF_UE_NGAP_ID)                           |
      | ran_ue_ngap_id                                                                  | {string:eq}({abotprop.SUT.RAN.UE.NGAP.ID.1})     |
      | nas_pdu.extended_protocol_discriminator                                         | {string:eq}({abotprop.SUT.NAS.EDP})            |
      | nas_pdu.security_header_type                                                    | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.PLAIN}) |
      | nas_pdu.message_type                                                            | {string:eq}({abotprop.SUT.NAS.AUTN.RES.MSG})   |
      | nas_pdu.authentication_response.authentication_response_parameter               | save(UE_5G_AKA_RES_STAR_AT_AMF1)               |
      | nas_pdu.authentication_response.rand                                            | b78c030000000000b78c030000000000               |
      | nas_pdu.authentication_response.hresstar                                        | {string:eq}(ec307a3f9f3bf828d8d7eed24ce3d6da)  |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {string:eq}({abotprop.SUT.MCC})                |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {string:eq}({abotprop.SUT.MNC})                |
      | user_location_information.nr_user_location_information.tai.tac                  | {string:eq}({abotprop.SUT.TAC})                |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {string:eq}({abotprop.SUT.MCC})                |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {string:eq}({abotprop.SUT.MNC})                |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {string:eq}({abotprop.SUT.NR.CELL.IDN})        |

    When I send NGAP message NG_DOWNLINK_NAS_SECURITY_MODE_CMD on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                            | value                          |
      | amf_ue_ngap_id                                       | $(AMF_UE_NGAP_ID)              |
      | ran_ue_ngap_id                                       | {abotprop.SUT.RAN.UE.NGAP.ID.1}  |
      | nas_pdu.extended_protocol_discriminator              | {abotprop.SUT.NAS.EDP}         |
      | nas_pdu.security_header_type                         | 0x03                           |
      | nas_pdu.message_type                                 | {abotprop.SUT.NAS.SEC.CMD.MSG} |
      | nas_pdu.security_mode_command.nas_security_algorithm | 0x11                           |
      | nas_pdu.security_mode_command.nas_key_set_identifier | {abotprop.SUT.NAS.KSI}         |
      | nas_pdu.security_mode_command.ue_security_capability | {abotprop.SUT.NAS.UE.SEC.CAPA} |

    Then I receive and validate NGAP message NG_DOWNLINK_NAS_SECURITY_MODE_CMD on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                            | value                                       |
      | amf_ue_ngap_id                                       | {string:eq}($(AMF_UE_NGAP_ID))              |
      | ran_ue_ngap_id                                       | {string:eq}({abotprop.SUT.RAN.UE.NGAP.ID.1})  |
      | nas_pdu.extended_protocol_discriminator              | {string:eq}({abotprop.SUT.NAS.EDP})         |
      | nas_pdu.security_header_type                         | {string:eq}(0x03)                           |
      | nas_pdu.message_type                                 | {string:eq}({abotprop.SUT.NAS.SEC.CMD.MSG}) |
      | nas_pdu.security_mode_command.nas_security_algorithm | {string:eq}(0x11)                           |
      | nas_pdu.security_mode_command.nas_key_set_identifier | {string:eq}({abotprop.SUT.NAS.KSI})         |
      | nas_pdu.security_mode_command.ue_security_capability | {string:eq}({abotprop.SUT.NAS.UE.SEC.CAPA}) |

    When I send NGAP message NG_UPLINK_NAS_SECURITY_MODE_COMPLETE on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                      | value                                     |
      | amf_ue_ngap_id                                                                                                                 | $(AMF_UE_NGAP_ID)                         |
      | ran_ue_ngap_id                                                                                                                 | $(RAN_UE_NGAP_ID)                         |
      | nas_pdu.extended_protocol_discriminator                                                                                        | {abotprop.SUT.NAS.EDP}                    |
      | nas_pdu.security_header_type                                                                                                   | 0x04                                      |
      | nas_pdu.message_type                                                                                                           | {abotprop.SUT.NAS.SEC.COM.MSG}            |
      | nas_pdu.security_mode_complete.nas_message_container.extended_protocol_discriminator                                           | {abotprop.SUT.NAS.EDP}                    |
      | nas_pdu.security_mode_complete.nas_message_container.security_header_type                                                      | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}         |
      | nas_pdu.security_mode_complete.nas_message_container.message_type                                                              | {abotprop.SUT.NAS.REG.REQ.MSG}            |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_registration_type                                | {abotprop.SUT.NAS.5GS.REG.TYPE.INI.REG}   |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.nas_key_set_identifier                               | {abotprop.SUT.NAS.KSI}                    |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.type_of_id                         | 0x01                                      |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_format                   | 0x00                                      |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_netwrk_id.mcc  | {abotprop.SUT.MCC}                        |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_netwrk_id.mnc  | {abotprop.SUT.MNC}                        |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_imsi.routing_ind         | 0                                         |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_imsi.prot_scheme_id      | 0                                         |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_net_pub_key_id | 0                                         |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_imsi.msin                | incr({abotprop.SUT.NAS.5GS.MOB.MSIN.1},1) |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gmm_capability                                      | {abotprop.SUT.NAS.5GMM.CAPA}              |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.ue_security_capability                               | {abotprop.SUT.NAS.UE.SEC.CAPA}            |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.nssai                                                | {abotprop.SUT.NAS.NSSAI}                  |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_tracking_area_identity                           | {abotprop.SUT.NAS.5GS.TAI}                |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.s1_ue_network_capability                             | {abotprop.SUT.NAS.S1.UE.NET.CAPA}         |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.uplink_data_status                                   | {abotprop.SUT.NAS.UPLINK.DATA.STAT}       |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.pdu_session_status                                   | {abotprop.SUT.NAS.PDU.SESS.STAT}          |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.mico_indication                                      | {abotprop.SUT.NAS.MICO.INDICATION}        |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.ue_status                                            | {abotprop.SUT.NAS.UE.STAT}                |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.allowed_pdu_session_status                           | {abotprop.SUT.NAS.ALLOWED.PDU.SESS.STAT}  |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.ue_usage_setting                                     | {abotprop.SUT.NAS.UE.USAGE.SETTING}       |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.drx_parameter                                        | {abotprop.SUT.NAS.DRX.PARAM}              |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.ladnindication                                       | {abotprop.SUT.NAS.LADN.INDICATION}        |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.payload_container                                    | {abotprop.SUT.NAS.PAYLOAD.CONTAINER}      |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.network_slicing_indication                           | {abotprop.SUT.NAS.NET.SLICING.INDICATION} |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_update_type                                      | {abotprop.SUT.NAS.5GS.UPDT.TYPE}          |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                                                   | {abotprop.SUT.MCC}                        |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                                                   | {abotprop.SUT.MNC}                        |
      | user_location_information.nr_user_location_information.tai.tac                                                                 | {abotprop.SUT.TAC}                        |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                                                | {abotprop.SUT.MCC}                        |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                                                | {abotprop.SUT.MNC}                        |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                                                 | {abotprop.SUT.NR.CELL.IDN}                |

    Then I receive and validate NGAP message NG_UPLINK_NAS_SECURITY_MODE_COMPLETE on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                            | value                                                  |
      | amf_ue_ngap_id                                                                                       | {string:eq}($(AMF_UE_NGAP_ID))                         |
      | ran_ue_ngap_id                                                                                       | {string:eq}($(RAN_UE_NGAP_ID))                         |
      | nas_pdu.extended_protocol_discriminator                                                              | {string:eq}({abotprop.SUT.NAS.EDP})                    |
      | nas_pdu.security_header_type                                                                         | {string:eq}(0x04)                                      |
      | nas_pdu.message_type                                                                                 | {string:eq}({abotprop.SUT.NAS.SEC.COM.MSG})            |
      | nas_pdu.security_mode_complete.nas_message_container.extended_protocol_discriminator                 | {string:eq}({abotprop.SUT.NAS.EDP})                    |
      | nas_pdu.security_mode_complete.nas_message_container.security_header_type                            | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.PLAIN})         |
      | nas_pdu.security_mode_complete.nas_message_container.message_type                                    | {string:eq}({abotprop.SUT.NAS.REG.REQ.MSG})            |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_registration_type      | {string:eq}({abotprop.SUT.NAS.5GS.REG.TYPE.INI.REG})   |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mobile_identity        | save(MOBILE_IDENTITY_5GS)                              |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gmm_capability            | {string:eq}({abotprop.SUT.NAS.5GMM.CAPA})              |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.ue_security_capability     | {string:eq}({abotprop.SUT.NAS.UE.SEC.CAPA})            |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.nssai                      | {string:eq}({abotprop.SUT.NAS.NSSAI})                  |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_tracking_area_identity | {string:eq}({abotprop.SUT.NAS.5GS.TAI})                |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.s1_ue_network_capability   | {string:eq}({abotprop.SUT.NAS.S1.UE.NET.CAPA})         |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.uplink_data_status         | {string:eq}({abotprop.SUT.NAS.UPLINK.DATA.STAT})       |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.pdu_session_status         | {string:eq}({abotprop.SUT.NAS.PDU.SESS.STAT})          |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.mico_indication            | {string:eq}({abotprop.SUT.NAS.MICO.INDICATION})        |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.ue_status                  | {string:eq}({abotprop.SUT.NAS.UE.STAT})                |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.allowed_pdu_session_status | {string:eq}({abotprop.SUT.NAS.ALLOWED.PDU.SESS.STAT})  |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.ue_usage_setting           | {string:eq}({abotprop.SUT.NAS.UE.USAGE.SETTING})       |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.drx_parameter              | {string:eq}({abotprop.SUT.NAS.DRX.PARAM})              |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.ladnindication             | {string:eq}({abotprop.SUT.NAS.LADN.INDICATION})        |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.payload_container          | {string:eq}({abotprop.SUT.NAS.PAYLOAD.CONTAINER})      |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.network_slicing_indication | {string:eq}({abotprop.SUT.NAS.NET.SLICING.INDICATION}) |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_update_type            | {string:eq}({abotprop.SUT.NAS.5GS.UPDT.TYPE})          |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                         | {string:eq}({abotprop.SUT.MCC})                        |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                         | {string:eq}({abotprop.SUT.MNC})                        |
      | user_location_information.nr_user_location_information.tai.tac                                       | {string:eq}({abotprop.SUT.TAC})                        |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                      | {string:eq}({abotprop.SUT.MCC})                        |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                      | {string:eq}({abotprop.SUT.MNC})                        |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                       | {string:eq}({abotprop.SUT.NR.CELL.IDN})                |

    When I send NGAP message NG_INIT_CTXT_SET_REQ_NAS_REGIS_ACC on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                                                                       | value                                                            |
      | amf_ue_ngap_id                                                                                  | $(AMF_UE_NGAP_ID)                                                |
      | ran_ue_ngap_id                                                                                  | {abotprop.SUT.RAN.UE.NGAP.ID.1}                                    |
      | nas_pdu.extended_protocol_discriminator                                                         | {abotprop.SUT.NAS.EDP}                                           |
      | nas_pdu.security_header_type                                                                    | 0x02                                                             |
      | nas_pdu.message_type                                                                            | {abotprop.SUT.NAS.REG.ACC.MSG}                                   |
      | nas_pdu.registration_accept.5gs_reg_result                                                      | 9                                                                |
      | nas_pdu.registration_accept.5gs_mob_id_choice.type_of_id                                        | 0x02                                                             |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.mcc                                       | {abotprop.SUT.MCC}                                               |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.mnc                                       | {abotprop.SUT.MNC}                                               |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_region_id                             | {abotprop.SUT.GUAMI.AMF.REGION.ID}                               |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_set_id                                | {abotprop.SUT.GUAMI.AMF.SET.ID}                                  |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_pointer                               | {abotprop.SUT.GUAMI.AMF.POINTER}                                 |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.5g_tmsi                                   | incr({abotprop.SUT.5GTMSI.START.1},1)                              |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.type_of_list                            | 0                                                                |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.no_of_elements                          | 1                                                                |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.mcc            | {abotprop.SUT.MCC}                                               |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.mnc            | {abotprop.SUT.MNC}                                               |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.tac_list.0.tac | {abotprop.SUT.TAC}                                               |
      | guami.plmn_identity.mcc                                                                         | {abotprop.SUT.MCC}                                               |
      | guami.plmn_identity.mnc                                                                         | {abotprop.SUT.MNC}                                               |
      | guami.amf_region_id                                                                             | {abotprop.SUT.GUAMI.AMF.REGION.ID}                               |
      | guami.amf_set_id                                                                                | {abotprop.SUT.GUAMI.AMF.SET.ID}                                  |
      | guami.pointer.amf_pointer                                                                       | {abotprop.SUT.GUAMI.AMF.POINTER}                                 |
      | allowed_s-nssai_list.0.sst                                                                      | 1                                                                |
      | ue_security_capabilities.nr_encryption_algo                                                     | 0xc000                                                           |
      | ue_security_capabilities.nr_integrity_protection_algo                                           | 0xc000                                                           |
      | ue_security_capabilities.e_utra_encryption_algo                                                 | 0x0000                                                           |
      | ue_security_capabilities.e_utra_integrity_protection_algo                                       | 0x0000                                                           |
      | security_key                                                                                    | a8202f2d5e1d4307b751e0ac558025f2865d9c25eebb409d9a5560145dd8e765 |

    Then I receive and validate NGAP message NG_INIT_CTXT_SET_REQ_NAS_REGIS_ACC on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                                                                       | value                                                                         |
      | amf_ue_ngap_id                                                                                  | {string:eq}($(AMF_UE_NGAP_ID))                                                |
      | ran_ue_ngap_id                                                                                  | {string:eq}({abotprop.SUT.RAN.UE.NGAP.ID.1})                                    |
      | nas_pdu.extended_protocol_discriminator                                                         | {string:eq}({abotprop.SUT.NAS.EDP})                                           |
      | nas_pdu.security_header_type                                                                    | {string:eq}(0x02)                                                             |
      | nas_pdu.message_type                                                                            | {string:eq}({abotprop.SUT.NAS.REG.ACC.MSG})                                   |
      | nas_pdu.registration_accept.5gs_reg_result                                                      | {string:eq}(9)                                                                |
      | nas_pdu.registration_accept.5gs_mob_id_choice.type_of_id                                        | {string:eq}(0x02)                                                             |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.mcc                                       | save(MCC)                                                                     |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.mnc                                       | save(MNC)                                                                     |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_region_id                             | save(AMF_REGION_ID)                                                           |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_set_id                                | save(AMF_SET_ID)                                                              |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_pointer                               | save(AMF_POINTER)                                                             |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.5g_tmsi                                   | save(5G_TMSI)                                                                 |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.type_of_list                            | {string:eq}(0)                                                                |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.no_of_elements                          | {string:eq}(1)                                                                |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.mcc            | {string:eq}({abotprop.SUT.MCC})                                               |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.mnc            | {string:eq}({abotprop.SUT.MNC})                                               |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.tac_list.0.tac | {string:eq}({abotprop.SUT.TAC})                                               |
      | guami.plmn_identity.mcc                                                                         | {string:eq}({abotprop.SUT.MCC})                                               |
      | guami.plmn_identity.mnc                                                                         | {string:eq}({abotprop.SUT.MNC})                                               |
      | guami.amf_region_id                                                                             | {string:eq}({abotprop.SUT.GUAMI.AMF.REGION.ID})                               |
      | guami.amf_set_id                                                                                | {string:eq}({abotprop.SUT.GUAMI.AMF.SET.ID})                                  |
      | guami.pointer.amf_pointer                                                                       | {string:eq}({abotprop.SUT.GUAMI.AMF.POINTER})                                 |
      | allowed_s-nssai_list.0.sst                                                                      | {string:eq}(1)                                                                |
      | ue_security_capabilities.nr_encryption_algo                                                     | {string:eq}(0xc000)                                                           |
      | ue_security_capabilities.nr_integrity_protection_algo                                           | {string:eq}(0xc000)                                                           |
      | ue_security_capabilities.e_utra_encryption_algo                                                 | {string:eq}(0x0000)                                                           |
      | ue_security_capabilities.e_utra_integrity_protection_algo                                       | {string:eq}(0x0000)                                                           |
      | security_key                                                                                    | {string:eq}(a8202f2d5e1d4307b751e0ac558025f2865d9c25eebb409d9a5560145dd8e765) |

    When I send NGAP message NG_INIT_CTXT_SET_RES on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter      | value                         |
      | amf_ue_ngap_id | $(AMF_UE_NGAP_ID)             |
      | ran_ue_ngap_id | {abotprop.SUT.RAN.UE.NGAP.ID.1} |

    Then I receive and validate NGAP message NG_INIT_CTXT_SET_RES on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter      | value                                      |
      | amf_ue_ngap_id | {string:eq}($(AMF_UE_NGAP_ID))             |
      | ran_ue_ngap_id | {string:eq}({abotprop.SUT.RAN.UE.NGAP.ID.1}) |

    When I send NGAP message NG_UPLINK_NAS_REGIS_COMPLETE on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                       | value                          |
      | amf_ue_ngap_id                                                                  | $(AMF_UE_NGAP_ID)              |
      | ran_ue_ngap_id                                                                  | {abotprop.SUT.RAN.UE.NGAP.ID.1}  |
      | nas_pdu.extended_protocol_discriminator                                         | {abotprop.SUT.NAS.EDP}         |
      | nas_pdu.security_header_type                                                    | 0x02                           |
      | nas_pdu.message_type                                                            | {abotprop.SUT.NAS.REG.COM.MSG} |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {abotprop.SUT.MCC}             |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {abotprop.SUT.MNC}             |
      | user_location_information.nr_user_location_information.tai.tac                  | {abotprop.SUT.TAC}             |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {abotprop.SUT.MCC}             |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {abotprop.SUT.MNC}             |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {abotprop.SUT.NR.CELL.IDN}     |

    Then I receive and validate NGAP message NG_UPLINK_NAS_REGIS_COMPLETE on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                       | value                                       |
      | amf_ue_ngap_id                                                                  | {string:eq}($(AMF_UE_NGAP_ID))              |
      | ran_ue_ngap_id                                                                  | {string:eq}({abotprop.SUT.RAN.UE.NGAP.ID.1})  |
      | nas_pdu.extended_protocol_discriminator                                         | {string:eq}({abotprop.SUT.NAS.EDP})         |
      | nas_pdu.security_header_type                                                    | {string:eq}(0x02)                           |
      | nas_pdu.message_type                                                            | {string:eq}({abotprop.SUT.NAS.REG.COM.MSG}) |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {string:eq}({abotprop.SUT.MCC})             |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {string:eq}({abotprop.SUT.MNC})             |
      | user_location_information.nr_user_location_information.tai.tac                  | {string:eq}({abotprop.SUT.TAC})             |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {string:eq}({abotprop.SUT.MCC})             |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {string:eq}({abotprop.SUT.MNC})             |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {string:eq}({abotprop.SUT.NR.CELL.IDN})     |

    Given the execution is paused for 10 seconds

	Given I end iteration
    
	Given I initiate RATE_CONTROL_ENFORCEMENT with the following parameters:
      | parameter         | value       |
      | search_pattern    | NIKSUN_SCTP |
      | RATE_CONTROL.HIGH | 0           |
      | RATE_CONTROL.LOW  | 10          |
	
    #### SCTP message storm
    Given I iterate 50 times
    #Registration Process
    When I send NGAP message NG_INIT_UE_MSG_NAS_REGIS_REQ on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                         | value                                     |
      | ran_ue_ngap_id                                                                    | incr({abotprop.SUT.RAN.UE.NGAP.ID.1},1)     |
      | nas_pdu.extended_protocol_discriminator                                           | {abotprop.SUT.NAS.EDP}                    |
      | nas_pdu.security_header_type                                                      | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}         |
      | nas_pdu.message_type                                                              | {abotprop.SUT.NAS.REG.REQ.MSG}            |
      | nas_pdu.registration_request.5gs_registration_type                                | {abotprop.SUT.NAS.5GS.REG.TYPE.INI.REG}   |
      | nas_pdu.registration_request.nas_key_set_identifier                               | {abotprop.SUT.NAS.KSI}                    |
      | nas_pdu.registration_request.5gs_mob_id_choice.type_of_id                         | 0x01                                      |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_format                   | 0x00                                      |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_netwrk_id.mcc  | {abotprop.SUT.MCC}                        |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_netwrk_id.mnc  | {abotprop.SUT.MNC}                        |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.routing_ind         | 0                                         |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.prot_scheme_id      | 0                                         |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_net_pub_key_id | 0                                         |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.msin                | incr({abotprop.SUT.NAS.5GS.MOB.MSIN.1},1) |
      | nas_pdu.registration_request.ue_security_capability                               | {abotprop.SUT.NAS.UE.SEC.CAPA}            |
      | nas_pdu.registration_request.ue_status                                            | {abotprop.SUT.NAS.UE.STAT}                |
      | rrc_establishment_cause                                                           | {abotprop.SUT.RRC.ESTD.CAUSE}             |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc      | {abotprop.SUT.MCC}                        |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc      | {abotprop.SUT.MNC}                        |
      | user_location_information.nr_user_location_information.tai.tac                    | {abotprop.SUT.TAC}                        |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc   | {abotprop.SUT.MCC}                        |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc   | {abotprop.SUT.MNC}                        |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity    | {abotprop.SUT.NR.CELL.IDN}                |
      | ue_context_request                                                                | 0                                         |

    Then I receive and validate NGAP message NG_INIT_UE_MSG_NAS_REGIS_REQ on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                       | value                                                  |
      | ran_ue_ngap_id                                                                  | save(RAN_UE_NGAP_ID)                                   |
      | nas_pdu.extended_protocol_discriminator                                         | {string:eq}({abotprop.SUT.NAS.EDP})                    |
      | nas_pdu.security_header_type                                                    | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.PLAIN})         |
      | nas_pdu.message_type                                                            | {string:eq}({abotprop.SUT.NAS.REG.REQ.MSG})            |
      | nas_pdu.registration_request.5gs_registration_type                              | {string:eq}({abotprop.SUT.NAS.5GS.REG.TYPE.INI.REG})   |
      | nas_pdu.registration_request.5gs_mobile_identity                                | save(MOBILE_IDENTITY_5GS)                              |
      | nas_pdu.registration_request.ue_security_capability                             | {string:eq}({abotprop.SUT.NAS.UE.SEC.CAPA})            |
      | nas_pdu.registration_request.ue_status                                          | {string:eq}({abotprop.SUT.NAS.UE.STAT})                |
      | rrc_establishment_cause                                                         | {string:eq}({abotprop.SUT.RRC.ESTD.CAUSE})             |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {string:eq}({abotprop.SUT.MCC})                        |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {string:eq}({abotprop.SUT.MNC})                        |
      | user_location_information.nr_user_location_information.tai.tac                  | {string:eq}({abotprop.SUT.TAC})                        |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {string:eq}({abotprop.SUT.MCC})                        |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {string:eq}({abotprop.SUT.MNC})                        |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {string:eq}({abotprop.SUT.NR.CELL.IDN})                |
      | ue_context_request                                                              | {string:eq}(0)                                         |

    When I send NGAP message NG_DOWNLINK_NAS_AUTHENTICATION_REQ on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                                    | value                                                            |
      | amf_ue_ngap_id                                               | {abotprop.SUT.AMF.UE.NGAP.ID.1}                                    |
      | ran_ue_ngap_id                                               | {abotprop.SUT.RAN.UE.NGAP.ID.1}                                    |
      | nas_pdu.extended_protocol_discriminator                      | {abotprop.SUT.NAS.EDP}                                           |
      | nas_pdu.security_header_type                                 | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}                                |
      | nas_pdu.message_type                                         | {abotprop.SUT.NAS.AUTN.REQ.MSG}                                  |
      | nas_pdu.authentication_request.nas_key_set_identifier        | {abotprop.SUT.NAS.KSI}                                           |
      | nas_pdu.authentication_request.abba                          | 0x0000                                                           |
      | nas_pdu.authentication_request.authentication_parameter_autn | AC955A53F63880018C5749D20450A72B                                 |
      | nas_pdu.authentication_request.authentication_parameter_rand | b78c030000000000b78c030000000000                                 |
      | nas_pdu.authentication_request.supi                          | incr({abotprop.SUT.SUPI.1},1)                                    |
      | nas_pdu.authentication_request.kseaf                         | 98cb7b7f3be2497d47c320ffa683b75a5a0822bd9c786facf6be7e22eae58df7 |

    Then I receive and validate NGAP message NG_DOWNLINK_NAS_AUTHENTICATION_REQ on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                                    | value                                          |
      | amf_ue_ngap_id                                               | save(AMF_UE_NGAP_ID)                           |
      | ran_ue_ngap_id                                               | save(RAN_UE_NGAP_ID)                           |
      | nas_pdu.extended_protocol_discriminator                      | {string:eq}({abotprop.SUT.NAS.EDP})            |
      | nas_pdu.security_header_type                                 | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.PLAIN}) |
      | nas_pdu.message_type                                         | {string:eq}({abotprop.SUT.NAS.AUTN.REQ.MSG})   |
      | nas_pdu.authentication_request.nas_key_set_identifier        | {string:eq}({abotprop.SUT.NAS.KSI})            |
      | nas_pdu.authentication_request.abba                          | {string:eq}(0x0000)                            |
      | nas_pdu.authentication_request.authentication_parameter_autn | save(5G_AKA_AUTN_AT_GNB1)                      |
      | nas_pdu.authentication_request.authentication_parameter_rand | save(5G_AKA_RAND_AT_GNB1)                      |
      | nas_pdu.authentication_request.K                             | 8baf473f2f8fd09487cccbd7097c6862               |
      | nas_pdu.authentication_request.OP                            | 1006020f0a478bf6b699f15c062e42b3               |
      | nas_pdu.authentication_request.serving_network_name          | 5G:mnc030.mcc404.3gppnetwork.org               |
      | nas_pdu.authentication_request.supi                          | incr({abotprop.SUT.SUPI.1},1)                  |

    When I send NGAP message NG_UPLINK_NAS_AUTHENTICATION_RES on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                       | value                              |
      | amf_ue_ngap_id                                                                  | $(AMF_UE_NGAP_ID)                  |
      | ran_ue_ngap_id                                                                  | {abotprop.SUT.RAN.UE.NGAP.ID.1}      |
      | nas_pdu.extended_protocol_discriminator                                         | {abotprop.SUT.NAS.EDP}             |
      | nas_pdu.security_header_type                                                    | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}  |
      | nas_pdu.message_type                                                            | {abotprop.SUT.NAS.AUTN.RES.MSG}    |
      | nas_pdu.authentication_response.authentication_response_parameter               | 0x00000000000000000000000000000000 |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {abotprop.SUT.MCC}                 |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {abotprop.SUT.MNC}                 |
      | user_location_information.nr_user_location_information.tai.tac                  | {abotprop.SUT.TAC}                 |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {abotprop.SUT.MCC}                 |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {abotprop.SUT.MNC}                 |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {abotprop.SUT.NR.CELL.IDN}         |

    Then I receive and validate NGAP message NG_UPLINK_NAS_AUTHENTICATION_RES on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                       | value                                          |
      | amf_ue_ngap_id                                                                  | save(AMF_UE_NGAP_ID)                           |
      | ran_ue_ngap_id                                                                  | {string:eq}({abotprop.SUT.RAN.UE.NGAP.ID.1})     |
      | nas_pdu.extended_protocol_discriminator                                         | {string:eq}({abotprop.SUT.NAS.EDP})            |
      | nas_pdu.security_header_type                                                    | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.PLAIN}) |
      | nas_pdu.message_type                                                            | {string:eq}({abotprop.SUT.NAS.AUTN.RES.MSG})   |
      | nas_pdu.authentication_response.authentication_response_parameter               | save(UE_5G_AKA_RES_STAR_AT_AMF1)               |
      | nas_pdu.authentication_response.rand                                            | b78c030000000000b78c030000000000               |
      | nas_pdu.authentication_response.hresstar                                        | {string:eq}(ec307a3f9f3bf828d8d7eed24ce3d6da)  |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {string:eq}({abotprop.SUT.MCC})                |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {string:eq}({abotprop.SUT.MNC})                |
      | user_location_information.nr_user_location_information.tai.tac                  | {string:eq}({abotprop.SUT.TAC})                |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {string:eq}({abotprop.SUT.MCC})                |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {string:eq}({abotprop.SUT.MNC})                |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {string:eq}({abotprop.SUT.NR.CELL.IDN})        |

    When I send NGAP message NG_DOWNLINK_NAS_SECURITY_MODE_CMD on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                            | value                          |
      | amf_ue_ngap_id                                       | $(AMF_UE_NGAP_ID)              |
      | ran_ue_ngap_id                                       | {abotprop.SUT.RAN.UE.NGAP.ID.1}  |
      | nas_pdu.extended_protocol_discriminator              | {abotprop.SUT.NAS.EDP}         |
      | nas_pdu.security_header_type                         | 0x03                           |
      | nas_pdu.message_type                                 | {abotprop.SUT.NAS.SEC.CMD.MSG} |
      | nas_pdu.security_mode_command.nas_security_algorithm | 0x11                           |
      | nas_pdu.security_mode_command.nas_key_set_identifier | {abotprop.SUT.NAS.KSI}         |
      | nas_pdu.security_mode_command.ue_security_capability | {abotprop.SUT.NAS.UE.SEC.CAPA} |

    Then I receive and validate NGAP message NG_DOWNLINK_NAS_SECURITY_MODE_CMD on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                            | value                                       |
      | amf_ue_ngap_id                                       | {string:eq}($(AMF_UE_NGAP_ID))              |
      | ran_ue_ngap_id                                       | {string:eq}({abotprop.SUT.RAN.UE.NGAP.ID.1})  |
      | nas_pdu.extended_protocol_discriminator              | {string:eq}({abotprop.SUT.NAS.EDP})         |
      | nas_pdu.security_header_type                         | {string:eq}(0x03)                           |
      | nas_pdu.message_type                                 | {string:eq}({abotprop.SUT.NAS.SEC.CMD.MSG}) |
      | nas_pdu.security_mode_command.nas_security_algorithm | {string:eq}(0x11)                           |
      | nas_pdu.security_mode_command.nas_key_set_identifier | {string:eq}({abotprop.SUT.NAS.KSI})         |
      | nas_pdu.security_mode_command.ue_security_capability | {string:eq}({abotprop.SUT.NAS.UE.SEC.CAPA}) |

    When I send NGAP message NG_UPLINK_NAS_SECURITY_MODE_COMPLETE on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                      | value                                     |
      | amf_ue_ngap_id                                                                                                                 | $(AMF_UE_NGAP_ID)                         |
      | ran_ue_ngap_id                                                                                                                 | $(RAN_UE_NGAP_ID)                         |
      | nas_pdu.extended_protocol_discriminator                                                                                        | {abotprop.SUT.NAS.EDP}                    |
      | nas_pdu.security_header_type                                                                                                   | 0x04                                      |
      | nas_pdu.message_type                                                                                                           | {abotprop.SUT.NAS.SEC.COM.MSG}            |
      | nas_pdu.security_mode_complete.nas_message_container.extended_protocol_discriminator                                           | {abotprop.SUT.NAS.EDP}                    |
      | nas_pdu.security_mode_complete.nas_message_container.security_header_type                                                      | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}         |
      | nas_pdu.security_mode_complete.nas_message_container.message_type                                                              | {abotprop.SUT.NAS.REG.REQ.MSG}            |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_registration_type                                | {abotprop.SUT.NAS.5GS.REG.TYPE.INI.REG}   |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.nas_key_set_identifier                               | {abotprop.SUT.NAS.KSI}                    |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.type_of_id                         | 0x01                                      |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_format                   | 0x00                                      |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_netwrk_id.mcc  | {abotprop.SUT.MCC}                        |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_netwrk_id.mnc  | {abotprop.SUT.MNC}                        |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_imsi.routing_ind         | 0                                         |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_imsi.prot_scheme_id      | 0                                         |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_net_pub_key_id | 0                                         |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_imsi.msin                | incr({abotprop.SUT.NAS.5GS.MOB.MSIN.1},1) |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gmm_capability                                      | {abotprop.SUT.NAS.5GMM.CAPA}              |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.ue_security_capability                               | {abotprop.SUT.NAS.UE.SEC.CAPA}            |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.nssai                                                | {abotprop.SUT.NAS.NSSAI}                  |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_tracking_area_identity                           | {abotprop.SUT.NAS.5GS.TAI}                |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.s1_ue_network_capability                             | {abotprop.SUT.NAS.S1.UE.NET.CAPA}         |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.uplink_data_status                                   | {abotprop.SUT.NAS.UPLINK.DATA.STAT}       |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.pdu_session_status                                   | {abotprop.SUT.NAS.PDU.SESS.STAT}          |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.mico_indication                                      | {abotprop.SUT.NAS.MICO.INDICATION}        |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.ue_status                                            | {abotprop.SUT.NAS.UE.STAT}                |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.allowed_pdu_session_status                           | {abotprop.SUT.NAS.ALLOWED.PDU.SESS.STAT}  |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.ue_usage_setting                                     | {abotprop.SUT.NAS.UE.USAGE.SETTING}       |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.drx_parameter                                        | {abotprop.SUT.NAS.DRX.PARAM}              |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.ladnindication                                       | {abotprop.SUT.NAS.LADN.INDICATION}        |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.payload_container                                    | {abotprop.SUT.NAS.PAYLOAD.CONTAINER}      |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.network_slicing_indication                           | {abotprop.SUT.NAS.NET.SLICING.INDICATION} |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_update_type                                      | {abotprop.SUT.NAS.5GS.UPDT.TYPE}          |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                                                   | {abotprop.SUT.MCC}                        |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                                                   | {abotprop.SUT.MNC}                        |
      | user_location_information.nr_user_location_information.tai.tac                                                                 | {abotprop.SUT.TAC}                        |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                                                | {abotprop.SUT.MCC}                        |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                                                | {abotprop.SUT.MNC}                        |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                                                 | {abotprop.SUT.NR.CELL.IDN}                |

    Then I receive and validate NGAP message NG_UPLINK_NAS_SECURITY_MODE_COMPLETE on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                            | value                                                  |
      | amf_ue_ngap_id                                                                                       | {string:eq}($(AMF_UE_NGAP_ID))                         |
      | ran_ue_ngap_id                                                                                       | {string:eq}($(RAN_UE_NGAP_ID))                         |
      | nas_pdu.extended_protocol_discriminator                                                              | {string:eq}({abotprop.SUT.NAS.EDP})                    |
      | nas_pdu.security_header_type                                                                         | {string:eq}(0x04)                                      |
      | nas_pdu.message_type                                                                                 | {string:eq}({abotprop.SUT.NAS.SEC.COM.MSG})            |
      | nas_pdu.security_mode_complete.nas_message_container.extended_protocol_discriminator                 | {string:eq}({abotprop.SUT.NAS.EDP})                    |
      | nas_pdu.security_mode_complete.nas_message_container.security_header_type                            | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.PLAIN})         |
      | nas_pdu.security_mode_complete.nas_message_container.message_type                                    | {string:eq}({abotprop.SUT.NAS.REG.REQ.MSG})            |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_registration_type      | {string:eq}({abotprop.SUT.NAS.5GS.REG.TYPE.INI.REG})   |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mobile_identity        | save(MOBILE_IDENTITY_5GS)                              |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gmm_capability            | {string:eq}({abotprop.SUT.NAS.5GMM.CAPA})              |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.ue_security_capability     | {string:eq}({abotprop.SUT.NAS.UE.SEC.CAPA})            |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.nssai                      | {string:eq}({abotprop.SUT.NAS.NSSAI})                  |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_tracking_area_identity | {string:eq}({abotprop.SUT.NAS.5GS.TAI})                |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.s1_ue_network_capability   | {string:eq}({abotprop.SUT.NAS.S1.UE.NET.CAPA})         |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.uplink_data_status         | {string:eq}({abotprop.SUT.NAS.UPLINK.DATA.STAT})       |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.pdu_session_status         | {string:eq}({abotprop.SUT.NAS.PDU.SESS.STAT})          |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.mico_indication            | {string:eq}({abotprop.SUT.NAS.MICO.INDICATION})        |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.ue_status                  | {string:eq}({abotprop.SUT.NAS.UE.STAT})                |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.allowed_pdu_session_status | {string:eq}({abotprop.SUT.NAS.ALLOWED.PDU.SESS.STAT})  |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.ue_usage_setting           | {string:eq}({abotprop.SUT.NAS.UE.USAGE.SETTING})       |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.drx_parameter              | {string:eq}({abotprop.SUT.NAS.DRX.PARAM})              |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.ladnindication             | {string:eq}({abotprop.SUT.NAS.LADN.INDICATION})        |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.payload_container          | {string:eq}({abotprop.SUT.NAS.PAYLOAD.CONTAINER})      |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.network_slicing_indication | {string:eq}({abotprop.SUT.NAS.NET.SLICING.INDICATION}) |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_update_type            | {string:eq}({abotprop.SUT.NAS.5GS.UPDT.TYPE})          |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                         | {string:eq}({abotprop.SUT.MCC})                        |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                         | {string:eq}({abotprop.SUT.MNC})                        |
      | user_location_information.nr_user_location_information.tai.tac                                       | {string:eq}({abotprop.SUT.TAC})                        |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                      | {string:eq}({abotprop.SUT.MCC})                        |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                      | {string:eq}({abotprop.SUT.MNC})                        |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                       | {string:eq}({abotprop.SUT.NR.CELL.IDN})                |

    When I send NGAP message NG_INIT_CTXT_SET_REQ_NAS_REGIS_ACC on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                                                                       | value                                                            |
      | amf_ue_ngap_id                                                                                  | $(AMF_UE_NGAP_ID)                                                |
      | ran_ue_ngap_id                                                                                  | {abotprop.SUT.RAN.UE.NGAP.ID.1}                                    |
      | nas_pdu.extended_protocol_discriminator                                                         | {abotprop.SUT.NAS.EDP}                                           |
      | nas_pdu.security_header_type                                                                    | 0x02                                                             |
      | nas_pdu.message_type                                                                            | {abotprop.SUT.NAS.REG.ACC.MSG}                                   |
      | nas_pdu.registration_accept.5gs_reg_result                                                      | 9                                                                |
      | nas_pdu.registration_accept.5gs_mob_id_choice.type_of_id                                        | 0x02                                                             |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.mcc                                       | {abotprop.SUT.MCC}                                               |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.mnc                                       | {abotprop.SUT.MNC}                                               |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_region_id                             | {abotprop.SUT.GUAMI.AMF.REGION.ID}                               |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_set_id                                | {abotprop.SUT.GUAMI.AMF.SET.ID}                                  |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_pointer                               | {abotprop.SUT.GUAMI.AMF.POINTER}                                 |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.5g_tmsi                                   | incr({abotprop.SUT.5GTMSI.START.1},1)                              |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.type_of_list                            | 0                                                                |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.no_of_elements                          | 1                                                                |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.mcc            | {abotprop.SUT.MCC}                                               |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.mnc            | {abotprop.SUT.MNC}                                               |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.tac_list.0.tac | {abotprop.SUT.TAC}                                               |
      | guami.plmn_identity.mcc                                                                         | {abotprop.SUT.MCC}                                               |
      | guami.plmn_identity.mnc                                                                         | {abotprop.SUT.MNC}                                               |
      | guami.amf_region_id                                                                             | {abotprop.SUT.GUAMI.AMF.REGION.ID}                               |
      | guami.amf_set_id                                                                                | {abotprop.SUT.GUAMI.AMF.SET.ID}                                  |
      | guami.pointer.amf_pointer                                                                       | {abotprop.SUT.GUAMI.AMF.POINTER}                                 |
      | allowed_s-nssai_list.0.sst                                                                      | 1                                                                |
      | ue_security_capabilities.nr_encryption_algo                                                     | 0xc000                                                           |
      | ue_security_capabilities.nr_integrity_protection_algo                                           | 0xc000                                                           |
      | ue_security_capabilities.e_utra_encryption_algo                                                 | 0x0000                                                           |
      | ue_security_capabilities.e_utra_integrity_protection_algo                                       | 0x0000                                                           |
      | security_key                                                                                    | a8202f2d5e1d4307b751e0ac558025f2865d9c25eebb409d9a5560145dd8e765 |

    Then I receive and validate NGAP message NG_INIT_CTXT_SET_REQ_NAS_REGIS_ACC on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                                                                       | value                                                                         |
      | amf_ue_ngap_id                                                                                  | {string:eq}($(AMF_UE_NGAP_ID))                                                |
      | ran_ue_ngap_id                                                                                  | {string:eq}({abotprop.SUT.RAN.UE.NGAP.ID.1})                                    |
      | nas_pdu.extended_protocol_discriminator                                                         | {string:eq}({abotprop.SUT.NAS.EDP})                                           |
      | nas_pdu.security_header_type                                                                    | {string:eq}(0x02)                                                             |
      | nas_pdu.message_type                                                                            | {string:eq}({abotprop.SUT.NAS.REG.ACC.MSG})                                   |
      | nas_pdu.registration_accept.5gs_reg_result                                                      | {string:eq}(9)                                                                |
      | nas_pdu.registration_accept.5gs_mob_id_choice.type_of_id                                        | {string:eq}(0x02)                                                             |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.mcc                                       | save(MCC)                                                                     |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.mnc                                       | save(MNC)                                                                     |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_region_id                             | save(AMF_REGION_ID)                                                           |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_set_id                                | save(AMF_SET_ID)                                                              |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_pointer                               | save(AMF_POINTER)                                                             |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.5g_tmsi                                   | save(5G_TMSI)                                                                 |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.type_of_list                            | {string:eq}(0)                                                                |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.no_of_elements                          | {string:eq}(1)                                                                |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.mcc            | {string:eq}({abotprop.SUT.MCC})                                               |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.mnc            | {string:eq}({abotprop.SUT.MNC})                                               |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.tac_list.0.tac | {string:eq}({abotprop.SUT.TAC})                                               |
      | guami.plmn_identity.mcc                                                                         | {string:eq}({abotprop.SUT.MCC})                                               |
      | guami.plmn_identity.mnc                                                                         | {string:eq}({abotprop.SUT.MNC})                                               |
      | guami.amf_region_id                                                                             | {string:eq}({abotprop.SUT.GUAMI.AMF.REGION.ID})                               |
      | guami.amf_set_id                                                                                | {string:eq}({abotprop.SUT.GUAMI.AMF.SET.ID})                                  |
      | guami.pointer.amf_pointer                                                                       | {string:eq}({abotprop.SUT.GUAMI.AMF.POINTER})                                 |
      | allowed_s-nssai_list.0.sst                                                                      | {string:eq}(1)                                                                |
      | ue_security_capabilities.nr_encryption_algo                                                     | {string:eq}(0xc000)                                                           |
      | ue_security_capabilities.nr_integrity_protection_algo                                           | {string:eq}(0xc000)                                                           |
      | ue_security_capabilities.e_utra_encryption_algo                                                 | {string:eq}(0x0000)                                                           |
      | ue_security_capabilities.e_utra_integrity_protection_algo                                       | {string:eq}(0x0000)                                                           |
      | security_key                                                                                    | {string:eq}(a8202f2d5e1d4307b751e0ac558025f2865d9c25eebb409d9a5560145dd8e765) |

    When I send NGAP message NG_INIT_CTXT_SET_RES on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter      | value                         |
      | amf_ue_ngap_id | $(AMF_UE_NGAP_ID)             |
      | ran_ue_ngap_id | {abotprop.SUT.RAN.UE.NGAP.ID.1} |

    Then I receive and validate NGAP message NG_INIT_CTXT_SET_RES on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter      | value                                      |
      | amf_ue_ngap_id | {string:eq}($(AMF_UE_NGAP_ID))             |
      | ran_ue_ngap_id | {string:eq}({abotprop.SUT.RAN.UE.NGAP.ID.1}) |

    When I send NGAP message NG_UPLINK_NAS_REGIS_COMPLETE on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                       | value                          |
      | amf_ue_ngap_id                                                                  | $(AMF_UE_NGAP_ID)              |
      | ran_ue_ngap_id                                                                  | {abotprop.SUT.RAN.UE.NGAP.ID.1}  |
      | nas_pdu.extended_protocol_discriminator                                         | {abotprop.SUT.NAS.EDP}         |
      | nas_pdu.security_header_type                                                    | 0x02                           |
      | nas_pdu.message_type                                                            | {abotprop.SUT.NAS.REG.COM.MSG} |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {abotprop.SUT.MCC}             |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {abotprop.SUT.MNC}             |
      | user_location_information.nr_user_location_information.tai.tac                  | {abotprop.SUT.TAC}             |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {abotprop.SUT.MCC}             |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {abotprop.SUT.MNC}             |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {abotprop.SUT.NR.CELL.IDN}     |

    Then I receive and validate NGAP message NG_UPLINK_NAS_REGIS_COMPLETE on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                       | value                                       |
      | amf_ue_ngap_id                                                                  | {string:eq}($(AMF_UE_NGAP_ID))              |
      | ran_ue_ngap_id                                                                  | {string:eq}({abotprop.SUT.RAN.UE.NGAP.ID.1})  |
      | nas_pdu.extended_protocol_discriminator                                         | {string:eq}({abotprop.SUT.NAS.EDP})         |
      | nas_pdu.security_header_type                                                    | {string:eq}(0x02)                           |
      | nas_pdu.message_type                                                            | {string:eq}({abotprop.SUT.NAS.REG.COM.MSG}) |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {string:eq}({abotprop.SUT.MCC})             |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {string:eq}({abotprop.SUT.MNC})             |
      | user_location_information.nr_user_location_information.tai.tac                  | {string:eq}({abotprop.SUT.TAC})             |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {string:eq}({abotprop.SUT.MCC})             |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {string:eq}({abotprop.SUT.MNC})             |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {string:eq}({abotprop.SUT.NR.CELL.IDN})     |

    Given the execution is paused for NIKSUN_SCTP.RATE_CONTROL seconds
	
	Given I end iteration