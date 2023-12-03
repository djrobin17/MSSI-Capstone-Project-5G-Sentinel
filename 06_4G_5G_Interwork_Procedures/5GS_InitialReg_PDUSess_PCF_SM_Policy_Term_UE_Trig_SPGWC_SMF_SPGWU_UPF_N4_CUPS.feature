@5gs-initialreg5gaka-pdusess-pcf-sm-pol-term-ue-trig-spgwc-smf-spgwu-upf-n4-cups @06-5g-interwork-procedure @23502-5gs @5g-core-sanity @5g-core

Feature: 5GS Initial Registration, PDU Session Establishment, PCF SM Policy Association, UE PDU Session Release triggers PCF SM Policy Termination with SPGWC and SMF and SPGWU and UPF based CUPS

  Scenario: 5GS Initial Registration with 5G AKA, Single PDU Session Establishment, PCF SM Policy Association Setup, UE PDU Session Release triggers PCF SM Policy Termination with combined SPGWC,SMF and SPGWU,UPF based CUPS

    Given the test data is in file /featureFiles/MESSAGE_BUNDLES/EPC_MESSAGES.xml

    Given all configured endpoints for EPC are connected successfully

    When I send PFCP message PFCP_ASSOCIATION_SETUP_REQ on interface N4 with the following details from node SPGWC_SMF1 to SPGWU_UPF1:
      | parameter            | value                                  |
      | header.message_type  | 5                                      |
      | header.seq_number    | incr(1,4)                              |
      | node_id.type         | {abotprop.SUT.PFCP_NODE_ID_TYPE}       |
      | node_id.value        | {abotprop.SUT.PFCP_NODE_ID}            |
      | cp_function_features | {abotprop.SUT.CP_FUNC_FEATURES}        |
      | recovery_timestamp   | {abotprop.SUT.PFCP_RECOVERY_TIMESTAMP} |

    Then I receive and validate PFCP message PFCP_ASSOCIATION_SETUP_REQ on interface N4 with the following details on node SPGWU_UPF1 from SPGWC_SMF1:
      | parameter            | value                                         |
      | header.message_type  | {string:eq}(5)                                |
      | header.seq_number    | save(PFCP_HDR_SEQ_NO)                         |
      | node_id.type         | {string:eq}({abotprop.SUT.PFCP_NODE_ID_TYPE}) |
      | node_id.value        | {string:eq}({abotprop.SUT.PFCP_NODE_ID})      |
      | cp_function_features | save(CP_FUNC_FEATURES)                        |
      | recovery_timestamp   | save(CP_RECOVERY_TIMESTAMP)                   |

    When I send PFCP message PFCP_ASSOCIATION_SETUP_RES on interface N4 with the following details from node SPGWU_UPF1 to SPGWC_SMF1:
      | parameter            | value                                  |
      | header.message_type  | 6                                      |
      | header.seq_number    | $(PFCP_HDR_SEQ_NO)                     |
      | node_id.type         | {abotprop.SUT.PFCP_NODE_ID_TYPE}       |
      | node_id.value        | {abotprop.SUT.PFCP_NODE_ID}            |
      | up_function_features | {abotprop.SUT.PFCP_UP_FUNC_FEATURES}   |
      | cause                | {abotprop.SUT.PFCP_REQUEST_ACCEPTED}   |
      | recovery_timestamp   | {abotprop.SUT.PFCP_RECOVERY_TIMESTAMP} |

    Then I receive and validate PFCP message PFCP_ASSOCIATION_SETUP_RES on interface N4 with the following details on node SPGWC_SMF1 from SPGWU_UPF1:
      | parameter            | value                                             |
      | header.message_type  | {string:eq}(6)                                    |
      | header.seq_number    | save(PFCP_HDR_SEQ_NO)                             |
      | node_id.type         | {string:eq}({abotprop.SUT.PFCP_NODE_ID_TYPE})     |
      | node_id.value        | {string:eq}({abotprop.SUT.PFCP_NODE_ID})          |
      | up_function_features | save(UP_FUNC_FEATURES)                            |
      | cause                | {string:eq}({abotprop.SUT.PFCP_REQUEST_ACCEPTED}) |
      | recovery_timestamp   | save(UP_RECOVERY_TIMESTAMP)                       |
      
### UE Initial Registration

    When I send NGAP message NG_INIT_UE_MSG_NAS_REGIS_REQ on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                         | value                                     |
      | ran_ue_ngap_id                                                                    | incr({abotprop.SUT.RAN.UE.NGAP.ID},1)     |
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
      | authentication_info.supi_or_suci         | incr({abotprop.SUT.SUCI},1)                       |
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
      | authentication_info.supi_or_suci         | save(SUCI)                                                     |
      | authentication_info.serving_network_name | {string:eq}(5G:mnc030.mcc404.3gppnetwork.org)                  |
      | authentication_info.amf_instance_id      | {string:eq}(5a2b84e4-0cb7-4575-ac08-46a2812bec0d)              |

    When I send HTTPV2 message HTTPV2_NUDM_UEAU_GEN_AUTH_DATA_REQ on interface N13 with the following details from node AUSF1 to HSS_UDM1:
      | parameter                                        | value                                                                                                        |
      | header.nva.0.name                                | :method                                                                                                      |
      | header.nva.0.value                               | POST                                                                                                         |
      | header.nva.1.name                                | :path                                                                                                        |
      | header.nva.1.value                               | /127.0.0.1:12348/nudm-ueau/v1/incr(suci-0-001-01-0-0-0-9990000001,1)/security-information/generate-auth-data |
      | header.nva.2.name                                | content-type                                                                                                 |
      | header.nva.2.value                               | application/json                                                                                             |
      | authentication_info_request.serving_network_name | 5G:mnc030.mcc404.3gppnetwork.org                                                                             |
      | authentication_info_request.ausf_instance_id     | 44e57b64-9008-11ed-a1eb-0242ac120002                                                                         |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UEAU_GEN_AUTH_DATA_REQ on interface N13 with the following details on node HSS_UDM1 from AUSF1:
      | parameter                                        | value                                                                                                                     |
      | header.nva.0.name                                | {string:eq}(:method)                                                                                                      |
      | header.nva.0.value                               | {string:eq}(POST)                                                                                                         |
      | header.nva.1.name                                | {string:eq}(:path)                                                                                                        |
      | header.nva.1.value                               | {string:eq}(/127.0.0.1:12348/nudm-ueau/v1/incr(suci-0-001-01-0-0-0-9990000001,1)/security-information/generate-auth-data) |
      | header.nva.2.name                                | {string:eq}(content-type)                                                                                                 |
      | header.nva.2.value                               | {string:eq}(application/json)                                                                                             |
      | authentication_info_request.serving_network_name | {string:eq}(5G:mnc030.mcc404.3gppnetwork.org)                                                                             |
      | authentication_info_request.ausf_instance_id     | {string:eq}(44e57b64-9008-11ed-a1eb-0242ac120002)                                                                         |

    When I send HTTPV2 message HTTPV2_NUDM_UEAU_GEN_AUTH_DATA_RES_200 on interface N13 with the following details from node HSS_UDM1 to AUSF1:
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
      | authentication_info_result.supi                                                    | incr({abotprop.SUT.SUPI},1)                                      |
      | authentication_info_result.authentication_vector.av_5G_he_aka.seq_no               | {abotprop.SUT.5GAKA.SQN}                                         |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UEAU_GEN_AUTH_DATA_RES_200 on interface N13 with the following details on node AUSF1 from HSS_UDM1:
      | parameter                                                               | value                          |
      | header.nva.0.name                                                       | {string:eq}(:status)           |
      | header.nva.0.value                                                      | {string:eq}(200)               |
      | header.nva.1.name                                                       | {string:eq}(content-type)      |
      | header.nva.1.value                                                      | {string:eq}(application/json)  |
      | authentication_info_result.authentication_vector.av_5G_he_aka.av_type   | {string:eq}(5G_AKA)            |
      | authentication_info_result.authentication_vector.av_5G_he_aka.rand      | save(5G_AKA_RAND_AT_AUSF)      |
      | authentication_info_result.authentication_vector.av_5G_he_aka.autn      | save(5G_AKA_AUTN_AT_AUSF)      |
      | authentication_info_result.authentication_vector.av_5G_he_aka.xres_star | save(5G_AKA_XRES_STAR_AT_AUSF) |
      | authentication_info_result.authentication_vector.av_5G_he_aka.kausf     | save(5G_AKA_KAUSF_AT_AUSF)     |
      | authentication_info_result.supi                                         | save(SUPI)                     |

    When I send HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_AUTHENTICATE_RES_201 on interface N12 with the following details from node AUSF1 to AMF1:
      | parameter                                              | value                                                                                                               |
      | header.nva.0.name                                      | :status                                                                                                             |
      | header.nva.0.value                                     | 201                                                                                                                 |
      | header.nva.1.name                                      | location                                                                                                            |
      | header.nva.1.value                                     | /127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr(suci-0-001-01-0-0-0-9990000001,1)                            |
      | header.nva.2.name                                      | content-type                                                                                                        |
      | header.nva.2.value                                     | application/3gppHal+json                                                                                            |
      | ue_authentication_ctx.auth_type                        | 5G_AKA                                                                                                              |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.rand      | $(5G_AKA_RAND_AT_AUSF)                                                                                              |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.autn      | $(5G_AKA_AUTN_AT_AUSF)                                                                                              |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.hxresstar | 00000000000000000000000000000000                                                                                    |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.kSeaf     | 0000000000000000000000000000000000000000000000000000000000000000                                                    |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.xres_star | $(5G_AKA_XRES_STAR_AT_AUSF)                                                                                         |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.kausf     | $(5G_AKA_KAUSF_AT_AUSF)                                                                                             |
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
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.rand      | save(5G_AKA_RAND_AT_AMF)                                                                                                         |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.autn      | save(5G_AKA_AUTN_AT_AMF)                                                                                                         |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.hxresstar | save(5G_AKA_HXRES_STAR_AT_AMF)                                                                                                   |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.kSeaf     | save(5G_AKA_KSEAF_AT_AMF)                                                                                                        |
      | ue_authentication_ctx._links.linkname                  | {string:eq}(5g-aka)                                                                                                              |
      | ue_authentication_ctx._links.linkvalue.0.href          | {string:eq}(http://127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr(suci-0-001-01-0-0-0-9990000001,1)/5g-aka-confirmation)  |
      | ue_authentication_ctx._links.linkvalue.1.href          | {string:eq}(http://127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr(suci-0-001-01-0-0-0-9990000001,1)/5g-aka-confirmation2) |
      | ue_authentication_ctx.serving_network_name             | {string:eq}(5G:mnc030.mcc404.3gppnetwork.org)                                                                                    |

    When I send NGAP message NG_DOWNLINK_NAS_AUTHENTICATION_REQ on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                                    | value                                 |
      | amf_ue_ngap_id                                               | incr({abotprop.SUT.AMF.UE.NGAP.ID},1) |
      | ran_ue_ngap_id                                               | $(RAN_UE_NGAP_ID)                     |
      | nas_pdu.extended_protocol_discriminator                      | 126                                   |
      | nas_pdu.security_header_type                                 | 0x00                                  |
      | nas_pdu.message_type                                         | 0x56                                  |
      | nas_pdu.authentication_request.nas_key_set_identifier        | 0x00                                  |
      | nas_pdu.authentication_request.abba                          | 0x0000                                |
      | nas_pdu.authentication_request.authentication_parameter_autn | $(5G_AKA_AUTN_AT_AMF)                 |
      | nas_pdu.authentication_request.authentication_parameter_rand | $(5G_AKA_RAND_AT_AMF)                 |
      | nas_pdu.authentication_request.kseaf                         | $(5G_AKA_KSEAF_AT_AMF)                |
      | nas_pdu.authentication_request.supi                          | incr({abotprop.SUT.SUPI},1)           |

    Then I receive and validate NGAP message NG_DOWNLINK_NAS_AUTHENTICATION_REQ on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                                    | value                               |
      | amf_ue_ngap_id                                               | save(AMF_UE_NGAP_ID)                |
      | ran_ue_ngap_id                                               | save(RAN_UE_NGAP_ID)                |
      | nas_pdu.extended_protocol_discriminator                      | {string:eq}(126)                    |
      | nas_pdu.security_header_type                                 | {string:eq}(0x00)                   |
      | nas_pdu.message_type                                         | {string:eq}(0x56)                   |
      | nas_pdu.authentication_request.nas_key_set_identifier        | save(5G_NAS_KSI_AT_GNB)             |
      | nas_pdu.authentication_request.abba                          | {string:eq}(0x0000)                 |
      | nas_pdu.authentication_request.authentication_parameter_autn | save(5G_AKA_AUTN_AT_GNB)            |
      | nas_pdu.authentication_request.authentication_parameter_rand | save(5G_AKA_RAND_AT_GNB)            |
      | nas_pdu.authentication_request.K                             | 8BAF473F2F8FD09487CCCBD7097C6862    |
      | nas_pdu.authentication_request.OP                            | 1006020F0A478BF6B699F15C062E42B3    |
      | nas_pdu.authentication_request.supi                          | incr({abotprop.SUT.SUPI},1)         |
      | nas_pdu.authentication_request.serving_network_name          | {abotprop.SUT.SERVICE.NETWORK.NAME} |

    When I send NGAP message NG_UPLINK_NAS_AUTHENTICATION_RES on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                       | value                              |
      | amf_ue_ngap_id                                                                  | $(AMF_UE_NGAP_ID)                  |
      | ran_ue_ngap_id                                                                  | $(RAN_UE_NGAP_ID)                  |
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
      | parameter                                                                       | value                                    |
      | amf_ue_ngap_id                                                                  | save(AMF_UE_NGAP_ID)                     |
      | ran_ue_ngap_id                                                                  | {string:eq}($(RAN_UE_NGAP_ID))           |
      | nas_pdu.extended_protocol_discriminator                                         | {string:eq}(126)                         |
      | nas_pdu.security_header_type                                                    | {string:eq}(0x00)                        |
      | nas_pdu.message_type                                                            | {string:eq}(0x57)                        |
      | nas_pdu.authentication_response.authentication_response_parameter               | save(UE_5G_AKA_RES_STAR_AT_AMF)          |
      | nas_pdu.authentication_response.rand                                            | $(5G_AKA_RAND_AT_AMF)                    |
      | nas_pdu.authentication_response.hresstar                                        | {string:eq}($(5G_AKA_HXRES_STAR_AT_AMF)) |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {string:eq}(404)                         |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {string:eq}(30)                          |
      | user_location_information.nr_user_location_information.tai.tac                  | {string:eq}(0x000001)                    |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {string:eq}(404)                         |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {string:eq}(30)                          |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {string:eq}(3584)                        |

    When I send HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_5G_AKA_CONF_REQ on interface N12 with the following details from node AMF1 to AUSF1:
      | parameter                      | value                                                                                                        |
      | header.nva.0.name              | :method                                                                                                      |
      | header.nva.0.value             | PUT                                                                                                          |
      | header.nva.1.name              | :path                                                                                                        |
      | header.nva.1.value             | /127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr(suci-0-001-01-0-0-0-9990000001,1)/5g-aka-confirmation |
      | header.nva.2.name              | content-type                                                                                                 |
      | header.nva.2.value             | application/json                                                                                             |
      | confirmation_data.res_star     | $(UE_5G_AKA_RES_STAR_AT_AMF)                                                                                 |
      | confirmation_data.supi_or_suci | incr({abotprop.SUT.SUCI},1)                                                                                  |

    Then I receive and validate HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_5G_AKA_CONF_REQ on interface N12 with the following details on node AUSF1 from AMF1:
      | parameter                      | value                                                                                                                     |
      | header.nva.0.name              | {string:eq}(:method)                                                                                                      |
      | header.nva.0.value             | {string:eq}(PUT)                                                                                                          |
      | header.nva.1.name              | {string:eq}(:path)                                                                                                        |
      | header.nva.1.value             | {string:eq}(/127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr(suci-0-001-01-0-0-0-9990000001,1)/5g-aka-confirmation) |
      | header.nva.2.name              | {string:eq}(content-type)                                                                                                 |
      | header.nva.2.value             | {string:eq}(application/json)                                                                                             |
      | confirmation_data.res_star     | {string:eq}($(5G_AKA_XRES_STAR_AT_AUSF))                                                                                  |
      | confirmation_data.supi_or_suci | save(SUCI)                                                                                                                |

    When I send HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_5G_AKA_CONF_RES_200 on interface N12 with the following details from node AUSF1 to AMF1:
      | parameter                              | value                       |
      | header.nva.0.name                      | :status                     |
      | header.nva.0.value                     | 200                         |
      | header.nva.1.name                      | content-type                |
      | header.nva.1.value                     | application/json            |
      | confirmation_data_response.auth_result | AUTHENTICATION_SUCCESS      |
      | confirmation_data_response.supi        | incr({abotprop.SUT.SUPI},1) |

    Then I receive and validate HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_5G_AKA_CONF_RES_200 on interface N12 with the following details on node AMF1 from AUSF1:
      | parameter                              | value                               |
      | header.nva.0.name                      | {string:eq}(:status)                |
      | header.nva.0.value                     | {string:eq}(200)                    |
      | header.nva.1.name                      | {string:eq}(content-type)           |
      | header.nva.1.value                     | {string:eq}(application/json)       |
      | confirmation_data_response.auth_result | {string:eq}(AUTHENTICATION_SUCCESS) |
      | confirmation_data_response.supi        | save(SUPI)                          |

### Inform UE Successful Authorization to UDM

    When I send HTTPV2 message HTTPV2_NUDM_UEAU_CONF_AUTH_REQ on interface N13 with the following details from node AUSF1 to HSS_UDM1:
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

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UEAU_CONF_AUTH_REQ on interface N13 with the following details on node HSS_UDM1 from AUSF1:
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

    When I send HTTPV2 message HTTPV2_NUDM_UEAU_CONF_AUTH_RES_201 on interface N13 with the following details from node HSS_UDM1 to AUSF1:
      | parameter                 | value                                |
      | header.nva.0.name         | :status                              |
      | header.nva.0.value        | 201                                  |
      | header.nva.1.name         | content-type                         |
      | header.nva.1.value        | application/json                     |
      | auth_event.nf_instance_id | 2ad93f83-5736-4297-8e36-479248207076 |
      | auth_event.success        | true                                 |
      | auth_event.time_stamp     | 2020-02-24T17:00:22Z                 |
      | auth_event.auth_type      | 5G_AKA                               |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UEAU_CONF_AUTH_RES_201 on interface N13 with the following details on node AUSF1 from HSS_UDM1:
      | parameter                 | value                                             |
      | header.nva.0.name         | {string:eq}(:status)                              |
      | header.nva.0.value        | {string:eq}(201)                                  |
      | header.nva.1.name         | {string:eq}(content-type)                         |
      | header.nva.1.value        | {string:eq}(application/json)                     |
      | auth_event.nf_instance_id | {string:eq}(2ad93f83-5736-4297-8e36-479248207076) |
      | auth_event.success        | {string:eq}(true)                                 |
      | auth_event.time_stamp     | {string:eq}(2020-02-24T17:00:22Z)                 |
      | auth_event.auth_type      | {string:eq}(5G_AKA)                               |

### Get UE Slice Selection Subscription data (AMF to UDM : Get UE Subscribed NSSAI, followed by AMF to NSSF : Get AMF Set for NSSAI)
### 1. Get UE Slice Information (AMF to UDM : Get UE Subscribed NSSAI

    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIBED_NSSAI_GET_REQ on interface N8 with the following details from node AMF1 to HSS_UDM1:
      | parameter          | value                                                                                            |
      | header.nva.0.name  | :method                                                                                          |
      | header.nva.0.value | GET                                                                                              |
      | header.nva.1.name  | :path                                                                                            |
      | header.nva.1.value | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/nssai?plmn-id={"mcc":"404","mnc":"30"} |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIBED_NSSAI_GET_REQ on interface N8 with the following details on node HSS_UDM1 from AMF1:
      | parameter          | value                                                                                                         |
      | header.nva.0.name  | {string:eq}(:method)                                                                                          |
      | header.nva.0.value | {string:eq}(GET)                                                                                              |
      | header.nva.1.name  | {string:eq}(:path)                                                                                            |
      | header.nva.1.value | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/nssai?plmn-id={"mcc":"404","mnc":"30"}) |

    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIBED_NSSAI_GET_RES_200 on interface N8 with the following details from node HSS_UDM1 to AMF1:
      | parameter                                | value            |
      | header.nva.0.name                        | :status          |
      | header.nva.0.value                       | 200              |
      | header.nva.1.name                        | content-type     |
      | header.nva.1.value                       | application/json |
      | nssai.default_single_nssais.0.snssai.sst | 1                |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIBED_NSSAI_GET_RES_200 on interface N8 with the following details on node AMF1 from HSS_UDM1:
      | parameter                                | value                         |
      | header.nva.0.name                        | {string:eq}(:status)          |
      | header.nva.0.value                       | {string:eq}(200)              |
      | header.nva.1.name                        | {string:eq}(content-type)     |
      | header.nva.1.value                       | {string:eq}(application/json) |
      | nssai.default_single_nssais.0.snssai.sst | {string:eq}(1)                |

### 2. Get Target AMF Set for UE Subscribed Network Slice (AMF to NSSF x: Get AMF Set for NSSAI)

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
      | amf_ue_ngap_id                                       | $(AMF_UE_NGAP_ID) |
      | ran_ue_ngap_id                                       | $(RAN_UE_NGAP_ID) |
      | nas_pdu.extended_protocol_discriminator              | 126               |
      | nas_pdu.security_header_type                         | 0x03              |
      | nas_pdu.message_type                                 | 0x5d              |
      | nas_pdu.security_mode_command.nas_security_algorithm | 0x11              |
      | nas_pdu.security_mode_command.nas_key_set_identifier | 0x00              |
      | nas_pdu.security_mode_command.ue_security_capability | 0xc0c0            |

    Then I receive and validate NGAP message NG_DOWNLINK_NAS_SECURITY_MODE_CMD on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                            | value                          |
      | amf_ue_ngap_id                                       | {string:eq}($(AMF_UE_NGAP_ID)) |
      | ran_ue_ngap_id                                       | {string:eq}($(RAN_UE_NGAP_ID)) |
      | nas_pdu.extended_protocol_discriminator              | {string:eq}(126)               |
      | nas_pdu.security_header_type                         | {string:eq}(0x03)              |
      | nas_pdu.message_type                                 | {string:eq}(0x5d)              |
      | nas_pdu.security_mode_command.nas_security_algorithm | {string:eq}(0x11)              |
      | nas_pdu.security_mode_command.nas_key_set_identifier | {string:eq}(0x00)              |
      | nas_pdu.security_mode_command.ue_security_capability | {string:eq}(0xc0c0)            |

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

## UE 3GPP Access Registration : Register the new UE 3GPP Access with UDM (also register for Event Notification for UDM Deregistration of AMF)

    When I send HTTPV2 message HTTPV2_NUDM_UECM_3GPP_ACCESS_REGISTRATION_PUT_REQ on interface N8 with the following details from node AMF1 to HSS_UDM1:
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

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UECM_3GPP_ACCESS_REGISTRATION_PUT_REQ on interface N8 with the following details on node HSS_UDM1 from AMF1:
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

    When I send HTTPV2 message HTTPV2_NUDM_UECM_3GPP_ACCESS_REGISTRATION_PUT_RES_201 on interface N8 with the following details from node HSS_UDM1 to AMF1:
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

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UECM_3GPP_ACCESS_REGISTRATION_PUT_RES_201 on interface N8 with the following details on node AMF1 from HSS_UDM1:
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

## Get AM Subscription & SMF Selection : Get UE AM Subscription Data. Get SMF Selection and Subscription Data and UE Context in SMF Data

    When I send HTTPV2 message HTTPV2_NUDM_SDM_GET_REQ on interface N8 with the following details from node AMF1 to HSS_UDM1:
      | parameter          | value                                                                                                               |
      | header.nva.0.name  | :method                                                                                                             |
      | header.nva.0.value | GET                                                                                                                 |
      | header.nva.1.name  | :path                                                                                                               |
      | header.nva.1.value | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)?dataset-names=AM,SMF_SEL&plmn-id={"mcc":"404","mnc":"30"} |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_GET_REQ on interface N8 with the following details on node HSS_UDM1 from AMF1:
      | parameter          | value                                                                                                                            |
      | header.nva.0.name  | {string:eq}(:method)                                                                                                             |
      | header.nva.0.value | {string:eq}(GET)                                                                                                                 |
      | header.nva.1.name  | {string:eq}(:path)                                                                                                               |
      | header.nva.1.value | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)?dataset-names=AM,SMF_SEL&plmn-id={"mcc":"404","mnc":"30"}) |

    When I send HTTPV2 message HTTPV2_NUDM_SDM_GET_RES_200 on interface N8 with the following details from node HSS_UDM1 to AMF1:
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

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_GET_RES_200 on interface N8 with the following details on node AMF1 from HSS_UDM1:
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

## Subscribe to UDM for UE Subscription Data change/update Notification

    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_REQ on interface N8 with the following details from node AMF1 to HSS_UDM1:
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

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_REQ on interface N8 with the following details on node HSS_UDM1 from AMF1:
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

    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_RES_201 on interface N8 with the following details from node HSS_UDM1 to AMF1:
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

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_RES_201 on interface N8 with the following details on node AMF1 from HSS_UDM1:
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


## AM Policy Association (AMF to PCF : Setup AM Policy Association for the UE with PCF for Access & Mobility control)

    When I send HTTPV2 message HTTPV2_NPCFAM_POLICY_CONTROL_CREATE_POST_REQ on interface N15 with the following details from node AMF1 to PCRF_PCF1:
      | parameter                                   | value                                                      |
      | header.nva.0.name                           | :method                                                    |
      | header.nva.0.value                          | POST                                                       |
      | header.nva.1.name                           | :path                                                      |
      | header.nva.1.value                          | /127.0.0.1:12348/npcf-am-policy-control/v1/policies        |
      | header.nva.2.name                           | content-type                                               |
      | header.nva.2.value                          | application/json                                           |
      | policy_association_request.notification_uri | /127.0.0.1:12348/npcf-am-policy-control/v1/policies/amPol1 |
      | policy_association_request.supi             | incr({abotprop.SUT.SUPI},1)                                |
      | policy_association_request.supp_feat        | SupportFeatureVersion1                                     |

    Then I receive and validate HTTPV2 message HTTPV2_NPCFAM_POLICY_CONTROL_CREATE_POST_REQ on interface N15 with the following details on node PCRF_PCF1 from AMF1:
      | parameter                                   | value                                                                   |
      | header.nva.0.name                           | {string:eq}(:method)                                                    |
      | header.nva.0.value                          | {string:eq}(POST)                                                       |
      | header.nva.1.name                           | {string:eq}(:path)                                                      |
      | header.nva.1.value                          | {string:eq}(/127.0.0.1:12348/npcf-am-policy-control/v1/policies)        |
      | header.nva.2.name                           | {string:eq}(content-type)                                               |
      | header.nva.2.value                          | {string:eq}(application/json)                                           |
      | policy_association_request.notification_uri | {string:eq}(/127.0.0.1:12348/npcf-am-policy-control/v1/policies/amPol1) |
      | policy_association_request.supi             | save(SUPI)                                                              |
      | policy_association_request.supp_feat        | {string:eq}(SupportFeatureVersion1)                                     |

    When I send HTTPV2 message HTTPV2_NPCFAM_POLICY_CONTROL_CREATE_POST_RES_201 on interface N15 with the following details from node PCRF_PCF1 to AMF1:
      | parameter                    | value                                                      |
      | header.nva.0.name            | :status                                                    |
      | header.nva.0.value           | 201                                                        |
      | header.nva.1.name            | location                                                   |
      | header.nva.1.value           | /127.0.0.1:12348/npcf-am-policy-control/v1/policies/amPol1 |
      | header.nva.2.name            | content-type                                               |
      | header.nva.2.value           | application/json                                           |
      | policy_association.supp_feat | SupportFeatureVersion1                                     |

    Then I receive and validate HTTPV2 message HTTPV2_NPCFAM_POLICY_CONTROL_CREATE_POST_RES_201 on interface N15 with the following details on node AMF1 from PCRF_PCF1:
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
      | amf_ue_ngap_id                                                                                  | $(AMF_UE_NGAP_ID)                                                |
      | ran_ue_ngap_id                                                                                  | $(RAN_UE_NGAP_ID)                                                |
      | nas_pdu.extended_protocol_discriminator                                                         | 126                                                              |
      | nas_pdu.security_header_type                                                                    | 0x03                                                             |
      | nas_pdu.message_type                                                                            | 0x42                                                             |
      | nas_pdu.registration_accept.5gs_reg_result                                                      | 9                                                                |
      | nas_pdu.registration_accept.5gs_network_feature_support                                         | 0x4d00                                                           |
      #| nas_pdu.registration_accept.5gs_mobile_identity                                                 | 0xf204043001004100000001                                         |
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
      | ran_ue_ngap_id                                                                                  | {string:eq}($(RAN_UE_NGAP_ID))                                                |
      | nas_pdu.extended_protocol_discriminator                                                         | {string:eq}(126)                                                              |
      | nas_pdu.security_header_type                                                                    | {string:eq}(0x03)                                                             |
      | nas_pdu.message_type                                                                            | {string:eq}(0x42)                                                             |
      | nas_pdu.registration_accept.5gs_reg_result                                                      | {string:eq}(9)                                                                |
      | nas_pdu.registration_accept.5gs_network_feature_support                                         | {string:eq}(0x4d00)                                                           |
      #| nas_pdu.registration_accept.5gs_mobile_identity                                                 | {string:eq}(0xf204043001004100000001)                                         |
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
      | parameter      | value             |
      | amf_ue_ngap_id | $(AMF_UE_NGAP_ID) |
      | ran_ue_ngap_id | $(RAN_UE_NGAP_ID) |

    Then I receive and validate NGAP message NG_INIT_CTXT_SET_RES on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter      | value                          |
      | amf_ue_ngap_id | {string:eq}($(AMF_UE_NGAP_ID)) |
      | ran_ue_ngap_id | {string:eq}($(RAN_UE_NGAP_ID)) |

    When I send NGAP message NG_UPLINK_NAS_REGIS_COMPLETE on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                       | value             |
      | amf_ue_ngap_id                                                                  | $(AMF_UE_NGAP_ID) |
      | ran_ue_ngap_id                                                                  | $(RAN_UE_NGAP_ID) |
      | nas_pdu.extended_protocol_discriminator                                         | 126               |
      | nas_pdu.security_header_type                                                    | 0x03              |
      | nas_pdu.message_type                                                            | 0x43              |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | 404               |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | 30                |
      | user_location_information.nr_user_location_information.tai.tac                  | 0x000001          |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | 404               |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | 30                |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | 3584              |

    Then I receive and validate NGAP message NG_UPLINK_NAS_REGIS_COMPLETE on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                       | value                          |
      | amf_ue_ngap_id                                                                  | {string:eq}($(AMF_UE_NGAP_ID)) |
      | ran_ue_ngap_id                                                                  | {string:eq}($(RAN_UE_NGAP_ID)) |
      | nas_pdu.extended_protocol_discriminator                                         | {string:eq}(126)               |
      | nas_pdu.security_header_type                                                    | {string:eq}(0x03)              |
      | nas_pdu.message_type                                                            | {string:eq}(0x43)              |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {string:eq}(404)               |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {string:eq}(30)                |
      | user_location_information.nr_user_location_information.tai.tac                  | {string:eq}(0x000001)          |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {string:eq}(404)               |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {string:eq}(30)                |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {string:eq}(3584)              |

### N2 - PDU Session Establishment (gNodeB to AMF : UE Initiated Single PDU Session Establishment Request)

    When I send NGAP message NG_UPLINK_NAS_UL_NAS_TRANS_PDU_SESS_ESTAB_REQ on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                               | value                                          |
      | amf_ue_ngap_id                                                                                                                          | $(AMF_UE_NGAP_ID)                              |
      | ran_ue_ngap_id                                                                                                                          | $(RAN_UE_NGAP_ID)                              |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                                                            | 404                                            |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                                                            | 30                                             |
      | user_location_information.nr_user_location_information.tai.tac                                                                          | 0x100101                                       |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                                                         | 404                                            |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                                                         | 30                                             |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                                                          | 3584                                           |
      | nas_pdu.extended_protocol_discriminator                                                                                                 | 126                                            |
      | nas_pdu.security_header_type                                                                                                            | 0x00                                           |
      | nas_pdu.message_type                                                                                                                    | 0x67                                           |
      | nas_pdu.ul_nas_transport.pdu_session_identity                                                                                           | 0x1206                                         |
      | nas_pdu.ul_nas_transport.request_type                                                                                                   | 0x81                                           |
      | nas_pdu.ul_nas_transport.snssai                                                                                                         | 0x01                                           |
      | nas_pdu.ul_nas_transport.dnn                                                                                                            | internet.apn.5gs.mnc030.mcc404.3gppnetwork.org |
      | nas_pdu.ul_nas_transport.payload_container_type                                                                                         | 0x01                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator              | 0x2e                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                               | 0x06                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                                          | 0x01                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                                 | 0xc1                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_req.int_protect_max_data_rate | 0xffff                                         |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_req.pdu_sess_type             | 0x91                                           |

    Then I receive and validate NGAP message NG_UPLINK_NAS_UL_NAS_TRANS_PDU_SESS_ESTAB_REQ on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                                                               | value                                                       |
      | amf_ue_ngap_id                                                                                                                          | {string:eq}($(AMF_UE_NGAP_ID))                              |
      | ran_ue_ngap_id                                                                                                                          | {string:eq}($(RAN_UE_NGAP_ID))                              |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                                                            | {string:eq}(404)                                            |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                                                            | {string:eq}(30)                                             |
      | user_location_information.nr_user_location_information.tai.tac                                                                          | {string:eq}(0x100101)                                       |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                                                         | {string:eq}(404)                                            |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                                                         | {string:eq}(30)                                             |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                                                          | {string:eq}(3584)                                           |
      | nas_pdu.extended_protocol_discriminator                                                                                                 | {string:eq}(126)                                            |
      | nas_pdu.security_header_type                                                                                                            | {string:eq}(0x00)                                           |
      | nas_pdu.message_type                                                                                                                    | {string:eq}(0x67)                                           |
      | nas_pdu.ul_nas_transport.pdu_session_identity                                                                                           | {string:eq}(0x1206)                                         |
      | nas_pdu.ul_nas_transport.request_type                                                                                                   | {string:eq}(0x81)                                           |
      | nas_pdu.ul_nas_transport.snssai                                                                                                         | {string:eq}(0x01)                                           |
      | nas_pdu.ul_nas_transport.dnn                                                                                                            | {string:eq}(internet.apn.5gs.mnc030.mcc404.3gppnetwork.org) |
      | nas_pdu.ul_nas_transport.payload_container_type                                                                                         | {string:eq}(0x01)                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator              | {string:eq}(0x2e)                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                               | {string:eq}(0x06)                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                                          | {string:eq}(0x01)                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                                 | {string:eq}(0xc1)                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_req.int_protect_max_data_rate | {string:eq}(0xffff)                                         |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_req.pdu_sess_type             | {string:eq}(0x91)                                           |

### N11 - Create PDU Session Context (AMF to SMF - Initite PDU Session Establishment and PDU Session Context Creation)

    When I send HTTPV2 message HTTPV2_NSMF_CREATE_SM_CONTEXT_REQ on interface N11 with the following details from node AMF1 to SPGWC_SMF1:
      | parameter                                                                                                   | value                                                                                                        |
      | header.nva.0.name                                                                                           | :method                                                                                                      |
      | header.nva.0.value                                                                                          | POST                                                                                                         |
      | header.nva.1.name                                                                                           | :path                                                                                                        |
      | header.nva.1.value                                                                                          | /127.0.0.1:12349/nsmf-pdusession/v1/sm-contexts                                                              |
      | header.nva.2.name                                                                                           | content-type                                                                                                 |
      | header.nva.2.value                                                                                          | multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json                      |
      | multipart_related.json_data.content_type                                                                    | application/json                                                                                             |
      | multipart_related.json_data.content_id                                                                      | sm-context-create-data                                                                                       |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.plmn_id.mcc                 | 404                                                                                                          |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.plmn_id.mnc                 | 30                                                                                                           |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.nr_cell_id                  | 1602                                                                                                         |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.plmn_id.mcc                  | 404                                                                                                          |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.plmn_id.mnc                  | 30                                                                                                           |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.tac                          | 2                                                                                                            |
      | multipart_related.json_data.sm_context_create_data.sm_context_status_uri                                    | /$({abotprop.AMF1.SecureShell.IPAddress}):$({abotprop.AMF1.N11.Server.Port})/v1/sm-contexts/smctx-1/status/6 |
      | multipart_related.json_data.sm_context_create_data.gpsi                                                     | msisdn-987654321                                                                                             |
      | multipart_related.json_data.sm_context_create_data.pdu_session_id                                           | 6                                                                                                            |
      | multipart_related.json_data.sm_context_create_data.n1_sm_msg.content_id                                     | n1-pdu-session-establishment-request                                                                         |
      | multipart_related.json_data.sm_context_create_data.an_type                                                  | 3GPP_ACCESS                                                                                                  |
      | multipart_related.json_data.sm_context_create_data.supi                                                     | incr({abotprop.SUT.SUPI},1)                                                                                  |
      | multipart_related.json_data.sm_context_create_data.s_nssai.sst                                              | 1                                                                                                            |
      | multipart_related.json_data.sm_context_create_data.serving_nf_id                                            | 0330940e-8a4f-4b63-98d8-03628f717df3                                                                         |
      | multipart_related.json_data.sm_context_create_data.pei                                                      | incr({abotprop.SUT.PEI},1)                                                                                   |
      | multipart_related.json_data.sm_context_create_data.request_type                                             | INITIAL_REQUEST                                                                                              |
      | multipart_related.json_data.sm_context_create_data.dnn                                                      | internet.apn.5gs.mnc030.mcc404.3gppnetwork.org                                                               |
      | multipart_related.json_data.sm_context_create_data.guami.plmn_id.mcc                                        | 404                                                                                                          |
      | multipart_related.json_data.sm_context_create_data.guami.plmn_id.mnc                                        | 30                                                                                                           |
      | multipart_related.json_data.sm_context_create_data.guami.amf_id                                             | 010041                                                                                                       |
      | multipart_related.json_data.sm_context_create_data.serving_network.mcc                                      | 404                                                                                                          |
      | multipart_related.json_data.sm_context_create_data.serving_network.mnc                                      | 30                                                                                                           |
      | multipart_related.json_data.sm_context_create_data.pdu_sessions_activate_list.0.pdu_session_id              | 6                                                                                                            |
      | multipart_related.binary_data_n1_sm_message.content_type                                                    | application/vnd.3gpp.5gnas                                                                                   |
      | multipart_related.binary_data_n1_sm_message.content_id                                                      | n1-pdu-session-establishment-request                                                                         |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator              | 0x2e                                                                                                         |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                               | 0x06                                                                                                         |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                                          | 0x01                                                                                                         |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                                 | 0xc1                                                                                                         |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_estab_req.int_protect_max_data_rate | 0xffff                                                                                                       |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_estab_req.pdu_sess_type             | 0x91                                                                                                         |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_CREATE_SM_CONTEXT_REQ on interface N11 with the following details on node SPGWC_SMF1 from AMF1:
      | parameter                                                                                                   | value                                                                                                |
      | header.nva.0.name                                                                                           | {string:eq}(content-type)                                                                            |
      | header.nva.0.value                                                                                          | {string:eq}(multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json) |
      | multipart_related.json_data.content_type                                                                    | {string:eq}(application/json)                                                                        |
      | multipart_related.json_data.content_id                                                                      | {string:eq}(sm-context-create-data)                                                                  |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.plmn_id.mcc                 | {string:eq}(404)                                                                                     |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.plmn_id.mnc                 | {string:eq}(30)                                                                                      |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.nr_cell_id                  | {string:eq}(1602)                                                                                    |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.plmn_id.mcc                  | {string:eq}(404)                                                                                     |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.plmn_id.mnc                  | {string:eq}(30)                                                                                      |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.tac                          | {string:eq}(2)                                                                                       |
      | multipart_related.json_data.sm_context_create_data.sm_context_status_uri                                    | save(SM_CTXT_STATUS_URI_AT_SPGWC_SMF)                                                                |
      | multipart_related.json_data.sm_context_create_data.gpsi                                                     | {string:eq}(msisdn-987654321)                                                                        |
      | multipart_related.json_data.sm_context_create_data.pdu_session_id                                           | {string:eq}(6)                                                                                       |
      | multipart_related.json_data.sm_context_create_data.n1_sm_msg.content_id                                     | {string:eq}(n1-pdu-session-establishment-request)                                                    |
      | multipart_related.json_data.sm_context_create_data.an_type                                                  | {string:eq}(3GPP_ACCESS)                                                                             |
      | multipart_related.json_data.sm_context_create_data.supi                                                     | save(SUPI)                                                                                           |
      | multipart_related.json_data.sm_context_create_data.s_nssai.sst                                              | {string:eq}(1)                                                                                       |
      | multipart_related.json_data.sm_context_create_data.serving_nf_id                                            | {string:eq}(0330940e-8a4f-4b63-98d8-03628f717df3)                                                    |
      | multipart_related.json_data.sm_context_create_data.pei                                                      | save(PEI)                                                                                            |
      | multipart_related.json_data.sm_context_create_data.request_type                                             | {string:eq}(INITIAL_REQUEST)                                                                         |
      | multipart_related.json_data.sm_context_create_data.dnn                                                      | {string:eq}(internet.apn.5gs.mnc030.mcc404.3gppnetwork.org)                                          |
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

### SMF to UDM - UE PDU Session Registration

    When I send HTTPV2 message HTTPV2_NUDM_UECM_SMF_REG_PUT_REQ on interface N10 with the following details from node SPGWC_SMF1 to HSS_UDM1:
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

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UECM_SMF_REG_PUT_REQ on interface N10 with the following details on node HSS_UDM1 from SPGWC_SMF1:
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

    When I send HTTPV2 message HTTPV2_NUDM_UECM_SMF_REG_PUT_RES_201 on interface N10 with the following details from node HSS_UDM1 to SPGWC_SMF1:
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

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UECM_SMF_REG_PUT_RES_201 on interface N10 with the following details on node SPGWC_SMF1 from HSS_UDM1:
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

    When I send HTTPV2 message HTTPV2_NSMF_CREATE_SM_CONTEXT_RES_201 on interface N11 with the following details from node SPGWC_SMF1 to AMF1:
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

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_CREATE_SM_CONTEXT_RES_201 on interface N11 with the following details on node AMF1 from SPGWC_SMF1:
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


## SM Policy Association for New PDU Session (SMF to PCF : Setup SM Policy Association for the UE with PCF for Session Management control)

    When I send HTTPV2 message HTTPV2_NPCFSM_POLICY_CONTROL_CREATE_POST_REQ on interface N7 with the following details from node SPGWC_SMF1 to PCRF_PCF1:
      | parameter                               | value                                                           |
      | header.nva.0.name                       | :method                                                         |
      | header.nva.0.value                      | POST                                                            |
      | header.nva.1.name                       | :path                                                           |
      | header.nva.1.value                      | /127.0.0.1:12348/npcf-smpolicycontrol/v1/sm-policies            |
      | header.nva.2.name                       | content-type                                                    |
      | header.nva.2.value                      | application/json                                                |
      | sm_policy_context_data.supi             | incr({abotprop.SUT.SUPI},1)                                     |
      | sm_policy_context_data.pdu_session_id   | 6                                                               |
      | sm_policy_context_data.pdu_session_type | 0                                                               |
      | sm_policy_context_data.dnn              | internet.apn.5gs.mnc030.mcc404.3gppnetwork.org                  |
      | sm_policy_context_data.notification_uri | /192.168.40.150:5341/npcf-smpolicycontrol/v1/sm-policies/smPol1 |
      | sm_policy_context_data.slice_info.sst   | 1                                                               |

    Then I receive and validate HTTPV2 message HTTPV2_NPCFSM_POLICY_CONTROL_CREATE_POST_REQ on interface N7 with the following details on node PCRF_PCF1 from SPGWC_SMF1:
      | parameter                               | value                                                                        |
      | header.nva.0.name                       | {string:eq}(:method)                                                         |
      | header.nva.0.value                      | {string:eq}(POST)                                                            |
      | header.nva.1.name                       | {string:eq}(:path)                                                           |
      | header.nva.1.value                      | {string:eq}(/127.0.0.1:12348/npcf-smpolicycontrol/v1/sm-policies)            |
      | header.nva.2.name                       | {string:eq}(content-type)                                                    |
      | header.nva.2.value                      | {string:eq}(application/json)                                                |
      | sm_policy_context_data.supi             | save(SUPI)                                                                   |
      | sm_policy_context_data.pdu_session_id   | {string:eq}(6)                                                               |
      | sm_policy_context_data.pdu_session_type | {string:eq}(0)                                                               |
      | sm_policy_context_data.dnn              | {string:eq}(internet.apn.5gs.mnc030.mcc404.3gppnetwork.org)                  |
      | sm_policy_context_data.notification_uri | {string:eq}(/192.168.40.150:5341/npcf-smpolicycontrol/v1/sm-policies/smPol1) |
      | sm_policy_context_data.slice_info.sst   | {string:eq}(1)                                                               |



## PCF Get UE SM Policy (PCF to UDR : Get Session Management Policy Data of UE from UDR)

    When I send HTTPV2 message HTTPV2_NUDRPDADED_DATA_REPOSITORY_POLICY_DATA_SM_DATA_GET_REQ on interface N36 with the following details from node PCRF_PCF1 to UDR1:
      | parameter          | value                                                                                                                                                |
      | header.nva.0.name  | :method                                                                                                                                              |
      | header.nva.0.value | GET                                                                                                                                                  |
      | header.nva.1.name  | :path                                                                                                                                                |
      | header.nva.1.value | /127.0.0.1:12348/nudr-dr/v2/policy-data/ues/incr(imsi-404309990000001,1)/sm-data?snssai={"sst":1}&dnn=internet.apn.5gs.mnc030.mcc404.3gppnetwork.org |

    Then I receive and validate HTTPV2 message HTTPV2_NUDRPDADED_DATA_REPOSITORY_POLICY_DATA_SM_DATA_GET_REQ on interface N36 with the following details on node UDR1 from PCRF_PCF1:
      | parameter          | value                                                                                                                                                             |
      | header.nva.0.name  | {string:eq}(:method)                                                                                                                                              |
      | header.nva.0.value | {string:eq}(GET)                                                                                                                                                  |
      | header.nva.1.name  | {string:eq}(:path)                                                                                                                                                |
      | header.nva.1.value | {string:eq}(/127.0.0.1:12348/nudr-dr/v2/policy-data/ues/incr(imsi-404309990000001,1)/sm-data?snssai={"sst":1}&dnn=internet.apn.5gs.mnc030.mcc404.3gppnetwork.org) |

    When I send HTTPV2 message HTTPV2_NUDRPDADED_DATA_REPOSITORY_POLICY_DATA_SM_DATA_GET_RES_200 on interface N36 with the following details from node UDR1 to PCRF_PCF1:
      | parameter                                                                                                                                                                                         | value                                          |
      | header.nva.0.name                                                                                                                                                                                 | :status                                        |
      | header.nva.0.value                                                                                                                                                                                | 200                                            |
      | header.nva.1.name                                                                                                                                                                                 | content-type                                   |
      | header.nva.1.value                                                                                                                                                                                | application/json                               |
      | sm_policy_data.sm_policy_snssai_data.sst1.snssai.sst                                                                                                                                              | 1                                              |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.dnn                                                                                   | internet.apn.5gs.mnc030.mcc404.3gppnetwork.org |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.allowed_services.0.allowed_service                                                    | Service1                                       |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.allowed_services.1.allowed_service                                                    | Service2                                       |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.subsc_cats.0.subsc_cat                                                                | SubscriberCategory1                            |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.subsc_cats.1.subsc_cat                                                                | SubscriberCategory2                            |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.gbr_ul                                                                                | 10000 Kbps                                     |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.gbr_dl                                                                                | 5000 Kbps                                      |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.adc_support                                                                           | true                                           |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.subsc_spending_limits                                                                 | true                                           |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.ipv4_index                                                                            | 0                                              |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.ipv6_index                                                                            | 0                                              |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.offline                                                                               | true                                           |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.online                                                                                | false                                          |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.chf_info.primary_chf_address                                                          | 1.1.1.1                                        |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.chf_info.secondary_chf_address                                                        | 2.2.2.2                                        |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.ref_um_data_limit_ids.refumdatalimitid1.limit_id                                      | refumdatalimitid1                              |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.ref_um_data_limit_ids.refumdatalimitid1.mon_key.0.mon_key_item                        | umdatamonitorkey1                              |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.mps_priority                                                                          | true                                           |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.mcs_priority                                                                          | true                                           |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.ims_signalling_prio                                                                   | true                                           |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.mps_priority_level                                                                    | 1                                              |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.mcs_priority_level                                                                    | 2                                              |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.pra_infos.prainfoid1.pra_id                                                           | prainfoid1                                     |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.pra_infos.prainfoid1.presence_state                                                   | IN_AREA                                        |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.pra_infos.prainfoid1.tracking_area_list.0.tai.plmn_id.mcc                             | 404                                            |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.pra_infos.prainfoid1.tracking_area_list.0.tai.plmn_id.mnc                             | 30                                             |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.pra_infos.prainfoid1.tracking_area_list.0.tai.tac                                     | 000001                                         |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.pra_infos.prainfoid1.ecgi_list.0.ecgi.plmn_id.mcc                                     | 404                                            |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.pra_infos.prainfoid1.ecgi_list.0.ecgi.plmn_id.mnc                                     | 30                                             |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.pra_infos.prainfoid1.ecgi_list.0.ecgi.eutra_cell_id                                   | 0000001                                        |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.pra_infos.prainfoid1.ncgi_list.0.ncgi.plmn_id.mcc                                     | 404                                            |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.pra_infos.prainfoid1.ncgi_list.0.ncgi.plmn_id.mnc                                     | 30                                             |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.pra_infos.prainfoid1.ncgi_list.0.ncgi.nr_cell_id                                      | 0000001                                        |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.pra_infos.prainfoid1.global_ran_node_id_list.0.global_ran_node_id.plmn_id.mcc         | 404                                            |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.pra_infos.prainfoid1.global_ran_node_id_list.0.global_ran_node_id.plmn_id.mnc         | 30                                             |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.pra_infos.prainfoid1.global_ran_node_id_list.0.global_ran_node_id.g_nb_id.bit_length  | 32                                             |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.pra_infos.prainfoid1.global_ran_node_id_list.0.global_ran_node_id.g_nb_id.g_n_b_value | 123456                                         |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.pra_infos.prainfoid1.globale_nb_id_list.0.global_ran_node_id.plmn_id.mcc              | 404                                            |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.pra_infos.prainfoid1.globale_nb_id_list.0.global_ran_node_id.plmn_id.mnc              | 30                                             |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.pra_infos.prainfoid1.globale_nb_id_list.0.global_ran_node_id.g_nb_id.bit_length       | 32                                             |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.pra_infos.prainfoid1.globale_nb_id_list.0.global_ran_node_id.g_nb_id.g_n_b_value      | 123456                                         |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.bdt_ref_ids.bdtrefid1                                                                 | BackgroundDataTransferPolicy1                  |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.loc_rout_not_allowed                                                                  | true                                           |
      | sm_policy_data.um_data_limits.umdatamonitorkey1.limit_id                                                                                                                                          | umdatamonitorkey1                              |
      | sm_policy_data.um_data_limits.umdatamonitorkey1.scopes.sst1.snssai.sst                                                                                                                            | 1                                              |
      | sm_policy_data.um_data_limits.umdatamonitorkey1.scopes.sst1.dnn.0.dnn_item                                                                                                                        | internet.apn.5gs.mnc030.mcc404.3gppnetwork.org |
      | sm_policy_data.um_data_limits.umdatamonitorkey1.um_level                                                                                                                                          | SESSION_LEVEL                                  |
      | sm_policy_data.um_data_limits.umdatamonitorkey1.start_date                                                                                                                                        | 2021-01-01T01:01:01.001Z                       |
      | sm_policy_data.um_data_limits.umdatamonitorkey1.end_date                                                                                                                                          | 2021-12-31T01:01:01.001Z                       |
      | sm_policy_data.um_data_limits.umdatamonitorkey1.usage_limit.duration                                                                                                                              | 5000                                           |
      | sm_policy_data.um_data_limits.umdatamonitorkey1.usage_limit.total_volume                                                                                                                          | 16000                                          |
      | sm_policy_data.um_data_limits.umdatamonitorkey1.usage_limit.downlink_volume                                                                                                                       | 10000                                          |
      | sm_policy_data.um_data_limits.umdatamonitorkey1.usage_limit.uplink_volume                                                                                                                         | 6000                                           |
      | sm_policy_data.um_data_limits.umdatamonitorkey1.reset_period.period                                                                                                                               | MONTHLY                                        |
      | sm_policy_data.um_data_limits.umdatamonitorkey1.reset_period.max_num_period                                                                                                                       | 3                                              |
      | sm_policy_data.um_data.umdatamonitorkey1.limit_id                                                                                                                                                 | umdatamonitorkey1                              |
      | sm_policy_data.um_data.umdatamonitorkey1.scopes.sst1.snssai.sst                                                                                                                                   | 1                                              |
      | sm_policy_data.um_data.umdatamonitorkey1.scopes.sst1.dnn.0.dnn_item                                                                                                                               | internet.apn.5gs.mnc030.mcc404.3gppnetwork.org |
      | sm_policy_data.um_data.umdatamonitorkey1.um_level                                                                                                                                                 | SESSION_LEVEL                                  |
      | sm_policy_data.um_data.umdatamonitorkey1.allowed_usage.duration                                                                                                                                   | 12000                                          |
      | sm_policy_data.um_data.umdatamonitorkey1.allowed_usage.total_volume                                                                                                                               | 30000                                          |
      | sm_policy_data.um_data.umdatamonitorkey1.allowed_usage.downlink_volume                                                                                                                            | 20000                                          |
      | sm_policy_data.um_data.umdatamonitorkey1.allowed_usage.uplink_volume                                                                                                                              | 10000                                          |
      | sm_policy_data.um_data.umdatamonitorkey1.reset_time                                                                                                                                               | 2021-04-01T01:01:01.001Z                       |

    Then I receive and validate HTTPV2 message HTTPV2_NUDRPDADED_DATA_REPOSITORY_POLICY_DATA_SM_DATA_GET_RES_200 on interface N36 with the following details on node PCRF_PCF1 from UDR1:
      | parameter                                                                                                       | value                                                       |
      | header.nva.0.name                                                                                               | {string:eq}(:status)                                        |
      | header.nva.0.value                                                                                              | {string:eq}(200)                                            |
      | header.nva.1.name                                                                                               | {string:eq}(content-type)                                   |
      | header.nva.1.value                                                                                              | {string:eq}(application/json)                               |
      | sm_policy_data.sm_policy_snssai_data.sst1.snssai.sst                                                            | {string:eq}(1)                                              |
      | sm_policy_data.sm_policy_snssai_data.sst1.sm_policy_dnn_data.internet.apn.5gs.mnc030.mcc404.3gppnetwork.org.dnn | {string:eq}(internet.apn.5gs.mnc030.mcc404.3gppnetwork.org) |
      | sm_policy_data.um_data_limits.umdatamonitorkey1.limit_id                                                        | {string:eq}(umdatamonitorkey1)                              |
      | sm_policy_data.um_data.umdatamonitorkey1.limit_id                                                               | {string:eq}(umdatamonitorkey1)                              |




    When I send HTTPV2 message HTTPV2_NPCFSM_POLICY_CONTROL_CREATE_POST_RES_201 on interface N7 with the following details from node PCRF_PCF1 to SPGWC_SMF1:
      | parameter                                                                                                | value                                                                         |
      | header.nva.0.name                                                                                        | :status                                                                       |
      | header.nva.0.value                                                                                       | 201                                                                           |
      | header.nva.1.name                                                                                        | location                                                                      |
      | header.nva.1.value                                                                                       | /127.0.0.1:12348/npcf-smpolicycontrol/v1/sm-policies/smPol1                   |
      | header.nva.2.name                                                                                        | content-type                                                                  |
      | header.nva.2.value                                                                                       | application/json                                                              |
      | sm_policy_decision.pcscf_rest_indication                                                                 | false                                                                         |
      | sm_policy_decision.reflective_qos_timer                                                                  | 3600                                                                          |
      | sm_policy_decision.revalidation_time                                                                     | 2021-05-01T01:01:01.001Z                                                      |
      | sm_policy_decision.offline                                                                               | true                                                                          |
      | sm_policy_decision.online                                                                                | false                                                                         |
      | sm_policy_decision.ipv4_index                                                                            | 0                                                                             |
      | sm_policy_decision.ipv6_index                                                                            | 0                                                                             |
      | sm_policy_decision.qos_flow_usage                                                                        | GENERAL                                                                       |
      | sm_policy_decision.supp_feat                                                                             | aabbccdd                                                                      |
      | sm_policy_decision.policy_ctrl_req_triggers.0.policy_ctrl_req_trigger                                    | US_RE                                                                         |
      | sm_policy_decision.pcc_rules.pccruleid1.pcc_rule_id                                                      | pccruleid1                                                                    |
      | sm_policy_decision.pcc_rules.pccruleid1.flow_infos.0.flow_information.flow_description                   | permit out 17 from 43.225.55.127/16 {7000-8000} to 172.16.0.10/16 {5000-6000} |
      | sm_policy_decision.pcc_rules.pccruleid1.flow_infos.0.flow_information.pack_filt_id                       | packetfilterid1                                                               |
      | sm_policy_decision.pcc_rules.pccruleid1.flow_infos.0.flow_information.packet_filter_usage                | true                                                                          |
      | sm_policy_decision.pcc_rules.pccruleid1.flow_infos.0.flow_information.tos_traffic_class                  | 0                                                                             |
      | sm_policy_decision.pcc_rules.pccruleid1.flow_infos.0.flow_information.flow_direction                     | BIDIRECTIONAL                                                                 |
      | sm_policy_decision.pcc_rules.pccruleid1.app_id                                                           | applicationid1                                                                |
      | sm_policy_decision.pcc_rules.pccruleid1.app_descriptor                                                   | someapplicationid1                                                            |
      | sm_policy_decision.pcc_rules.pccruleid1.cont_ver                                                         | 2                                                                             |
      | sm_policy_decision.pcc_rules.pccruleid1.precedence                                                       | 1                                                                             |
      | sm_policy_decision.pcc_rules.pccruleid1.af_sig_protocol                                                  | NO_INFORMATION                                                                |
      | sm_policy_decision.pcc_rules.pccruleid1.app_reloc                                                        | false                                                                         |
      | sm_policy_decision.pcc_rules.pccruleid1.ref_qos_data.0.ref_qos_data_item                                 | qosid1                                                                        |
      | sm_policy_decision.pcc_rules.pccruleid1.ref_tc_data.0.ref_tc_data_item                                   | tcid1                                                                         |
      | sm_policy_decision.pcc_rules.pccruleid1.ref_chg_data.0.ref_chg_data_item                                 | chgid1                                                                        |
      | sm_policy_decision.pcc_rules.pccruleid1.ref_um_data.0.ref_um_data_item                                   | umid1                                                                         |
      | sm_policy_decision.pcc_rules.pccruleid1.ref_qos_mon.0.ref_qos_mon_item                                   | qmid1                                                                         |
      | sm_policy_decision.pcc_rules.pccruleid1.addr_preser_ind                                                  | false                                                                         |
      | sm_policy_decision.pcc_rules.pccruleid1.addr_preser_ind                                                  | false                                                                         |
      | sm_policy_decision.sess_rules.sessruleid1.sess_rule_id                                                   | sessruleid1                                                                   |
      | sm_policy_decision.sess_rules.sessruleid1.auth_sess_ambr.uplink                                          | 20000 Kbps                                                                    |
      | sm_policy_decision.sess_rules.sessruleid1.auth_sess_ambr.downlink                                        | 30000 Kbps                                                                    |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.5qi                                               | 9                                                                             |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.arp.priority_level                                | 1                                                                             |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.arp.preemption_cap                                | NON_PREEMPT                                                                   |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.arp.preempt_vuln                                  | NON_PREEMPTABLE                                                               |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.priority_level                                    | 1                                                                             |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.aver_window                                       | 1000                                                                          |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.max_data_burst_vol                                | 100                                                                           |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.max_br_ul                                         | 30000 Kbps                                                                    |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.max_br_dl                                         | 40000 Kbps                                                                    |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.gbr_ul                                            | 6000 Kbps                                                                     |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.gbr_dl                                            | 100000 Kbps                                                                   |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.qnc                                               | false                                                                         |
      | sm_policy_decision.sess_rules.sessruleid1.ref_um_data                                                    | umid1                                                                         |
      | sm_policy_decision.qos_decs.qosid1.qos_id                                                                | qosid1                                                                        |
      | sm_policy_decision.qos_decs.qosid1.5qi                                                                   | 9                                                                             |
      | sm_policy_decision.qos_decs.qosid1.max_br_ul                                                             | 10000 Kbps                                                                    |
      | sm_policy_decision.qos_decs.qosid1.max_br_dl                                                             | 20000 Kbps                                                                    |
      | sm_policy_decision.qos_decs.qosid1.gbr_ul                                                                | 4000 Kbps                                                                     |
      | sm_policy_decision.qos_decs.qosid1.gbr_dl                                                                | 8000 Kbps                                                                     |
      | sm_policy_decision.qos_decs.qosid1.arp.priority_level                                                    | 1                                                                             |
      | sm_policy_decision.qos_decs.qosid1.arp.preemption_cap                                                    | NON_PREEMPT                                                                   |
      | sm_policy_decision.qos_decs.qosid1.arp.preempt_vuln                                                      | NON_PREEMPTABLE                                                               |
      | sm_policy_decision.qos_decs.qosid1.qnc                                                                   | false                                                                         |
      | sm_policy_decision.qos_decs.qosid1.priority_level                                                        | 1                                                                             |
      | sm_policy_decision.qos_decs.qosid1.aver_window                                                           | 800                                                                           |
      | sm_policy_decision.qos_decs.qosid1.max_data_burst_vol                                                    | 80                                                                            |
      | sm_policy_decision.qos_decs.qosid1.reflective_qos                                                        | false                                                                         |
      | sm_policy_decision.qos_decs.qosid1.max_packet_loss_rate_dl                                               | 10                                                                            |
      | sm_policy_decision.qos_decs.qosid1.max_packet_loss_rate_ul                                               | 10                                                                            |
      | sm_policy_decision.qos_decs.qosid1.def_qos_flow_indication                                               | true                                                                          |
      | sm_policy_decision.chg_decs.chgid1.chg_id                                                                | chgid1                                                                        |
      | sm_policy_decision.chg_decs.chgid1.metering_method                                                       | DURATION                                                                      |
      | sm_policy_decision.chg_decs.chgid1.offline                                                               | true                                                                          |
      | sm_policy_decision.chg_decs.chgid1.online                                                                | false                                                                         |
      | sm_policy_decision.chg_decs.chgid1.sdf_handl                                                             | false                                                                         |
      | sm_policy_decision.chg_decs.chgid1.rating_group                                                          | 1                                                                             |
      | sm_policy_decision.chg_decs.chgid1.reporting_level                                                       | SER_ID_LEVEL                                                                  |
      | sm_policy_decision.chg_decs.chgid1.service_id                                                            | 1                                                                             |
      | sm_policy_decision.chg_decs.chgid1.af_charging_identifier                                                | 1                                                                             |
      | sm_policy_decision.chg_decs.chgid1.af_charg_id                                                           | afchargingid1                                                                 |
      | sm_policy_decision.traff_cont_decs.tcid1.tc_id                                                           | tcid1                                                                         |
      | sm_policy_decision.traff_cont_decs.tcid1.flow_status                                                     | ENABLED                                                                       |
      | sm_policy_decision.traff_cont_decs.tcid1.redirect_info.redirect_enabled                                  | false                                                                         |
      | sm_policy_decision.traff_cont_decs.tcid1.mute_notif                                                      | false                                                                         |
      | sm_policy_decision.traff_cont_decs.tcid1.traff_corre_ind                                                 | false                                                                         |
      | sm_policy_decision.traff_cont_decs.tcid1.mul_acc_ctrl                                                    | NOT_ALLOWED                                                                   |
      | sm_policy_decision.um_decs.umid1.um_id                                                                   | umid1                                                                         |
      | sm_policy_decision.um_decs.umid1.volume_threshold                                                        | 30000                                                                         |
      | sm_policy_decision.um_decs.umid1.volume_threshold_uplink                                                 | 10000                                                                         |
      | sm_policy_decision.um_decs.umid1.volume_threshold_downlink                                               | 20000                                                                         |
      | sm_policy_decision.um_decs.umid1.time_threshold                                                          | 12000                                                                         |
      | sm_policy_decision.um_decs.umid1.monitoring_time                                                         | 2021-04-04T01:01:01.001Z                                                      |
      | sm_policy_decision.um_decs.umid1.next_vol_threshold                                                      | 30000                                                                         |
      | sm_policy_decision.um_decs.umid1.next_vol_threshold_uplink                                               | 10000                                                                         |
      | sm_policy_decision.um_decs.umid1.next_vol_threshold_downlink                                             | 20000                                                                         |
      | sm_policy_decision.um_decs.umid1.next_time_threshold                                                     | 12000                                                                         |
      | sm_policy_decision.um_decs.umid1.inactivity_time                                                         | 5                                                                             |
      | sm_policy_decision.qos_mon_decs.qmid1.qm_id                                                              | qmid1                                                                         |
      | sm_policy_decision.qos_mon_decs.qmid1.req_qos_mon_params.0.req_qos_mon_param                             | ROUND_TRIP                                                                    |
      | sm_policy_decision.qos_mon_decs.qmid1.rep_freqs.0.rep_freq                                               | EVENT_TRIGGERED                                                               |
      | sm_policy_decision.qos_mon_decs.qmid1.rep_thresh_rp                                                      | 200                                                                           |
      | sm_policy_decision.qos_mon_decs.qmid1.wait_time                                                          | 30                                                                            |
      | sm_policy_decision.pra_infos.prainfoid1.pra_id                                                           | prainfoid1                                                                    |
      | sm_policy_decision.pra_infos.prainfoid1.presence_state                                                   | IN_AREA                                                                       |
      | sm_policy_decision.pra_infos.prainfoid1.tracking_area_list.0.tai.plmn_id.mcc                             | 404                                                                           |
      | sm_policy_decision.pra_infos.prainfoid1.tracking_area_list.0.tai.plmn_id.mnc                             | 30                                                                            |
      | sm_policy_decision.pra_infos.prainfoid1.tracking_area_list.0.tai.tac                                     | 000001                                                                        |
      | sm_policy_decision.pra_infos.prainfoid1.ecgi_list.0.ecgi.plmn_id.mcc                                     | 404                                                                           |
      | sm_policy_decision.pra_infos.prainfoid1.ecgi_list.0.ecgi.plmn_id.mnc                                     | 30                                                                            |
      | sm_policy_decision.pra_infos.prainfoid1.ecgi_list.0.ecgi.eutra_cell_id                                   | 0000001                                                                       |
      | sm_policy_decision.pra_infos.prainfoid1.ncgi_list.0.ncgi.plmn_id.mcc                                     | 404                                                                           |
      | sm_policy_decision.pra_infos.prainfoid1.ncgi_list.0.ncgi.plmn_id.mnc                                     | 30                                                                            |
      | sm_policy_decision.pra_infos.prainfoid1.ncgi_list.0.ncgi.nr_cell_id                                      | 0000001                                                                       |
      | sm_policy_decision.pra_infos.prainfoid1.global_ran_node_id_list.0.global_ran_node_id.plmn_id.mcc         | 404                                                                           |
      | sm_policy_decision.pra_infos.prainfoid1.global_ran_node_id_list.0.global_ran_node_id.plmn_id.mnc         | 30                                                                            |
      | sm_policy_decision.pra_infos.prainfoid1.global_ran_node_id_list.0.global_ran_node_id.g_nb_id.bit_length  | 32                                                                            |
      | sm_policy_decision.pra_infos.prainfoid1.global_ran_node_id_list.0.global_ran_node_id.g_nb_id.g_n_b_value | 123456                                                                        |
      | sm_policy_decision.pra_infos.prainfoid1.globale_nb_id_list.0.global_ran_node_id.plmn_id.mcc              | 404                                                                           |
      | sm_policy_decision.pra_infos.prainfoid1.globale_nb_id_list.0.global_ran_node_id.plmn_id.mnc              | 30                                                                            |
      | sm_policy_decision.pra_infos.prainfoid1.globale_nb_id_list.0.global_ran_node_id.g_nb_id.bit_length       | 32                                                                            |
      | sm_policy_decision.pra_infos.prainfoid1.globale_nb_id_list.0.global_ran_node_id.g_nb_id.g_n_b_value      | 123456                                                                        |
      | sm_policy_decision.charging_info.primary_chf_address                                                     | 1.1.1.1                                                                       |
      | sm_policy_decision.charging_info.secondary_chf_address                                                   | 2.2.2.2                                                                       |

    Then I receive and validate HTTPV2 message HTTPV2_NPCFSM_POLICY_CONTROL_CREATE_POST_RES_201 on interface N7 with the following details on node SPGWC_SMF1 from PCRF_PCF1:
      | parameter                                                             | value                                                                    |
      | header.nva.0.name                                                     | {string:eq}(:status)                                                     |
      | header.nva.0.value                                                    | {string:eq}(201)                                                         |
      | header.nva.1.name                                                     | {string:eq}(location)                                                    |
      | header.nva.1.value                                                    | {string:eq}(/127.0.0.1:12348/npcf-smpolicycontrol/v1/sm-policies/smPol1) |
      | header.nva.2.name                                                     | {string:eq}(content-type)                                                |
      | header.nva.2.value                                                    | {string:eq}(application/json)                                            |
      | sm_policy_decision.supp_feat                                          | {string:eq}(aabbccdd)                                                    |
      | sm_policy_decision.pcc_rules.pccruleid1.pcc_rule_id                   | {string:eq}(pccruleid1)                                                  |
      | sm_policy_decision.sess_rules.sessruleid1.sess_rule_id                | {string:eq}(sessruleid1)                                                 |
      | sm_policy_decision.qos_decs.qosid1.qos_id                             | {string:eq}(qosid1)                                                      |
      | sm_policy_decision.chg_decs.chgid1.chg_id                             | {string:eq}(chgid1)                                                      |
      | sm_policy_decision.traff_cont_decs.tcid1.tc_id                        | {string:eq}(tcid1)                                                       |
      | sm_policy_decision.um_decs.umid1.um_id                                | {string:eq}(umid1)                                                       |
      | sm_policy_decision.qos_mon_decs.qmid1.qm_id                           | {string:eq}(qmid1)                                                       |
      | sm_policy_decision.pra_infos.prainfoid1.pra_id                        | {string:eq}(prainfoid1)                                                  |
      | sm_policy_decision.policy_ctrl_req_triggers.0.policy_ctrl_req_trigger | {string:eq}(US_RE)                                                       |

## N4 (CUPS) - Session Establishment (SMF to UPF : 1. Trigger setup of SMF allocated UPF N3 Tunnel Endpoint, 2. UE Static IP Allocated by SMF)
## Configure : Forwarding Incoming Uplink Packets - PDR Rule Id 1, mapped to FAR Rule ID 1, for UPF N3 Tunnel (Source Interface - Access(0), Destination interface - Core(1))
##             Forwarding Incoming Downlink Packets - PDR Rule Id 2, mapped to FAR Rule ID 2, for destination UE IP Address towards GNB N3 Tunnel (Source Interface - Core(1), Destination interface - Access(0))
##                                                    GNB N3 Tunnel forwarding is updated in FAR Rule ID 2 in Session Modification from SMF when it receives it from GNB via AMF

    When I send PFCP message PFCP_SESSION_ESTABLISH_REQ on interface N4 with the following details from node SPGWC_SMF1 to SPGWU_UPF1:
      | parameter                                               | value                                                                         |
      | header.message_type                                     | 50                                                                            |
      | header.seid                                             | 0                                                                             |
      | header.seq_number                                       | incr(1,3)                                                                     |
      | node_id.type                                            | 0                                                                             |
      | node_id.value                                           | 1.2.3.4                                                                       |
      | cp_f_seid.flag                                          | 2                                                                             |
      | cp_f_seid.seid                                          | incr(10000000,1)                                                              |
      | cp_f_seid.ipv4_addr                                     | 1.2.3.4                                                                       |
      | pdn_type                                                | {abotprop.SUT.3GPP.PDN_TYPE}                                                  |
      | create_pdr.0.pdr_id                                     | 1                                                                             |
      | create_pdr.0.precedence                                 | 1                                                                             |
      | create_pdr.0.pdi.source_interface                       | 0                                                                             |
      | create_pdr.0.pdi.local_fteid.flag                       | 1                                                                             |
      | create_pdr.0.pdi.local_fteid.teid                       | incr(30000000,1)                                                              |
      | create_pdr.0.pdi.local_fteid.ipv4_addr                  | 10.10.10.11                                                                   |
      | create_pdr.0.pdi.qfi                                    | 9                                                                             |
      | create_pdr.0.outer_header_removal.outer_head_remov_desc | 0                                                                             |
      | create_pdr.0.outer_header_removal.gtpu_ext_head_desc    | 0                                                                             |
      | create_pdr.0.far_id                                     | 1                                                                             |
      | create_pdr.0.qer_id                                     | 1                                                                             |
      | create_pdr.1.pdr_id                                     | 2                                                                             |
      | create_pdr.1.precedence                                 | 1                                                                             |
      | create_pdr.1.pdi.source_interface                       | 1                                                                             |
      | create_pdr.1.pdi.ue_ip_addr.flag                        | 6                                                                             |
      | create_pdr.1.pdi.ue_ip_addr.ipv4_addr                   | incr(172.16.0.10,1)                                                           |
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

    Then I receive and validate PFCP message PFCP_SESSION_ESTABLISH_REQ on interface N4 with the following details on node SPGWU_UPF1 from SPGWC_SMF1:
      | parameter                                               | value                                     |
      | header.message_type                                     | {string:eq}(50)                           |
      | header.seid                                             | {string:eq}(0)                            |
      | header.seq_number                                       | save(PFCP_HDR_SEQ_NO)                     |
      | node_id.type                                            | {string:eq}(0)                            |
      | node_id.value                                           | save(PFCP_NODE_TYPE_SPGWC_SMF)            |
      | cp_f_seid.flag                                          | {string:eq}(2)                            |
      | cp_f_seid.seid                                          | save(PFCP_HDR_SEID_SPGWC_SMF)             |
      | cp_f_seid.ipv4_addr                                     | save(PFCP_MSG_IP_SPGWC_SMF)               |
      | pdn_type                                                | {string:eq}({abotprop.SUT.3GPP.PDN_TYPE}) |
      | create_pdr.0.pdr_id                                     | {string:eq}(1)                            |
      | create_pdr.0.precedence                                 | {string:eq}(1)                            |
      | create_pdr.0.pdi.source_interface                       | {string:eq}(0)                            |
      | create_pdr.0.pdi.local_fteid.flag                       | {string:eq}(1)                            |
      | create_pdr.0.pdi.local_fteid.teid                       | save(GTP_UL_TEID)                         |
      | create_pdr.0.pdi.local_fteid.ipv4_addr                  | save(GTP_UL_IP)                           |
      | create_pdr.0.pdi.qfi                                    | {string:eq}(9)                            |
      | create_pdr.0.outer_header_removal.outer_head_remov_desc | {string:eq}(0)                            |
      | create_pdr.0.outer_header_removal.gtpu_ext_head_desc    | {string:eq}(0)                            |
      | create_pdr.0.far_id                                     | {string:eq}(1)                            |
      | create_pdr.0.qer_id                                     | {string:eq}(1)                            |
      | create_pdr.1.pdr_id                                     | {string:eq}(2)                            |
      | create_pdr.1.precedence                                 | {string:eq}(1)                            |
      | create_pdr.1.pdi.source_interface                       | {string:eq}(1)                            |
      | create_pdr.1.pdi.ue_ip_addr.flag                        | {string:eq}(6)                            |
      | create_pdr.1.pdi.ue_ip_addr.ipv4_addr                   | save(UE_IP)                               |
      | create_pdr.1.pdi.qfi                                    | {string:eq}(9)                            |
      | create_pdr.1.pdi.                                       | save(FLOW_DESC)                           |
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

    When I send PFCP message PFCP_SESSION_ESTABLISH_RES on interface N4 with the following details from node SPGWU_UPF1 to SPGWC_SMF1:
      | parameter            | value                      |
      | header.message_type  | 51                         |
      | header.seid          | $(PFCP_HDR_SEID_SPGWC_SMF) |
      | header.seq_number    | $(PFCP_HDR_SEQ_NO)         |
      | node_id.type         | 0                          |
      | node_id.value        | 5.6.7.8                    |
      | cause                | 1                          |
      | up_f_seid.flag       | 2                          |
      | up_f_seid.seid       | incr(20000000,1)           |
      | up_f_seid.ipv4_addr  | 5.6.7.8                    |
      | created_pdr.0.pdr_id | 1                          |
      | created_pdr.1.pdr_id | 2                          |

    Then I receive and validate PFCP message PFCP_SESSION_ESTABLISH_RES on interface N4 with the following details on node SPGWC_SMF1 from SPGWU_UPF1:
      | parameter            | value                          |
      | header.message_type  | {string:eq}(51)                |
      | header.seid          | save(PFCP_HDR_SEID_SPGWC_SMF)  |
      | header.seq_number    | save(PFCP_HDR_SEQ_NO)          |
      | node_id.type         | {string:eq}(0)                 |
      | node_id.value        | save(PFCP_NODE_TYPE_SPGWU_UPF) |
      | cause                | {string:eq}(1)                 |
      | up_f_seid.flag       | {string:eq}(2)                 |
      | up_f_seid.seid       | save(PFCP_HDR_SEID_SPGWU_UPF)  |
      | up_f_seid.ipv4_addr  | save(PFCP_MSG_IP_SPGWU_UPF)    |
      | created_pdr.0.pdr_id | {string:eq}(1)                 |
      | created_pdr.1.pdr_id | {string:eq}(2)                 |

    When I send HTTPV2 message HTTPV2_NAMF_COMM_N1N2_MSG_TRANSFER_POST_REQ on interface N11 with the following details from node SPGWC_SMF1 to AMF1:
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
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.pdu_address                                                                                                        | incr(172.16.0.10,1)                                                                                    |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.snssai                                                                                                             | 0x01                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.dnn                                                                                                                | internet.apn.5gs.mnc030.mcc404.3gppnetwork.org                                                         |
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
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                      | 10.10.10.11                                                                                            |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                     | incr(30000000,1)                                                                                       |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                                 | 0                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                                    | 9                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi         | 9                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.priority_level | 1                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                                 | 1                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                             | 0                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                          | 0                                                                                                      |

    Then I receive and validate HTTPV2 message HTTPV2_NAMF_COMM_N1N2_MSG_TRANSFER_POST_REQ on interface N11 with the following details on node AMF1 from SPGWC_SMF1:
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
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.pdu_address                                                                                                        | save(UE_IP)                                                                                                         |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.snssai                                                                                                             | {string:eq}(0x01)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.dnn                                                                                                                | {string:eq}(internet.apn.5gs.mnc030.mcc404.3gppnetwork.org)                                                         |
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
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                      | save(GTP_UL_IP)                                                                                                     |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                     | save(GTP_UL_TEID)                                                                                                   |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                                 | {string:eq}(0)                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                                    | {string:eq}(9)                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi         | {string:eq}(9)                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.priority_level | {string:eq}(1)                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                                 | {string:eq}(1)                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                             | {string:eq}(0)                                                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                          | {string:eq}(0)                                                                                                      |

    When I send HTTPV2 message HTTPV2_NAMF_COMM_N1N2_MSG_TRANSFER_POST_RES_200 on interface N11 with the following details from node AMF1 to SPGWC_SMF1:
      | parameter                            | value                                                                                            |
      | header.nva.0.name                    | :status                                                                                          |
      | header.nva.0.value                   | 200                                                                                              |
      | header.nva.1.name                    | content-type                                                                                     |
      | header.nva.1.value                   | application/json                                                                                 |
      | n1n2_message_transfer_rsp_data.cause | N1_N2_TRANSFER_INITIATED                                                                         |

    Then I receive and validate HTTPV2 message HTTPV2_NAMF_COMM_N1N2_MSG_TRANSFER_POST_RES_200 on interface N11 with the following details on node SPGWC_SMF1 from AMF1:
      | parameter                            | value                                                                                                         |
      | header.nva.0.name                    | {string:eq}(:status)                                                                                          |
      | header.nva.0.value                   | {string:eq}(200)                                                                                              |
      | header.nva.1.name                    | {string:eq}(content-type)                                                                                     |
      | header.nva.1.value                   | {string:eq}(application/json)                                                                                 |
      | n1n2_message_transfer_rsp_data.cause | {string:eq}(N1_N2_TRANSFER_INITIATED)                                                                         |

## N2 - Update PDU Session Context (AMF sends SMF : 1. gNodeB N3 Downlink Tunnel Endpoint)

    When I send NGAP message NG_PDU_SESS_RESRC_SETUP_REQ on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                                                                                                                                                                                                                                                              | value                                          |
      | amf_ue_ngap_id                                                                                                                                                                                                                                                                         | $(AMF_UE_NGAP_ID)                              |
      | ran_ue_ngap_id                                                                                                                                                                                                                                                                         | $(RAN_UE_NGAP_ID)                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.extended_protocol_discriminator                                                                                                                                                                                  | 126                                            |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.security_header_type                                                                                                                                                                                             | 0x00                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.message_type                                                                                                                                                                                                     | 0x68                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.pdu_session_identity                                                                                                                                                                            | 0x1206                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_type                                                                                                                                                                          | 0x01                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator                                                                                               | 0x2e                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                                                                                                                | 0x06                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                                                                                                                           | 0x01                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                                                                                                                  | 0xc2                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.selected_pdu_sess_type                                                                                     | 0x01                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.selected_ssc_mode                                                                                          | 0x01                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.session_ambr                                                                                               | 0x010400010400                                 |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.pdu_address                                                                                                | $(UE_IP)                                       |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.snssai                                                                                                     | 0x01                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.dnn                                                                                                        | internet.apn.5gs.mnc030.mcc404.3gppnetwork.org |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.qri                                                                       | 0x01                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.op_code_dqr_bit_no_of_pkt_filters                                         | 0x31                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.precedence                                                                | 0x01                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.segr_bit_qfi                                                              | 0x09                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.dir_id                                               | 0x21                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.type                           | 0x11                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.ipv4_local_address_mask        | 0xac10000affff0000                             |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.type                           | 0x10                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.ipv4_remote_address_mask       | 0x2be1377fffff0000                             |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.type                           | 0x30                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.ipv4_proto_id_or_ipv6_next_hdr | 0x11                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.type                           | 0x41                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.local_port_range               | 0x13881770                                     |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.type                           | 0x51                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.remote_port_range              | 0x1b581f40                                     |
      | pdu_session_resource_setup_request_list.0.pdu_session_id                                                                                                                                                                                                                               | 6                                              |
      | pdu_session_resource_setup_request_list.0.s-nssai.sst                                                                                                                                                                                                                                  | 1                                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate                                                                                                                 | 10000000                                       |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate                                                                                                                 | 10000000                                       |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                                                                                                                      | $(GTP_UL_IP)                                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                                                                                                                     | $(GTP_UL_TEID)                                 |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                                                                                                                                 | 0                                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                                                                                                                                    | 9                                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi                                                                                                         | 9                                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.priority_level                                                                                                 | 1                                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                                                                                                                                 | 1                                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                                                                                                                             | 0                                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                                                                                                                          | 0                                              |

    Then I receive and validate NGAP message NG_PDU_SESS_RESRC_SETUP_REQ on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                                                                                                                                                                                                                                                              | value                                                       |
      | amf_ue_ngap_id                                                                                                                                                                                                                                                                         | {string:eq}($(AMF_UE_NGAP_ID))                              |
      | ran_ue_ngap_id                                                                                                                                                                                                                                                                         | {string:eq}($(RAN_UE_NGAP_ID))                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.extended_protocol_discriminator                                                                                                                                                                                  | {string:eq}(126)                                            |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.security_header_type                                                                                                                                                                                             | {string:eq}(0x00)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.message_type                                                                                                                                                                                                     | {string:eq}(0x68)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.dnn                                                                                                        | {string:eq}(internet.apn.5gs.mnc030.mcc404.3gppnetwork.org) |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.qri                                                                       | {string:eq}(0x01)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.op_code_dqr_bit_no_of_pkt_filters                                         | {string:eq}(0x31)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.precedence                                                                | {string:eq}(0x01)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.segr_bit_qfi                                                              | {string:eq}(0x09)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.dir_id                                               | {string:eq}(0x21)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.type                           | {string:eq}(0x11)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.ipv4_local_address_mask        | {string:eq}(0xac10000affff0000)                             |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.type                           | {string:eq}(0x10)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.ipv4_remote_address_mask       | {string:eq}(0x2be1377fffff0000)                             |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.type                           | {string:eq}(0x30)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.ipv4_proto_id_or_ipv6_next_hdr | {string:eq}(0x11)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.type                           | {string:eq}(0x41)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.local_port_range               | {string:eq}(0x13881770)                                     |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.type                           | {string:eq}(0x51)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.remote_port_range              | {string:eq}(0x1b581f40)                                     |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_type                                                                                                                                                                          | {string:eq}(0x01)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator                                                                                               | {string:eq}(0x2e)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                                                                                                                | {string:eq}(0x06)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                                                                                                                           | {string:eq}(0x01)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                                                                                                                  | {string:eq}(0xc2)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.selected_pdu_sess_type                                                                                     | {string:eq}(0x01)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.selected_ssc_mode                                                                                          | {string:eq}(0x01)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules                                                                                       | {string:eq}(0x010003300101)                                 |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.session_ambr                                                                                               | {string:eq}(0x010400010400)                                 |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.pdu_address                                                                                                | save(UE_IP)                                                 |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.snssai                                                                                                     | {string:eq}(0x01)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.dnn                                                                                                        | {string:eq}(internet.apn.5gs.mnc030.mcc404.3gppnetwork.org) |
      | pdu_session_resource_setup_request_list.0.pdu_session_id                                                                                                                                                                                                                               | {string:eq}(6)                                              |
      | pdu_session_resource_setup_request_list.0.s-nssai.sst                                                                                                                                                                                                                                  | {string:eq}(1)                                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate                                                                                                                 | {string:eq}(10000000)                                       |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate                                                                                                                 | {string:eq}(10000000)                                       |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                                                                                                                      | save(GTP_UL_IP)                                             |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                                                                                                                     | save(GTP_UL_TEID)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                                                                                                                                 | {string:eq}(0)                                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                                                                                                                                    | {string:eq}(9)                                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi                                                                                                         | {string:eq}(9)                                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.priority_level                                                                                                 | {string:eq}(1)                                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                                                                                                                                 | {string:eq}(1)                                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                                                                                                                             | {string:eq}(0)                                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                                                                                                                          | {string:eq}(0)                                              |

    When I send NGAP message NG_PDU_SESS_RESRC_SETUP_RES on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                                                                          | value             |
      | amf_ue_ngap_id                                                                                                                                                                     | $(AMF_UE_NGAP_ID) |
      | ran_ue_ngap_id                                                                                                                                                                     | $(RAN_UE_NGAP_ID) |
      | pdu_session_resource_setup_response_list.0.pdu_session_id                                                                                                                          | 6                 |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | 10.10.10.12       |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | incr(40000000,1)  |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | 9                 |

    Then I receive and validate NGAP message NG_PDU_SESS_RESRC_SETUP_RES on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                                                                                                          | value                          |
      | amf_ue_ngap_id                                                                                                                                                                     | {string:eq}($(AMF_UE_NGAP_ID)) |
      | ran_ue_ngap_id                                                                                                                                                                     | {string:eq}($(RAN_UE_NGAP_ID)) |
      | pdu_session_resource_setup_response_list.0.pdu_session_id                                                                                                                          | {string:eq}(6)                 |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | save(GTP_DL_IP)                |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | save(GTP_DL_TEID)              |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | {string:eq}(9)                 |

## N11 - Update PDU Session Context (AMF sends SMF : 1. gNodeB N3 Downlink Tunnel Endpoint)

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details from node AMF1 to SPGWC_SMF1:
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
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | $(GTP_DL_IP)                                                                            |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | $(GTP_DL_TEID)                                                                          |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | 5                                                                                       |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details on node SPGWC_SMF1 from AMF1:
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
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | save(GTP_DL_IP)                                                                                      |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | save(GTP_DL_TEID)                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | {string:eq}(5)                                                                                       |

## N4 (CUPS) - Session Modification (SMF informs UPF : gNodeB N3 Tunnel Endpoint)
## Configure : Forward Incoming Downlink packets at UPF to gNodeB N3 (PDR Rule ID 2, FAR Rule ID 2 : Source Interface - Core (1), Destination Interface - Access (0))

    When I send PFCP message PFCP_SESSION_MODIFICATION_REQ on interface N4 with the following details from node SPGWC_SMF1 to SPGWU_UPF1:
      | parameter                                                              | value                      |
      | header.message_type                                                    | 52                         |
      | header.seid                                                            | $(PFCP_HDR_SEID_SPGWU_UPF) |
      | header.seq_number                                                      | incr(2,3)                  |
      | update_far.0.far_id                                                    | 2                          |
      | update_far.0.apply_action                                              | 2                          |
      | update_far.0.update_forwarding_parms.destination_interface             | 0                          |
      | update_far.0.update_forwarding_parms.outer_header_creation.description | 0x100                      |
      | update_far.0.update_forwarding_parms.outer_header_creation.teid        | $(GTP_DL_TEID)             |
      | update_far.0.update_forwarding_parms.outer_header_creation.ipv4_addr   | $(GTP_DL_IP)               |

    Then I receive and validate PFCP message PFCP_SESSION_MODIFICATION_REQ on interface N4 with the following details on node SPGWU_UPF1 from SPGWC_SMF1:
      | parameter                                                              | value                         |
      | header.message_type                                                    | {string:eq}(52)               |
      | header.seid                                                            | save(PFCP_HDR_SEID_SPGWU_UPF) |
      | header.seq_number                                                      | save(PFCP_HDR_SEQ_NO)         |
      | update_far.0.far_id                                                    | {string:eq}(2)                |
      | update_far.0.apply_action                                              | {string:eq}(2)                |
      | update_far.0.update_forwarding_parms.destination_interface             | {string:eq}(0)                |
      | update_far.0.update_forwarding_parms.outer_header_creation.description | save(OUT_HDR_CREATE_DESC)     |
      | update_far.0.update_forwarding_parms.outer_header_creation.teid        | save(GTP_DL_TEID)             |
      | update_far.0.update_forwarding_parms.outer_header_creation.ipv4_addr   | save(GTP_DL_IP)               |

    When I send PFCP message PFCP_SESSION_MODIFICATION_RES on interface N4 with the following details from node SPGWU_UPF1 to SPGWC_SMF1:
      | parameter           | value                      |
      | header.message_type | 53                         |
      | header.seid         | $(PFCP_HDR_SEID_SPGWC_SMF) |
      | header.seq_number   | $(PFCP_HDR_SEQ_NO)         |
      | cause               | 1                          |

    Then I receive and validate PFCP message PFCP_SESSION_MODIFICATION_RES on interface N4 with the following details on node SPGWC_SMF1 from SPGWU_UPF1:
      | parameter           | value                         |
      | header.message_type | {string:eq}(53)               |
      | header.seid         | save(PFCP_HDR_SEID_SPGWC_SMF) |
      | header.seq_number   | save(PFCP_HDR_SEQ_NO)         |
      | cause               | {string:eq}(1)                |

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_200 on interface N11 with the following details from node SPGWC_SMF1 to AMF1:
      | parameter                                             | value            |
      | header.nva.0.name                                     | :status          |
      | header.nva.0.value                                    | 200              |
      | header.nva.1.name                                     | content-type     |
      | header.nva.1.value                                    | application/json |
      | application_json.sm_context_updated_data.up_cnx_state | ACTIVATED        |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_200 on interface N11 with the following details on node AMF1 from SPGWC_SMF1:
      | parameter                                             | value                         |
      | header.nva.0.name                                     | {string:eq}(:status)          |
      | header.nva.0.value                                    | {string:eq}(200)              |
      | header.nva.1.name                                     | {string:eq}(content-type)     |
      | header.nva.1.value                                    | {string:eq}(application/json) |
      | application_json.sm_context_updated_data.up_cnx_state | {string:eq}(ACTIVATED)        |



########################################################
## UE Initiated PDU Session Release Request NAS Message
########################################################

## UE Initiated PDU Session Release Request NAS Message

    When I send NGAP message NG_UPLINK_NAS_UL_NAS_TRANS_PDU_SESS_RELEASE_REQ on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                  | value                                          |
      | amf_ue_ngap_id                                                                                                             | $(AMF_UE_NGAP_ID)                              |
      | ran_ue_ngap_id                                                                                                             | $(RAN_UE_NGAP_ID)                              |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                                               | 404                                            |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                                               | 30                                             |
      | user_location_information.nr_user_location_information.tai.tac                                                             | 0x100101                                       |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                                            | 404                                            |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                                            | 30                                             |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                                             | 3584                                           |
      | nas_pdu.extended_protocol_discriminator                                                                                    | 126                                            |
      | nas_pdu.security_header_type                                                                                               | 0x00                                           |
      | nas_pdu.message_type                                                                                                       | 0x67                                           |
      | nas_pdu.ul_nas_transport.pdu_session_identity                                                                              | 0x1206                                         |
      | nas_pdu.ul_nas_transport.request_type                                                                                      | 0x82                                           |
      | nas_pdu.ul_nas_transport.snssai                                                                                            | 0x01                                           |
      | nas_pdu.ul_nas_transport.dnn                                                                                               | internet.apn.5gs.mnc030.mcc404.3gppnetwork.org |
      | nas_pdu.ul_nas_transport.payload_container_type                                                                            | 0x01                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator | 0x2e                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                  | 0x06                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                             | 0x01                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                    | 0xd1                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_release_req.5gsm_cause | 0x24                                           |

    Then I receive and validate NGAP message NG_UPLINK_NAS_UL_NAS_TRANS_PDU_SESS_RELEASE_REQ on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                                                  | value                                                       |
      | amf_ue_ngap_id                                                                                                             | {string:eq}($(AMF_UE_NGAP_ID))                              |
      | ran_ue_ngap_id                                                                                                             | {string:eq}($(RAN_UE_NGAP_ID))                              |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                                               | {string:eq}(404)                                            |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                                               | {string:eq}(30)                                             |
      | user_location_information.nr_user_location_information.tai.tac                                                             | {string:eq}(0x100101)                                       |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                                            | {string:eq}(404)                                            |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                                            | {string:eq}(30)                                             |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                                             | {string:eq}(3584)                                           |
      | nas_pdu.extended_protocol_discriminator                                                                                    | {string:eq}(126)                                            |
      | nas_pdu.security_header_type                                                                                               | {string:eq}(0x00)                                           |
      | nas_pdu.message_type                                                                                                       | {string:eq}(0x67)                                           |
      | nas_pdu.ul_nas_transport.pdu_session_identity                                                                              | {string:eq}(0x1206)                                         |
      | nas_pdu.ul_nas_transport.request_type                                                                                      | {string:eq}(0x82)                                           |
      | nas_pdu.ul_nas_transport.snssai                                                                                            | {string:eq}(0x01)                                           |
      | nas_pdu.ul_nas_transport.dnn                                                                                               | {string:eq}(internet.apn.5gs.mnc030.mcc404.3gppnetwork.org) |
      | nas_pdu.ul_nas_transport.payload_container_type                                                                            | {string:eq}(0x01)                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator | {string:eq}(0x2e)                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                  | {string:eq}(0x06)                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                             | {string:eq}(0x01)                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                    | {string:eq}(0xd1)                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_release_req.5gsm_cause | {string:eq}(0x24)                                           |



### AMF to SMF Update SM Contect - forward UE NAS Message PDU Session Release Request

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details from node AMF1 to SPGWC_SMF1:
      | parameter                                                                                      | value                                                                                   |
      | header.nva.0.name                                                                              | :method                                                                                 |
      | header.nva.0.value                                                                             | POST                                                                                    |
      | header.nva.1.name                                                                              | :path                                                                                   |
      | header.nva.1.value                                                                             | /127.0.0.1:12348/nsmf-pdusession/v1/sm-contexts/smctx-1/modify                          |
      | header.nva.2.name                                                                              | content-type                                                                            |
      | header.nva.2.value                                                                             | multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json |
      | multipart_related.json_data.content_type                                                       | application/json                                                                        |
      | multipart_related.json_data.content_id                                                         | sm-context-update                                                                       |
      | multipart_related.json_data.sm_context_update_data.pei                                         | incr({abotprop.SUT.PEI},1)                                                              |
      | multipart_related.json_data.sm_context_update_data.s_nssai.sst                                 | 1                                                                                       |
      | multipart_related.json_data.sm_context_update_data.n1_sm_msg.content_id                        | n1-pdu-session-release-request                                                          |
      | multipart_related.binary_data_n1_sm_message.content_type                                       | application/vnd.3gpp.5gnas                                                              |
      | multipart_related.binary_data_n1_sm_message.content_id                                         | n1-pdu-session-release-request                                                          |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator | 0x2e                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                  | 0x06                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                             | 0x01                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                    | 0xd1                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_release_req.5gsm_cause | 0x24                                                                                    |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details on node SPGWC_SMF1 from AMF1:
      | parameter                                                                                      | value                                                                                                |
      | header.nva.0.name                                                                              | {string:eq}(:method)                                                                                 |
      | header.nva.0.value                                                                             | {string:eq}(POST)                                                                                    |
      | header.nva.1.name                                                                              | {string:eq}(:path)                                                                                   |
      | header.nva.1.value                                                                             | {string:eq}(/127.0.0.1:12348/nsmf-pdusession/v1/sm-contexts/smctx-1/modify)                          |
      | header.nva.2.name                                                                              | {string:eq}(content-type)                                                                            |
      | header.nva.2.value                                                                             | {string:eq}(multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json) |
      | multipart_related.json_data.content_type                                                       | {string:eq}(application/json)                                                                        |
      | multipart_related.json_data.content_id                                                         | {string:eq}(sm-context-update)                                                                       |
      | multipart_related.json_data.sm_context_update_data.pei                                         | {string:eq}($(PEI))                                                                                  |
      | multipart_related.json_data.sm_context_update_data.s_nssai.sst                                 | {string:eq}(1)                                                                                       |
      | multipart_related.json_data.sm_context_update_data.n1_sm_msg.content_id                        | {string:eq}(n1-pdu-session-release-request)                                                          |
      | multipart_related.binary_data_n1_sm_message.content_type                                       | {string:eq}(application/vnd.3gpp.5gnas)                                                              |
      | multipart_related.binary_data_n1_sm_message.content_id                                         | {string:eq}(n1-pdu-session-release-request)                                                          |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator | {string:eq}(0x2e)                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                  | {string:eq}(0x06)                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                             | {string:eq}(0x01)                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                    | {string:eq}(0xd1)                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_release_req.5gsm_cause | {string:eq}(0x24)                                                                                    |



### SMF to UPF - Delete PDU Session and associated resources

    When I send PFCP message PFCP_SESSION_DELETION_REQ on interface N4 with the following details from node SPGWC_SMF1 to SPGWU_UPF1:
      | parameter           | value                      |
      | header.message_type | 54                         |
      | header.seid         | $(PFCP_HDR_SEID_SPGWU_UPF) |
      | header.seq_number   | incr(3,3)                  |

    Then I receive and validate PFCP message PFCP_SESSION_DELETION_REQ on interface N4 with the following details on node SPGWU_UPF1 from SPGWC_SMF1:
      | parameter           | value                         |
      | header.message_type | {string:eq}(54)               |
      | header.seid         | save(PFCP_HDR_SEID_SPGWU_UPF) |
      | header.seq_number   | save(PFCP_HDR_SEQ_NO)         |

    When I send PFCP message PFCP_SESSION_DELETION_RES on interface N4 with the following details from node SPGWU_UPF1 to SPGWC_SMF1:
      | parameter           | value                      |
      | header.message_type | 55                         |
      | header.seid         | $(PFCP_HDR_SEID_SPGWC_SMF) |
      | header.seq_number   | $(PFCP_HDR_SEQ_NO)         |
      | cause               | 1                          |

    Then I receive and validate PFCP message PFCP_SESSION_DELETION_RES on interface N4 with the following details on node SPGWC_SMF1 from SPGWU_UPF1:
      | parameter           | value                         |
      | header.message_type | {string:eq}(55)               |
      | header.seid         | save(PFCP_HDR_SEID_SPGWC_SMF) |
      | header.seq_number   | save(PFCP_HDR_SEQ_NO)         |
      | cause               | {string:eq}(1)                |



### SMF to AMF Update SM Context Reponse - SMF NAS Message (N1) PDU Session Release Command & SMF Ngap IE (N2) SM PDU Session Resource Release Command Transfer

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_200 on interface N11 with the following details from node SPGWC_SMF1 to AMF1:
      | parameter                                                                                                       | value                                                                                   |
      | header.nva.0.name                                                                                               | :status                                                                                 |
      | header.nva.0.value                                                                                              | 200                                                                                     |
      | header.nva.1.name                                                                                               | content-type                                                                            |
      | header.nva.1.value                                                                                              | multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json |
      | multipart_related.json_data.content_type                                                                        | application/json                                                                        |
      | multipart_related.json_data.content_id                                                                          | sm-context-update                                                                       |
      | multipart_related.json_data.sm_context_updated_data.n2_sm_info.content_id                                       | n2-pdu-session-resource-release-command-transfer-ie                                     |
      | multipart_related.json_data.sm_context_updated_data.n2_sm_info_type                                             | PDU_RES_REL_CMD                                                                         |
      | multipart_related.json_data.sm_context_updated_data.n1_sm_msg.content_id                                        | n1-pdu-session-release-command                                                          |
      | multipart_related.binary_data_n2_sm_information.content_type                                                    | application/vnd.3gpp.ngap                                                               |
      | multipart_related.binary_data_n2_sm_information.content_id                                                      | n2-pdu-session-resource-release-command-transfer-ie                                     |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_command_transfer.cause.nas | 0                                                                                       |
      | multipart_related.binary_data_n1_sm_message.content_type                                                        | application/vnd.3gpp.5gnas                                                              |
      | multipart_related.binary_data_n1_sm_message.content_id                                                          | n1-pdu-session-release-command                                                          |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator                  | 0x2e                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                                   | 0x06                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                                              | 0x01                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                                     | 0xd3                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_release_cmd.5gsm_cause                  | 0x24                                                                                    |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_200 on interface N11 with the following details on node AMF1 from SPGWC_SMF1:
      | parameter                                                                                                       | value                                                                                                |
      | header.nva.0.name                                                                                               | {string:eq}(:status)                                                                                 |
      | header.nva.0.value                                                                                              | {string:eq}(200)                                                                                     |
      | header.nva.1.name                                                                                               | {string:eq}(content-type)                                                                            |
      | header.nva.1.value                                                                                              | {string:eq}(multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json) |
      | multipart_related.json_data.content_type                                                                        | {string:eq}(application/json)                                                                        |
      | multipart_related.json_data.content_id                                                                          | {string:eq}(sm-context-update)                                                                       |
      | multipart_related.json_data.sm_context_updated_data.n2_sm_info.content_id                                       | {string:eq}(n2-pdu-session-resource-release-command-transfer-ie)                                     |
      | multipart_related.json_data.sm_context_updated_data.n2_sm_info_type                                             | {string:eq}(PDU_RES_REL_CMD)                                                                         |
      | multipart_related.json_data.sm_context_updated_data.n1_sm_msg.content_id                                        | {string:eq}(n1-pdu-session-release-command)                                                          |
      | multipart_related.binary_data_n2_sm_information.content_type                                                    | {string:eq}(application/vnd.3gpp.ngap)                                                               |
      | multipart_related.binary_data_n2_sm_information.content_id                                                      | {string:eq}(n2-pdu-session-resource-release-command-transfer-ie)                                     |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_command_transfer.cause.nas | {string:eq}(0)                                                                                       |
      | multipart_related.binary_data_n1_sm_message.content_type                                                        | {string:eq}(application/vnd.3gpp.5gnas)                                                              |
      | multipart_related.binary_data_n1_sm_message.content_id                                                          | {string:eq}(n1-pdu-session-release-command)                                                          |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator                  | {string:eq}(0x2e)                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                                   | {string:eq}(0x06)                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                                              | {string:eq}(0x01)                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                                     | {string:eq}(0xd3)                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_release_cmd.5gsm_cause                  | {string:eq}(0x24)                                                                                    |



### AMF to gNodeB PDU Session Resource Release Command Message - forward SMF NAS Message (N1) PDU Session Release Command & SMF Ngap IE (N2) SM PDU Session Resource Release Command Transfer

    When I send NGAP message NG_PDU_SESS_RESRC_REL_CMD on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                                                                                                  | value             |
      | amf_ue_ngap_id                                                                                                             | $(AMF_UE_NGAP_ID) |
      | ran_ue_ngap_id                                                                                                             | $(RAN_UE_NGAP_ID) |
      | nas_pdu.extended_protocol_discriminator                                                                                    | 126               |
      | nas_pdu.security_header_type                                                                                               | 0x00              |
      | nas_pdu.message_type                                                                                                       | 0x68              |
      | nas_pdu.dl_nas_transport.pdu_session_identity                                                                              | 0x1206            |
      | nas_pdu.dl_nas_transport.payload_container_type                                                                            | 0x01              |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator | 0x2e              |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                  | 0x06              |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                             | 0x01              |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                    | 0xd3              |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_release_cmd.5gsm_cause | 0x24              |
      | pdu_session_resource_to_release_list.0.pdu_session_id                                                                      | 6                 |
      | pdu_session_resource_to_release_list.0.pdu_session_resource_release_command_transfer.cause.nas                             | 0                 |

    Then I receive and validate NGAP message NG_PDU_SESS_RESRC_REL_CMD on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                                                                                                  | value                          |
      | amf_ue_ngap_id                                                                                                             | {string:eq}($(AMF_UE_NGAP_ID)) |
      | ran_ue_ngap_id                                                                                                             | {string:eq}($(RAN_UE_NGAP_ID)) |
      | nas_pdu.extended_protocol_discriminator                                                                                    | {string:eq}(126)               |
      | nas_pdu.security_header_type                                                                                               | {string:eq}(0x00)              |
      | nas_pdu.message_type                                                                                                       | {string:eq}(0x68)              |
      | nas_pdu.dl_nas_transport.pdu_session_identity                                                                              | {string:eq}(0x1206)            |
      | nas_pdu.dl_nas_transport.payload_container_type                                                                            | {string:eq}(0x01)              |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator | {string:eq}(0x2e)              |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                  | {string:eq}(0x06)              |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                             | {string:eq}(0x01)              |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                    | {string:eq}(0xd3)              |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_release_cmd.5gsm_cause | {string:eq}(0x24)              |
      | pdu_session_resource_to_release_list.0.pdu_session_id                                                                      | {string:eq}(6)                 |
      | pdu_session_resource_to_release_list.0.pdu_session_resource_release_command_transfer.cause.nas                             | {string:eq}(0)                 |

### gNodeB to AMF - N2 Reponse (N2) SM PDU Session Resource Release Response Transfer IE

    When I send NGAP message NG_PDU_SESS_RESRC_REL_RES on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                                                                                                         | value             |
      | amf_ue_ngap_id                                                                                                                                                                                                    | $(AMF_UE_NGAP_ID) |
      | ran_ue_ngap_id                                                                                                                                                                                                    | $(RAN_UE_NGAP_ID) |
      | pdu_session_resource_released_list.0.pdu_session_id                                                                                                                                                               | 6                 |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.rat_type                                                                    | 0                 |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.start_timestamp    | 0x00              |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.end_timestamp      | 0x0a              |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.usage_count_ul     | 1000              |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.usage_count_dl     | 1000              |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qfi                                                                    | 5                 |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.rat_type                                                               | 0                 |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.start_timestamp | 0x00              |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.end_timestamp   | 0x0a              |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.usage_count_ul  | 1000              |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.usage_count_dl  | 1000              |

    Then I receive and validate NGAP message NG_PDU_SESS_RESRC_REL_RES on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                                                                                                                                         | value                          |
      | amf_ue_ngap_id                                                                                                                                                                                                    | {string:eq}($(AMF_UE_NGAP_ID)) |
      | ran_ue_ngap_id                                                                                                                                                                                                    | {string:eq}($(RAN_UE_NGAP_ID)) |
      | pdu_session_resource_released_list.0.pdu_session_id                                                                                                                                                               | 6                              |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.rat_type                                                                    | 0                              |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.start_timestamp    | 0x00                           |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.end_timestamp      | 0x0a                           |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.usage_count_ul     | 1000                           |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.usage_count_dl     | 1000                           |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qfi                                                                    | 5                              |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.rat_type                                                               | 0                              |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.start_timestamp | 0x00                           |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.end_timestamp   | 0x0a                           |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.usage_count_ul  | 1000                           |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.usage_count_dl  | 1000                           |

### AMF to SMF Update SM Context Message - forward gNodebB NGAP IE PDU Session Resource Release Response Transfer (N2 IE)

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details from node AMF1 to SPGWC_SMF1:
      | parameter                                                                                                                                                                                                                            | value                                                                                   |
      | header.nva.0.name                                                                                                                                                                                                                    | :method                                                                                 |
      | header.nva.0.value                                                                                                                                                                                                                   | POST                                                                                    |
      | header.nva.1.name                                                                                                                                                                                                                    | :path                                                                                   |
      | header.nva.1.value                                                                                                                                                                                                                   | /127.0.0.1:12348/nsmf-pdusession/v1/sm-contexts/smctx-1/modify                          |
      | header.nva.2.name                                                                                                                                                                                                                    | content-type                                                                            |
      | header.nva.2.value                                                                                                                                                                                                                   | multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json |
      | multipart_related.json_data.content_type                                                                                                                                                                                             | application/json                                                                        |
      | multipart_related.json_data.content_id                                                                                                                                                                                               | sm-context-update                                                                       |
      | multipart_related.json_data.sm_context_update_data.pei                                                                                                                                                                               | incr({abotprop.SUT.PEI},1)                                                              |
      | multipart_related.json_data.sm_context_update_data.s_nssai.sst                                                                                                                                                                       | 1                                                                                       |
      | multipart_related.json_data.sm_context_update_data.n2_sm_info.content_id                                                                                                                                                             | n2-pdu-session-resource-release-response-transfer-ie                                    |
      | multipart_related.json_data.sm_context_update_data.n2_sm_info_type                                                                                                                                                                   | PDU_RES_REL_RSP                                                                         |
      | multipart_related.binary_data_n2_sm_information.content_type                                                                                                                                                                         | application/vnd.3gpp.ngap                                                               |
      | multipart_related.binary_data_n2_sm_information.content_id                                                                                                                                                                           | n2-pdu-session-resource-release-response-transfer-ie                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.rat_type                                                                    | 0                                                                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.start_timestamp    | 0x00                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.end_timestamp      | 0x0a                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.usage_count_ul     | 1000                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.usage_count_dl     | 1000                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qfi                                                                    | 5                                                                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.rat_type                                                               | 0                                                                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.start_timestamp | 0x00                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.end_timestamp   | 0x0a                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.usage_count_ul  | 1000                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.usage_count_dl  | 1000                                                                                    |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details on node SPGWC_SMF1 from AMF1:
      | parameter                                                                                                                                                                                                                            | value                                                                                                |
      | header.nva.0.name                                                                                                                                                                                                                    | {string:eq}(:method)                                                                                 |
      | header.nva.0.value                                                                                                                                                                                                                   | {string:eq}(POST)                                                                                    |
      | header.nva.1.name                                                                                                                                                                                                                    | {string:eq}(:path)                                                                                   |
      | header.nva.1.value                                                                                                                                                                                                                   | {string:eq}(/127.0.0.1:12348/nsmf-pdusession/v1/sm-contexts/smctx-1/modify)                          |
      | header.nva.2.name                                                                                                                                                                                                                    | {string:eq}(content-type)                                                                            |
      | header.nva.2.value                                                                                                                                                                                                                   | {string:eq}(multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json) |
      | multipart_related.json_data.content_type                                                                                                                                                                                             | {string:eq}(application/json)                                                                        |
      | multipart_related.json_data.content_id                                                                                                                                                                                               | {string:eq}(sm-context-update)                                                                       |
      | multipart_related.json_data.sm_context_update_data.pei                                                                                                                                                                               | {string:eq}($(PEI))                                                                                  |
      | multipart_related.json_data.sm_context_update_data.s_nssai.sst                                                                                                                                                                       | {string:eq}(1)                                                                                       |
      | multipart_related.json_data.sm_context_update_data.n2_sm_info.content_id                                                                                                                                                             | {string:eq}(n2-pdu-session-resource-release-response-transfer-ie)                                    |
      | multipart_related.json_data.sm_context_update_data.n2_sm_info_type                                                                                                                                                                   | {string:eq}(PDU_RES_REL_RSP)                                                                         |
      | multipart_related.binary_data_n2_sm_information.content_type                                                                                                                                                                         | {string:eq}(application/vnd.3gpp.ngap)                                                               |
      | multipart_related.binary_data_n2_sm_information.content_id                                                                                                                                                                           | {string:eq}(n2-pdu-session-resource-release-response-transfer-ie)                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.rat_type                                                                    | {string:eq}(0)                                                                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.start_timestamp    | {string:eq}(0x00)                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.end_timestamp      | {string:eq}(0x0a)                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.usage_count_ul     | {string:eq}(1000)                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.usage_count_dl     | {string:eq}(1000)                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qfi                                                                    | {string:eq}(5)                                                                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.rat_type                                                               | {string:eq}(0)                                                                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.start_timestamp | {string:eq}(0x00)                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.end_timestamp   | {string:eq}(0x0a)                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.usage_count_ul  | {string:eq}(1000)                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.usage_count_dl  | {string:eq}(1000)                                                                                    |

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_204 on interface N11 with the following details from node SPGWC_SMF1 to AMF1:
      | parameter          | value   |
      | header.nva.0.name  | :status |
      | header.nva.0.value | 204     |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_204 on interface N11 with the following details on node AMF1 from SPGWC_SMF1:
      | parameter          | value                |
      | header.nva.0.name  | {string:eq}(:status) |
      | header.nva.0.value | {string:eq}(204)     |

### gNodeB to AMF - PDU Session Resource Release Complete (N1 NAS PDU)

    When I send NGAP message NG_UPLINK_NAS_UL_NAS_TRANS_PDU_SESS_RELEASE_COMPL on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                  | value                                          |
      | amf_ue_ngap_id                                                                                                             | $(AMF_UE_NGAP_ID)                              |
      | ran_ue_ngap_id                                                                                                             | $(RAN_UE_NGAP_ID)                              |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                                               | 404                                            |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                                               | 30                                             |
      | user_location_information.nr_user_location_information.tai.tac                                                             | 0x100101                                       |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                                            | 404                                            |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                                            | 30                                             |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                                             | 3584                                           |
      | nas_pdu.extended_protocol_discriminator                                                                                    | 126                                            |
      | nas_pdu.security_header_type                                                                                               | 0x00                                           |
      | nas_pdu.message_type                                                                                                       | 0x67                                           |
      | nas_pdu.ul_nas_transport.pdu_session_identity                                                                              | 0x1206                                         |
      | nas_pdu.ul_nas_transport.request_type                                                                                      | 0x82                                           |
      | nas_pdu.ul_nas_transport.snssai                                                                                            | 0x01                                           |
      | nas_pdu.ul_nas_transport.dnn                                                                                               | internet.apn.5gs.mnc030.mcc404.3gppnetwork.org |
      | nas_pdu.ul_nas_transport.payload_container_type                                                                            | 0x01                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator | 0x2e                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                  | 0x06                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                             | 0x01                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                    | 0xd4                                           |

    Then I receive and validate NGAP message NG_UPLINK_NAS_UL_NAS_TRANS_PDU_SESS_RELEASE_COMPL on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                                                  | value                                                       |
      | amf_ue_ngap_id                                                                                                             | {string:eq}($(AMF_UE_NGAP_ID))                              |
      | ran_ue_ngap_id                                                                                                             | {string:eq}($(RAN_UE_NGAP_ID))                              |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                                               | {string:eq}(404)                                            |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                                               | {string:eq}(30)                                             |
      | user_location_information.nr_user_location_information.tai.tac                                                             | {string:eq}(0x100101)                                       |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                                            | {string:eq}(404)                                            |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                                            | {string:eq}(30)                                             |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                                             | {string:eq}(3584)                                           |
      | nas_pdu.extended_protocol_discriminator                                                                                    | {string:eq}(126)                                            |
      | nas_pdu.security_header_type                                                                                               | {string:eq}(0x00)                                           |
      | nas_pdu.message_type                                                                                                       | {string:eq}(0x67)                                           |
      | nas_pdu.ul_nas_transport.pdu_session_identity                                                                              | {string:eq}(0x1206)                                         |
      | nas_pdu.ul_nas_transport.request_type                                                                                      | {string:eq}(0x82)                                           |
      | nas_pdu.ul_nas_transport.snssai                                                                                            | {string:eq}(0x01)                                           |
      | nas_pdu.ul_nas_transport.dnn                                                                                               | {string:eq}(internet.apn.5gs.mnc030.mcc404.3gppnetwork.org) |
      | nas_pdu.ul_nas_transport.payload_container_type                                                                            | {string:eq}(0x01)                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator | {string:eq}(0x2e)                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                  | {string:eq}(0x06)                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                             | {string:eq}(0x01)                                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                    | {string:eq}(0xd4)                                           |

### AMF to SMF Update SM Contect - forward UE NAS Message PDU Session Release Complete (N1 NAS)

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details from node AMF1 to SPGWC_SMF1:
      | parameter                                                                                      | value                                                                                   |
      | header.nva.0.name                                                                              | :method                                                                                 |
      | header.nva.0.value                                                                             | POST                                                                                    |
      | header.nva.1.name                                                                              | :path                                                                                   |
      | header.nva.1.value                                                                             | /127.0.0.1:12348/nsmf-pdusession/v1/sm-contexts/smctx-1/modify                          |
      | header.nva.2.name                                                                              | content-type                                                                            |
      | header.nva.2.value                                                                             | multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json |
      | multipart_related.json_data.content_type                                                       | application/json                                                                        |
      | multipart_related.json_data.content_id                                                         | sm-context-update                                                                       |
      | multipart_related.json_data.sm_context_update_data.pei                                         | incr({abotprop.SUT.PEI},1)                                                              |
      | multipart_related.json_data.sm_context_update_data.s_nssai.sst                                 | 1                                                                                       |
      | multipart_related.json_data.sm_context_update_data.n1_sm_msg.content_id                        | n1-pdu-session-release-complete                                                         |
      | multipart_related.binary_data_n1_sm_message.content_type                                       | application/vnd.3gpp.5gnas                                                              |
      | multipart_related.binary_data_n1_sm_message.content_id                                         | n1-pdu-session-release-complete                                                         |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator | 0x2e                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                  | 0x06                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                             | 0x01                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                    | 0xd4                                                                                    |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details on node SPGWC_SMF1 from AMF1:
      | parameter                                                                                      | value                                                                                                |
      | header.nva.0.name                                                                              | {string:eq}(:method)                                                                                 |
      | header.nva.0.value                                                                             | {string:eq}(POST)                                                                                    |
      | header.nva.1.name                                                                              | {string:eq}(:path)                                                                                   |
      | header.nva.1.value                                                                             | {string:eq}(/127.0.0.1:12348/nsmf-pdusession/v1/sm-contexts/smctx-1/modify)                          |
      | header.nva.2.name                                                                              | {string:eq}(content-type)                                                                            |
      | header.nva.2.value                                                                             | {string:eq}(multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json) |
      | multipart_related.json_data.content_type                                                       | {string:eq}(application/json)                                                                        |
      | multipart_related.json_data.content_id                                                         | {string:eq}(sm-context-update)                                                                       |
      | multipart_related.json_data.sm_context_update_data.pei                                         | {string:eq}($(PEI))                                                                                  |
      | multipart_related.json_data.sm_context_update_data.s_nssai.sst                                 | {string:eq}(1)                                                                                       |
      | multipart_related.json_data.sm_context_update_data.n1_sm_msg.content_id                        | {string:eq}(n1-pdu-session-release-complete)                                                         |
      | multipart_related.binary_data_n1_sm_message.content_type                                       | {string:eq}(application/vnd.3gpp.5gnas)                                                              |
      | multipart_related.binary_data_n1_sm_message.content_id                                         | {string:eq}(n1-pdu-session-release-complete)                                                         |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator | {string:eq}(0x2e)                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                  | {string:eq}(0x06)                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                             | {string:eq}(0x01)                                                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                    | {string:eq}(0xd4)                                                                                    |

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_204 on interface N11 with the following details from node SPGWC_SMF1 to AMF1:
      | parameter          | value   |
      | header.nva.0.name  | :status |
      | header.nva.0.value | 204     |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_204 on interface N11 with the following details on node AMF1 from SPGWC_SMF1:
      | parameter          | value                |
      | header.nva.0.name  | {string:eq}(:status) |
      | header.nva.0.value | {string:eq}(204)     |

### SMF to AMF - Notify SM Context Released Status

    When I send HTTPV2 message HTTPV2_NSMF_NOTIFY_SM_CONTEXT_STATUS_REQ on interface N11 with the following details from node SPGWC_SMF1 to AMF1:
      | parameter                                                  | value                              |
      | header.nva.0.name                                          | :method                            |
      | header.nva.0.value                                         | POST                               |
      | header.nva.1.name                                          | :path                              |
      | header.nva.1.value                                         | $(SM_CTXT_STATUS_URI_AT_SPGWC_SMF) |
      | header.nva.2.name                                          | content-type                       |
      | header.nva.2.value                                         | application/json                   |
      | sm_context_status_notification.status_info.resource_status | RELEASED                           |
      | sm_context_status_notification.status_info.cause           | INSUFFICIENT_UP_RESOURCES          |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_NOTIFY_SM_CONTEXT_STATUS_REQ on interface N11 with the following details on node AMF1 from SPGWC_SMF1:
      | parameter                                                  | value                                  |
      | header.nva.0.name                                          | {string:eq}(:method)                   |
      | header.nva.0.value                                         | {string:eq}(POST)                      |
      | header.nva.1.name                                          | {string:eq}(:path)                     |
      | header.nva.1.value                                         | save(SM_CTXT_STATUS_URI_HDR_AT_AMF)    |
      | header.nva.2.name                                          | {string:eq}(content-type)              |
      | header.nva.2.value                                         | {string:eq}(application/json)          |
      | sm_context_status_notification.status_info.resource_status | {string:eq}(RELEASED)                  |
      | sm_context_status_notification.status_info.cause           | {string:eq}(INSUFFICIENT_UP_RESOURCES) |

    When I send HTTPV2 message HTTPV2_NSMF_NOTIFY_SM_CONTEXT_STATUS_RES_204 on interface N11 with the following details from node AMF1 to SPGWC_SMF1:
      | parameter          | value   |
      | header.nva.0.name  | :status |
      | header.nva.0.value | 204     |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_NOTIFY_SM_CONTEXT_STATUS_RES_204 on interface N11 with the following details on node SPGWC_SMF1 from AMF1:
      | parameter          | value                |
      | header.nva.0.name  | {string:eq}(:status) |
      | header.nva.0.value | {string:eq}(204)     |




## SMF to PCF - SM Policy Delete for deleting PDU Session Policy at PCF. Includes Usage Monitoring Data

    When I send HTTPV2 message HTTPV2_NPCFSM_POLICY_CONTROL_DELETE_POST_REQ on interface N7 with the following details from node SPGWC_SMF1 to PCRF_PCF1:
      | parameter                                                                            | value                                                              |
      | header.nva.0.name                                                                    | :method                                                            |
      | header.nva.0.value                                                                   | POST                                                               |
      | header.nva.1.name                                                                    | :path                                                              |
      | header.nva.1.value                                                                   | /127.0.0.1:12348/npcf-smpolicycontrol/v1/sm-policies/smPol1/delete |
      | header.nva.2.name                                                                    | content-type                                                       |
      | header.nva.2.value                                                                   | application/json                                                   |
      | sm_policy_delete_data.ran_nas_rel_causes.0.ran_nas_rel_cause.5g_sm_cause             | 36                                                                 |
      | sm_policy_delete_data.accu_usage_reports.0.accu_usage_report.ref_um_ids              | umid1                                                              |
      | sm_policy_delete_data.accu_usage_reports.0.accu_usage_report.vol_usage               | 0                                                                  |
      | sm_policy_delete_data.accu_usage_reports.0.accu_usage_report.vol_usage_uplink        | 0                                                                  |
      | sm_policy_delete_data.accu_usage_reports.0.accu_usage_report.vol_usage_downlink      | 0                                                                  |
      | sm_policy_delete_data.accu_usage_reports.0.accu_usage_report.time_usage              | 0                                                                  |
      | sm_policy_delete_data.accu_usage_reports.0.accu_usage_report.next_vol_usage          | 10000                                                              |
      | sm_policy_delete_data.accu_usage_reports.0.accu_usage_report.next_vol_usage_uplink   | 4000                                                               |
      | sm_policy_delete_data.accu_usage_reports.0.accu_usage_report.next_vol_usage_downlink | 6000                                                               |
      | sm_policy_delete_data.accu_usage_reports.0.accu_usage_report.next_time_usage         | 4000                                                               |

    Then I receive and validate HTTPV2 message HTTPV2_NPCFSM_POLICY_CONTROL_DELETE_POST_REQ on interface N7 with the following details on node PCRF_PCF1 from SPGWC_SMF1:
      | parameter                                                                            | value                                                                           |
      | header.nva.0.name                                                                    | {string:eq}(:method)                                                            |
      | header.nva.0.value                                                                   | {string:eq}(POST)                                                               |
      | header.nva.1.name                                                                    | {string:eq}(:path)                                                              |
      | header.nva.1.value                                                                   | {string:eq}(/127.0.0.1:12348/npcf-smpolicycontrol/v1/sm-policies/smPol1/delete) |
      | header.nva.2.name                                                                    | {string:eq}(content-type)                                                       |
      | header.nva.2.value                                                                   | {string:eq}(application/json)                                                   |
      | sm_policy_delete_data.ran_nas_rel_causes.0.ran_nas_rel_cause.5g_sm_cause             | {string:eq}(36)                                                                 |
      | sm_policy_delete_data.accu_usage_reports.0.accu_usage_report.ref_um_ids              | {string:eq}(umid1)                                                              |
      | sm_policy_delete_data.accu_usage_reports.0.accu_usage_report.vol_usage               | {string:eq}(0)                                                                  |
      | sm_policy_delete_data.accu_usage_reports.0.accu_usage_report.vol_usage_uplink        | {string:eq}(0)                                                                  |
      | sm_policy_delete_data.accu_usage_reports.0.accu_usage_report.vol_usage_downlink      | {string:eq}(0)                                                                  |
      | sm_policy_delete_data.accu_usage_reports.0.accu_usage_report.time_usage              | {string:eq}(0)                                                                  |
      | sm_policy_delete_data.accu_usage_reports.0.accu_usage_report.next_vol_usage          | {string:eq}(10000)                                                              |
      | sm_policy_delete_data.accu_usage_reports.0.accu_usage_report.next_vol_usage_uplink   | {string:eq}(4000)                                                               |
      | sm_policy_delete_data.accu_usage_reports.0.accu_usage_report.next_vol_usage_downlink | {string:eq}(6000)                                                               |
      | sm_policy_delete_data.accu_usage_reports.0.accu_usage_report.next_time_usage         | {string:eq}(4000)                                                               |




## PCF to UDR - SM Policy Data Update to indicate the remaining overall amount of resource (after all PDU Sessions to the DNN are Terminated)

    When I send HTTPV2 message HTTPV2_NUDRPDADED_DATA_REPOSITORY_POLICY_DATA_SM_DATA_UPDATE_PATCH_REQ on interface N36 with the following details from node PCRF_PCF1 to UDR1:
      | parameter                                                                    | value                                                                            |
      | header.nva.0.name                                                            | :method                                                                          |
      | header.nva.0.value                                                           | PATCH                                                                            |
      | header.nva.1.name                                                            | :path                                                                            |
      | header.nva.1.value                                                           | /127.0.0.1:12348/nudr-dr/v2/policy-data/ues/incr(imsi-404309990000001,1)/sm-data |
      | header.nva.2.name                                                            | content-type                                                                     |
      | header.nva.2.value                                                           | application/merge-patch+json                                                     |
      | sm_policy_data_patch.um_data.umdatamonitorkey1.limit_id                      | umdatamonitorkey1                                                                |
      | sm_policy_data_patch.um_data.umdatamonitorkey1.scopes.sst1.snssai.sst        | 1                                                                                |
      | sm_policy_data_patch.um_data.umdatamonitorkey1.scopes.sst1.dnn.0.dnn_item    | internet.apn.5gs.mnc030.mcc404.3gppnetwork.org                                   |
      | sm_policy_data_patch.um_data.umdatamonitorkey1.um_level                      | SESSION_LEVEL                                                                    |
      | sm_policy_data_patch.um_data.umdatamonitorkey1.allowed_usage.duration        | 8000                                                                             |
      | sm_policy_data_patch.um_data.umdatamonitorkey1.allowed_usage.total_volume    | 20000                                                                            |
      | sm_policy_data_patch.um_data.umdatamonitorkey1.allowed_usage.downlink_volume | 14000                                                                            |
      | sm_policy_data_patch.um_data.umdatamonitorkey1.allowed_usage.uplink_volume   | 6000                                                                             |

    Then I receive and validate HTTPV2 message HTTPV2_NUDRPDADED_DATA_REPOSITORY_POLICY_DATA_SM_DATA_UPDATE_PATCH_REQ on interface N36 with the following details on node UDR1 from PCRF_PCF1:
      | parameter                                                                    | value                                                                                         |
      | header.nva.0.name                                                            | {string:eq}(:method)                                                                          |
      | header.nva.0.value                                                           | {string:eq}(PATCH)                                                                            |
      | header.nva.1.name                                                            | {string:eq}(:path)                                                                            |
      | header.nva.1.value                                                           | {string:eq}(/127.0.0.1:12348/nudr-dr/v2/policy-data/ues/incr(imsi-404309990000001,1)/sm-data) |
      | header.nva.2.name                                                            | {string:eq}(content-type)                                                                     |
      | header.nva.2.value                                                           | {string:eq}(application/merge-patch+json)                                                     |
      | sm_policy_data_patch.um_data.umdatamonitorkey1.limit_id                      | {string:eq}(umdatamonitorkey1)                                                                |
      | sm_policy_data_patch.um_data.umdatamonitorkey1.scopes.sst1.snssai.sst        | {string:eq}(1)                                                                                |
      | sm_policy_data_patch.um_data.umdatamonitorkey1.scopes.sst1.dnn.0.dnn_item    | {string:eq}(internet.apn.5gs.mnc030.mcc404.3gppnetwork.org)                                   |
      | sm_policy_data_patch.um_data.umdatamonitorkey1.um_level                      | {string:eq}(SESSION_LEVEL)                                                                    |
      | sm_policy_data_patch.um_data.umdatamonitorkey1.allowed_usage.duration        | {string:eq}(8000)                                                                             |
      | sm_policy_data_patch.um_data.umdatamonitorkey1.allowed_usage.total_volume    | {string:eq}(20000)                                                                            |
      | sm_policy_data_patch.um_data.umdatamonitorkey1.allowed_usage.downlink_volume | {string:eq}(14000)                                                                            |
      | sm_policy_data_patch.um_data.umdatamonitorkey1.allowed_usage.uplink_volume   | {string:eq}(6000)                                                                             |

    When I send HTTPV2 message HTTPV2_NUDRPDADED_DATA_REPOSITORY_POLICY_DATA_SM_DATA_UPDATE_PATCH_RES_204 on interface N36 with the following details from node UDR1 to PCRF_PCF1:
      | parameter          | value   |
      | header.nva.0.name  | :status |
      | header.nva.0.value | 204     |

    Then I receive and validate HTTPV2 message HTTPV2_NUDRPDADED_DATA_REPOSITORY_POLICY_DATA_SM_DATA_UPDATE_PATCH_RES_204 on interface N36 with the following details on node PCRF_PCF1 from UDR1:
      | parameter          | value                |
      | header.nva.0.name  | {string:eq}(:status) |
      | header.nva.0.value | {string:eq}(204)     |




    When I send HTTPV2 message HTTPV2_NPCFSM_POLICY_CONTROL_DELETE_POST_RES_204 on interface N7 with the following details from node PCRF_PCF1 to SPGWC_SMF1:
      | parameter          | value   |
      | header.nva.0.name  | :status |
      | header.nva.0.value | 204     |

    Then I receive and validate HTTPV2 message HTTPV2_NPCFSM_POLICY_CONTROL_DELETE_POST_RES_204 on interface N7 with the following details on node SPGWC_SMF1 from PCRF_PCF1:
      | parameter          | value                |
      | header.nva.0.name  | {string:eq}(:status) |
      | header.nva.0.value | {string:eq}(204)     |


### SMF to UDM UECM Deregistration of PDU Session

    When I send HTTPV2 message HTTPV2_NUDM_UECM_SMF_DEREG_DELETE_REQ on interface N10 with the following details from node SPGWC_SMF1 to HSS_UDM1:
      | parameter          | value                                                                                        |
      | header.nva.0.name  | :method                                                                                      |
      | header.nva.0.value | DELETE                                                                                       |
      | header.nva.1.name  | :path                                                                                        |
      | header.nva.1.value | /127.0.0.1:12348/nudm-uecm/v1/incr(imsi-404309990000001,1)/registrations/smf-registrations/6 |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UECM_SMF_DEREG_DELETE_REQ on interface N10 with the following details on node HSS_UDM1 from SPGWC_SMF1:
      | parameter          | value                                                                                                     |
      | header.nva.0.name  | {string:eq}(:method)                                                                                      |
      | header.nva.0.value | {string:eq}(DELETE)                                                                                       |
      | header.nva.1.name  | {string:eq}(:path)                                                                                        |
      | header.nva.1.value | {string:eq}(/127.0.0.1:12348/nudm-uecm/v1/incr(imsi-404309990000001,1)/registrations/smf-registrations/6) |

    When I send HTTPV2 message HTTPV2_NUDM_UECM_SMF_DEREG_DELETE_RES_204 on interface N10 with the following details from node HSS_UDM1 to SPGWC_SMF1:
      | parameter          | value   |
      | header.nva.0.name  | :status |
      | header.nva.0.value | 204     |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UECM_SMF_DEREG_DELETE_RES_204 on interface N10 with the following details on node SPGWC_SMF1 from HSS_UDM1:
      | parameter          | value                |
      | header.nva.0.name  | {string:eq}(:status) |
      | header.nva.0.value | {string:eq}(204)     |



