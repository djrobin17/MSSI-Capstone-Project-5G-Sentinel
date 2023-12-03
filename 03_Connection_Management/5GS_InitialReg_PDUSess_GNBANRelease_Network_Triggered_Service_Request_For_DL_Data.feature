@5gs-initialreg5gaka-pdusess-gnbanrelease-network-triggered-service-req-dl-data @03-connection-mgmt-procedures @23502-5gs @5g-core-sanity @5g-core

Feature: UE 5GS Initial Registration, PDU Session, GNB Initiated AN Release With Network Triggered Service Request for DL Data

  Scenario: UE 5GS Initial Registration with 5G AKA, PDU Session Establishment, GNB Initiated AN Release With Network Triggered Service Request for DL Data

    Given the test data is in file /featureFiles/MESSAGE_BUNDLES/EPC_MESSAGES.xml

    Given all configured endpoints for EPC are connected successfully


    Given the execution is paused for {abotprop.WAIT_3_SEC} seconds

    Given that I execute dependency feature /featureFiles/3GPP-23502-5G/01_Interface_Management_Procedures/01_gNB_AMF_procedures/01_NG_Setup_Procedure/NG_Setup_Request.feature

    When I send PFCP message PFCP_ASSOCIATION_SETUP_REQ on interface N4 with the following details from node SMF1 to UPF1:
      | parameter            | value                                    |
      | header.message_type  | 5                                        |
      | header.seq_number    | incr(1,3)                                |
      | node_id.type         | {abotprop.SUT.PFCP_NODE_ID_TYPE}         |
      | node_id.value        | $({abotprop.SMF1.SecureShell.IPAddress}) |
      | cp_function_features | {abotprop.SUT.CP_FUNC_FEATURES}          |
      | recovery_timestamp   | {abotprop.SUT.PFCP_RECOVERY_TIMESTAMP}   |

    Then I receive and validate PFCP message PFCP_ASSOCIATION_SETUP_REQ on interface N4 with the following details on node UPF1 from SMF1:
      | parameter            | value                                                 |
      | header.message_type  | {string:eq}(5)                                        |
      | header.seq_number    | save(PFCP_HDR_SEQ_NO)                                 |
      | node_id.type         | {string:eq}({abotprop.SUT.PFCP_NODE_ID_TYPE})         |
      | node_id.value        | {string:eq}($({abotprop.SMF1.SecureShell.IPAddress})) |
      | cp_function_features | save(CP_FUNC_FEATURES)                                |
      | recovery_timestamp   | save(CP_RECOVERY_TIMESTAMP)                           |

    When I send PFCP message PFCP_ASSOCIATION_SETUP_RES on interface N4 with the following details from node UPF1 to SMF1:
      | parameter            | value                                    |
      | header.message_type  | 6                                        |
      | header.seq_number    | $(PFCP_HDR_SEQ_NO)                       |
      | node_id.type         | {abotprop.SUT.PFCP_NODE_ID_TYPE}         |
      | node_id.value        | $({abotprop.UPF1.SecureShell.IPAddress}) |
      | up_function_features | {abotprop.SUT.PFCP_UP_FUNC_FEATURES}     |
      | cause                | {abotprop.SUT.PFCP_REQUEST_ACCEPTED}     |
      | recovery_timestamp   | {abotprop.SUT.PFCP_RECOVERY_TIMESTAMP}   |

    Then I receive and validate PFCP message PFCP_ASSOCIATION_SETUP_RES on interface N4 with the following details on node SMF1 from UPF1:
      | parameter            | value                                                 |
      | header.message_type  | {string:eq}(6)                                        |
      | header.seq_number    | save(PFCP_HDR_SEQ_NO)                                 |
      | node_id.type         | {string:eq}({abotprop.SUT.PFCP_NODE_ID_TYPE})         |
      | node_id.value        | {string:eq}($({abotprop.UPF1.SecureShell.IPAddress})) |
      | up_function_features | save(UP_FUNC_FEATURES)                                |
      | cause                | {string:eq}({abotprop.SUT.PFCP_REQUEST_ACCEPTED})     |
      | recovery_timestamp   | save(UP_RECOVERY_TIMESTAMP)                           |

### UE Initial Registration with 5G AKA Procedure

    When I send NGAP message NG_INIT_UE_MSG_NAS_REGIS_REQ on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                         | value                                     |
      | ran_ue_ngap_id                                                                    | incr(4294967295,1)                        |
      | nas_pdu.extended_protocol_discriminator                                           | {abotprop.SUT.NAS.EDP}                    |
      | nas_pdu.security_header_type                                                      | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}         |
      | nas_pdu.message_type                                                              | {abotprop.SUT.NAS.REG.REQ.MSG}            |
      | nas_pdu.registration_request.5gs_registration_type                                | {abotprop.SUT.NAS.5GS.REG.TYPE.INI.REG}   |
      | nas_pdu.registration_request.nas_key_set_identifier                               | {abotprop.SUT.NAS.KSI}                    |
      #| nas_pdu.registration_request.5gs_mobile_identity                                  | incr({abotprop.SUT.NAS.5GS.MOB.IDN},1)    |
      | nas_pdu.registration_request.5gs_mob_id_choice.type_of_id                         | 0x01                                      |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_format                   | 0x00                                      |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_netwrk_id.mcc  | {abotprop.SUT.MCC}                        |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_netwrk_id.mnc  | {abotprop.SUT.MNC}                        |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.routing_ind         | 0                                         |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.prot_scheme_id      | 0                                         |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_net_pub_key_id | 0                                         |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.msin                | incr({abotprop.SUT.NAS.5GS.MOB.MSIN},1)   |
      #| nas_pdu.registration_request.5gmm_capability                                      | {abotprop.SUT.NAS.5GMM.CAPA}              |
      | nas_pdu.registration_request.ue_security_capability                               | {abotprop.SUT.NAS.UE.SEC.CAPA}            |
      #| nas_pdu.registration_request.nssai                                                | {abotprop.SUT.NAS.NSSAI}                  |
      #| nas_pdu.registration_request.5gs_tracking_area_identity                           | {abotprop.SUT.NAS.5GS.TAI}                |
      #| nas_pdu.registration_request.s1_ue_network_capability                             | {abotprop.SUT.NAS.S1.UE.NET.CAPA}         |
      #| nas_pdu.registration_request.uplink_data_status                                   | {abotprop.SUT.NAS.UPLINK.DATA.STAT}       |
      #| nas_pdu.registration_request.pdu_session_status                                   | {abotprop.SUT.NAS.PDU.SESS.STAT}          |
      #| nas_pdu.registration_request.mico_indication                                      | {abotprop.SUT.NAS.MICO.INDICATION}        |
      | nas_pdu.registration_request.ue_status                                            | {abotprop.SUT.NAS.UE.STAT}                |
      #| nas_pdu.registration_request.allowed_pdu_session_status                           | {abotprop.SUT.NAS.ALLOWED.PDU.SESS.STAT}  |
      #| nas_pdu.registration_request.ue_usage_setting                                     | {abotprop.SUT.NAS.UE.USAGE.SETTING}       |
      #| nas_pdu.registration_request.drx_parameter                                        | {abotprop.SUT.NAS.DRX.PARAM}              |
      #| nas_pdu.registration_request.ladnindication                                       | {abotprop.SUT.NAS.LADN.INDICATION}        |
      #| nas_pdu.registration_request.payload_container                                    | {abotprop.SUT.NAS.PAYLOAD.CONTAINER}      |
      #| nas_pdu.registration_request.network_slicing_indication                           | {abotprop.SUT.NAS.NET.SLICING.INDICATION} |
      #| nas_pdu.registration_request.5gs_update_type                                      | {abotprop.SUT.NAS.5GS.UPDT.TYPE}          |
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
      #| nas_pdu.registration_request.5gmm_capability                                    | {string:eq}({abotprop.SUT.NAS.5GMM.CAPA})              |
      | nas_pdu.registration_request.ue_security_capability                             | {string:eq}({abotprop.SUT.NAS.UE.SEC.CAPA})            |
      #| nas_pdu.registration_request.nssai                                              | {string:eq}({abotprop.SUT.NAS.NSSAI})                  |
      #| nas_pdu.registration_request.5gs_tracking_area_identity                         | {string:eq}({abotprop.SUT.NAS.5GS.TAI})                |
      #| nas_pdu.registration_request.s1_ue_network_capability                           | {string:eq}({abotprop.SUT.NAS.S1.UE.NET.CAPA})         |
      #| nas_pdu.registration_request.uplink_data_status                                 | {string:eq}({abotprop.SUT.NAS.UPLINK.DATA.STAT})       |
      #| nas_pdu.registration_request.pdu_session_status                                 | {string:eq}({abotprop.SUT.NAS.PDU.SESS.STAT})          |
      #| nas_pdu.registration_request.mico_indication                                    | {string:eq}({abotprop.SUT.NAS.MICO.INDICATION})        |
      | nas_pdu.registration_request.ue_status                                          | {string:eq}({abotprop.SUT.NAS.UE.STAT})                |
      #| nas_pdu.registration_request.allowed_pdu_session_status                         | {string:eq}({abotprop.SUT.NAS.ALLOWED.PDU.SESS.STAT})  |
      #| nas_pdu.registration_request.ue_usage_setting                                   | {string:eq}({abotprop.SUT.NAS.UE.USAGE.SETTING})       |
      #| nas_pdu.registration_request.drx_parameter                                      | {string:eq}({abotprop.SUT.NAS.DRX.PARAM})              |
      #| nas_pdu.registration_request.ladnindication                                     | {string:eq}({abotprop.SUT.NAS.LADN.INDICATION})        |
      #| nas_pdu.registration_request.payload_container                                  | {string:eq}({abotprop.SUT.NAS.PAYLOAD.CONTAINER})      |
      #| nas_pdu.registration_request.network_slicing_indication                         | {string:eq}({abotprop.SUT.NAS.NET.SLICING.INDICATION}) |
      #| nas_pdu.registration_request.5gs_update_type                                    | {string:eq}({abotprop.SUT.NAS.5GS.UPDT.TYPE})          |
      | rrc_establishment_cause                                                         | {string:eq}({abotprop.SUT.RRC.ESTD.CAUSE})             |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {string:eq}({abotprop.SUT.MCC})                        |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {string:eq}({abotprop.SUT.MNC})                        |
      | user_location_information.nr_user_location_information.tai.tac                  | {string:eq}({abotprop.SUT.TAC})                        |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {string:eq}({abotprop.SUT.MCC})                        |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {string:eq}({abotprop.SUT.MNC})                        |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {string:eq}({abotprop.SUT.NR.CELL.IDN})                |
      | ue_context_request                                                              | {string:eq}(0)                                         |

    When I send HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_AUTHENTICATE_REQ on interface N12 with the following details from node AMF1 to AUSF1:
      | parameter                                | value                                             |
      | header.nva.0.name                        | :method                                           |
      | header.nva.0.value                       | POST                                              |
      | header.nva.1.name                        | :path                                             |
      | header.nva.1.value                       | /127.0.0.1:12348/nausf-auth/v1/ue-authentications |
      | header.nva.2.name                        | content-type                                      |
      | header.nva.2.value                       | application/json                                  |
      | authentication_info.supi_or_suci         | incr(suci-0-001-01-0-0-0-9990000001,1)            |
      | authentication_info.serving_network_name | 5G:mnc030.mcc404.3gppnetwork.org                  |
      | authentication_info.amf_instance_id      | 5a2b84e4-0cb7-4575-ac08-46a2812bec0d              |

    Then I receive and validate HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_AUTHENTICATE_REQ on interface N12 with the following details on node AUSF1 from AMF1:
      | parameter                                | value                                                          |
      | header.nva.0.name                        | {string:eq}(:method)                                           |
      | header.nva.0.value                       | {string:eq}(POST)                                              |
      | header.nva.1.name                        | {string:eq}(:path)                                             |
      | header.nva.1.value                       | {string:eq}(/127.0.0.1:12348/nausf-auth/v1/ue-authentications) |
      | header.nva.2.name                        | {string:eq}(content-type)                                      |
      | header.nva.2.value                       | {string:eq}(application/json)                                  |
      | authentication_info.supi_or_suci         | {string:eq}(incr(suci-0-001-01-0-0-0-9990000001,1))            |
      | authentication_info.serving_network_name | {string:eq}(5G:mnc030.mcc404.3gppnetwork.org)                  |
      | authentication_info.amf_instance_id      | {string:eq}(5a2b84e4-0cb7-4575-ac08-46a2812bec0d)              |

    When I send HTTPV2 message HTTPV2_NUDM_UEAU_GEN_AUTH_DATA_REQ on interface N13 with the following details from node AUSF1 to UDM1:
      | parameter                                        | value                                                                                                        |
      | header.nva.0.name                                | :method                                                                                                      |
      | header.nva.0.value                               | POST                                                                                                         |
      | header.nva.1.name                                | :path                                                                                                        |
      | header.nva.1.value                               | /127.0.0.1:12348/nudm-ueau/v1/incr(suci-0-001-01-0-0-0-9990000001,1)/security-information/generate-auth-data |
      | header.nva.2.name                                | content-type                                                                                                 |
      | header.nva.2.value                               | application/json                                                                                             |
      | authentication_info_request.serving_network_name | 5G:mnc030.mcc404.3gppnetwork.org                                                                             |
      | authentication_info_request.ausf_instance_id     | 44e57b64-9008-11ed-a1eb-0242ac120002                                                                         |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UEAU_GEN_AUTH_DATA_REQ on interface N13 with the following details on node UDM1 from AUSF1:
      | parameter                                        | value                                                                                                                     |
      | header.nva.0.name                                | {string:eq}(:method)                                                                                                      |
      | header.nva.0.value                               | {string:eq}(POST)                                                                                                         |
      | header.nva.1.name                                | {string:eq}(:path)                                                                                                        |
      | header.nva.1.value                               | {string:eq}(/127.0.0.1:12348/nudm-ueau/v1/incr(suci-0-001-01-0-0-0-9990000001,1)/security-information/generate-auth-data) |
      | header.nva.2.name                                | {string:eq}(content-type)                                                                                                 |
      | header.nva.2.value                               | {string:eq}(application/json)                                                                                             |
      | authentication_info_request.serving_network_name | {string:eq}(5G:mnc030.mcc404.3gppnetwork.org)                                                                             |
      | authentication_info_request.ausf_instance_id     | {string:eq}(44e57b64-9008-11ed-a1eb-0242ac120002)                                                                         |

    When I send HTTPV2 message HTTPV2_NUDM_UEAU_GEN_AUTH_DATA_RES_200 on interface N13 with the following details from node UDM1 to AUSF1:
      | parameter                                                                          | value                                                            |
      | header.nva.0.name                                                                  | :status                                                          |
      | header.nva.0.value                                                                 | 200                                                              |
      | header.nva.1.name                                                                  | content-type                                                     |
      | header.nva.1.value                                                                 | application/json                                                 |
      | authentication_info_result.authentication_vector.av_5G_he_aka.av_type              | 5G_AKA                                                           |
      | authentication_info_result.authentication_vector.av_5G_he_aka.rand                 | b78c030000000000b78c030000000000                                 |
      | authentication_info_result.authentication_vector.av_5G_he_aka.autn                 | 00000000000000000000000000000000                                 |
      | authentication_info_result.authentication_vector.av_5G_he_aka.xres_star            | 00000000000000000000000000000000                                 |
      | authentication_info_result.authentication_vector.av_5G_he_aka.kausf                | 0000000000000000000000000000000000000000000000000000000000000000 |
      | authentication_info_result.authentication_vector.av_5G_he_aka.serving_network_name | 5G:mnc030.mcc404.3gppnetwork.org                                 |
      | authentication_info_result.authentication_vector.av_5G_he_aka.AMF                  | 8001                                                             |
      | authentication_info_result.authentication_vector.av_5G_he_aka.K                    | 8baf473f2f8fd09487cccbd7097c6862                                 |
      | authentication_info_result.authentication_vector.av_5G_he_aka.OP                   | 1006020f0a478bf6b699f15c062e42b3                                 |
      | authentication_info_result.supi                                                    | incr(imsi-404309990000001,1)                                     |
      | authentication_info_result.authentication_vector.av_5G_he_aka.seq_no               | {abotprop.SUT.5GAKA.SQN}                                         |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UEAU_GEN_AUTH_DATA_RES_200 on interface N13 with the following details on node AUSF1 from UDM1:
      | parameter                                                               | value                                     |
      | header.nva.0.name                                                       | {string:eq}(:status)                      |
      | header.nva.0.value                                                      | {string:eq}(200)                          |
      | header.nva.1.name                                                       | {string:eq}(content-type)                 |
      | header.nva.1.value                                                      | {string:eq}(application/json)             |
      | authentication_info_result.authentication_vector.av_5G_he_aka.av_type   | {string:eq}(5G_AKA)                       |
      | authentication_info_result.authentication_vector.av_5G_he_aka.rand      | save(5G_AKA_RAND_AT_AUSF1)                |
      | authentication_info_result.authentication_vector.av_5G_he_aka.autn      | save(5G_AKA_AUTN_AT_AUSF1)                |
      | authentication_info_result.authentication_vector.av_5G_he_aka.xres_star | save(5G_AKA_XRES_STAR_AT_AUSF1)           |
      | authentication_info_result.authentication_vector.av_5G_he_aka.kausf     | save(5G_AKA_KAUSF_AT_AUSF1)               |
      | authentication_info_result.supi                                         | {string:eq}(incr(imsi-404309990000001,1)) |

    When I send HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_AUTHENTICATE_RES_201 on interface N12 with the following details from node AUSF1 to AMF1:
      | parameter                                              | value                                                                                                               |
      | header.nva.0.name                                      | :status                                                                                                             |
      | header.nva.0.value                                     | 201                                                                                                                 |
      | header.nva.1.name                                      | location                                                                                                            |
      | header.nva.1.value                                     | /127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr(suci-0-001-01-0-0-0-9990000001,1)                            |
      | header.nva.2.name                                      | content-type                                                                                                        |
      | header.nva.2.value                                     | application/3gppHal+json                                                                                            |
      | ue_authentication_ctx.auth_type                        | 5G_AKA                                                                                                              |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.rand      | $(5G_AKA_RAND_AT_AUSF1)                                                                                             |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.autn      | $(5G_AKA_AUTN_AT_AUSF1)                                                                                             |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.hxresstar | 00000000000000000000000000000000                                                                                    |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.kSeaf     | 0000000000000000000000000000000000000000000000000000000000000000                                                    |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.xres_star | $(5G_AKA_XRES_STAR_AT_AUSF1)                                                                                        |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.kausf     | $(5G_AKA_KAUSF_AT_AUSF1)                                                                                            |
      | ue_authentication_ctx._links.linkname                  | 5g-aka                                                                                                              |
      | ue_authentication_ctx._links.linkvalue.0.href          | http://127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr(suci-0-001-01-0-0-0-9990000001,1)/5g-aka-confirmation  |
      | ue_authentication_ctx._links.linkvalue.1.href          | http://127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr(suci-0-001-01-0-0-0-9990000001,1)/5g-aka-confirmation2 |
      | ue_authentication_ctx.serving_network_name             | 5G:mnc030.mcc404.3gppnetwork.org                                                                                    |

    Then I receive and validate HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_AUTHENTICATE_RES_201 on interface N12 with the following details on node AMF1 from AUSF1:
      | parameter                                              | value                                                                                                                            |
      | header.nva.0.name                                      | {string:eq}(:status)                                                                                                             |
      | header.nva.0.value                                     | {string:eq}(201)                                                                                                                 |
      | header.nva.1.name                                      | {string:eq}(location)                                                                                                            |
      | header.nva.1.value                                     | {string:eq}(/127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr(suci-0-001-01-0-0-0-9990000001,1))                            |
      | header.nva.2.name                                      | {string:eq}(content-type)                                                                                                        |
      | header.nva.2.value                                     | {string:eq}(application/3gppHal+json)                                                                                            |
      | ue_authentication_ctx.auth_type                        | {string:eq}(5G_AKA)                                                                                                              |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.rand      | save(5G_AKA_RAND_AT_AMF1)                                                                                                        |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.autn      | save(5G_AKA_AUTN_AT_AMF1)                                                                                                        |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.hxresstar | save(5G_AKA_HXRES_STAR_AT_AMF1)                                                                                                  |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.kSeaf     | save(5G_AKA_KSEAF_AT_AMF1)                                                                                                       |
      | ue_authentication_ctx._links.linkname                  | {string:eq}(5g-aka)                                                                                                              |
      | ue_authentication_ctx._links.linkvalue.0.href          | {string:eq}(http://127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr(suci-0-001-01-0-0-0-9990000001,1)/5g-aka-confirmation)  |
      | ue_authentication_ctx._links.linkvalue.1.href          | {string:eq}(http://127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr(suci-0-001-01-0-0-0-9990000001,1)/5g-aka-confirmation2) |
      | ue_authentication_ctx.serving_network_name             | {string:eq}(5G:mnc030.mcc404.3gppnetwork.org)                                                                                    |

    When I send NGAP message NG_DOWNLINK_NAS_AUTHENTICATION_REQ on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                                    | value                        |
      | amf_ue_ngap_id                                               | incr(1234,1)                 |
      | ran_ue_ngap_id                                               | $(RAN_UE_NGAP_ID)            |
      | nas_pdu.extended_protocol_discriminator                      | 126                          |
      | nas_pdu.security_header_type                                 | 0x00                         |
      | nas_pdu.message_type                                         | 0x56                         |
      | nas_pdu.authentication_request.nas_key_set_identifier        | 0x00                         |
      | nas_pdu.authentication_request.abba                          | 0x0000                       |
      | nas_pdu.authentication_request.authentication_parameter_autn | $(5G_AKA_AUTN_AT_AMF1)       |
      | nas_pdu.authentication_request.authentication_parameter_rand | $(5G_AKA_RAND_AT_AMF1)       |
      | nas_pdu.authentication_request.kseaf                         | $(5G_AKA_KSEAF_AT_AMF1)      |
      | nas_pdu.authentication_request.supi                          | incr(imsi-404309990000001,1) |

    Then I receive and validate NGAP message NG_DOWNLINK_NAS_AUTHENTICATION_REQ on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                                    | value                               |
      | amf_ue_ngap_id                                               | save(AMF_UE_NGAP_ID)                |
      | ran_ue_ngap_id                                               | save(RAN_UE_NGAP_ID)                |
      | nas_pdu.extended_protocol_discriminator                      | {string:eq}(126)                    |
      | nas_pdu.security_header_type                                 | {string:eq}(0x00)                   |
      | nas_pdu.message_type                                         | {string:eq}(0x56)                   |
      | nas_pdu.authentication_request.nas_key_set_identifier        | {string:eq}(0x00)                   |
      | nas_pdu.authentication_request.abba                          | {string:eq}(0x0000)                 |
      | nas_pdu.authentication_request.authentication_parameter_autn | save(5G_AKA_AUTN_AT_GNB1)           |
      | nas_pdu.authentication_request.authentication_parameter_rand | save(5G_AKA_RAND_AT_GNB1)           |
      | nas_pdu.authentication_request.K                             | 8BAF473F2F8FD09487CCCBD7097C6862    |
      | nas_pdu.authentication_request.OP                            | 1006020F0A478BF6B699F15C062E42B3    |
      | nas_pdu.authentication_request.supi                          | incr(imsi-404309990000001,1)        |
      | nas_pdu.authentication_request.serving_network_name          | {abotprop.SUT.SERVICE.NETWORK.NAME} |

    When I send NGAP message NG_UPLINK_NAS_AUTHENTICATION_RES on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                       | value                              |
      | amf_ue_ngap_id                                                                  | $(AMF_UE_NGAP_ID)                  |
      | ran_ue_ngap_id                                                                  | incr(4294967295,1)                 |
      | nas_pdu.extended_protocol_discriminator                                         | 126                                |
      | nas_pdu.security_header_type                                                    | 0x00                               |
      | nas_pdu.message_type                                                            | 0x57                               |
      | nas_pdu.authentication_response.authentication_response_parameter               | 0x00000000000000000000000000000000 |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | 404                                |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | 30                                 |
      | user_location_information.nr_user_location_information.tai.tac                  | 0x000001                           |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | 404                                |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | 30                                 |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | 3584                               |

    Then I receive and validate NGAP message NG_UPLINK_NAS_AUTHENTICATION_RES on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                       | value                                     |
      | amf_ue_ngap_id                                                                  | save(AMF_UE_NGAP_ID)                      |
      | ran_ue_ngap_id                                                                  | {string:eq}($(RAN_UE_NGAP_ID))            |
      | nas_pdu.extended_protocol_discriminator                                         | {string:eq}(126)                          |
      | nas_pdu.security_header_type                                                    | {string:eq}(0x00)                         |
      | nas_pdu.message_type                                                            | {string:eq}(0x57)                         |
      | nas_pdu.authentication_response.authentication_response_parameter               | save(UE_5G_AKA_RES_STAR_AT_AMF1)          |
      | nas_pdu.authentication_response.rand                                            | $(5G_AKA_RAND_AT_AMF1)                    |
      | nas_pdu.authentication_response.hresstar                                        | {string:eq}($(5G_AKA_HXRES_STAR_AT_AMF1)) |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {string:eq}(404)                          |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {string:eq}(30)                           |
      | user_location_information.nr_user_location_information.tai.tac                  | {string:eq}(0x000001)                     |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {string:eq}(404)                          |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {string:eq}(30)                           |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {string:eq}(3584)                         |

    When I send HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_5G_AKA_CONF_REQ on interface N12 with the following details from node AMF1 to AUSF1:
      | parameter                      | value                                                                                                        |
      | header.nva.0.name              | :method                                                                                                      |
      | header.nva.0.value             | PUT                                                                                                          |
      | header.nva.1.name              | :path                                                                                                        |
      | header.nva.1.value             | /127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr(suci-0-001-01-0-0-0-9990000001,1)/5g-aka-confirmation |
      | header.nva.2.name              | content-type                                                                                                 |
      | header.nva.2.value             | application/json                                                                                             |
      | confirmation_data.res_star     | $(UE_5G_AKA_RES_STAR_AT_AMF1)                                                                                |
      | confirmation_data.supi_or_suci | incr(suci-0-001-01-0-0-0-9990000001,1)                                                                       |

    Then I receive and validate HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_5G_AKA_CONF_REQ on interface N12 with the following details on node AUSF1 from AMF1:
      | parameter                      | value                                                                                                                     |
      | header.nva.0.name              | {string:eq}(:method)                                                                                                      |
      | header.nva.0.value             | {string:eq}(PUT)                                                                                                          |
      | header.nva.1.name              | {string:eq}(:path)                                                                                                        |
      | header.nva.1.value             | {string:eq}(/127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr(suci-0-001-01-0-0-0-9990000001,1)/5g-aka-confirmation) |
      | header.nva.2.name              | {string:eq}(content-type)                                                                                                 |
      | header.nva.2.value             | {string:eq}(application/json)                                                                                             |
      | confirmation_data.res_star     | {string:eq}($(5G_AKA_XRES_STAR_AT_AUSF1))                                                                                 |
      | confirmation_data.supi_or_suci | {string:eq}(incr(suci-0-001-01-0-0-0-9990000001,1))                                                                       |

    When I send HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_5G_AKA_CONF_RES_200 on interface N12 with the following details from node AUSF1 to AMF1:
      | parameter                              | value                        |
      | header.nva.0.name                      | :status                      |
      | header.nva.0.value                     | 200                          |
      | header.nva.1.name                      | content-type                 |
      | header.nva.1.value                     | application/json             |
      | confirmation_data_response.auth_result | AUTHENTICATION_SUCCESS       |
      | confirmation_data_response.supi        | incr(imsi-404309990000001,1) |

    Then I receive and validate HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_5G_AKA_CONF_RES_200 on interface N12 with the following details on node AMF1 from AUSF1:
      | parameter                              | value                                     |
      | header.nva.0.name                      | {string:eq}(:status)                      |
      | header.nva.0.value                     | {string:eq}(200)                          |
      | header.nva.1.name                      | {string:eq}(content-type)                 |
      | header.nva.1.value                     | {string:eq}(application/json)             |
      | confirmation_data_response.auth_result | {string:eq}(AUTHENTICATION_SUCCESS)       |
      | confirmation_data_response.supi        | {string:eq}(incr(imsi-404309990000001,1)) |

    When I send HTTPV2 message HTTPV2_NUDM_UEAU_CONF_AUTH_REQ on interface N13 with the following details from node AUSF1 to UDM1:
      | parameter                 | value                                                                  |
      | header.nva.0.name         | :method                                                                |
      | header.nva.0.value        | POST                                                                   |
      | header.nva.1.name         | :path                                                                  |
      | header.nva.1.value        | /127.0.0.1:12348/nudm-ueau/v1/incr(imsi-404309990000001,1)/auth-events |
      | header.nva.2.name         | content-type                                                           |
      | header.nva.2.value        | application/json                                                       |
      | auth_event.nf_instance_id | 2ad93f83-5736-4297-8e36-479248207076                                   |
      | auth_event.success        | true                                                                   |
      | auth_event.time_stamp     | 2020-02-24T17:00:22Z                                                   |
      | auth_event.auth_type      | 5G_AKA                                                                 |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UEAU_CONF_AUTH_REQ on interface N13 with the following details on node UDM1 from AUSF1:
      | parameter                 | value                                                                               |
      | header.nva.0.name         | {string:eq}(:method)                                                                |
      | header.nva.0.value        | {string:eq}(POST)                                                                   |
      | header.nva.1.name         | {string:eq}(:path)                                                                  |
      | header.nva.1.value        | {string:eq}(/127.0.0.1:12348/nudm-ueau/v1/incr(imsi-404309990000001,1)/auth-events) |
      | header.nva.2.name         | {string:eq}(content-type)                                                           |
      | header.nva.2.value        | {string:eq}(application/json)                                                       |
      | auth_event.nf_instance_id | {string:eq}(2ad93f83-5736-4297-8e36-479248207076)                                   |
      | auth_event.success        | {string:eq}(true)                                                                   |
      | auth_event.time_stamp     | {string:eq}(2020-02-24T17:00:22Z)                                                   |
      | auth_event.auth_type      | {string:eq}(5G_AKA)                                                                 |

    When I send HTTPV2 message HTTPV2_NUDM_UEAU_CONF_AUTH_RES_201 on interface N13 with the following details from node UDM1 to AUSF1:
      | parameter                 | value                                |
      | header.nva.0.name         | :status                              |
      | header.nva.0.value        | 201                                  |
      | header.nva.1.name         | content-type                         |
      | header.nva.1.value        | application/json                     |
      | auth_event.nf_instance_id | 2ad93f83-5736-4297-8e36-479248207076 |
      | auth_event.success        | true                                 |
      | auth_event.time_stamp     | 2020-02-24T17:00:22Z                 |
      | auth_event.auth_type      | 5G_AKA                               |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UEAU_CONF_AUTH_RES_201 on interface N13 with the following details on node AUSF1 from UDM1:
      | parameter                 | value                                             |
      | header.nva.0.name         | {string:eq}(:status)                              |
      | header.nva.0.value        | {string:eq}(201)                                  |
      | header.nva.1.name         | {string:eq}(content-type)                         |
      | header.nva.1.value        | {string:eq}(application/json)                     |
      | auth_event.nf_instance_id | {string:eq}(2ad93f83-5736-4297-8e36-479248207076) |
      | auth_event.success        | {string:eq}(true)                                 |
      | auth_event.time_stamp     | {string:eq}(2020-02-24T17:00:22Z)                 |
      | auth_event.auth_type      | {string:eq}(5G_AKA)                               |

### UE Slice Selection Subscription data, NSSF get AMF Set for NSSAI

    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIBED_NSSAI_GET_REQ on interface N8 with the following details from node AMF1 to UDM1:
      | parameter          | value                                                                                            |
      | header.nva.0.name  | :method                                                                                          |
      | header.nva.0.value | GET                                                                                              |
      | header.nva.1.name  | :path                                                                                            |
      | header.nva.1.value | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/nssai?plmn-id={"mcc":"404","mnc":"30"} |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIBED_NSSAI_GET_REQ on interface N8 with the following details on node UDM1 from AMF1:
      | parameter          | value                                                                                                         |
      | header.nva.0.name  | {string:eq}(:method)                                                                                          |
      | header.nva.0.value | {string:eq}(GET)                                                                                              |
      | header.nva.1.name  | {string:eq}(:path)                                                                                            |
      | header.nva.1.value | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/nssai?plmn-id={"mcc":"404","mnc":"30"}) |

    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIBED_NSSAI_GET_RES_200 on interface N8 with the following details from node UDM1 to AMF1:
      | parameter                                | value            |
      | header.nva.0.name                        | :status          |
      | header.nva.0.value                       | 200              |
      | header.nva.1.name                        | content-type     |
      | header.nva.1.value                       | application/json |
      | nssai.default_single_nssais.0.snssai.sst | 1                |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIBED_NSSAI_GET_RES_200 on interface N8 with the following details on node AMF1 from UDM1:
      | parameter                                | value                         |
      | header.nva.0.name                        | {string:eq}(:status)          |
      | header.nva.0.value                       | {string:eq}(200)              |
      | header.nva.1.name                        | {string:eq}(content-type)     |
      | header.nva.1.value                       | {string:eq}(application/json) |
      | nssai.default_single_nssais.0.snssai.sst | {string:eq}(1)                |

    When I send HTTPV2 message HTTPV2_NNSSF_NETWORK_SLICE_SELECTION_GET_REQ on interface N22 with the following details from node AMF1 to NSSF1:
      | parameter          | value                                                                                                                                                                                                                                                                                                                                                            |
      | header.nva.0.name  | :method                                                                                                                                                                                                                                                                                                                                                          |
      | header.nva.0.value | GET                                                                                                                                                                                                                                                                                                                                                              |
      | header.nva.1.name  | :path                                                                                                                                                                                                                                                                                                                                                            |
      | header.nva.1.value | /127.0.0.1:12348/nnssf-nsselection/v2/network-slice-information?nf-type=AMF&nf-id=5a2b84e4-0cb7-4575-ac08-46a2812bec0d&slice-info-request-for-registration={"requestedNssai":[{"sst":1}],"subscribedNssai":[{"subscribedSnssai":{"sst":1},"defaultIndication":true}]}&tai:{"plmnId":{"mcc":"404","mnc":"30"},"tac":"0001"}&home-plmn-id:{"mcc":"404","mnc":"30"} |

    Then I receive and validate HTTPV2 message HTTPV2_NNSSF_NETWORK_SLICE_SELECTION_GET_REQ on interface N22 with the following details on node NSSF1 from AMF1:
      | parameter          | value                                                                                                                                                                                                                                                                                                                                                                         |
      | header.nva.0.name  | {string:eq}(:method)                                                                                                                                                                                                                                                                                                                                                          |
      | header.nva.0.value | {string:eq}(GET)                                                                                                                                                                                                                                                                                                                                                              |
      | header.nva.1.name  | {string:eq}(:path)                                                                                                                                                                                                                                                                                                                                                            |
      | header.nva.1.value | {string:eq}(/127.0.0.1:12348/nnssf-nsselection/v2/network-slice-information?nf-type=AMF&nf-id=5a2b84e4-0cb7-4575-ac08-46a2812bec0d&slice-info-request-for-registration={"requestedNssai":[{"sst":1}],"subscribedNssai":[{"subscribedSnssai":{"sst":1},"defaultIndication":true}]}&tai:{"plmnId":{"mcc":"404","mnc":"30"},"tac":"0001"}&home-plmn-id:{"mcc":"404","mnc":"30"}) |

    When I send HTTPV2 message HTTPV2_NNSSF_NETWORK_SLICE_SELECTION_GET_RES_200 on interface N22 with the following details from node NSSF1 to AMF1:
      | parameter                                                                                                                | value            |
      | header.nva.0.name                                                                                                        | :status          |
      | header.nva.0.value                                                                                                       | 200              |
      | header.nva.1.name                                                                                                        | content-type     |
      | header.nva.1.value                                                                                                       | application/json |
      | authorized_network_slice_info.target_amf_set                                                                             | 404-30-01-001    |
      | authorized_network_slice_info.allowed_nssai_list.0.allowed_nssai.allowed_snssai_list.0.allowed_snssai.allowed_snssai.sst | 1                |
      | authorized_network_slice_info.allowed_nssai_list.0.allowed_nssai.access_type                                             | 3GPP_ACCESS      |

    Then I receive and validate HTTPV2 message HTTPV2_NNSSF_NETWORK_SLICE_SELECTION_GET_RES_200 on interface N22 with the following details on node AMF1 from NSSF1:
      | parameter                                                                                                                | value                         |
      | header.nva.0.name                                                                                                        | {string:eq}(:status)          |
      | header.nva.0.value                                                                                                       | {string:eq}(200)              |
      | header.nva.1.name                                                                                                        | {string:eq}(content-type)     |
      | header.nva.1.value                                                                                                       | {string:eq}(application/json) |
      | authorized_network_slice_info.target_amf_set                                                                             | {string:eq}(404-30-01-001)    |
      | authorized_network_slice_info.allowed_nssai_list.0.allowed_nssai.allowed_snssai_list.0.allowed_snssai.allowed_snssai.sst | {string:eq}(1)                |
      | authorized_network_slice_info.allowed_nssai_list.0.allowed_nssai.access_type                                             | {string:eq}(3GPP_ACCESS)      |

### UE Security Context Setup

    When I send NGAP message NG_DOWNLINK_NAS_SECURITY_MODE_CMD on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                            | value             |
      | amf_ue_ngap_id                                       | incr(1234,1)      |
      | ran_ue_ngap_id                                       | $(RAN_UE_NGAP_ID) |
      | nas_pdu.extended_protocol_discriminator              | 126               |
      | nas_pdu.security_header_type                         | 0x03              |
      | nas_pdu.message_type                                 | 0x5d              |
      | nas_pdu.security_mode_command.nas_security_algorithm | 0x01              |
      | nas_pdu.security_mode_command.nas_key_set_identifier | 0x00              |
      | nas_pdu.security_mode_command.ue_security_capability | 0xc0c0            |

    Then I receive and validate NGAP message NG_DOWNLINK_NAS_SECURITY_MODE_CMD on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                            | value                           |
      | amf_ue_ngap_id                                       | {string:eq}($(AMF_UE_NGAP_ID))  |
      | ran_ue_ngap_id                                       | {string:eq}(incr(4294967295,1)) |
      | nas_pdu.extended_protocol_discriminator              | {string:eq}(126)                |
      | nas_pdu.security_header_type                         | {string:eq}(0x03)               |
      | nas_pdu.message_type                                 | {string:eq}(0x5d)               |
      | nas_pdu.security_mode_command.nas_security_algorithm | {string:eq}(0x01)               |
      | nas_pdu.security_mode_command.nas_key_set_identifier | {string:eq}(0x00)               |
      | nas_pdu.security_mode_command.ue_security_capability | {string:eq}(0xc0c0)             |

    When I send NGAP message NG_UPLINK_NAS_SECURITY_MODE_COMPLETE on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                      | value                                     |
      | amf_ue_ngap_id                                                                                                                 | $(AMF_UE_NGAP_ID)                         |
      | ran_ue_ngap_id                                                                                                                 | $(RAN_UE_NGAP_ID)                         |
      | nas_pdu.extended_protocol_discriminator                                                                                        | {abotprop.SUT.NAS.EDP}                    |
      | nas_pdu.security_header_type                                                                                                   | 0x03                                      |
      | nas_pdu.message_type                                                                                                           | {abotprop.SUT.NAS.SEC.COM.MSG}            |
      | nas_pdu.security_mode_complete.nas_message_container.extended_protocol_discriminator                                           | {abotprop.SUT.NAS.EDP}                    |
      | nas_pdu.security_mode_complete.nas_message_container.security_header_type                                                      | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}         |
      | nas_pdu.security_mode_complete.nas_message_container.message_type                                                              | {abotprop.SUT.NAS.REG.REQ.MSG}            |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_registration_type                                | {abotprop.SUT.NAS.5GS.REG.TYPE.INI.REG}   |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.nas_key_set_identifier                               | {abotprop.SUT.NAS.KSI}                    |
      #| nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mobile_identity                                  | {abotprop.SUT.NAS.5GS.MOB.IDN}            |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.type_of_id                         | 0x01                                      |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_format                   | 0x00                                      |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_netwrk_id.mcc  | {abotprop.SUT.MCC}                        |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_netwrk_id.mnc  | {abotprop.SUT.MNC}                        |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_imsi.routing_ind         | 0                                         |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_imsi.prot_scheme_id      | 0                                         |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_net_pub_key_id | 0                                         |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_imsi.msin                | incr({abotprop.SUT.NAS.5GS.MOB.MSIN},1)   |
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
      | nas_pdu.security_header_type                                                                         | {string:eq}(0x03)                                      |
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

    When I send HTTPV2 message HTTPV2_NUDM_UECM_3GPP_ACCESS_REGISTRATION_PUT_REQ on interface N8 with the following details from node AMF1 to UDM1:
      | parameter                                       | value                                                                                                  |
      | header.nva.0.name                               | :method                                                                                                |
      | header.nva.0.value                              | PUT                                                                                                    |
      | header.nva.1.name                               | :path                                                                                                  |
      | header.nva.1.value                              | /127.0.0.1:12349/nudm-uecm/v1/incr(imsi-404309990000001,1)/registrations/amf-3gpp-access               |
      | header.nva.2.name                               | content-type                                                                                           |
      | header.nva.2.value                              | application/json                                                                                       |
      | amf_3gpp_access_registration.amf_id             | 010041                                                                                                 |
      | amf_3gpp_access_registration.dereg_callback_uri | /127.0.0.1:12349/nudm-uecm/v1/incr(imsi-404309990000001,1)/registrations/amf-3gpp-access/dereg-calback |
      | amf_3gpp_access_registration.guami.plmn_id.mcc  | {abotprop.SUT.MCC}                                                                                     |
      | amf_3gpp_access_registration.guami.plmn_id.mnc  | {abotprop.SUT.MNC}                                                                                     |
      | amf_3gpp_access_registration.guami.amf_id       | {abotprop.SUT.AMF.REG.AMF.ID}                                                                          |
      | amf_3gpp_access_registration.rat_type           | {abotprop.SUT.RATTYPE1}                                                                                |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UECM_3GPP_ACCESS_REGISTRATION_PUT_REQ on interface N8 with the following details on node UDM1 from AMF1:
      | parameter                                       | value                                                                                                 |
      | header.nva.0.name                               | {string:eq}(:method)                                                                                  |
      | header.nva.0.value                              | {string:eq}(PUT)                                                                                      |
      | header.nva.1.name                               | {string:eq}(:path)                                                                                    |
      | header.nva.1.value                              | {string:eq}(/127.0.0.1:12349/nudm-uecm/v1/incr(imsi-404309990000001,1)/registrations/amf-3gpp-access) |
      | header.nva.2.name                               | {string:eq}(content-type)                                                                             |
      | header.nva.2.value                              | {string:eq}(application/json)                                                                         |
      | amf_3gpp_access_registration.amf_id             | save(AMF_ID)                                                                                          |
      | amf_3gpp_access_registration.dereg_callback_uri | save(DREG_CALLBACK_URI)                                                                               |
      | amf_3gpp_access_registration.guami.plmn_id.mcc  | save(GUAMI_PLMN_MCC)                                                                                  |
      | amf_3gpp_access_registration.guami.plmn_id.mnc  | save(GUAMI_PLMN_MNC)                                                                                  |
      | amf_3gpp_access_registration.guami.amf_id       | save(GUAMI_AMF_ID)                                                                                    |
      | amf_3gpp_access_registration.rat_type           | save(RAT_TYPE)                                                                                        |

    When I send HTTPV2 message HTTPV2_NUDM_UECM_3GPP_ACCESS_REGISTRATION_PUT_RES_201 on interface N8 with the following details from node UDM1 to AMF1:
      | parameter                                       | value                                                                                    |
      | header.nva.0.name                               | :status                                                                                  |
      | header.nva.0.value                              | 201                                                                                      |
      | header.nva.1.name                               | location                                                                                 |
      | header.nva.1.value                              | /127.0.0.1:12349/nudm-uecm/v1/incr(imsi-404309990000001,1)/registrations/amf-3gpp-access |
      | amf_3gpp_access_registration.amf_id             | $(AMF_ID)                                                                                |
      | amf_3gpp_access_registration.dereg_callback_uri | $(DREG_CALLBACK_URI)                                                                     |
      | amf_3gpp_access_registration.guami.plmn_id.mcc  | $(GUAMI_PLMN_MCC)                                                                        |
      | amf_3gpp_access_registration.guami.plmn_id.mnc  | $(GUAMI_PLMN_MNC)                                                                        |
      | amf_3gpp_access_registration.guami.amf_id       | $(GUAMI_AMF_ID)                                                                          |
      | amf_3gpp_access_registration.rat_type           | $(RAT_TYPE)                                                                              |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UECM_3GPP_ACCESS_REGISTRATION_PUT_RES_201 on interface N8 with the following details on node AMF1 from UDM1:
      | parameter                                       | value                   |
      | header.nva.0.name                               | {string:eq}(:status)    |
      | header.nva.0.value                              | {string:eq}(201)        |
      | header.nva.1.name                               | {string:eq}(location)   |
      | header.nva.1.value                              | save(LOCATION)          |
      | amf_3gpp_access_registration.amf_id             | save(AMF_ID)            |
      | amf_3gpp_access_registration.dereg_callback_uri | save(DREG_CALLBACK_URI) |
      | amf_3gpp_access_registration.guami.plmn_id.mcc  | save(GUAMI_PLMN_MCC)    |
      | amf_3gpp_access_registration.guami.plmn_id.mnc  | save(GUAMI_PLMN_MNC)    |
      | amf_3gpp_access_registration.guami.amf_id       | save(GUAMI_AMF_ID)      |
      | amf_3gpp_access_registration.rat_type           | save(RAT_TYPE)          |

    When I send HTTPV2 message HTTPV2_NUDM_SDM_GET_REQ on interface N8 with the following details from node AMF1 to UDM1:
      | parameter          | value                                                                                                               |
      | header.nva.0.name  | :method                                                                                                             |
      | header.nva.0.value | GET                                                                                                                 |
      | header.nva.1.name  | :path                                                                                                               |
      | header.nva.1.value | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)?dataset-names=AM,SMF_SEL&plmn-id={"mcc":"404","mnc":"30"} |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_GET_REQ on interface N8 with the following details on node UDM1 from AMF1:
      | parameter          | value                                                                                                                            |
      | header.nva.0.name  | {string:eq}(:method)                                                                                                             |
      | header.nva.0.value | {string:eq}(GET)                                                                                                                 |
      | header.nva.1.name  | {string:eq}(:path)                                                                                                               |
      | header.nva.1.value | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)?dataset-names=AM,SMF_SEL&plmn-id={"mcc":"404","mnc":"30"}) |

    When I send HTTPV2 message HTTPV2_NUDM_SDM_GET_RES_200 on interface N8 with the following details from node UDM1 to AMF1:
      | parameter                                                                                         | value                                          |
      | header.nva.0.name                                                                                 | :status                                        |
      | header.nva.0.value                                                                                | 200                                            |
      | header.nva.1.name                                                                                 | content-type                                   |
      | header.nva.1.value                                                                                | application/json                               |
      | subscription_data_sets.am_data.gpsis.0.gpsi                                                       | msisdn-404309987654321                         |
      | subscription_data_sets.am_data.subscribed_ue_ambr.uplink                                          | 50000000                                       |
      | subscription_data_sets.am_data.subscribed_ue_ambr.downlink                                        | 100000000                                      |
      | subscription_data_sets.am_data.nssai.default_single_nssais.0.snssai.sst                           | 1                                              |
      | subscription_data_sets.am_data.rat_restrictions.0.rat_type                                        | NR                                             |
      | subscription_data_sets.am_data.rat_restrictions.1.rat_type                                        | EUTRA                                          |
      | subscription_data_sets.am_data.core_network_type_restrictions.0.core_network_type                 | 5GC                                            |
      | subscription_data_sets.smf_sel_data.subscribed_snssai_info.0.snssai_info.single_nssai.sst         | 1                                              |
      | subscription_data_sets.smf_sel_data.subscribed_snssai_info.0.snssai_info.dnn_infos.0.dnn_info.dnn | internet.apn.5gs.mnc030.mcc404.3gppnetwork.org |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_GET_RES_200 on interface N8 with the following details on node AMF1 from UDM1:
      | parameter                                                                                         | value                                                       |
      | header.nva.0.name                                                                                 | {string:eq}(:status)                                        |
      | header.nva.0.value                                                                                | {string:eq}(200)                                            |
      | header.nva.1.name                                                                                 | {string:eq}(content-type)                                   |
      | header.nva.1.value                                                                                | {string:eq}(application/json)                               |
      | subscription_data_sets.am_data.gpsis.0.gpsi                                                       | {string:eq}(msisdn-404309987654321)                         |
      | subscription_data_sets.am_data.subscribed_ue_ambr.uplink                                          | {string:eq}(50000000)                                       |
      | subscription_data_sets.am_data.subscribed_ue_ambr.downlink                                        | {string:eq}(100000000)                                      |
      | subscription_data_sets.am_data.nssai.default_single_nssais.0.snssai.sst                           | {string:eq}(1)                                              |
      | subscription_data_sets.am_data.rat_restrictions.0.rat_type                                        | {string:eq}(NR)                                             |
      | subscription_data_sets.am_data.rat_restrictions.1.rat_type                                        | {string:eq}(EUTRA)                                          |
      | subscription_data_sets.am_data.core_network_type_restrictions.0.core_network_type                 | {string:eq}(5GC)                                            |
      | subscription_data_sets.smf_sel_data.subscribed_snssai_info.0.snssai_info.single_nssai.sst         | {string:eq}(1)                                              |
      | subscription_data_sets.smf_sel_data.subscribed_snssai_info.0.snssai_info.dnn_infos.0.dnn_info.dnn | {string:eq}(internet.apn.5gs.mnc030.mcc404.3gppnetwork.org) |

    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_REQ on interface N8 with the following details from node AMF1 to UDM1:
      | parameter                                      | value                                                                                           |
      | header.nva.0.name                              | :method                                                                                         |
      | header.nva.0.value                             | POST                                                                                            |
      | header.nva.1.name                              | :path                                                                                           |
      | header.nva.1.value                             | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscriptions                     |
      | header.nva.2.name                              | content-type                                                                                    |
      | header.nva.2.value                             | application/json                                                                                |
      | sdm_subscription.callback_reference            | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/callback-subs-notify |
      | sdm_subscription.monitored_resource_uris.0.uri | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/amData               |
      | sdm_subscription.nf_instance_id                | 5a2b84e4-0cb7-4575-ac08-46a2812bec0d                                                            |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_REQ on interface N8 with the following details on node UDM1 from AMF1:
      | parameter                                      | value                                                                                                        |
      | header.nva.0.name                              | {string:eq}(:method)                                                                                         |
      | header.nva.0.value                             | {string:eq}(POST)                                                                                            |
      | header.nva.1.name                              | {string:eq}(:path)                                                                                           |
      | header.nva.1.value                             | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscriptions)                     |
      | header.nva.2.name                              | {string:eq}(content-type)                                                                                    |
      | header.nva.2.value                             | {string:eq}(application/json)                                                                                |
      | sdm_subscription.callback_reference            | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/callback-subs-notify) |
      | sdm_subscription.monitored_resource_uris.0.uri | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/amData)               |
      | sdm_subscription.nf_instance_id                | {string:eq}(5a2b84e4-0cb7-4575-ac08-46a2812bec0d)                                                            |

    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_RES_201 on interface N8 with the following details from node UDM1 to AMF1:
      | parameter                                      | value                                                                                           |
      | header.nva.0.name                              | :status                                                                                         |
      | header.nva.0.value                             | 201                                                                                             |
      | header.nva.1.name                              | location                                                                                        |
      | header.nva.1.value                             | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscriptions/subscriptionId1     |
      | header.nva.2.name                              | content-type                                                                                    |
      | header.nva.2.value                             | application/json                                                                                |
      | sdm_subscription.callback_reference            | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/callback-subs-notify |
      | sdm_subscription.monitored_resource_uris.0.uri | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/amData               |
      | sdm_subscription.nf_instance_id                | 5a2b84e4-0cb7-4575-ac08-46a2812bec0d                                                            |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_RES_201 on interface N8 with the following details on node AMF1 from UDM1:
      | parameter                                      | value                                                                                                        |
      | header.nva.0.name                              | {string:eq}(:status)                                                                                         |
      | header.nva.0.value                             | {string:eq}(201)                                                                                             |
      | header.nva.1.name                              | {string:eq}(location)                                                                                        |
      | header.nva.1.value                             | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscriptions/subscriptionId1)     |
      | header.nva.2.name                              | {string:eq}(content-type)                                                                                    |
      | header.nva.2.value                             | {string:eq}(application/json)                                                                                |
      | sdm_subscription.callback_reference            | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/callback-subs-notify) |
      | sdm_subscription.monitored_resource_uris.0.uri | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/amData)               |
      | sdm_subscription.nf_instance_id                | {string:eq}(5a2b84e4-0cb7-4575-ac08-46a2812bec0d)                                                            |

    When I send HTTPV2 message HTTPV2_NPCFAM_POLICY_CONTROL_CREATE_POST_REQ on interface N15 with the following details from node AMF1 to PCF1:
      | parameter                                   | value                                                      |
      | header.nva.0.name                           | :method                                                    |
      | header.nva.0.value                          | POST                                                       |
      | header.nva.1.name                           | :path                                                      |
      | header.nva.1.value                          | /127.0.0.1:12348/npcf-am-policy-control/v1/policies        |
      | header.nva.2.name                           | content-type                                               |
      | header.nva.2.value                          | application/json                                           |
      | policy_association_request.notification_uri | /127.0.0.1:12348/npcf-am-policy-control/v1/policies/amPol1 |
      | policy_association_request.supi             | incr(imsi-404309990000001,1)                               |
      | policy_association_request.supp_feat        | SupportFeatureVersion1                                     |

    Then I receive and validate HTTPV2 message HTTPV2_NPCFAM_POLICY_CONTROL_CREATE_POST_REQ on interface N15 with the following details on node PCF1 from AMF1:
      | parameter                                   | value                                                                   |
      | header.nva.0.name                           | {string:eq}(:method)                                                    |
      | header.nva.0.value                          | {string:eq}(POST)                                                       |
      | header.nva.1.name                           | {string:eq}(:path)                                                      |
      | header.nva.1.value                          | {string:eq}(/127.0.0.1:12348/npcf-am-policy-control/v1/policies)        |
      | header.nva.2.name                           | {string:eq}(content-type)                                               |
      | header.nva.2.value                          | {string:eq}(application/json)                                           |
      | policy_association_request.notification_uri | {string:eq}(/127.0.0.1:12348/npcf-am-policy-control/v1/policies/amPol1) |
      | policy_association_request.supi             | {string:eq}(incr(imsi-404309990000001,1))                               |
      | policy_association_request.supp_feat        | {string:eq}(SupportFeatureVersion1)                                     |

    When I send HTTPV2 message HTTPV2_NPCFAM_POLICY_CONTROL_CREATE_POST_RES_201 on interface N15 with the following details from node PCF1 to AMF1:
      | parameter                    | value                                                      |
      | header.nva.0.name            | :status                                                    |
      | header.nva.0.value           | 201                                                        |
      | header.nva.1.name            | location                                                   |
      | header.nva.1.value           | /127.0.0.1:12348/npcf-am-policy-control/v1/policies/amPol1 |
      | header.nva.2.name            | content-type                                               |
      | header.nva.2.value           | application/json                                           |
      | policy_association.supp_feat | SupportFeatureVersion1                                     |

    Then I receive and validate HTTPV2 message HTTPV2_NPCFAM_POLICY_CONTROL_CREATE_POST_RES_201 on interface N15 with the following details on node AMF1 from PCF1:
      | parameter                    | value                                                                   |
      | header.nva.0.name            | {string:eq}(:status)                                                    |
      | header.nva.0.value           | {string:eq}(201)                                                        |
      | header.nva.1.name            | {string:eq}(location)                                                   |
      | header.nva.1.value           | {string:eq}(/127.0.0.1:12348/npcf-am-policy-control/v1/policies/amPol1) |
      | header.nva.2.name            | {string:eq}(content-type)                                               |
      | header.nva.2.value           | {string:eq}(application/json)                                           |
      | policy_association.supp_feat | {string:eq}(SupportFeatureVersion1)                                     |

    When I send NGAP message NG_INIT_CTXT_SET_REQ_NAS_REGIS_ACC on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                                                                       | value                                                            |
      | amf_ue_ngap_id                                                                                  | incr(1234,1)                                                     |
      | ran_ue_ngap_id                                                                                  | $(RAN_UE_NGAP_ID)                                                |
      | nas_pdu.extended_protocol_discriminator                                                         | 126                                                              |
      | nas_pdu.security_header_type                                                                    | 0x01                                                             |
      | nas_pdu.message_type                                                                            | 0x42                                                             |
      | nas_pdu.registration_accept.5gs_reg_result                                                      | 9                                                                |
      #| nas_pdu.registration_accept.5gs_mobile_identity                                                 | 0xf200f1100100415b855ff4                                         |
      | nas_pdu.registration_accept.5gs_mob_id_choice.type_of_id                                        | 0x02                                                             |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.mcc                                       | {abotprop.SUT.MCC}                                               |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.mnc                                       | {abotprop.SUT.MNC}                                               |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_region_id                             | {abotprop.SUT.GUAMI.AMF.REGION.ID}                               |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_set_id                                | {abotprop.SUT.GUAMI.AMF.SET.ID}                                  |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_pointer                               | {abotprop.SUT.GUAMI.AMF.POINTER}                                 |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.5g_tmsi                                   | incr({abotprop.SUT.5GTMSI.START},1)                              |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.type_of_list                            | 0                                                                |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.no_of_elements                          | 1                                                                |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.mcc            | {abotprop.SUT.MCC}                                               |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.mnc            | {abotprop.SUT.MNC}                                               |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.tac_list.0.tac | {abotprop.SUT.TAC}                                               |
      | guami.plmn_identity.mcc                                                                         | 404                                                              |
      | guami.plmn_identity.mnc                                                                         | 30                                                               |
      | guami.amf_region_id                                                                             | 0x01                                                             |
      | guami.amf_set_id                                                                                | 0x01                                                             |
      | guami.pointer.amf_pointer                                                                       | 0x01                                                             |
      | allowed_s-nssai_list.0.sst                                                                      | 1                                                                |
      | ue_security_capabilities.nr_encryption_algo                                                     | 0xc000                                                           |
      | ue_security_capabilities.nr_integrity_protection_algo                                           | 0xc000                                                           |
      | ue_security_capabilities.e_utra_encryption_algo                                                 | 0x0000                                                           |
      | ue_security_capabilities.e_utra_integrity_protection_algo                                       | 0x0000                                                           |
      | security_key                                                                                    | a8202f2d5e1d4307b751e0ac558025f2865d9c25eebb409d9a5560145dd8e765 |

    Then I receive and validate NGAP message NG_INIT_CTXT_SET_REQ_NAS_REGIS_ACC on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                                                                       | value                                                                         |
      | amf_ue_ngap_id                                                                                  | {string:eq}($(AMF_UE_NGAP_ID))                                                |
      | ran_ue_ngap_id                                                                                  | {string:eq}(incr(4294967295,1))                                               |
      | nas_pdu.extended_protocol_discriminator                                                         | {string:eq}(126)                                                              |
      | nas_pdu.security_header_type                                                                    | {string:eq}(0x01)                                                             |
      | nas_pdu.message_type                                                                            | {string:eq}(0x42)                                                             |
      | nas_pdu.registration_accept.5gs_reg_result                                                      | {string:eq}(9)                                                                |
      #| nas_pdu.registration_accept.5gs_mobile_identity                                                 | {string:eq}(0xf200f1100100415b855ff4)                                         |
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
      | guami.plmn_identity.mcc                                                                         | {string:eq}(404)                                                              |
      | guami.plmn_identity.mnc                                                                         | {string:eq}(30)                                                               |
      | guami.amf_region_id                                                                             | {string:eq}(0x01)                                                             |
      | guami.amf_set_id                                                                                | {string:eq}(0x01)                                                             |
      | guami.pointer.amf_pointer                                                                       | {string:eq}(0x01)                                                             |
      | allowed_s-nssai_list.0.sst                                                                      | {string:eq}(1)                                                                |
      | ue_security_capabilities.nr_encryption_algo                                                     | {string:eq}(0xc000)                                                           |
      | ue_security_capabilities.nr_integrity_protection_algo                                           | {string:eq}(0xc000)                                                           |
      | ue_security_capabilities.e_utra_encryption_algo                                                 | {string:eq}(0x0000)                                                           |
      | ue_security_capabilities.e_utra_integrity_protection_algo                                       | {string:eq}(0x0000)                                                           |
      | security_key                                                                                    | {string:eq}(a8202f2d5e1d4307b751e0ac558025f2865d9c25eebb409d9a5560145dd8e765) |

    When I send NGAP message NG_INIT_CTXT_SET_RES on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter      | value              |
      | amf_ue_ngap_id | $(AMF_UE_NGAP_ID)  |
      | ran_ue_ngap_id | incr(4294967295,1) |

    Then I receive and validate NGAP message NG_INIT_CTXT_SET_RES on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter      | value                          |
      | amf_ue_ngap_id | {string:eq}(incr(1234,1))      |
      | ran_ue_ngap_id | {string:eq}($(RAN_UE_NGAP_ID)) |

    When I send NGAP message NG_UPLINK_NAS_REGIS_COMPLETE on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                       | value              |
      | amf_ue_ngap_id                                                                  | $(AMF_UE_NGAP_ID)  |
      | ran_ue_ngap_id                                                                  | incr(4294967295,1) |
      | nas_pdu.extended_protocol_discriminator                                         | 126                |
      | nas_pdu.security_header_type                                                    | 0x01               |
      | nas_pdu.message_type                                                            | 0x43               |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | 404                |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | 30                 |
      | user_location_information.nr_user_location_information.tai.tac                  | 0x000001           |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | 404                |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | 30                 |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | 3584               |

    Then I receive and validate NGAP message NG_UPLINK_NAS_REGIS_COMPLETE on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                       | value                          |
      | amf_ue_ngap_id                                                                  | {string:eq}(incr(1234,1))      |
      | ran_ue_ngap_id                                                                  | {string:eq}($(RAN_UE_NGAP_ID)) |
      | nas_pdu.extended_protocol_discriminator                                         | {string:eq}(126)               |
      | nas_pdu.security_header_type                                                    | {string:eq}(0x01)              |
      | nas_pdu.message_type                                                            | {string:eq}(0x43)              |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {string:eq}(404)               |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {string:eq}(30)                |
      | user_location_information.nr_user_location_information.tai.tac                  | {string:eq}(0x000001)          |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {string:eq}(404)               |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {string:eq}(30)                |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {string:eq}(3584)              |

### UE Initiated Single PDU Session Establishment Procedure

    When I send NGAP message NG_UPLINK_NAS_UL_NAS_TRANS_PDU_SESS_ESTAB_REQ on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                               | value               |
      | amf_ue_ngap_id                                                                                                                          | $(AMF_UE_NGAP_ID)   |
      | ran_ue_ngap_id                                                                                                                          | incr(4294967295,1)  |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                                                            | 404                 |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                                                            | 30                  |
      | user_location_information.nr_user_location_information.tai.tac                                                                          | 0x100101            |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                                                         | 404                 |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                                                         | 30                  |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                                                          | 3584                |
      | nas_pdu.extended_protocol_discriminator                                                                                                 | 126                 |
      | nas_pdu.security_header_type                                                                                                            | 0x01                |
      | nas_pdu.message_type                                                                                                                    | 0x67                |
      | nas_pdu.ul_nas_transport.pdu_session_identity                                                                                           | 0x1206              |
      | nas_pdu.ul_nas_transport.request_type                                                                                                   | 0x81                |
      | nas_pdu.ul_nas_transport.snssai                                                                                                         | 0x01                |
      | nas_pdu.ul_nas_transport.dnn                                                                                                            | {abotprop.SUT.DNN1} |
      | nas_pdu.ul_nas_transport.payload_container_type                                                                                         | 0x01                |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator              | 0x2e                |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                               | 0x06                |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                                          | 0x01                |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                                 | 0xc1                |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_req.int_protect_max_data_rate | 0xffff              |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_req.pdu_sess_type             | 0x91                |

    Then I receive and validate NGAP message NG_UPLINK_NAS_UL_NAS_TRANS_PDU_SESS_ESTAB_REQ on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                                                               | value                            |
      | amf_ue_ngap_id                                                                                                                          | {string:eq}(incr(1234,1))        |
      | ran_ue_ngap_id                                                                                                                          | {string:eq}($(RAN_UE_NGAP_ID))   |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                                                            | {string:eq}(404)                 |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                                                            | {string:eq}(30)                  |
      | user_location_information.nr_user_location_information.tai.tac                                                                          | {string:eq}(0x100101)            |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                                                         | {string:eq}(404)                 |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                                                         | {string:eq}(30)                  |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                                                          | {string:eq}(3584)                |
      | nas_pdu.extended_protocol_discriminator                                                                                                 | {string:eq}(126)                 |
      | nas_pdu.security_header_type                                                                                                            | {string:eq}(0x01)                |
      | nas_pdu.message_type                                                                                                                    | {string:eq}(0x67)                |
      | nas_pdu.ul_nas_transport.pdu_session_identity                                                                                           | {string:eq}(0x1206)              |
      | nas_pdu.ul_nas_transport.request_type                                                                                                   | {string:eq}(0x81)                |
      | nas_pdu.ul_nas_transport.snssai                                                                                                         | {string:eq}(0x01)                |
      | nas_pdu.ul_nas_transport.dnn                                                                                                            | {string:eq}({abotprop.SUT.DNN1}) |
      | nas_pdu.ul_nas_transport.payload_container_type                                                                                         | {string:eq}(0x01)                |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator              | {string:eq}(0x2e)                |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                               | {string:eq}(0x06)                |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                                          | {string:eq}(0x01)                |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                                 | {string:eq}(0xc1)                |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_req.int_protect_max_data_rate | {string:eq}(0xffff)              |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_req.pdu_sess_type             | {string:eq}(0x91)                |

    When I send HTTPV2 message HTTPV2_NSMF_CREATE_SM_CONTEXT_REQ on interface N11 with the following details from node AMF1 to SMF1:
      | parameter                                                                                                   | value                                                                                   |
      | header.nva.0.name                                                                                           | :method                                                                                 |
      | header.nva.0.value                                                                                          | POST                                                                                    |
      | header.nva.1.name                                                                                           | :path                                                                                   |
      | header.nva.1.value                                                                                          | /127.0.0.1:12349/nsmf-pdusession/v1/sm-contexts                                         |
      | header.nva.2.name                                                                                           | content-type                                                                            |
      | header.nva.2.value                                                                                          | multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json |
      | multipart_related.json_data.content_type                                                                    | application/json                                                                        |
      | multipart_related.json_data.content_id                                                                      | sm-context-create-data                                                                  |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.plmn_id.mcc                 | 404                                                                                     |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.plmn_id.mnc                 | 30                                                                                      |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.nr_cell_id                  | 1602                                                                                    |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.plmn_id.mcc                  | 404                                                                                     |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.plmn_id.mnc                  | 30                                                                                      |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.tac                          | 2                                                                                       |
      | multipart_related.json_data.sm_context_create_data.sm_context_status_uri                                    | http://127.0.0.1:12349/namf-comm/v1/sm-contexts/smctx-1/status/6                        |
      | multipart_related.json_data.sm_context_create_data.gpsi                                                     | msisdn-987654321                                                                        |
      | multipart_related.json_data.sm_context_create_data.pdu_session_id                                           | 6                                                                                       |
      | multipart_related.json_data.sm_context_create_data.n1_sm_msg.content_id                                     | n1-pdu-session-establishment-request                                                    |
      | multipart_related.json_data.sm_context_create_data.an_type                                                  | 3GPP_ACCESS                                                                             |
      | multipart_related.json_data.sm_context_create_data.supi                                                     | incr(imsi-404309990000001,1)                                                            |
      | multipart_related.json_data.sm_context_create_data.s_nssai.sst                                              | 1                                                                                       |
      | multipart_related.json_data.sm_context_create_data.serving_nf_id                                            | 0330940e-8a4f-4b63-98d8-03628f717df3                                                    |
      | multipart_related.json_data.sm_context_create_data.pei                                                      | incr({abotprop.SUT.PEI},1)                                                              |
      | multipart_related.json_data.sm_context_create_data.request_type                                             | INITIAL_REQUEST                                                                         |
      | multipart_related.json_data.sm_context_create_data.dnn                                                      | {abotprop.SUT.DNN1}                                                                     |
      | multipart_related.json_data.sm_context_create_data.guami.plmn_id.mcc                                        | 404                                                                                     |
      | multipart_related.json_data.sm_context_create_data.guami.plmn_id.mnc                                        | 30                                                                                      |
      | multipart_related.json_data.sm_context_create_data.guami.amf_id                                             | 010041                                                                                  |
      | multipart_related.json_data.sm_context_create_data.serving_network.mcc                                      | 404                                                                                     |
      | multipart_related.json_data.sm_context_create_data.serving_network.mnc                                      | 30                                                                                      |
      | multipart_related.json_data.sm_context_create_data.pdu_sessions_activate_list.0.pdu_session_id              | 6                                                                                       |
      | multipart_related.binary_data_n1_sm_message.content_type                                                    | application/vnd.3gpp.5gnas                                                              |
      | multipart_related.binary_data_n1_sm_message.content_id                                                      | n1-pdu-session-establishment-request                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator              | 0x2e                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                               | 0x06                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                                          | 0x01                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                                 | 0xc1                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_estab_req.int_protect_max_data_rate | 0xffff                                                                                  |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_estab_req.pdu_sess_type             | 0x91                                                                                    |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_CREATE_SM_CONTEXT_REQ on interface N11 with the following details on node SMF1 from AMF1:
      | parameter                                                                                                   | value                                                                                                |
      | header.nva.0.name                                                                                           | {string:eq}(:method)                                                                                 |
      | header.nva.0.value                                                                                          | {string:eq}(POST)                                                                                    |
      | header.nva.1.name                                                                                           | {string:eq}(:path)                                                                                   |
      | header.nva.1.value                                                                                          | {string:eq}(/127.0.0.1:12349/nsmf-pdusession/v1/sm-contexts)                                         |
      | header.nva.2.name                                                                                           | {string:eq}(content-type)                                                                            |
      | header.nva.2.value                                                                                          | {string:eq}(multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json) |
      | multipart_related.json_data.content_type                                                                    | {string:eq}(application/json)                                                                        |
      | multipart_related.json_data.content_id                                                                      | {string:eq}(sm-context-create-data)                                                                  |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.plmn_id.mcc                 | {string:eq}(404)                                                                                     |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.plmn_id.mnc                 | {string:eq}(30)                                                                                      |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.nr_cell_id                  | {string:eq}(1602)                                                                                    |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.plmn_id.mcc                  | {string:eq}(404)                                                                                     |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.plmn_id.mnc                  | {string:eq}(30)                                                                                      |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.tac                          | {string:eq}(2)                                                                                       |
      | multipart_related.json_data.sm_context_create_data.sm_context_status_uri                                    | {string:eq}(http://127.0.0.1:12349/namf-comm/v1/sm-contexts/smctx-1/status/6)                        |
      | multipart_related.json_data.sm_context_create_data.gpsi                                                     | {string:eq}(msisdn-987654321)                                                                        |
      | multipart_related.json_data.sm_context_create_data.pdu_session_id                                           | {string:eq}(6)                                                                                       |
      | multipart_related.json_data.sm_context_create_data.n1_sm_msg.content_id                                     | {string:eq}(n1-pdu-session-establishment-request)                                                    |
      | multipart_related.json_data.sm_context_create_data.an_type                                                  | {string:eq}(3GPP_ACCESS)                                                                             |
      | multipart_related.json_data.sm_context_create_data.supi                                                     | {string:eq}(incr(imsi-404309990000001,1))                                                            |
      | multipart_related.json_data.sm_context_create_data.s_nssai.sst                                              | {string:eq}(1)                                                                                       |
      | multipart_related.json_data.sm_context_create_data.serving_nf_id                                            | {string:eq}(0330940e-8a4f-4b63-98d8-03628f717df3)                                                    |
      | multipart_related.json_data.sm_context_create_data.pei                                                      | save(PEI)                                                                                            |
      | multipart_related.json_data.sm_context_create_data.request_type                                             | {string:eq}(INITIAL_REQUEST)                                                                         |
      | multipart_related.json_data.sm_context_create_data.dnn                                                      | {string:eq}({abotprop.SUT.DNN1})                                                                     |
      | multipart_related.json_data.sm_context_create_data.guami.plmn_id.mcc                                        | {string:eq}(404)                                                                                     |
      | multipart_related.json_data.sm_context_create_data.guami.plmn_id.mnc                                        | {string:eq}(30)                                                                                      |
      | multipart_related.json_data.sm_context_create_data.guami.amf_id                                             | {string:eq}(010041)                                                                                  |
      | multipart_related.json_data.sm_context_create_data.serving_network.mcc                                      | {string:eq}(404)                                                                                     |
      | multipart_related.json_data.sm_context_create_data.serving_network.mnc                                      | {string:eq}(30)                                                                                      |
      | multipart_related.json_data.sm_context_create_data.pdu_sessions_activate_list.0.pdu_session_id              | {string:eq}(6)                                                                                       |
      | multipart_related.binary_data_n1_sm_message.content_type                                                    | {string:eq}(application/vnd.3gpp.5gnas)                                                              |
      | multipart_related.binary_data_n1_sm_message.content_id                                                      | {string:eq}(n1-pdu-session-establishment-request)                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator              | {string:eq}(0x2e)                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                               | {string:eq}(0x06)                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                                          | {string:eq}(0x01)                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                                 | {string:eq}(0xc1)                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_estab_req.int_protect_max_data_rate | {string:eq}(0xffff)                                                                                  |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_estab_req.pdu_sess_type             | {string:eq}(0x91)                                                                                    |

    When I send HTTPV2 message HTTPV2_NUDM_UECM_SMF_REG_PUT_REQ on interface N10 with the following details from node SMF1 to UDM1:
      | parameter                         | value                                                                                        |
      | header.nva.0.name                 | :method                                                                                      |
      | header.nva.0.value                | PUT                                                                                          |
      | header.nva.1.name                 | :path                                                                                        |
      | header.nva.1.value                | /127.0.0.1:12348/nudm-uecm/v1/incr(imsi-404309990000001,1)/registrations/smf-registrations/6 |
      | header.nva.2.name                 | content-type                                                                                 |
      | header.nva.2.value                | application/json                                                                             |
      | smf_registration.smf_instance_id  | 7ebf5515-c8e6-4405-992c-93ee0c0fb392                                                         |
      | smf_registration.pdu_session_id   | 6                                                                                            |
      | smf_registration.single_nssai.sst | 1                                                                                            |
      | smf_registration.plmn_id.mcc      | 404                                                                                          |
      | smf_registration.plmn_id.mnc      | 30                                                                                           |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UECM_SMF_REG_PUT_REQ on interface N10 with the following details on node UDM1 from SMF1:
      | parameter                         | value                                                                                                     |
      | header.nva.0.name                 | {string:eq}(:method)                                                                                      |
      | header.nva.0.value                | {string:eq}(PUT)                                                                                          |
      | header.nva.1.name                 | {string:eq}(:path)                                                                                        |
      | header.nva.1.value                | {string:eq}(/127.0.0.1:12348/nudm-uecm/v1/incr(imsi-404309990000001,1)/registrations/smf-registrations/6) |
      | header.nva.2.name                 | {string:eq}(content-type)                                                                                 |
      | header.nva.2.value                | {string:eq}(application/json)                                                                             |
      | smf_registration.smf_instance_id  | {string:eq}(7ebf5515-c8e6-4405-992c-93ee0c0fb392)                                                         |
      | smf_registration.pdu_session_id   | {string:eq}(6)                                                                                            |
      | smf_registration.single_nssai.sst | {string:eq}(1)                                                                                            |
      | smf_registration.plmn_id.mcc      | {string:eq}(404)                                                                                          |
      | smf_registration.plmn_id.mnc      | {string:eq}(30)                                                                                           |

    When I send HTTPV2 message HTTPV2_NUDM_UECM_SMF_REG_PUT_RES_201 on interface N10 with the following details from node UDM1 to SMF1:
      | parameter                         | value                                                                                        |
      | header.nva.0.name                 | :status                                                                                      |
      | header.nva.0.value                | 201                                                                                          |
      | header.nva.1.name                 | location                                                                                     |
      | header.nva.1.value                | /127.0.0.1:12348/nudm-uecm/v1/incr(imsi-404309990000001,1)/registrations/smf-registrations/6 |
      | header.nva.2.name                 | content-type                                                                                 |
      | header.nva.2.value                | application/json                                                                             |
      | smf_registration.smf_instance_id  | 7ebf5515-c8e6-4405-992c-93ee0c0fb392                                                         |
      | smf_registration.pdu_session_id   | 6                                                                                            |
      | smf_registration.single_nssai.sst | 1                                                                                            |
      | smf_registration.plmn_id.mcc      | 404                                                                                          |
      | smf_registration.plmn_id.mnc      | 30                                                                                           |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UECM_SMF_REG_PUT_RES_201 on interface N10 with the following details on node SMF1 from UDM1:
      | parameter                         | value                                                                                                     |
      | header.nva.0.name                 | {string:eq}(:status)                                                                                      |
      | header.nva.0.value                | {string:eq}(201)                                                                                          |
      | header.nva.1.name                 | {string:eq}(location)                                                                                     |
      | header.nva.1.value                | {string:eq}(/127.0.0.1:12348/nudm-uecm/v1/incr(imsi-404309990000001,1)/registrations/smf-registrations/6) |
      | header.nva.2.name                 | {string:eq}(content-type)                                                                                 |
      | header.nva.2.value                | {string:eq}(application/json)                                                                             |
      | smf_registration.smf_instance_id  | {string:eq}(7ebf5515-c8e6-4405-992c-93ee0c0fb392)                                                         |
      | smf_registration.pdu_session_id   | {string:eq}(6)                                                                                            |
      | smf_registration.single_nssai.sst | {string:eq}(1)                                                                                            |
      | smf_registration.plmn_id.mcc      | {string:eq}(404)                                                                                          |
      | smf_registration.plmn_id.mnc      | {string:eq}(30)                                                                                           |

    When I send HTTPV2 message HTTPV2_NSMF_CREATE_SM_CONTEXT_RES_201 on interface N11 with the following details from node SMF1 to AMF1:
      | parameter                                               | value                                                         |
      | header.nva.0.name                                       | :status                                                       |
      | header.nva.0.value                                      | 201                                                           |
      | header.nva.1.name                                       | content-type                                                  |
      | header.nva.1.value                                      | application/json                                              |
      | header.nva.2.name                                       | location                                                      |
      | header.nva.2.value                                      | http://127.0.0.1:12352/nsmf-pdusession/v1/sm-contexts/smctx-1 |
      | application_json.sm_context_created_data.h_smf_uri      | http://127.0.0.1:12352                                        |
      | application_json.sm_context_created_data.pdu_session_id | 6                                                             |
      | application_json.sm_context_created_data.s_nssai.sst    | 1                                                             |
      | application_json.sm_context_created_data.up_cnx_state   | ACTIVATED                                                     |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_CREATE_SM_CONTEXT_RES_201 on interface N11 with the following details on node AMF1 from SMF1:
      | parameter                                               | value                                                                      |
      | header.nva.0.name                                       | {string:eq}(:status)                                                       |
      | header.nva.0.value                                      | {string:eq}(201)                                                           |
      | header.nva.1.name                                       | {string:eq}(content-type)                                                  |
      | header.nva.1.value                                      | {string:eq}(application/json)                                              |
      | header.nva.2.name                                       | {string:eq}(location)                                                      |
      | header.nva.2.value                                      | {string:eq}(http://127.0.0.1:12352/nsmf-pdusession/v1/sm-contexts/smctx-1) |
      | application_json.sm_context_created_data.h_smf_uri      | {string:eq}(http://127.0.0.1:12352)                                        |
      | application_json.sm_context_created_data.pdu_session_id | {string:eq}(6)                                                             |
      | application_json.sm_context_created_data.s_nssai.sst    | {string:eq}(1)                                                             |
      | application_json.sm_context_created_data.up_cnx_state   | {string:eq}(ACTIVATED)                                                     |
	  
### SMF to PCF - Create PCF SM Policy For the PDU Session

    When I send HTTPV2 message HTTPV2_NPCFSM_POLICY_CONTROL_CREATE_POST_REQ on interface N7 with the following details from node SMF1 to PCF1:
      | parameter                               | value                                                                                                                          |
      | header.nva.0.name                       | :method                                                                                                                        |
      | header.nva.0.value                      | POST                                                                                                                           |
      | header.nva.1.name                       | :path                                                                                                                          |
      | header.nva.1.value                      | /127.0.0.1:12348/npcf-smpolicycontrol/v1/sm-policies                                                                           |
      | header.nva.2.name                       | content-type                                                                                                                   |
      | header.nva.2.value                      | application/json                                                                                                               |
      | sm_policy_context_data.supi             | incr({abotprop.SUT.SUPI},1)                                                                                                    |
      | sm_policy_context_data.pdu_session_id   | {abotprop.SUT.PDU.SESS.ID}                                                                                                     |
      | sm_policy_context_data.pdu_session_type | {abotprop.SUT.HTTP2.PDU_SESSION_TYPE}                                                                                          |
      | sm_policy_context_data.dnn              | {abotprop.SUT.DNN1}                                                                                                            |
      | sm_policy_context_data.notification_uri | /$({abotprop.SMF1.SecureShell.IPAddress}):$({abotprop.SMF1.N7.Server.Port})/npcf-smpolicycontrol/v1/sm-policies/smPol-notifuri |
      | sm_policy_context_data.slice_info.sst   | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}                                                                                     |
	  
    Then I receive and validate HTTPV2 message HTTPV2_NPCFSM_POLICY_CONTROL_CREATE_POST_REQ on interface N7 with the following details on node PCF1 from SMF1:
      | parameter                               | value                                                                     |
      | header.nva.0.name                       | {string:eq}(:method)                                                      |
      | header.nva.0.value                      | {string:eq}(POST)                                                         |
      | header.nva.1.name                       | {string:eq}(:path)                                                        |
      | header.nva.1.value                      | {string:eq}(/127.0.0.1:12348/npcf-smpolicycontrol/v1/sm-policies)         |
      | header.nva.2.name                       | {string:eq}(content-type)                                                 |
      | header.nva.2.value                      | {string:eq}(application/json)                                             |
      | sm_policy_context_data.supi             | save(SUPI)                                                                |
      | sm_policy_context_data.pdu_session_id   | {string:eq}({abotprop.SUT.PDU.SESS.ID})                                   |
      | sm_policy_context_data.pdu_session_type | {string:eq}({abotprop.SUT.HTTP2.PDU_SESSION_TYPE})                        |
      | sm_policy_context_data.dnn              | {string:eq}({abotprop.SUT.DNN1})                                          |
      | sm_policy_context_data.notification_uri | save(SMF_NOTIFICATION_URI)                                                |
      | sm_policy_context_data.slice_info.sst   | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB})                   |

    When I send HTTPV2 message HTTPV2_NPCFSM_POLICY_CONTROL_CREATE_POST_RES_201 on interface N7 with the following details from node PCF1 to SMF1:
      | parameter                                                                                 | value                                                                         |
      | header.nva.0.name                                                                         | :status                                                                       |
      | header.nva.0.value                                                                        | 201                                                                           |
      | header.nva.1.name                                                                         | location                                                                      |
      | header.nva.1.value                                                                        | /127.0.0.1:12348/npcf-smpolicycontrol/v1/sm-policies/smPol1                   |
      | header.nva.2.name                                                                         | content-type                                                                  |
      | header.nva.2.value                                                                        | application/json                                                              |
      | sm_policy_decision.revalidation_time                                                      | 2022-12-01T01:01:01.001Z                                                      |
      | sm_policy_decision.offline                                                                | true                                                                          |
      | sm_policy_decision.online                                                                 | false                                                                         |
      | sm_policy_decision.ipv4_index                                                             | 0                                                                             |
      | sm_policy_decision.qos_flow_usage                                                         | GENERAL                                                                       |
      | sm_policy_decision.supp_feat                                                              | aabbccdd                                                                      |
      | sm_policy_decision.pcc_rules.pccruleid1.pcc_rule_id                                       | {abotprop.SUT.DYNAMIC.PCC_RULE1.PCC_RULE_ID}                                  |
      | sm_policy_decision.pcc_rules.pccruleid1.precedence                                        | {abotprop.SUT.DYNAMIC.PCC_RULE1.PRECEDENCE}                                   |
      | sm_policy_decision.pcc_rules.pccruleid1.flow_infos.0.flow_information.flow_description    | permit out 17 from 43.225.55.127/16 {7000-8000} to 172.16.0.10/16 {5000-6000} |
      | sm_policy_decision.pcc_rules.pccruleid1.flow_infos.0.flow_information.pack_filt_id        | {abotprop.SUT.DYNAMIC.PCC_RULE1.PACKET_FLTR_ID}                               |
      | sm_policy_decision.pcc_rules.pccruleid1.flow_infos.0.flow_information.packet_filter_usage | true                                                                          |
      | sm_policy_decision.pcc_rules.pccruleid1.flow_infos.0.flow_information.tos_traffic_class   | 0                                                                             |
      | sm_policy_decision.pcc_rules.pccruleid1.flow_infos.0.flow_information.flow_direction      | DOWNLINK                                                                      |
      | sm_policy_decision.pcc_rules.pccruleid1.ref_qos_data.0.ref_qos_data_item                  | {abotprop.SUT.DYNAMIC.PCC_RULE1.QoS_ID}                                       |
      | sm_policy_decision.sess_rules.sessruleid1.sess_rule_id                                    | {abotprop.SUT.DYNAMIC.PCC_RULE1.SESSION_RULE_ID}                              |
      | sm_policy_decision.sess_rules.sessruleid1.auth_sess_ambr.uplink                           | {abotprop.SUT.SESSION.AMBR.UL}                                                |
      | sm_policy_decision.sess_rules.sessruleid1.auth_sess_ambr.downlink                         | {abotprop.SUT.SESSION.AMBR.DL}                                                |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.5qi                                | {abotprop.SUT.AUTO.RSP.PDU.SESS.5QI}                                          |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.priority_level                     | {abotprop.SUT.QOS.5QI.PRIORITY}                                               |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.arp.priority_level                 | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PRIORITY.LEVEL}                           |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.arp.preemption_cap                 | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.CAPABILITY}                       |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.arp.preempt_vuln                   | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.VULNERABILITY}                    |
      | sm_policy_decision.qos_decs.qosid1.qos_id                                                 | {abotprop.SUT.DYNAMIC.PCC_RULE1.QoS_ID}                                       |
      | sm_policy_decision.qos_decs.qosid1.def_qos_flow_indication                                | true                                                                          |


    Then I receive and validate HTTPV2 message HTTPV2_NPCFSM_POLICY_CONTROL_CREATE_POST_RES_201 on interface N7 with the following details on node SMF1 from PCF1:
      | parameter                                              | value                                                                    |
      | header.nva.0.name                                      | {string:eq}(:status)                                                     |
      | header.nva.0.value                                     | {string:eq}(201)                                                         |
      | header.nva.1.name                                      | {string:eq}(location)                                                    |
      | header.nva.1.value                                     | {string:eq}(/127.0.0.1:12348/npcf-smpolicycontrol/v1/sm-policies/smPol1) |
      | header.nva.2.name                                      | {string:eq}(content-type)                                                |
      | header.nva.2.value                                     | {string:eq}(application/json)                                            |
      | sm_policy_decision.supp_feat                           | {string:eq}(aabbccdd)                                                    |
      | sm_policy_decision.pcc_rules.pccruleid1.pcc_rule_id    | save(PCC_RULE_ID1)                                                       |
      | sm_policy_decision.sess_rules.sessruleid1.sess_rule_id | save(SESSION_RULE_ID1)                                                   |
      | sm_policy_decision.qos_decs.qosid1.qos_id              | save(QOS_RULE_ID1)                                                       |

    When I send PFCP message PFCP_SESSION_ESTABLISH_REQ on interface N4 with the following details from node SMF1 to UPF1:
      | parameter                                               | value                                                                         |
      | header.message_type                                     | 50                                                                            |
      | header.seid                                             | 0                                                                             |
      | header.seq_number                                       | incr(22,12)                                                                   |
      | node_id.type                                            | 0                                                                             |
      | node_id.value                                           | 1.2.3.4                                                                       |
      | cp_f_seid.flag                                          | 2                                                                             |
      | cp_f_seid.seid                                          | incr(1,2)                                                                     |
      | cp_f_seid.ipv4_addr                                     | 1.2.3.4                                                                       |
      | pdn_type                                                | {abotprop.SUT.3GPP.PDN_TYPE}                                                  |
      | create_pdr.0.pdr_id                                     | 1                                                                             |
      | create_pdr.0.precedence                                 | 1                                                                             |
      | create_pdr.0.pdi.source_interface                       | 0                                                                             |
      | create_pdr.0.pdi.local_fteid.flag                       | 1                                                                             |
      | create_pdr.0.pdi.local_fteid.teid                       | incr(11,3)                                                                    |
      | create_pdr.0.pdi.local_fteid.ipv4_addr                  | incr(10.10.10.11,3)                                                           |
      | create_pdr.0.pdi.qfi                                    | 9                                                                             |
      | create_pdr.0.outer_header_removal.outer_head_remov_desc | 0                                                                             |
      | create_pdr.0.outer_header_removal.gtpu_ext_head_desc    | 0                                                                             |
      | create_pdr.0.far_id                                     | 1                                                                             |
      | create_pdr.0.qer_id                                     | 1                                                                             |
      | create_pdr.1.pdr_id                                     | 2                                                                             |
      | create_pdr.1.precedence                                 | 1                                                                             |
      | create_pdr.1.pdi.source_interface                       | 1                                                                             |
      | create_pdr.1.pdi.ue_ip_addr.flag                        | 6                                                                             |
      | create_pdr.1.pdi.ue_ip_addr.ipv4_addr                   | incr(10.10.10.10,3)                                                           |
      | create_pdr.1.pdi.qfi                                    | 9                                                                             |
      | create_pdr.1.pdi.sdf_filter.flow_description            | permit out 17 from 43.225.55.127/16 {7000-8000} to 172.16.0.10/16 {5000-6000} |
      | create_pdr.1.far_id                                     | 2                                                                             |
      | create_pdr.1.qer_id                                     | 1                                                                             |
      | create_far.0.far_id                                     | 1                                                                             |
      | create_far.0.apply_action                               | 2                                                                             |
      | create_far.0.forwarding_parms.destination_interface     | 1                                                                             |
      | create_far.1.far_id                                     | 2                                                                             |
      | create_far.1.apply_action                               | 2                                                                             |
      | create_far.1.forwarding_parms.destination_interface     | 0                                                                             |
      | create_qer.0.qer_id                                     | 1                                                                             |
      | create_qer.0.gate_status.ul_gate                        | 0                                                                             |
      | create_qer.0.gate_status.dl_gate                        | 0                                                                             |
      | create_qer.0.mbr.ul_mbr                                 | 10000                                                                         |
      | create_qer.0.mbr.dl_mbr                                 | 10000                                                                         |
      | create_qer.0.qfi                                        | 9                                                                             |

    Then I receive and validate PFCP message PFCP_SESSION_ESTABLISH_REQ on interface N4 with the following details on node UPF1 from SMF1:
      | parameter                                               | value                                     |
      | header.message_type                                     | {string:eq}(50)                           |
      | header.seid                                             | {string:eq}(0)                            |
      | header.seq_number                                       | {string:eq}(incr(22,12))                  |
      | node_id.type                                            | {string:eq}(0)                            |
      | node_id.value                                           | {string:eq}(1.2.3.4)                      |
      | cp_f_seid.flag                                          | {string:eq}(2)                            |
      | cp_f_seid.seid                                          | {string:eq}(incr(1,2))                    |
      | cp_f_seid.ipv4_addr                                     | {string:eq}(1.2.3.4)                      |
      | pdn_type                                                | {string:eq}({abotprop.SUT.3GPP.PDN_TYPE}) |
      | create_pdr.0.pdr_id                                     | {string:eq}(1)                            |
      | create_pdr.0.precedence                                 | {string:eq}(1)                            |
      | create_pdr.0.pdi.source_interface                       | {string:eq}(0)                            |
      | create_pdr.0.pdi.local_fteid.flag                       | save(N4_UPF_LOCAL_TEID_FLAG_AT_UPF)       |
      | create_pdr.0.pdi.local_fteid.teid                       | {string:eq}(incr(11,3))                   |
      | create_pdr.0.pdi.local_fteid.ipv4_addr                  | {string:eq}(incr(10.10.10.11,3))          |
      | create_pdr.0.pdi.qfi                                    | {string:eq}(9)                            |
      | create_pdr.0.outer_header_removal.outer_head_remov_desc | {string:eq}(0)                            |
      | create_pdr.0.outer_header_removal.gtpu_ext_head_desc    | {string:eq}(0)                            |
      | create_pdr.0.far_id                                     | {string:eq}(1)                            |
      | create_pdr.0.qer_id                                     | {string:eq}(1)                            |
      | create_pdr.1.pdr_id                                     | {string:eq}(2)                            |
      | create_pdr.1.precedence                                 | {string:eq}(1)                            |
      | create_pdr.1.pdi.source_interface                       | {string:eq}(1)                            |
      | create_pdr.1.pdi.ue_ip_addr.flag                        | {string:eq}(6)                            |
      | create_pdr.1.pdi.ue_ip_addr.ipv4_addr                   | {string:eq}(incr(10.10.10.10,3))          |
      | create_pdr.1.pdi.qfi                                    | {string:eq}(9)                            |
      | create_pdr.1.pdi.sdf_filter.flow_description            | save(FLOW_DESC)                           |
      | create_pdr.1.far_id                                     | {string:eq}(2)                            |
      | create_pdr.1.qer_id                                     | {string:eq}(1)                            |
      | create_far.0.far_id                                     | {string:eq}(1)                            |
      | create_far.0.apply_action                               | {string:eq}(2)                            |
      | create_far.0.forwarding_parms.destination_interface     | {string:eq}(1)                            |
      | create_far.1.far_id                                     | {string:eq}(2)                            |
      | create_far.1.apply_action                               | {string:eq}(2)                            |
      | create_far.1.forwarding_parms.destination_interface     | {string:eq}(0)                            |
      | create_qer.0.qer_id                                     | {string:eq}(1)                            |
      | create_qer.0.gate_status.ul_gate                        | {string:eq}(0)                            |
      | create_qer.0.gate_status.dl_gate                        | {string:eq}(0)                            |
      | create_qer.0.mbr.ul_mbr                                 | {string:eq}(10000)                        |
      | create_qer.0.mbr.dl_mbr                                 | {string:eq}(10000)                        |
      | create_qer.0.qfi                                        | {string:eq}(9)                            |

    When I send PFCP message PFCP_SESSION_ESTABLISH_RES on interface N4 with the following details from node UPF1 to SMF1:
      | parameter            | value       |
      | header.message_type  | 51          |
      | header.seid          | incr(1,2)   |
      | header.seq_number    | incr(23,12) |
      | node_id.type         | 0           |
      | node_id.value        | 5.6.7.8     |
      | cause                | 1           |
      | up_f_seid.flag       | 2           |
      | up_f_seid.seid       | incr(2,2)   |
      | up_f_seid.ipv4_addr  | 5.6.7.8     |
      | created_pdr.0.pdr_id | 1           |
      | created_pdr.1.pdr_id | 2           |

    Then I receive and validate PFCP message PFCP_SESSION_ESTABLISH_RES on interface N4 with the following details on node SMF1 from UPF1:
      | parameter            | value                    |
      | header.message_type  | {string:eq}(51)          |
      | header.seid          | {string:eq}(incr(1,2))   |
      | header.seq_number    | {string:eq}(incr(23,12)) |
      | node_id.type         | {string:eq}(0)           |
      | node_id.value        | {string:eq}(5.6.7.8)     |
      | cause                | {string:eq}(1)           |
      | up_f_seid.flag       | {string:eq}(2)           |
      | up_f_seid.seid       | {string:eq}(incr(2,2))   |
      | up_f_seid.ipv4_addr  | {string:eq}(5.6.7.8)     |
      | created_pdr.0.pdr_id | {string:eq}(1)           |
      | created_pdr.1.pdr_id | {string:eq}(2)           |

    When I send HTTPV2 message HTTPV2_NAMF_COMM_N1N2_MSG_TRANSFER_POST_REQ on interface N11 with the following details from node SMF1 to AMF1:
      | parameter                                                                                                                                                                                         | value                                                                                                  |
      | header.nva.0.name                                                                                                                                                                                 | :method                                                                                                |
      | header.nva.0.value                                                                                                                                                                                | POST                                                                                                   |
      | header.nva.1.name                                                                                                                                                                                 | :path                                                                                                  |
      | header.nva.1.value                                                                                                                                                                                | /127.0.0.1:12348/namf-comm/v1/ue-contexts/incr(imsi-404309990000001,1)/n1-n2-messages                  |
      | header.nva.2.name                                                                                                                                                                                 | content-type                                                                                           |
      | header.nva.2.value                                                                                                                                                                                | multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json                |
      | multipart_related.json_data.content_type                                                                                                                                                          | application/json                                                                                       |
      | multipart_related.json_data.content_id                                                                                                                                                            | n1n2-message-transfer-req-data                                                                         |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1_message_container.n1_message_class                                                                                                  | SM                                                                                                     |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1_message_container.n1_message_content.content_id                                                                                     | n1-pdu-session-establishment-accept                                                                    |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.n2_information_class                                                                                                 | SM                                                                                                     |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.n2_info_content.ngap_ie_type                                                                                 | PDU_RES_SETUP_REQ                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.n2_info_content.ngap_data.content_id                                                                         | n2-pdu-session-resource-setup-request-transfer-ie                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.pdu_session_id                                                                                               | 6                                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.s_nssai.sst                                                                                                  | 1                                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.skip_ind                                                                                                                               | false                                                                                                  |
      | multipart_related.json_data.n1n2_message_transfer_req_data.pdu_session_id                                                                                                                         | 6                                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.5qi                                                                                                                                    | 9                                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1n2_failure_txf_notif_u_r_i                                                                                                           | /127.0.0.1:12348/namf-comm/v1/ue-contexts/incr(imsi-404309990000001,1)/n1-n2-messages/callback-failure |
      | multipart_related.json_data.n1n2_message_transfer_req_data.smf_reallocation_ind                                                                                                                   | false                                                                                                  |
      | multipart_related.binary_data_n1_message.content_type                                                                                                                                             | application/vnd.3gpp.5gnas                                                                             |
      | multipart_related.binary_data_n1_message.content_id                                                                                                                                               | n1-pdu-session-establishment-accept                                                                    |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.extended_protocol_discriminator                                                                                                       | 0x2e                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_session_id                                                                                                                        | 0x06                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pti                                                                                                                                   | 0x01                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.message_type                                                                                                                          | 0xc2                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.selected_pdu_sess_type                                                                                             | 0x01                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.selected_ssc_mode                                                                                                  | 0x01                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.session_ambr                                                                                                       | 0x010400010400                                                                                         |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.pdu_address                                                                                                        | incr(10.10.10.10,3)                                                                                    |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.snssai                                                                                                             | 0x01                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.dnn                                                                                                                | {abotprop.SUT.DNN1}                                                                                    |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.qri                                                                               | 0x01                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.op_code_dqr_bit_no_of_pkt_filters                                                 | 0x31                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.precedence                                                                        | 0x01                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.segr_bit_qfi                                                                      | 0x09                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.dir_id                                                       | 0x21                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.type                                   | 0x11                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.ipv4_local_address_mask                | 0xac10000affff0000                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.type                                   | 0x10                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.ipv4_remote_address_mask               | 0x2be1377fffff0000                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.type                                   | 0x30                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.ipv4_proto_id_or_ipv6_next_hdr         | 0x11                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.type                                   | 0x41                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.local_port_range                       | 0x13881770                                                                                             |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.type                                   | 0x51                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.remote_port_range                      | 0x1b581f40                                                                                             |
      | multipart_related.binary_data_n2_information.content_type                                                                                                                                         | application/vnd.3gpp.ngap                                                                              |
      | multipart_related.binary_data_n2_information.content_id                                                                                                                                           | n2-pdu-session-resource-setup-request-transfer-ie                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate                 | 10000                                                                                                  |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate                 | 10000                                                                                                  |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                      | incr(10.10.10.11,3)                                                                                    |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                     | incr(11,3)                                                                                             |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                                 | 0                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                                    | 9                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi         | 9                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.priority_level | 1                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                                 | 1                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                             | 0                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                          | 0                                                                                                      |

    Then I receive and validate HTTPV2 message HTTPV2_NAMF_COMM_N1N2_MSG_TRANSFER_POST_REQ on interface N11 with the following details on node AMF1 from SMF1:
      | parameter                                                                                                                                                                                         | value                                                                                                               |
      | header.nva.0.name                                                                                                                                                                                 | {string:eq}(:method)                                                                                                |
      | header.nva.0.value                                                                                                                                                                                | {string:eq}(POST)                                                                                                   |
      | header.nva.1.name                                                                                                                                                                                 | {string:eq}(:path)                                                                                                  |
      | header.nva.1.value                                                                                                                                                                                | {string:eq}(/127.0.0.1:12348/namf-comm/v1/ue-contexts/incr(imsi-404309990000001,1)/n1-n2-messages)                  |
      | header.nva.2.name                                                                                                                                                                                 | {string:eq}(content-type)                                                                                           |
      | header.nva.2.value                                                                                                                                                                                | {string:eq}(multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json)                |
      | multipart_related.json_data.content_type                                                                                                                                                          | {string:eq}(application/json)                                                                                       |
      | multipart_related.json_data.content_id                                                                                                                                                            | {string:eq}(n1n2-message-transfer-req-data)                                                                         |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1_message_container.n1_message_class                                                                                                  | {string:eq}(SM)                                                                                                     |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1_message_container.n1_message_content.content_id                                                                                     | {string:eq}(n1-pdu-session-establishment-accept)                                                                    |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.n2_information_class                                                                                                 | {string:eq}(SM)                                                                                                     |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.n2_info_content.ngap_ie_type                                                                                 | {string:eq}(PDU_RES_SETUP_REQ)                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.n2_info_content.ngap_data.content_id                                                                         | {string:eq}(n2-pdu-session-resource-setup-request-transfer-ie)                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.pdu_session_id                                                                                               | {string:eq}(6)                                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.s_nssai.sst                                                                                                  | {string:eq}(1)                                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.skip_ind                                                                                                                               | {string:eq}(false)                                                                                                  |
      | multipart_related.json_data.n1n2_message_transfer_req_data.pdu_session_id                                                                                                                         | {string:eq}(6)                                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.5qi                                                                                                                                    | {string:eq}(9)                                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1n2_failure_txf_notif_u_r_i                                                                                                           | {string:eq}(/127.0.0.1:12348/namf-comm/v1/ue-contexts/incr(imsi-404309990000001,1)/n1-n2-messages/callback-failure) |
      | multipart_related.json_data.n1n2_message_transfer_req_data.smf_reallocation_ind                                                                                                                   | {string:eq}(false)                                                                                                  |
      | multipart_related.binary_data_n1_message.content_type                                                                                                                                             | {string:eq}(application/vnd.3gpp.5gnas)                                                                             |
      | multipart_related.binary_data_n1_message.content_id                                                                                                                                               | {string:eq}(n1-pdu-session-establishment-accept)                                                                    |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.extended_protocol_discriminator                                                                                                       | {string:eq}(0x2e)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_session_id                                                                                                                        | {string:eq}(0x06)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pti                                                                                                                                   | {string:eq}(0x01)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.message_type                                                                                                                          | {string:eq}(0xc2)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.selected_pdu_sess_type                                                                                             | {string:eq}(0x01)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.selected_ssc_mode                                                                                                  | {string:eq}(0x01)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.session_ambr                                                                                                       | {string:eq}(0x010400010400)                                                                                         |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.pdu_address                                                                                                        | {string:eq}(incr(10.10.10.10,3))                                                                                    |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.snssai                                                                                                             | {string:eq}(0x01)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.dnn                                                                                                                | {string:eq}({abotprop.SUT.DNN1})                                                                                    |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.qri                                                                               | {string:eq}(0x01)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.op_code_dqr_bit_no_of_pkt_filters                                                 | {string:eq}(0x31)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.precedence                                                                        | {string:eq}(0x01)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.segr_bit_qfi                                                                      | {string:eq}(0x09)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.dir_id                                                       | {string:eq}(0x21)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.type                                   | {string:eq}(0x11)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.ipv4_local_address_mask                | {string:eq}(0xac10000affff0000)                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.type                                   | {string:eq}(0x10)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.ipv4_remote_address_mask               | {string:eq}(0x2be1377fffff0000)                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.type                                   | {string:eq}(0x30)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.ipv4_proto_id_or_ipv6_next_hdr         | {string:eq}(0x11)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.type                                   | {string:eq}(0x41)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.local_port_range                       | {string:eq}(0x13881770)                                                                                             |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.type                                   | {string:eq}(0x51)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.remote_port_range                      | {string:eq}(0x1b581f40)                                                                                             |
      | multipart_related.binary_data_n2_information.content_type                                                                                                                                         | {string:eq}(application/vnd.3gpp.ngap)                                                                              |
      | multipart_related.binary_data_n2_information.content_id                                                                                                                                           | {string:eq}(n2-pdu-session-resource-setup-request-transfer-ie)                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate                 | {string:eq}(10000)                                                                                                  |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate                 | {string:eq}(10000)                                                                                                  |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                      | {string:eq}(incr(10.10.10.11,3))                                                                                    |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                     | {string:eq}(incr(11,3))                                                                                             |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                                 | {string:eq}(0)                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                                    | {string:eq}(9)                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi         | {string:eq}(9)                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.priority_level | {string:eq}(1)                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                                 | {string:eq}(1)                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                             | {string:eq}(0)                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                          | {string:eq}(0)                                                                                                      |

    When I send HTTPV2 message HTTPV2_NAMF_COMM_N1N2_MSG_TRANSFER_POST_RES_200 on interface N11 with the following details from node AMF1 to SMF1:
      | parameter                            | value                                                                                            |
      | header.nva.0.name                    | :status                                                                                          |
      | header.nva.0.value                   | 200                                                                                              |
      | header.nva.1.name                    | content-type                                                                                     |
      | header.nva.1.value                   | application/json                                                                                 |
      | n1n2_message_transfer_rsp_data.cause | N1_N2_TRANSFER_INITIATED                                                                         |

    Then I receive and validate HTTPV2 message HTTPV2_NAMF_COMM_N1N2_MSG_TRANSFER_POST_RES_200 on interface N11 with the following details on node SMF1 from AMF1:
      | parameter                            | value                                                                                                         |
      | header.nva.0.name                    | {string:eq}(:status)                                                                                          |
      | header.nva.0.value                   | {string:eq}(200)                                                                                              |
      | header.nva.1.name                    | {string:eq}(content-type)                                                                                     |
      | header.nva.1.value                   | {string:eq}(application/json)                                                                                 |
      | n1n2_message_transfer_rsp_data.cause | {string:eq}(N1_N2_TRANSFER_INITIATED)                                                                         |
                                                                         |

    When I send NGAP message NG_PDU_SESS_RESRC_SETUP_REQ on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                                                                                                                                                                                                                                                              | value               |
      | amf_ue_ngap_id                                                                                                                                                                                                                                                                         | incr(1234,1)        |
      | ran_ue_ngap_id                                                                                                                                                                                                                                                                         | $(RAN_UE_NGAP_ID)   |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.extended_protocol_discriminator                                                                                                                                                                                  | 126                 |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.security_header_type                                                                                                                                                                                             | 0x01                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.message_type                                                                                                                                                                                                     | 0x68                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.pdu_session_identity                                                                                                                                                                            | 0x1206              |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_type                                                                                                                                                                          | 0x01                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator                                                                                               | 0x2e                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                                                                                                                | 0x06                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                                                                                                                           | 0x01                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                                                                                                                  | 0xc2                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.selected_pdu_sess_type                                                                                     | 0x01                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.selected_ssc_mode                                                                                          | 0x01                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.session_ambr                                                                                               | 0x010400010400      |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.pdu_address                                                                                                | incr(10.10.10.10,3) |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.snssai                                                                                                     | 0x01                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.dnn                                                                                                        | {abotprop.SUT.DNN1} |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.qri                                                                       | 0x01                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.op_code_dqr_bit_no_of_pkt_filters                                         | 0x31                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.precedence                                                                | 0x01                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.segr_bit_qfi                                                              | 0x09                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.dir_id                                               | 0x21                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.type                           | 0x11                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.ipv4_local_address_mask        | 0xac10000affff0000  |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.type                           | 0x10                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.ipv4_remote_address_mask       | 0x2be1377fffff0000  |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.type                           | 0x30                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.ipv4_proto_id_or_ipv6_next_hdr | 0x11                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.type                           | 0x41                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.local_port_range               | 0x13881770          |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.type                           | 0x51                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.remote_port_range              | 0x1b581f40          |
      | pdu_session_resource_setup_request_list.0.pdu_session_id                                                                                                                                                                                                                               | 6                   |
      | pdu_session_resource_setup_request_list.0.s-nssai.sst                                                                                                                                                                                                                                  | 1                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate                                                                                                                 | 10000000            |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate                                                                                                                 | 10000000            |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                                                                                                                      | incr(10.10.10.11,3) |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                                                                                                                     | incr(11,3)          |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                                                                                                                                 | 0                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                                                                                                                                    | 9                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi                                                                                                         | 9                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.priority_level                                                                                                 | 1                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                                                                                                                                 | 1                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                                                                                                                             | 0                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                                                                                                                          | 0                   |

    Then I receive and validate NGAP message NG_PDU_SESS_RESRC_SETUP_REQ on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                                                                                                                                                                                                                                                              | value                            |
      | amf_ue_ngap_id                                                                                                                                                                                                                                                                         | {string:eq}($(AMF_UE_NGAP_ID))   |
      | ran_ue_ngap_id                                                                                                                                                                                                                                                                         | {string:eq}(incr(4294967295,1))  |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.extended_protocol_discriminator                                                                                                                                                                                  | {string:eq}(126)                 |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.security_header_type                                                                                                                                                                                             | {string:eq}(0x01)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.message_type                                                                                                                                                                                                     | {string:eq}(0x68)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.pdu_session_identity                                                                                                                                                                            | {string:eq}(0x1206)              |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_type                                                                                                                                                                          | {string:eq}(0x01)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator                                                                                               | {string:eq}(0x2e)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                                                                                                                | {string:eq}(0x06)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                                                                                                                           | {string:eq}(0x01)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                                                                                                                  | {string:eq}(0xc2)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.selected_pdu_sess_type                                                                                     | {string:eq}(0x01)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.selected_ssc_mode                                                                                          | {string:eq}(0x01)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.session_ambr                                                                                               | {string:eq}(0x010400010400)      |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.pdu_address                                                                                                | {string:eq}(incr(10.10.10.10,3)) |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.snssai                                                                                                     | {string:eq}(0x01)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.dnn                                                                                                        | {string:eq}({abotprop.SUT.DNN1}) |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.qri                                                                       | {string:eq}(0x01)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.op_code_dqr_bit_no_of_pkt_filters                                         | {string:eq}(0x31)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.precedence                                                                | {string:eq}(0x01)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.segr_bit_qfi                                                              | {string:eq}(0x09)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.dir_id                                               | {string:eq}(0x21)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.type                           | {string:eq}(0x11)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.ipv4_local_address_mask        | {string:eq}(0xac10000affff0000)  |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.type                           | {string:eq}(0x10)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.ipv4_remote_address_mask       | {string:eq}(0x2be1377fffff0000)  |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.type                           | {string:eq}(0x30)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.ipv4_proto_id_or_ipv6_next_hdr | {string:eq}(0x11)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.type                           | {string:eq}(0x41)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.local_port_range               | {string:eq}(0x13881770)          |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.type                           | {string:eq}(0x51)                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.remote_port_range              | {string:eq}(0x1b581f40)          |
      | pdu_session_resource_setup_request_list.0.pdu_session_id                                                                                                                                                                                                                               | {string:eq}(6)                   |
      | pdu_session_resource_setup_request_list.0.s-nssai.sst                                                                                                                                                                                                                                  | {string:eq}(1)                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate                                                                                                                 | {string:eq}(10000000)            |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate                                                                                                                 | {string:eq}(10000000)            |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                                                                                                                      | {string:eq}(incr(10.10.10.11,3)) |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                                                                                                                     | {string:eq}(incr(11,3))          |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                                                                                                                                 | save(PDU_SESS_TYPE_AT_GNB)       |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                                                                                                                                    | {string:eq}(9)                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi                                                                                                         | {string:eq}(9)                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.priority_level                                                                                                 | {string:eq}(1)                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                                                                                                                                 | {string:eq}(1)                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                                                                                                                             | {string:eq}(0)                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                                                                                                                          | {string:eq}(0)                   |

	
    When I send NGAP message NG_PDU_SESS_RESRC_SETUP_RES on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                                                                          | value               |
      | amf_ue_ngap_id                                                                                                                                                                     | $(AMF_UE_NGAP_ID)   |
      | ran_ue_ngap_id                                                                                                                                                                     | incr(4294967295,1)  |
      | pdu_session_resource_setup_response_list.0.pdu_session_id                                                                                                                          | 6                   |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | incr(10.10.10.12,3) |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | incr(12,3)          |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | 9                   |

    Then I receive and validate NGAP message NG_PDU_SESS_RESRC_SETUP_RES on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                                                                                                          | value                            |
      | amf_ue_ngap_id                                                                                                                                                                     | {string:eq}(incr(1234,1))        |
      | ran_ue_ngap_id                                                                                                                                                                     | {string:eq}($(RAN_UE_NGAP_ID))   |
      | pdu_session_resource_setup_response_list.0.pdu_session_id                                                                                                                          | {string:eq}(6)                   |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | {string:eq}(incr(10.10.10.12,3)) |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | {string:eq}(incr(12,3))          |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | {string:eq}(9)                   |

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details from node AMF1 to SMF1:
      | parameter                                                                                                                                                                                       | value                                                                                   |
      | header.nva.0.name                                                                                                                                                                               | :method                                                                                 |
      | header.nva.0.value                                                                                                                                                                              | POST                                                                                    |
      | header.nva.1.name                                                                                                                                                                               | :path                                                                                   |
      | header.nva.1.value                                                                                                                                                                              | /127.0.0.1:12348/nsmf-pdusession/v1/sm-contexts/smctx-1/modify                          |
      | header.nva.2.name                                                                                                                                                                               | content-type                                                                            |
      | header.nva.2.value                                                                                                                                                                              | multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json |
      | multipart_related.json_data.content_type                                                                                                                                                        | application/json                                                                        |
      | multipart_related.json_data.content_id                                                                                                                                                          | sm-context-update                                                                       |
      | multipart_related.json_data.sm_context_update_data.pei                                                                                                                                          | incr({abotprop.SUT.PEI},1)                                                              |
      | multipart_related.json_data.sm_context_update_data.s_nssai.sst                                                                                                                                  | 1                                                                                       |
      | multipart_related.json_data.sm_context_update_data.up_cnx_state                                                                                                                                 | ACTIVATED                                                                               |
      | multipart_related.json_data.sm_context_update_data.n2_sm_info.content_id                                                                                                                        | n2-pdu-session-resource-setup-response-transfer-ie                                      |
      | multipart_related.json_data.sm_context_update_data.n2_sm_info_type                                                                                                                              | PDU_RES_SETUP_RSP                                                                       |
      | multipart_related.binary_data_n2_sm_information.content_type                                                                                                                                    | application/vnd.3gpp.ngap                                                               |
      | multipart_related.binary_data_n2_sm_information.content_id                                                                                                                                      | n2-pdu-session-resource-setup-response-transfer-ie                                      |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | incr(10.10.10.12,3)                                                                     |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | incr(12,3)                                                                              |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | 5                                                                                       |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details on node SMF1 from AMF1:
      | parameter                                                                                                                                                                                       | value                                                                                                |
      | header.nva.0.name                                                                                                                                                                               | {string:eq}(:method)                                                                                 |
      | header.nva.0.value                                                                                                                                                                              | {string:eq}(POST)                                                                                    |
      | header.nva.1.name                                                                                                                                                                               | {string:eq}(:path)                                                                                   |
      | header.nva.1.value                                                                                                                                                                              | {string:eq}(/127.0.0.1:12348/nsmf-pdusession/v1/sm-contexts/smctx-1/modify)                          |
      | header.nva.2.name                                                                                                                                                                               | {string:eq}(content-type)                                                                            |
      | header.nva.2.value                                                                                                                                                                              | {string:eq}(multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json) |
      | multipart_related.json_data.content_type                                                                                                                                                        | {string:eq}(application/json)                                                                        |
      | multipart_related.json_data.content_id                                                                                                                                                          | {string:eq}(sm-context-update)                                                                       |
      | multipart_related.json_data.sm_context_update_data.pei                                                                                                                                          | {string:eq}($(PEI))                                                                                  |
      | multipart_related.json_data.sm_context_update_data.s_nssai.sst                                                                                                                                  | {string:eq}(1)                                                                                       |
      | multipart_related.json_data.sm_context_update_data.up_cnx_state                                                                                                                                 | {string:eq}(ACTIVATED)                                                                               |
      | multipart_related.json_data.sm_context_update_data.n2_sm_info.content_id                                                                                                                        | {string:eq}(n2-pdu-session-resource-setup-response-transfer-ie)                                      |
      | multipart_related.json_data.sm_context_update_data.n2_sm_info_type                                                                                                                              | {string:eq}(PDU_RES_SETUP_RSP)                                                                       |
      | multipart_related.binary_data_n2_sm_information.content_type                                                                                                                                    | {string:eq}(application/vnd.3gpp.ngap)                                                               |
      | multipart_related.binary_data_n2_sm_information.content_id                                                                                                                                      | {string:eq}(n2-pdu-session-resource-setup-response-transfer-ie)                                      |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | {string:eq}(incr(10.10.10.12,3))                                                                     |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | {string:eq}(incr(12,3))                                                                              |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | {string:eq}(5)                                                                                       |

    When I send PFCP message PFCP_SESSION_MODIFICATION_REQ on interface N4 with the following details from node SMF1 to UPF1:
      | parameter                                                              | value               |
      | header.message_type                                                    | 52                  |
      | header.seid                                                            | incr(2,2)           |
      | header.seq_number                                                      | incr(24,12)         |
      | update_far.0.far_id                                                    | 2                   |
      | update_far.0.apply_action                                              | 2                   |
      | update_far.0.update_forwarding_parms.destination_interface             | 0                   |
      | update_far.0.update_forwarding_parms.outer_header_creation.description | 0x100               |
      | update_far.0.update_forwarding_parms.outer_header_creation.teid        | incr(12,3)          |
      | update_far.0.update_forwarding_parms.outer_header_creation.ipv4_addr   | incr(10.10.10.12,3) |

    Then I receive and validate PFCP message PFCP_SESSION_MODIFICATION_REQ on interface N4 with the following details on node UPF1 from SMF1:
      | parameter                                                              | value                                        |
      | header.message_type                                                    | {string:eq}(52)                              |
      | header.seid                                                            | {string:eq}(incr(2,2))                       |
      | header.seq_number                                                      | {string:eq}(incr(24,12))                     |
      | update_far.0.far_id                                                    | {string:eq}(2)                               |
      | update_far.0.apply_action                                              | {string:eq}(2)                               |
      | update_far.0.update_forwarding_parms.destination_interface             | {string:eq}(0)                               |
      | update_far.0.update_forwarding_parms.outer_header_creation.description | save(N4_GNB_TEID_OUT_HDR_CREATE_DESC_AT_UPF) |
      | update_far.0.update_forwarding_parms.outer_header_creation.teid        | {string:eq}(incr(12,3))                      |
      | update_far.0.update_forwarding_parms.outer_header_creation.ipv4_addr   | {string:eq}(incr(10.10.10.12,3))             |

    When I send PFCP message PFCP_SESSION_MODIFICATION_RES on interface N4 with the following details from node UPF1 to SMF1:
      | parameter           | value       |
      | header.message_type | 53          |
      | header.seid         | incr(1,2)   |
      | header.seq_number   | incr(25,12) |
      | cause               | 1           |

    Then I receive and validate PFCP message PFCP_SESSION_MODIFICATION_RES on interface N4 with the following details on node SMF1 from UPF1:
      | parameter           | value                    |
      | header.message_type | {string:eq}(53)          |
      | header.seid         | {string:eq}(incr(1,2))   |
      | header.seq_number   | {string:eq}(incr(25,12)) |
      | cause               | {string:eq}(1)           |

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_200 on interface N11 with the following details from node SMF1 to AMF1:
      | parameter                                             | value            |
      | header.nva.0.name                                     | :status          |
      | header.nva.0.value                                    | 200              |
      | header.nva.1.name                                     | content-type     |
      | header.nva.1.value                                    | application/json |
      | application_json.sm_context_updated_data.up_cnx_state | ACTIVATED        |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_200 on interface N11 with the following details on node AMF1 from SMF1:
      | parameter                                             | value                         |
      | header.nva.0.name                                     | {string:eq}(:status)          |
      | header.nva.0.value                                    | {string:eq}(200)              |
      | header.nva.1.name                                     | {string:eq}(content-type)     |
      | header.nva.1.value                                    | {string:eq}(application/json) |
      | application_json.sm_context_updated_data.up_cnx_state | {string:eq}(ACTIVATED)        |

    Given the execution is paused for {abotprop.WAIT_2_SEC} seconds

### GNB Initiated AN Release Procedure

    When I send NGAP message NG_UE_CTXT_RELEASE_REQ on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                  | value              |
      | amf_ue_ngap_id                             | $(AMF_UE_NGAP_ID)  |
      | ran_ue_ngap_id                             | incr(4294967295,1) |
      | cause.radio_network                        | 3                  |
      | pdu_session_resource_list.0.pdu_session_id | 6                  |

    Then I receive and validate NGAP message NG_UE_CTXT_RELEASE_REQ on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                  | value                          |
      | amf_ue_ngap_id                             | {string:eq}(incr(1234,1))      |
      | ran_ue_ngap_id                             | {string:eq}($(RAN_UE_NGAP_ID)) |
      | cause.radio_network                        | {string:eq}(3)                 |
      | pdu_session_resource_list.0.pdu_session_id | {string:eq}(6)                 |

    When I send NGAP message NG_UE_CTXT_RELEASE_CMD on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                         | value             |
      | ue_ngap_ids_choice.ue_ngap_id_pair.amf_ue_ngap_id | incr(1234,1)      |
      | ue_ngap_ids_choice.ue_ngap_id_pair.ran_ue_ngap_id | $(RAN_UE_NGAP_ID) |
      | cause.radio_network                               | 3                 |

    Then I receive and validate NGAP message NG_UE_CTXT_RELEASE_CMD on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                         | value                           |
      | ue_ngap_ids_choice.ue_ngap_id_pair.amf_ue_ngap_id | {string:eq}($(AMF_UE_NGAP_ID))  |
      | ue_ngap_ids_choice.ue_ngap_id_pair.ran_ue_ngap_id | {string:eq}(incr(4294967295,1)) |
      | cause.radio_network                               | {string:eq}(3)                  |

    When I send NGAP message NG_UE_CTXT_RELEASE_COMPLETE on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                  | value              |
      | amf_ue_ngap_id                             | $(AMF_UE_NGAP_ID)  |
      | ran_ue_ngap_id                             | incr(4294967295,1) |
      | pdu_session_resource_list.0.pdu_session_id | 6                  |

    Then I receive and validate NGAP message NG_UE_CTXT_RELEASE_COMPLETE on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                  | value                          |
      | amf_ue_ngap_id                             | {string:eq}(incr(1234,1))      |
      | ran_ue_ngap_id                             | {string:eq}($(RAN_UE_NGAP_ID)) |
      | pdu_session_resource_list.0.pdu_session_id | {string:eq}(6)                 |

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details from node AMF1 to SMF1:
      | parameter                                            | value                                                          |
      | header.nva.0.name                                    | :method                                                        |
      | header.nva.0.value                                   | POST                                                           |
      | header.nva.1.name                                    | :path                                                          |
      | header.nva.1.value                                   | /127.0.0.1:12348/nsmf-pdusession/v1/sm-contexts/smctx-1/modify |
      | header.nva.2.name                                    | content-type                                                   |
      | header.nva.2.value                                   | application/json                                               |
      | application_json.sm_context_update_data.pei          | incr({abotprop.SUT.PEI},1)                                     |
      | application_json.sm_context_update_data.s_nssai.sst  | 1                                                              |
      | application_json.sm_context_update_data.up_cnx_state | DEACTIVATED                                                    |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details on node SMF1 from AMF1:
      | parameter                                            | value                                                                       |
      | header.nva.0.name                                    | {string:eq}(:method)                                                        |
      | header.nva.0.value                                   | {string:eq}(POST)                                                           |
      | header.nva.1.name                                    | {string:eq}(:path)                                                          |
      | header.nva.1.value                                   | {string:eq}(/127.0.0.1:12348/nsmf-pdusession/v1/sm-contexts/smctx-1/modify) |
      | header.nva.2.name                                    | {string:eq}(content-type)                                                   |
      | header.nva.2.value                                   | {string:eq}(application/json)                                               |
      | application_json.sm_context_update_data.pei          | {string:eq}($(PEI))                                                         |
      | application_json.sm_context_update_data.s_nssai.sst  | {string:eq}(1)                                                              |
      | application_json.sm_context_update_data.up_cnx_state | {string:eq}(DEACTIVATED)                                                    |

    When I send PFCP message PFCP_SESSION_MODIFICATION_REQ on interface N4 with the following details from node SMF1 to UPF1:
      | parameter           | value       |
      | header.message_type | 52          |
      | header.seid         | incr(2,2)   |
      | header.seq_number   | incr(26,12) |
      | remove_pdr.0.pdr_id | 1           |
      | remove_pdr.1.pdr_id | 2           |
      | remove_far.0.far_id | 1           |
      | remove_far.1.far_id | 2           |
      | remove_qer.0.qer_id | 1           |

    Then I receive and validate PFCP message PFCP_SESSION_MODIFICATION_REQ on interface N4 with the following details on node UPF1 from SMF1:
      | parameter           | value                    |
      | header.message_type | {string:eq}(52)          |
      | header.seid         | {string:eq}(incr(2,2))   |
      | header.seq_number   | {string:eq}(incr(26,12)) |
      | remove_pdr.0.pdr_id | {string:eq}(1)           |
      | remove_pdr.1.pdr_id | {string:eq}(2)           |
      | remove_far.0.far_id | {string:eq}(1)           |
      | remove_far.1.far_id | {string:eq}(2)           |
      | remove_qer.0.qer_id | {string:eq}(1)           |

    When I send PFCP message PFCP_SESSION_MODIFICATION_RES on interface N4 with the following details from node UPF1 to SMF1:
      | parameter           | value       |
      | header.message_type | 53          |
      | header.seid         | incr(1,2)   |
      | header.seq_number   | incr(27,12) |
      | cause               | 1           |

    Then I receive and validate PFCP message PFCP_SESSION_MODIFICATION_RES on interface N4 with the following details on node SMF1 from UPF1:
      | parameter           | value                    |
      | header.message_type | {string:eq}(53)          |
      | header.seid         | {string:eq}(incr(1,2))   |
      | header.seq_number   | {string:eq}(incr(27,12)) |
      | cause               | {string:eq}(1)           |

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_200 on interface N11 with the following details from node SMF1 to AMF1:
      | parameter                                             | value            |
      | header.nva.0.name                                     | :status          |
      | header.nva.0.value                                    | 200              |
      | header.nva.1.name                                     | content-type     |
      | header.nva.1.value                                    | application/json |
      | application_json.sm_context_updated_data.up_cnx_state | DEACTIVATED      |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_200 on interface N11 with the following details on node AMF1 from SMF1:
      | parameter                                             | value                         |
      | header.nva.0.name                                     | {string:eq}(:status)          |
      | header.nva.0.value                                    | {string:eq}(200)              |
      | header.nva.1.name                                     | {string:eq}(content-type)     |
      | header.nva.1.value                                    | {string:eq}(application/json) |
      | application_json.sm_context_updated_data.up_cnx_state | {string:eq}(DEACTIVATED)      |

    Given the execution is paused for {abotprop.WAIT_1_SEC} seconds

### Network Triggered Service Request For DL Data Procedure

### Due to Downlink Data arrival UPF sends Downlink Data Notificaiton to SMF

    When I send PFCP message PFCP_SESSION_REPORT_REQ on interface N4 with the following details from node UPF1 to SMF1:
      | parameter                         | value       |
      | header.message_type               | 56          |
      | header.seid                       | incr(1,2)   |
      | header.seq_number                 | incr(28,12) |
      | report_type                       | 1           |
      | downlink_data_report.ies.0.pdr_id | 1           |

    Then I receive and validate PFCP message PFCP_SESSION_REPORT_REQ on interface N4 with the following details on node SMF1 from UPF1:
      | parameter                         | value                    |
      | header.message_type               | {string:eq}(56)          |
      | header.seid                       | {string:eq}(incr(1,2))   |
      | header.seq_number                 | {string:eq}(incr(28,12)) |
      | report_type                       | {string:eq}(1)           |
      | downlink_data_report.ies.0.pdr_id | {string:eq}(1)           |

    When I send PFCP message PFCP_SESSION_REPORT_RES on interface N4 with the following details from node SMF1 to UPF1:
      | parameter           | value       |
      | header.message_type | 57          |
      | header.seid         | incr(2,2)   |
      | header.seq_number   | incr(29,12) |
      | cause               | 1           |

    Then I receive and validate PFCP message PFCP_SESSION_REPORT_RES on interface N4 with the following details on node UPF1 from SMF1:
      | parameter           | value                    |
      | header.message_type | {string:eq}(57)          |
      | header.seid         | {string:eq}(incr(2,2))   |
      | header.seq_number   | {string:eq}(incr(29,12)) |
      | cause               | {string:eq}(1)           |

    When I send HTTPV2 message HTTPV2_NAMF_COMM_N1N2_MSG_TRANSFER_POST_REQ on interface N11 with the following details from node SMF1 to AMF1:
      | parameter                                                                                                                                                                                 | value                                                                                                  |
      | header.nva.0.name                                                                                                                                                                         | :method                                                                                                |
      | header.nva.0.value                                                                                                                                                                        | POST                                                                                                   |
      | header.nva.1.name                                                                                                                                                                         | :path                                                                                                  |
      | header.nva.1.value                                                                                                                                                                        | /127.0.0.1:12348/namf-comm/v1/ue-contexts/incr(imsi-404309990000001,1)/n1-n2-messages                  |
      | header.nva.2.name                                                                                                                                                                         | content-type                                                                                           |
      | header.nva.2.value                                                                                                                                                                        | multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json                |
      | multipart_related.json_data.content_type                                                                                                                                                  | application/json                                                                                       |
      | multipart_related.json_data.content_id                                                                                                                                                    | n1n2-message-transfer-req-data                                                                         |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.n2_information_class                                                                                         | SM                                                                                                     |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.n2_info_content.ngap_ie_type                                                                         | PDU_RES_SETUP_REQ                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.n2_info_content.ngap_data.content_id                                                                 | n2-pdu-session-resource-setup-request-transfer-ie                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.pdu_session_id                                                                                       | 6                                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.s_nssai.sst                                                                                          | 1                                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.skip_ind                                                                                                                       | false                                                                                                  |
      | multipart_related.json_data.n1n2_message_transfer_req_data.pdu_session_id                                                                                                                 | 6                                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.5qi                                                                                                                            | 1                                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1n2_failure_txf_notif_u_r_i                                                                                                   | /127.0.0.1:12348/namf-comm/v1/ue-contexts/incr(imsi-404309990000001,1)/n1-n2-messages/callback-failure |
      | multipart_related.json_data.n1n2_message_transfer_req_data.smf_reallocation_ind                                                                                                           | false                                                                                                  |
      | multipart_related.binary_data_n2_information.content_type                                                                                                                                 | application/vnd.3gpp.ngap                                                                              |
      | multipart_related.binary_data_n2_information.content_id                                                                                                                                   | n2-pdu-session-resource-setup-request-transfer-ie                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate         | 10000                                                                                                  |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate         | 10000                                                                                                  |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                              | incr(10.10.10.11,3)                                                                                    |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                             | incr(11,3)                                                                                             |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                         | 0                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                            | 5                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi | 4                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                         | 3                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                     | 0                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                  | 0                                                                                                      |

    Then I receive and validate HTTPV2 message HTTPV2_NAMF_COMM_N1N2_MSG_TRANSFER_POST_REQ on interface N11 with the following details on node AMF1 from SMF1:
      | parameter                                                                                                                                                                                 | value                                                                                                               |
      | header.nva.0.name                                                                                                                                                                         | {string:eq}(:method)                                                                                                |
      | header.nva.0.value                                                                                                                                                                        | {string:eq}(POST)                                                                                                   |
      | header.nva.1.name                                                                                                                                                                         | {string:eq}(:path)                                                                                                  |
      | header.nva.1.value                                                                                                                                                                        | {string:eq}(/127.0.0.1:12348/namf-comm/v1/ue-contexts/incr(imsi-404309990000001,1)/n1-n2-messages)                  |
      | header.nva.2.name                                                                                                                                                                         | {string:eq}(content-type)                                                                                           |
      | header.nva.2.value                                                                                                                                                                        | {string:eq}(multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json)                |
      | multipart_related.json_data.content_type                                                                                                                                                  | {string:eq}(application/json)                                                                                       |
      | multipart_related.json_data.content_id                                                                                                                                                    | {string:eq}(n1n2-message-transfer-req-data)                                                                         |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.n2_information_class                                                                                         | {string:eq}(SM)                                                                                                     |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.n2_info_content.ngap_ie_type                                                                         | {string:eq}(PDU_RES_SETUP_REQ)                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.n2_info_content.ngap_data.content_id                                                                 | {string:eq}(n2-pdu-session-resource-setup-request-transfer-ie)                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.pdu_session_id                                                                                       | {string:eq}(6)                                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.s_nssai.sst                                                                                          | {string:eq}(1)                                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.skip_ind                                                                                                                       | {string:eq}(false)                                                                                                  |
      | multipart_related.json_data.n1n2_message_transfer_req_data.pdu_session_id                                                                                                                 | {string:eq}(6)                                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.5qi                                                                                                                            | {string:eq}(1)                                                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1n2_failure_txf_notif_u_r_i                                                                                                   | {string:eq}(/127.0.0.1:12348/namf-comm/v1/ue-contexts/incr(imsi-404309990000001,1)/n1-n2-messages/callback-failure) |
      | multipart_related.json_data.n1n2_message_transfer_req_data.smf_reallocation_ind                                                                                                           | {string:eq}(false)                                                                                                  |
      | multipart_related.binary_data_n2_information.content_type                                                                                                                                 | {string:eq}(application/vnd.3gpp.ngap)                                                                              |
      | multipart_related.binary_data_n2_information.content_id                                                                                                                                   | {string:eq}(n2-pdu-session-resource-setup-request-transfer-ie)                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate         | {string:eq}(10000)                                                                                                  |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate         | {string:eq}(10000)                                                                                                  |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                              | {string:eq}(incr(10.10.10.11,3))                                                                                    |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                             | {string:eq}(incr(11,3))                                                                                             |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                         | {string:eq}(0)                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                            | {string:eq}(5)                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi | {string:eq}(4)                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                         | {string:eq}(3)                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                     | {string:eq}(0)                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                  | {string:eq}(0)                                                                                                      |

    When I send HTTPV2 message HTTPV2_NAMF_COMM_N1N2_MSG_TRANSFER_POST_RES_202 on interface N11 with the following details from node AMF1 to SMF1:
      | parameter                            | value                                                                                            |
      | header.nva.0.name                    | :status                                                                                          |
      | header.nva.0.value                   | 202                                                                                              |
      | header.nva.1.name                    | location                                                                                         |
      | header.nva.1.value                   | /127.0.0.1:12348/namf-comm/v1/ue-contexts/incr(imsi-404309990000001,1)/n1-n2-messages/amf-status |
      | header.nva.2.name                    | content-type                                                                                     |
      | header.nva.2.value                   | application/json                                                                                 |
      | n1n2_message_transfer_rsp_data.cause | ATTEMPTING_TO_REACH_UE                                                                           |

    Then I receive and validate HTTPV2 message HTTPV2_NAMF_COMM_N1N2_MSG_TRANSFER_POST_RES_202 on interface N11 with the following details on node SMF1 from AMF1:
      | parameter                            | value                                                                                                         |
      | header.nva.0.name                    | {string:eq}(:status)                                                                                          |
      | header.nva.0.value                   | {string:eq}(202)                                                                                              |
      | header.nva.1.name                    | {string:eq}(location)                                                                                         |
      | header.nva.1.value                   | {string:eq}(/127.0.0.1:12348/namf-comm/v1/ue-contexts/incr(imsi-404309990000001,1)/n1-n2-messages/amf-status) |
      | header.nva.2.name                    | {string:eq}(content-type)                                                                                     |
      | header.nva.2.value                   | {string:eq}(application/json)                                                                                 |
      | n1n2_message_transfer_rsp_data.cause | {string:eq}(ATTEMPTING_TO_REACH_UE)                                                                           |

    When I send NGAP message NG_PAGING_REQ on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                   | value                               |
      | ue_paging_identity.5g_s_tmsi.amf_set_id     | {abotprop.SUT.GUAMI.AMF.SET.ID}     |
      | ue_paging_identity.5g_s_tmsi.amf_pointer    | {abotprop.SUT.GUAMI.AMF.POINTER}    |
      | ue_paging_identity.5g_s_tmsi.5g_tmsi        | incr({abotprop.SUT.5GTMSI.START},1) |
      | tai_list_for_paging.0.tai.plmn_identity.mcc | 404                                 |
      | tai_list_for_paging.0.tai.plmn_identity.mnc | 30                                  |
      | tai_list_for_paging.0.tai.tac               | 0x000001                            |
      | paging_drx                                  | 0x01                                |
      | paging_priority                             | 0x01                                |

    Then I receive and validate NGAP message NG_PAGING_REQ on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                   | value                 |
      | ue_paging_identity.5g_s_tmsi.amf_set_id     | save(AMF_SET_ID)      |
      | ue_paging_identity.5g_s_tmsi.amf_pointer    | save(AMF_POINTER)     |
      | ue_paging_identity.5g_s_tmsi.5g_tmsi        | save(5G_TMSI)         |
      | tai_list_for_paging.0.tai.plmn_identity.mcc | {string:eq}(404)      |
      | tai_list_for_paging.0.tai.plmn_identity.mnc | {string:eq}(30)       |
      | tai_list_for_paging.0.tai.tac               | {string:eq}(0x000001) |
      | paging_drx                                  | {string:eq}(0x01)     |
      | paging_priority                             | {string:eq}(0x01)     |

    When I send NGAP message NG_INIT_UE_MSG_NAS_SERVICE_REQ on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                       | value              |
      | ran_ue_ngap_id                                                                  | incr(4294967295,1) |
      | nas_pdu.extended_protocol_discriminator                                         | 126                |
      | nas_pdu.security_header_type                                                    | 0x01               |
      | nas_pdu.message_type                                                            | 0x4c               |
      | nas_pdu.service_request.nas_key_set_identifier                                  | 0x10               |
      #| nas_pdu.service_request.5gs_mobile_identity                                     | 0xf4004099900000   |
      | nas_pdu.service_request.5gs_mob_id_choice.type_of_id                            | 0x04               |
      | nas_pdu.service_request.5gs_mob_id_choice.5g_s_tmsi.amf_set_id                  | $(AMF_SET_ID)      |
      | nas_pdu.service_request.5gs_mob_id_choice.5g_s_tmsi.amf_pointer                 | $(AMF_POINTER)     |
      | nas_pdu.service_request.5gs_mob_id_choice.5g_s_tmsi.5g_tmsi                     | $(5G_TMSI)         |
      | nas_pdu.service_request.uplink_data_status                                      | 0x4000             |
      | nas_pdu.service_request.pdu_session_status                                      | 0x4000             |
      | rrc_establishment_cause                                                         | 1                  |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | 404                |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | 30                 |
      | user_location_information.nr_user_location_information.tai.tac                  | 0x000001           |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | 404                |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | 30                 |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | 3584               |

    Then I receive and validate NGAP message NG_INIT_UE_MSG_NAS_SERVICE_REQ on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                       | value                         |
      | ran_ue_ngap_id                                                                  | save(RAN_UE_NGAP_ID)          |
      | nas_pdu.extended_protocol_discriminator                                         | {string:eq}(126)              |
      | nas_pdu.security_header_type                                                    | {string:eq}(0x01)             |
      | nas_pdu.message_type                                                            | {string:eq}(0x4c)             |
      | nas_pdu.service_request.nas_key_set_identifier                                  | {string:eq}(0x10)             |
      #| nas_pdu.service_request.5gs_mobile_identity                                     | {string:eq}(0xf4004099900000) |
      | nas_pdu.service_request.5gs_mob_id_choice.type_of_id                            | 0x04                          |
      | nas_pdu.service_request.5gs_mob_id_choice.5g_s_tmsi.amf_set_id                  | save(AMF_SET_ID)              |
      | nas_pdu.service_request.5gs_mob_id_choice.5g_s_tmsi.amf_pointer                 | save(AMF_POINTER)             |
      | nas_pdu.service_request.5gs_mob_id_choice.5g_s_tmsi.5g_tmsi                     | save(5G_TMSI)                 |
      | nas_pdu.service_request.uplink_data_status                                      | {string:eq}(0x4000)           |
      | nas_pdu.service_request.pdu_session_status                                      | {string:eq}(0x4000)           |
      | rrc_establishment_cause                                                         | {string:eq}(1)                |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {string:eq}(404)              |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {string:eq}(30)               |
      | user_location_information.nr_user_location_information.tai.tac                  | {string:eq}(0x000001)         |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {string:eq}(404)              |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {string:eq}(30)               |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {string:eq}(3584)             |

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details from node AMF1 to SMF1:
      | parameter                                            | value                                                          |
      | header.nva.0.name                                    | :method                                                        |
      | header.nva.0.value                                   | POST                                                           |
      | header.nva.1.name                                    | :path                                                          |
      | header.nva.1.value                                   | /127.0.0.1:12348/nsmf-pdusession/v1/sm-contexts/smctx-1/modify |
      | header.nva.2.name                                    | content-type                                                   |
      | header.nva.2.value                                   | application/json                                               |
      | application_json.sm_context_update_data.pei          | incr({abotprop.SUT.PEI},1)                                     |
      | application_json.sm_context_update_data.s_nssai.sst  | 1                                                              |
      | application_json.sm_context_update_data.up_cnx_state | ACTIVATING                                                     |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details on node SMF1 from AMF1:
      | parameter                                            | value                                                                       |
      | header.nva.0.name                                    | {string:eq}(:method)                                                        |
      | header.nva.0.value                                   | {string:eq}(POST)                                                           |
      | header.nva.1.name                                    | {string:eq}(:path)                                                          |
      | header.nva.1.value                                   | {string:eq}(/127.0.0.1:12348/nsmf-pdusession/v1/sm-contexts/smctx-1/modify) |
      | header.nva.2.name                                    | {string:eq}(content-type)                                                   |
      | header.nva.2.value                                   | {string:eq}(application/json)                                               |
      | application_json.sm_context_update_data.pei          | {string:eq}($(PEI))                                                         |
      | application_json.sm_context_update_data.s_nssai.sst  | {string:eq}(1)                                                              |
      | application_json.sm_context_update_data.up_cnx_state | {string:eq}(ACTIVATING)                                                     |

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_200 on interface N11 with the following details from node SMF1 to AMF1:
      | parameter                                                                                                                                                                                    | value                                                                                   |
      | header.nva.0.name                                                                                                                                                                            | :status                                                                                 |
      | header.nva.0.value                                                                                                                                                                           | 200                                                                                     |
      | header.nva.1.name                                                                                                                                                                            | content-type                                                                            |
      | header.nva.1.value                                                                                                                                                                           | multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json |
      | multipart_related.json_data.content_type                                                                                                                                                     | application/json                                                                        |
      | multipart_related.json_data.content_id                                                                                                                                                       | sm-context-updated                                                                      |
      | multipart_related.json_data.sm_context_updated_data.up_cnx_state      `                                                                                                                      | ACTIVATED                                                                               |
      | multipart_related.json_data.sm_context_updated_data.n2_sm_info_type                                                                                                                          | PDU_RES_SETUP_REQ                                                                       |
      | multipart_related.json_data.sm_context_updated_data.n2_sm_info.content_id                                                                                                                    | n2-pdu-session-resource-setup-request-transfer-ie                                       |
      | multipart_related.binary_data_n2_sm_information.content_type                                                                                                                                 | application/vnd.3gpp.ngap                                                               |
      | multipart_related.binary_data_n2_sm_information.content_id                                                                                                                                   | n2-pdu-session-resource-setup-request-transfer-ie                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate         | 10000                                                                                   |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate         | 10000                                                                                   |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                              | incr(10.10.10.11,3)                                                                     |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                             | incr(11,3)                                                                              |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                         | 0                                                                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                            | 5                                                                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi | 4                                                                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                         | 3                                                                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                     | 0                                                                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                  | 0                                                                                       |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_200 on interface N11 with the following details on node AMF1 from SMF1:
      | parameter                                                                                                                                                                                    | value                                                                                                |
      | header.nva.0.name                                                                                                                                                                            | {string:eq}(:status)                                                                                 |
      | header.nva.0.value                                                                                                                                                                           | {string:eq}(200)                                                                                     |
      | header.nva.1.name                                                                                                                                                                            | {string:eq}(content-type)                                                                            |
      | header.nva.1.value                                                                                                                                                                           | {string:eq}(multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json) |
      | multipart_related.json_data.content_type                                                                                                                                                     | {string:eq}(application/json)                                                                        |
      | multipart_related.json_data.content_id                                                                                                                                                       | {string:eq}(sm-context-updated)                                                                      |
      | multipart_related.json_data.sm_context_updated_data.up_cnx_state      `                                                                                                                      | {string:eq}(ACTIVATED)                                                                               |
      | multipart_related.json_data.sm_context_updated_data.n2_sm_info_type                                                                                                                          | {string:eq}(PDU_RES_SETUP_REQ)                                                                       |
      | multipart_related.json_data.sm_context_updated_data.n2_sm_info.content_id                                                                                                                    | {string:eq}(n2-pdu-session-resource-setup-request-transfer-ie)                                       |
      | multipart_related.binary_data_n2_sm_information.content_type                                                                                                                                 | {string:eq}(application/vnd.3gpp.ngap)                                                               |
      | multipart_related.binary_data_n2_sm_information.content_id                                                                                                                                   | {string:eq}(n2-pdu-session-resource-setup-request-transfer-ie)                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate         | {string:eq}(10000)                                                                                   |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate         | {string:eq}(10000)                                                                                   |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                              | {string:eq}(incr(10.10.10.11,3))                                                                     |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                             | {string:eq}(incr(11,3))                                                                              |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                         | {string:eq}(0)                                                                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                            | {string:eq}(5)                                                                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi | {string:eq}(4)                                                                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                         | {string:eq}(3)                                                                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                     | {string:eq}(0)                                                                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                  | {string:eq}(0)                                                                                       |

    When I send NGAP message NG_INIT_CTXT_SET_REQ_NAS_SERVICE_ACC on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                                                                                                                                                      | value                                                            |
      | amf_ue_ngap_id                                                                                                                                                                 | incr(1234,1)                                                     |
      | ran_ue_ngap_id                                                                                                                                                                 | $(RAN_UE_NGAP_ID)                                                |
      | nas_pdu.extended_protocol_discriminator                                                                                                                                        | 126                                                              |
      | nas_pdu.security_header_type                                                                                                                                                   | 0x01                                                             |
      | nas_pdu.message_type                                                                                                                                                           | 0x4e                                                             |
      | nas_pdu.service_accept.pdu_session_status                                                                                                                                      | 0x4000                                                           |
      | nas_pdu.service_accept.pdu_session_reactivation_result_error_cause                                                                                                             | 0xbeff                                                           |
      | guami.plmn_identity.mcc                                                                                                                                                        | 404                                                              |
      | guami.plmn_identity.mnc                                                                                                                                                        | 30                                                               |
      | guami.amf_region_id                                                                                                                                                            | 0x01                                                             |
      | guami.amf_set_id                                                                                                                                                               | 0x01                                                             |
      | guami.pointer.amf_pointer                                                                                                                                                      | 0x01                                                             |
      | allowed_s-nssai_list.0.sst                                                                                                                                                     | 1                                                                |
      | ue_security_capabilities.nr_encryption_algo                                                                                                                                    | 0xc000                                                           |
      | ue_security_capabilities.nr_integrity_protection_algo                                                                                                                          | 0xc000                                                           |
      | ue_security_capabilities.e_utra_encryption_algo                                                                                                                                | 0x0000                                                           |
      | ue_security_capabilities.e_utra_integrity_protection_algo                                                                                                                      | 0x0000                                                           |
      | security_key                                                                                                                                                                   | a8202f2d5e1d4307b751e0ac558025f2865d9c25eebb409d9a5560145dd8e765 |
      | pdu_session_resource_setup_request_list.0.pdu_session_id                                                                                                                       | 6                                                                |
      | pdu_session_resource_setup_request_list.0.s-nssai.sst                                                                                                                          | 1                                                                |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate         | 10000000                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate         | 10000000                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                              | incr(10.10.10.11,3)                                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                             | incr(11,3)                                                       |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                         | 0                                                                |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                            | 5                                                                |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi | 4                                                                |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                         | 3                                                                |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                     | 0                                                                |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                  | 0                                                                |

    Then I receive and validate NGAP message NG_INIT_CTXT_SET_REQ_NAS_SERVICE_ACC on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                                                                                                                                                      | value                                                                         |
      | amf_ue_ngap_id                                                                                                                                                                 | save(AMF_UE_NGAP_ID)                                                          |
      | ran_ue_ngap_id                                                                                                                                                                 | {string:eq}(incr(4294967295,1))                                               |
      | nas_pdu.extended_protocol_discriminator                                                                                                                                        | {string:eq}(126)                                                              |
      | nas_pdu.security_header_type                                                                                                                                                   | {string:eq}(0x01)                                                             |
      | nas_pdu.message_type                                                                                                                                                           | {string:eq}(0x4e)                                                             |
      | nas_pdu.service_accept.pdu_session_status                                                                                                                                      | {string:eq}(0x4000)                                                           |
      | nas_pdu.service_accept.pdu_session_reactivation_result_error_cause                                                                                                             | {string:eq}(0xbeff)                                                           |
      | guami.plmn_identity.mcc                                                                                                                                                        | {string:eq}(404)                                                              |
      | guami.plmn_identity.mnc                                                                                                                                                        | {string:eq}(30)                                                               |
      | guami.amf_region_id                                                                                                                                                            | {string:eq}(0x01)                                                             |
      | guami.amf_set_id                                                                                                                                                               | {string:eq}(0x01)                                                             |
      | guami.pointer.amf_pointer                                                                                                                                                      | {string:eq}(0x01)                                                             |
      | allowed_s-nssai_list.0.sst                                                                                                                                                     | {string:eq}(1)                                                                |
      | ue_security_capabilities.nr_encryption_algo                                                                                                                                    | {string:eq}(0xc000)                                                           |
      | ue_security_capabilities.nr_integrity_protection_algo                                                                                                                          | {string:eq}(0xc000)                                                           |
      | ue_security_capabilities.e_utra_encryption_algo                                                                                                                                | {string:eq}(0x0000)                                                           |
      | ue_security_capabilities.e_utra_integrity_protection_algo                                                                                                                      | {string:eq}(0x0000)                                                           |
      | security_key                                                                                                                                                                   | {string:eq}(a8202f2d5e1d4307b751e0ac558025f2865d9c25eebb409d9a5560145dd8e765) |
      | pdu_session_resource_setup_request_list.0.pdu_session_id                                                                                                                       | {string:eq}(6)                                                                |
      | pdu_session_resource_setup_request_list.0.s-nssai.sst                                                                                                                          | {string:eq}(1)                                                                |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate         | {string:eq}(10000000)                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate         | {string:eq}(10000000)                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                              | {string:eq}(incr(10.10.10.11,3))                                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                             | {string:eq}(incr(11,3))                                                       |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                         | save(PDU_SESS_TYPE_AT_GNB)                                                    |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                            | {string:eq}(5)                                                                |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi | {string:eq}(4)                                                                |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                         | {string:eq}(3)                                                                |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                     | {string:eq}(0)                                                                |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                  | {string:eq}(0)                                                                |

    When I send NGAP message NG_INIT_CTXT_SET_RES on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                                                                          | value               |
      | amf_ue_ngap_id                                                                                                                                                                     | $(AMF_UE_NGAP_ID)   |
      | ran_ue_ngap_id                                                                                                                                                                     | incr(4294967295,1)  |
      | pdu_session_resource_setup_response_list.0.pdu_session_id                                                                                                                          | 6                   |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | incr(10.10.10.12,3) |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | incr(12,3)          |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | 5                   |

    Then I receive and validate NGAP message NG_INIT_CTXT_SET_RES on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                                                                                                          | value                            |
      | amf_ue_ngap_id                                                                                                                                                                     | {string:eq}(incr(1234,1))        |
      | ran_ue_ngap_id                                                                                                                                                                     | {string:eq}($(RAN_UE_NGAP_ID))   |
      | pdu_session_resource_setup_response_list.0.pdu_session_id                                                                                                                          | {string:eq}(6)                   |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | {string:eq}(incr(10.10.10.12,3)) |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | {string:eq}(incr(12,3))          |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | {string:eq}(5)                   |

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details from node AMF1 to SMF1:
      | parameter                                                                                                                                                                                       | value                                                                                   |
      | header.nva.0.name                                                                                                                                                                               | :method                                                                                 |
      | header.nva.0.value                                                                                                                                                                              | POST                                                                                    |
      | header.nva.1.name                                                                                                                                                                               | :path                                                                                   |
      | header.nva.1.value                                                                                                                                                                              | /127.0.0.1:12348/nsmf-pdusession/v1/sm-contexts/smctx-1/modify                          |
      | header.nva.2.name                                                                                                                                                                               | content-type                                                                            |
      | header.nva.2.value                                                                                                                                                                              | multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json |
      | multipart_related.json_data.content_type                                                                                                                                                        | application/json                                                                        |
      | multipart_related.json_data.content_id                                                                                                                                                          | sm-context-update                                                                       |
      | multipart_related.json_data.sm_context_update_data.pei                                                                                                                                          | incr({abotprop.SUT.PEI},1)                                                              |
      | multipart_related.json_data.sm_context_update_data.s_nssai.sst                                                                                                                                  | 1                                                                                       |
      | multipart_related.json_data.sm_context_update_data.up_cnx_state                                                                                                                                 | ACTIVATED                                                                               |
      | multipart_related.json_data.sm_context_update_data.n2_sm_info.content_id                                                                                                                        | n2-pdu-session-resource-setup-response-transfer-ie                                      |
      | multipart_related.json_data.sm_context_update_data.n2_sm_info_type                                                                                                                              | PDU_RES_SETUP_RSP                                                                       |
      | multipart_related.binary_data_n2_sm_information.content_type                                                                                                                                    | application/vnd.3gpp.ngap                                                               |
      | multipart_related.binary_data_n2_sm_information.content_id                                                                                                                                      | n2-pdu-session-resource-setup-response-transfer-ie                                      |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | incr(10.10.10.12,3)                                                                     |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | incr(12,3)                                                                              |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | 5                                                                                       |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details on node SMF1 from AMF1:
      | parameter                                                                                                                                                                                       | value                                                                                                |
      | header.nva.0.name                                                                                                                                                                               | {string:eq}(:method)                                                                                 |
      | header.nva.0.value                                                                                                                                                                              | {string:eq}(POST)                                                                                    |
      | header.nva.1.name                                                                                                                                                                               | {string:eq}(:path)                                                                                   |
      | header.nva.1.value                                                                                                                                                                              | {string:eq}(/127.0.0.1:12348/nsmf-pdusession/v1/sm-contexts/smctx-1/modify)                          |
      | header.nva.2.name                                                                                                                                                                               | {string:eq}(content-type)                                                                            |
      | header.nva.2.value                                                                                                                                                                              | {string:eq}(multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json) |
      | multipart_related.json_data.content_type                                                                                                                                                        | {string:eq}(application/json)                                                                        |
      | multipart_related.json_data.content_id                                                                                                                                                          | {string:eq}(sm-context-update)                                                                       |
      | multipart_related.json_data.sm_context_update_data.pei                                                                                                                                          | {string:eq}($(PEI))                                                                                  |
      | multipart_related.json_data.sm_context_update_data.s_nssai.sst                                                                                                                                  | {string:eq}(1)                                                                                       |
      | multipart_related.json_data.sm_context_update_data.up_cnx_state                                                                                                                                 | {string:eq}(ACTIVATED)                                                                               |
      | multipart_related.json_data.sm_context_update_data.n2_sm_info.content_id                                                                                                                        | {string:eq}(n2-pdu-session-resource-setup-response-transfer-ie)                                      |
      | multipart_related.json_data.sm_context_update_data.n2_sm_info_type                                                                                                                              | {string:eq}(PDU_RES_SETUP_RSP)                                                                       |
      | multipart_related.binary_data_n2_sm_information.content_type                                                                                                                                    | {string:eq}(application/vnd.3gpp.ngap)                                                               |
      | multipart_related.binary_data_n2_sm_information.content_id                                                                                                                                      | {string:eq}(n2-pdu-session-resource-setup-response-transfer-ie)                                      |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | {string:eq}(incr(10.10.10.12,3))                                                                     |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | {string:eq}(incr(12,3))                                                                              |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | {string:eq}(5)                                                                                       |


    When I send PFCP message PFCP_SESSION_MODIFICATION_REQ on interface N4 with the following details from node SMF1 to UPF1:
      | parameter                                                       | value               |
      | header.message_type                                             | 52                  |
      | header.seid                                                     | incr(2,2)           |
      | header.seq_number                                               | incr(30,12)         |
      | create_pdr.0.pdr_id                                             | 1                   |
      | create_pdr.0.precedence                                         | 1                   |
      | create_pdr.0.pdi.source_interface                               | 0                   |
      | create_pdr.0.pdi.local_fteid.flag                               | 1                   |
      | create_pdr.0.pdi.local_fteid.teid                               | incr(11,3)          |
      | create_pdr.0.pdi.local_fteid.ipv4_addr                          | incr(10.10.10.11,3) |
      | create_pdr.0.pdi.qfi                                            | 5                   |
      | create_pdr.0.outer_header_removal.outer_head_remov_desc         | 0                   |
      | create_pdr.0.outer_header_removal.gtpu_ext_head_desc            | 0                   |
      | create_pdr.0.far_id                                             | 1                   |
      | create_pdr.0.qer_id                                             | 1                   |
      | create_pdr.1.pdr_id                                             | 2                   |
      | create_pdr.1.precedence                                         | 1                   |
      | create_pdr.1.pdi.source_interface                               | 1                   |
      | create_pdr.1.pdi.ue_ip_addr.flag                                | 6                   |
      | create_pdr.1.pdi.ue_ip_addr.ipv4_addr                           | incr(10.10.10.10,3) |
      | create_pdr.1.pdi.qfi                                            | 5                   |
      | create_pdr.1.far_id                                             | 2                   |
      | create_pdr.1.qer_id                                             | 1                   |
      | create_far.0.far_id                                             | 1                   |
      | create_far.0.apply_action                                       | 2                   |
      | create_far.0.forwarding_parms.destination_interface             | 1                   |
      | create_far.1.far_id                                             | 2                   |
      | create_far.1.apply_action                                       | 2                   |
      | create_far.1.forwarding_parms.destination_interface             | 0                   |
      | create_far.1.forwarding_parms.outer_header_creation.description | 0x100               |
      | create_far.1.forwarding_parms.outer_header_creation.teid        | incr(12,3)          |
      | create_far.1.forwarding_parms.outer_header_creation.ipv4_addr   | incr(10.10.10.12,3) |
      | create_qer.0.qer_id                                             | 1                   |
      | create_qer.0.gate_status.ul_gate                                | 0                   |
      | create_qer.0.gate_status.dl_gate                                | 0                   |
      | create_qer.0.mbr.ul_mbr                                         | 10000               |
      | create_qer.0.mbr.dl_mbr                                         | 10000               |
      | create_qer.0.qfi                                                | 5                   |

    Then I receive and validate PFCP message PFCP_SESSION_MODIFICATION_REQ on interface N4 with the following details on node UPF1 from SMF1:
      | parameter                                                       | value                               |
      | header.message_type                                             | {string:eq}(52)                     |
      | header.seid                                                     | {string:eq}(incr(2,2))              |
      | header.seq_number                                               | {string:eq}(incr(30,12))            |
      | create_pdr.0.pdr_id                                             | {string:eq}(1)                      |
      | create_pdr.0.precedence                                         | {string:eq}(1)                      |
      | create_pdr.0.pdi.source_interface                               | {string:eq}(0)                      |
      | create_pdr.0.pdi.local_fteid.flag                               | save(N4_UPF_LOCAL_TEID_FLAG_AT_UPF) |
      | create_pdr.0.pdi.local_fteid.teid                               | {string:eq}(incr(11,3))             |
      | create_pdr.0.pdi.local_fteid.ipv4_addr                          | {string:eq}(incr(10.10.10.11,3))    |
      | create_pdr.0.pdi.qfi                                            | {string:eq}(5)                      |
      | create_pdr.0.outer_header_removal.outer_head_remov_desc         | {string:eq}(0)                      |
      | create_pdr.0.outer_header_removal.gtpu_ext_head_desc            | {string:eq}(0)                      |
      | create_pdr.0.far_id                                             | {string:eq}(1)                      |
      | create_pdr.0.qer_id                                             | {string:eq}(1)                      |
      | create_pdr.1.pdr_id                                             | {string:eq}(2)                      |
      | create_pdr.1.precedence                                         | {string:eq}(1)                      |
      | create_pdr.1.pdi.source_interface                               | {string:eq}(1)                      |
      | create_pdr.1.pdi.ue_ip_addr.flag                                | {string:eq}(6)                      |
      | create_pdr.1.pdi.ue_ip_addr.ipv4_addr                           | {string:eq}(incr(10.10.10.10,3))    |
      | create_pdr.1.pdi.qfi                                            | {string:eq}(5)                      |
      | create_pdr.1.far_id                                             | {string:eq}(2)                      |
      | create_pdr.1.qer_id                                             | {string:eq}(1)                      |
      | create_far.0.far_id                                             | {string:eq}(1)                      |
      | create_far.0.apply_action                                       | {string:eq}(2)                      |
      | create_far.0.forwarding_parms.destination_interface             | {string:eq}(1)                      |
      | create_far.1.far_id                                             | {string:eq}(2)                      |
      | create_far.1.apply_action                                       | {string:eq}(2)                      |
      | create_far.1.forwarding_parms.destination_interface             | {string:eq}(0)                      |
      | create_far.1.forwarding_parms.outer_header_creation.description | save(GTP_OUT_HDR_CREATE_DESC)       |
      | create_far.1.forwarding_parms.outer_header_creation.teid        | save(GTP_DL_TEID)                   |
      | create_far.1.forwarding_parms.outer_header_creation.ipv4_addr   | save(GTP_DL_IP)                     |
      | create_qer.0.qer_id                                             | {string:eq}(1)                      |
      | create_qer.0.gate_status.ul_gate                                | {string:eq}(0)                      |
      | create_qer.0.gate_status.dl_gate                                | {string:eq}(0)                      |
      | create_qer.0.mbr.ul_mbr                                         | {string:eq}(10000)                  |
      | create_qer.0.mbr.dl_mbr                                         | {string:eq}(10000)                  |
      | create_qer.0.qfi                                                | {string:eq}(5)                      |

    When I send PFCP message PFCP_SESSION_MODIFICATION_RES on interface N4 with the following details from node UPF1 to SMF1:
      | parameter            | value       |
      | header.message_type  | 53          |
      | header.seid          | incr(1,2)   |
      | header.seq_number    | incr(31,12) |
      | cause                | 1           |
      | created_pdr.0.pdr_id | 1           |
      | created_pdr.1.pdr_id | 2           |

    Then I receive and validate PFCP message PFCP_SESSION_MODIFICATION_RES on interface N4 with the following details on node SMF1 from UPF1:
      | parameter            | value                    |
      | header.message_type  | {string:eq}(53)          |
      | header.seid          | {string:eq}(incr(1,2))   |
      | header.seq_number    | {string:eq}(incr(31,12)) |
      | cause                | {string:eq}(1)           |
      | created_pdr.0.pdr_id | {string:eq}(1)           |
      | created_pdr.1.pdr_id | {string:eq}(2)           |

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_200 on interface N11 with the following details from node SMF1 to AMF1:
      | parameter                                             | value            |
      | header.nva.0.name                                     | :status          |
      | header.nva.0.value                                    | 200              |
      | header.nva.1.name                                     | content-type     |
      | header.nva.1.value                                    | application/json |
      | application_json.sm_context_updated_data.up_cnx_state | ACTIVATED        |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_200 on interface N11 with the following details on node AMF1 from SMF1:
      | parameter                                             | value                         |
      | header.nva.0.name                                     | {string:eq}(:status)          |
      | header.nva.0.value                                    | {string:eq}(200)              |
      | header.nva.1.name                                     | {string:eq}(content-type)     |
      | header.nva.1.value                                    | {string:eq}(application/json) |
      | application_json.sm_context_updated_data.up_cnx_state | {string:eq}(ACTIVATED)        |
