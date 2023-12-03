@5gs-usr-prof-subs-time-mod @08-usr-prof-mgmt-proc @23502-5gs @5g-core-sanity @5g-core

Feature: User Profile Management Procedure

  Scenario: UE Registration and Subscription Time Modification by AMF

    Given the steps below will be executed at the end
    When I run the SSH command {abotprop.SUT.DEFAULT.GENB.CONFIG} at node gNodeB1
    When I run the SSH command {abotprop.SUT.DEFAULT.AMF.CONFIG} at node AMF1
    Then the ending steps are complete

    Given the test data is in file /featureFiles/MESSAGE_BUNDLES/EPC_MESSAGES.xml

    When I run the SSH command {abotprop.SUT.CUSTOM.GENB.CONFIG} and pause for {abotprop.WAIT_5_SEC} seconds at node gNodeB1
    When I run the SSH command {abotprop.SUT.CUSTOM.ENB.CONFIG} and pause for {abotprop.WAIT_5_SEC} seconds at node AMF1

    Given all configured endpoints for EPC are connected successfully
    Given that I execute dependency feature /featureFiles/3GPP-23502-5G/01_Interface_Management_Procedures/01_gNB_AMF_procedures/01_NG_Setup_Procedure/NG_Setup_Request.feature
   
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
      | parameter                                | value                                                        |
      | header.nva.0.name                        | :method                                                      |
      | header.nva.0.value                       | POST                                                         |
      | header.nva.1.name                        | :path                                                        |
      | header.nva.1.value                       | {abotprop.SUT.HEADER.NAUSF.AUTH.UEAUTHENTICATIONS.POST.PATH} |
      | header.nva.2.name                        | content-type                                                 |
      | header.nva.2.value                       | application/json                                             |
      | authentication_info.supi_or_suci         | incr({abotprop.SUT.SUCI},1)                                  |
      | authentication_info.serving_network_name | {abotprop.SUT.SERVICE.NETWORK.NAME}                          |
      | authentication_info.amf_instance_id      | {abotprop.SUT.AMF.INSTANCE.ID}                               |

    Then I receive and validate HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_AUTHENTICATE_REQ on interface N12 with the following details on node AUSF1 from AMF1:
      | parameter                                | value                                                                     |
      | header.nva.0.name                        | {string:eq}(:method)                                                      |
      | header.nva.0.value                       | {string:eq}(POST)                                                         |
      | header.nva.1.name                        | {string:eq}(:path)                                                        |
      | header.nva.1.value                       | {string:eq}({abotprop.SUT.HEADER.NAUSF.AUTH.UEAUTHENTICATIONS.POST.PATH}) |
      | header.nva.2.name                        | {string:eq}(content-type)                                                 |
      | header.nva.2.value                       | {string:eq}(application/json)                                             |
      | authentication_info.supi_or_suci         | save(SUCI)                                                                |
      | authentication_info.serving_network_name | {string:eq}({abotprop.SUT.SERVICE.NETWORK.NAME})                          |
      | authentication_info.amf_instance_id      | {string:eq}({abotprop.SUT.AMF.INSTANCE.ID})                               |

    When I send HTTPV2 message HTTPV2_NUDM_UEAU_GEN_AUTH_DATA_REQ on interface N13 with the following details from node AUSF1 to UDM1:
      | parameter                                        | value                                         |
      | header.nva.0.name                                | :method                                       |
      | header.nva.0.value                               | POST                                          |
      | header.nva.1.name                                | :path                                         |
      | header.nva.1.value                               | {abotprop.SUT.HEADER.NUDM.UEAU.GEN.AUTH.DATA} |
      | header.nva.2.name                                | content-type                                  |
      | header.nva.2.value                               | application/json                              |
      | authentication_info_request.serving_network_name | {abotprop.SUT.SERVICE.NETWORK.NAME}           |
      | authentication_info_request.ausf_instance_id     | 44e57b64-9008-11ed-a1eb-0242ac120002          |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UEAU_GEN_AUTH_DATA_REQ on interface N13 with the following details on node UDM1 from AUSF1:
      | parameter                                        | value                                                      |
      | header.nva.0.name                                | {string:eq}(:method)                                       |
      | header.nva.0.value                               | {string:eq}(POST)                                          |
      | header.nva.1.name                                | {string:eq}(:path)                                         |
      | header.nva.1.value                               | {string:eq}({abotprop.SUT.HEADER.NUDM.UEAU.GEN.AUTH.DATA}) |
      | header.nva.2.name                                | {string:eq}(content-type)                                  |
      | header.nva.2.value                               | {string:eq}(application/json)                              |
      | authentication_info_request.serving_network_name | {string:eq}({abotprop.SUT.SERVICE.NETWORK.NAME})           |
      | authentication_info_request.ausf_instance_id     | {string:eq}(44e57b64-9008-11ed-a1eb-0242ac120002)          |

    When I send HTTPV2 message HTTPV2_NUDM_UEAU_GEN_AUTH_DATA_RES_200 on interface N13 with the following details from node UDM1 to AUSF1:
      | parameter                                                                          | value                                                            |
      | header.nva.0.name                                                                  | :status                                                          |
      | header.nva.0.value                                                                 | 200                                                              |
      | header.nva.1.name                                                                  | content-type                                                     |
      | header.nva.1.value                                                                 | application/json                                                 |
      | authentication_info_result.authentication_vector.av_5G_he_aka.av_type              | {abotprop.SUT.AUTH.TYPE.5GAKA}                                   |
      | authentication_info_result.authentication_vector.av_5G_he_aka.rand                 | {abotprop.SUT.5GAKA.RAND}                                        |
      | authentication_info_result.authentication_vector.av_5G_he_aka.autn                 | 00000000000000000000000000000000                                 |
      | authentication_info_result.authentication_vector.av_5G_he_aka.xres_star            | 00000000000000000000000000000000                                 |
      | authentication_info_result.authentication_vector.av_5G_he_aka.kausf                | 0000000000000000000000000000000000000000000000000000000000000000 |
      | authentication_info_result.authentication_vector.av_5G_he_aka.serving_network_name | {abotprop.SUT.SERVICE.NETWORK.NAME}                              |
      | authentication_info_result.authentication_vector.av_5G_he_aka.AMF                  | {abotprop.SUT.5GAKA.AMF}                                         |
      | authentication_info_result.authentication_vector.av_5G_he_aka.K                    | {abotprop.SUT.5GAKA.K}                                           |
      | authentication_info_result.authentication_vector.av_5G_he_aka.OP                   | {abotprop.SUT.5GAKA.OP}                                          |
      | authentication_info_result.supi                                                    | incr({abotprop.SUT.SUPI},1)                                      |
      | authentication_info_result.authentication_vector.av_5G_he_aka.seq_no               | {abotprop.SUT.5GAKA.SQN}                                         |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UEAU_GEN_AUTH_DATA_RES_200 on interface N13 with the following details on node AUSF1 from UDM1:
      | parameter                                                               | value                                       |
      | header.nva.0.name                                                       | {string:eq}(:status)                        |
      | header.nva.0.value                                                      | {string:eq}(200)                            |
      | header.nva.1.name                                                       | {string:eq}(content-type)                   |
      | header.nva.1.value                                                      | {string:eq}(application/json)               |
      | authentication_info_result.authentication_vector.av_5G_he_aka.av_type   | {string:eq}({abotprop.SUT.AUTH.TYPE.5GAKA}) |
      | authentication_info_result.authentication_vector.av_5G_he_aka.rand      | save(5G_AKA_RAND_AT_AUSF1)                  |
      | authentication_info_result.authentication_vector.av_5G_he_aka.autn      | save(5G_AKA_AUTN_AT_AUSF1)                  |
      | authentication_info_result.authentication_vector.av_5G_he_aka.xres_star | save(5G_AKA_XRES_STAR_AT_AUSF1)             |
      | authentication_info_result.authentication_vector.av_5G_he_aka.kausf     | save(5G_AKA_KAUSF_AT_AUSF1)                 |
      | authentication_info_result.supi                                         | save(SUPI)                                  |

    When I send HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_AUTHENTICATE_RES_201 on interface N12 with the following details from node AUSF1 to AMF1:
      | parameter                                              | value                                                            |
      | header.nva.0.name                                      | :status                                                          |
      | header.nva.0.value                                     | 201                                                              |
      | header.nva.1.name                                      | location                                                         |
      | header.nva.1.value                                     | {abotprop.SUT.HEADER.NAUSF.AUTH.SUCI}                            |
      | header.nva.2.name                                      | content-type                                                     |
      | header.nva.2.value                                     | application/3gppHal+json                                         |
      | ue_authentication_ctx.auth_type                        | {abotprop.SUT.AUTH.TYPE.5GAKA}                                   |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.rand      | $(5G_AKA_RAND_AT_AUSF1)                                          |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.autn      | $(5G_AKA_AUTN_AT_AUSF1)                                          |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.hxresstar | 00000000000000000000000000000000                                 |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.kSeaf     | 0000000000000000000000000000000000000000000000000000000000000000 |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.xres_star | $(5G_AKA_XRES_STAR_AT_AUSF1)                                     |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.kausf     | $(5G_AKA_KAUSF_AT_AUSF1)                                         |
      | ue_authentication_ctx._links.linkname                  | 5g-aka                                                           |
      | ue_authentication_ctx._links.linkvalue.0.href          | {abotprop.SUT.UE.AUTH.CTX.NAUSF.AUTH.5GAKA.CONF}                 |
      | ue_authentication_ctx._links.linkvalue.1.href          | {abotprop.SUT.UE.AUTH.CTX.NAUSF.AUTH.5GAKA.CONF2}                |
      | ue_authentication_ctx.serving_network_name             | {abotprop.SUT.SERVICE.NETWORK.NAME}                              |

    Then I receive and validate HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_AUTHENTICATE_RES_201 on interface N12 with the following details on node AMF1 from AUSF1:
      | parameter                                              | value                                              |
      | header.nva.0.name                                      | {string:eq}(:status)                               |
      | header.nva.0.value                                     | {string:eq}(201)                                   |
      | header.nva.1.name                                      | {string:eq}(location)                              |
      | header.nva.1.value                                     | {string:eq}({abotprop.SUT.HEADER.NAUSF.AUTH.SUCI}) |
      | header.nva.2.name                                      | {string:eq}(content-type)                          |
      | header.nva.2.value                                     | {string:eq}(application/3gppHal+json)              |
      | ue_authentication_ctx.auth_type                        | {string:eq}({abotprop.SUT.AUTH.TYPE.5GAKA})        |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.rand      | save(5G_AKA_RAND_AT_AMF1)                          |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.autn      | save(5G_AKA_AUTN_AT_AMF1)                          |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.hxresstar | save(5G_AKA_HXRES_STAR_AT_AMF1)                    |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.kSeaf     | save(5G_AKA_KSEAF_AT_AMF1)                         |
      | ue_authentication_ctx._links.linkname                  | {string:eq}(5g-aka)                                |
      | ue_authentication_ctx._links.linkvalue.0.href          | save(NAUSF_AUTH_5G_AKA_CONF)                       |
      | ue_authentication_ctx._links.linkvalue.1.href          | save(NAUSF_AUTH_5G_AKA_CONF2)                      |
      | ue_authentication_ctx.serving_network_name             | {string:eq}({abotprop.SUT.SERVICE.NETWORK.NAME})   |

    When I send NGAP message NG_DOWNLINK_NAS_AUTHENTICATION_REQ on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                                    | value                                 |
      | amf_ue_ngap_id                                               | incr({abotprop.SUT.AMF.UE.NGAP.ID},1) |
      | ran_ue_ngap_id                                               | $(RAN_UE_NGAP_ID)                     |
      | nas_pdu.extended_protocol_discriminator                      | {abotprop.SUT.NAS.EDP}                |
      | nas_pdu.security_header_type                                 | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}     |
      | nas_pdu.message_type                                         | {abotprop.SUT.NAS.AUTN.REQ.MSG}       |
      | nas_pdu.authentication_request.nas_key_set_identifier        | {abotprop.SUT.NAS.KSI}                |
      | nas_pdu.authentication_request.abba                          | 0x0000                                |
      | nas_pdu.authentication_request.authentication_parameter_autn | $(5G_AKA_AUTN_AT_AMF1)                |
      | nas_pdu.authentication_request.authentication_parameter_rand | $(5G_AKA_RAND_AT_AMF1)                |
      | nas_pdu.authentication_request.kseaf                         | $(5G_AKA_KSEAF_AT_AMF1)               |
      | nas_pdu.authentication_request.supi                          | incr({abotprop.SUT.SUPI},1)           |

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
      | nas_pdu.authentication_request.K                             | {abotprop.SUT.5GAKA.K}                         |
      | nas_pdu.authentication_request.OP                            | {abotprop.SUT.5GAKA.OP}                        |
      | nas_pdu.authentication_request.supi                          | incr({abotprop.SUT.SUPI},1)                    |
      | nas_pdu.authentication_request.serving_network_name          | {abotprop.SUT.SERVICE.NETWORK.NAME}            |

    When I send NGAP message NG_UPLINK_NAS_AUTHENTICATION_RES on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                       | value                              |
      | amf_ue_ngap_id                                                                  | $(AMF_UE_NGAP_ID)                  |
      | ran_ue_ngap_id                                                                  | $(RAN_UE_NGAP_ID)                  |
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
      | ran_ue_ngap_id                                                                  | {string:eq}($(RAN_UE_NGAP_ID))                 |
      | nas_pdu.extended_protocol_discriminator                                         | {string:eq}({abotprop.SUT.NAS.EDP})            |
      | nas_pdu.security_header_type                                                    | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.PLAIN}) |
      | nas_pdu.message_type                                                            | {string:eq}({abotprop.SUT.NAS.AUTN.RES.MSG})   |
      | nas_pdu.authentication_response.authentication_response_parameter               | save(UE_5G_AKA_RES_STAR_AT_AMF1)               |
      | nas_pdu.authentication_response.rand                                            | $(5G_AKA_RAND_AT_AMF1)                         |
      | nas_pdu.authentication_response.hresstar                                        | {string:eq}($(5G_AKA_HXRES_STAR_AT_AMF1))      |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {string:eq}({abotprop.SUT.MCC})                |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {string:eq}({abotprop.SUT.MNC})                |
      | user_location_information.nr_user_location_information.tai.tac                  | {string:eq}({abotprop.SUT.TAC})                |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {string:eq}({abotprop.SUT.MCC})                |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {string:eq}({abotprop.SUT.MNC})                |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {string:eq}({abotprop.SUT.NR.CELL.IDN})        |

    When I send HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_5G_AKA_CONF_REQ on interface N12 with the following details from node AMF1 to AUSF1:
      | parameter                      | value                                       |
      | header.nva.0.name              | :method                                     |
      | header.nva.0.value             | PUT                                         |
      | header.nva.1.name              | :path                                       |
      | header.nva.1.value             | {abotprop.SUT.HEADER.NAUSF.AUTH.5GAKA.CONF} |
      | header.nva.2.name              | content-type                                |
      | header.nva.2.value             | application/json                            |
      | confirmation_data.res_star     | $(UE_5G_AKA_RES_STAR_AT_AMF1)               |
      | confirmation_data.supi_or_suci | incr({abotprop.SUT.SUCI},1)                 |

    Then I receive and validate HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_5G_AKA_CONF_REQ on interface N12 with the following details on node AUSF1 from AMF1:
      | parameter                      | value                                                    |
      | header.nva.0.name              | {string:eq}(:method)                                     |
      | header.nva.0.value             | {string:eq}(PUT)                                         |
      | header.nva.1.name              | {string:eq}(:path)                                       |
      | header.nva.1.value             | {string:eq}({abotprop.SUT.HEADER.NAUSF.AUTH.5GAKA.CONF}) |
      | header.nva.2.name              | {string:eq}(content-type)                                |
      | header.nva.2.value             | {string:eq}(application/json)                            |
      | confirmation_data.res_star     | {string:eq}($(5G_AKA_XRES_STAR_AT_AUSF1))                |
      | confirmation_data.supi_or_suci | save(SUCI)                                               |

    When I send HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_5G_AKA_CONF_RES_200 on interface N12 with the following details from node AUSF1 to AMF1:
      | parameter                              | value                           |
      | header.nva.0.name                      | :status                         |
      | header.nva.0.value                     | 200                             |
      | header.nva.1.name                      | content-type                    |
      | header.nva.1.value                     | application/json                |
      | confirmation_data_response.auth_result | {abotprop.SUT.AUTH.RESULT.SUCC} |
      | confirmation_data_response.supi        | incr({abotprop.SUT.SUPI},1)     |

    Then I receive and validate HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_5G_AKA_CONF_RES_200 on interface N12 with the following details on node AMF1 from AUSF1:
      | parameter                              | value                                        |
      | header.nva.0.name                      | {string:eq}(:status)                         |
      | header.nva.0.value                     | {string:eq}(200)                             |
      | header.nva.1.name                      | {string:eq}(content-type)                    |
      | header.nva.1.value                     | {string:eq}(application/json)                |
      | confirmation_data_response.auth_result | {string:eq}({abotprop.SUT.AUTH.RESULT.SUCC}) |
      | confirmation_data_response.supi        | save(SUPI)                                   |

    When I send HTTPV2 message HTTPV2_NUDM_UEAU_CONF_AUTH_REQ on interface N13 with the following details from node AUSF1 to UDM1:
      | parameter                 | value                                           |
      | header.nva.0.name         | :method                                         |
      | header.nva.0.value        | POST                                            |
      | header.nva.1.name         | :path                                           |
      | header.nva.1.value        | {abotprop.SUT.HEADER.NUDM.UEAU.AUTH.EVENT.IMSI} |
      | header.nva.2.name         | content-type                                    |
      | header.nva.2.value        | application/json                                |
      | auth_event.nf_instance_id | {abotprop.SUT.AUSF1.NFINSTANCEID}               |
      | auth_event.success        | true                                            |
      | auth_event.time_stamp     | 2020-02-24T17:00:22Z                            |
      | auth_event.auth_type      | {abotprop.SUT.AUTH.TYPE.5GAKA}                  |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UEAU_CONF_AUTH_REQ on interface N13 with the following details on node UDM1 from AUSF1:
      | parameter                 | value                                                        |
      | header.nva.0.name         | {string:eq}(:method)                                         |
      | header.nva.0.value        | {string:eq}(POST)                                            |
      | header.nva.1.name         | {string:eq}(:path)                                           |
      | header.nva.1.value        | {string:eq}({abotprop.SUT.HEADER.NUDM.UEAU.AUTH.EVENT.IMSI}) |
      | header.nva.2.name         | {string:eq}(content-type)                                    |
      | header.nva.2.value        | {string:eq}(application/json)                                |
      | auth_event.nf_instance_id | {string:eq}({abotprop.SUT.AUSF1.NFINSTANCEID})               |
      | auth_event.success        | {string:eq}(true)                                            |
      | auth_event.time_stamp     | {string:eq}(2020-02-24T17:00:22Z)                            |
      | auth_event.auth_type      | {string:eq}({abotprop.SUT.AUTH.TYPE.5GAKA})                  |

    When I send HTTPV2 message HTTPV2_NUDM_UEAU_CONF_AUTH_RES_201 on interface N13 with the following details from node UDM1 to AUSF1:
      | parameter                 | value                            |
      | header.nva.0.name         | :status                          |
      | header.nva.0.value        | 201                              |
      | header.nva.1.name         | content-type                     |
      | header.nva.1.value        | application/json                 |
      | auth_event.nf_instance_id | {abotprop.SUT.UDM1.NFINSTANCEID} |
      | auth_event.success        | true                             |
      | auth_event.time_stamp     | 2020-02-24T17:00:22Z             |
      | auth_event.auth_type      | {abotprop.SUT.AUTH.TYPE.5GAKA}   |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UEAU_CONF_AUTH_RES_201 on interface N13 with the following details on node AUSF1 from UDM1:
      | parameter                 | value                                         |
      | header.nva.0.name         | {string:eq}(:status)                          |
      | header.nva.0.value        | {string:eq}(201)                              |
      | header.nva.1.name         | {string:eq}(content-type)                     |
      | header.nva.1.value        | {string:eq}(application/json)                 |
      | auth_event.nf_instance_id | {string:eq}({abotprop.SUT.UDM1.NFINSTANCEID}) |
      | auth_event.success        | {string:eq}(true)                             |
      | auth_event.time_stamp     | {string:eq}(2020-02-24T17:00:22Z)             |
      | auth_event.auth_type      | {string:eq}({abotprop.SUT.AUTH.TYPE.5GAKA})   |

### UE Slice Selection Subscription data, NSSF get AMF Set for NSSAI

    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIBED_NSSAI_GET_REQ on interface N8 with the following details from node AMF1 to UDM1:
      | parameter          | value                                            |
      | header.nva.0.name  | :method                                          |
      | header.nva.0.value | GET                                              |
      | header.nva.1.name  | :path                                            |
      | header.nva.1.value | {abotprop.SUT.UDM.SDM.SUBSCRIBED.NSSAI.GET.PATH} |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIBED_NSSAI_GET_REQ on interface N8 with the following details on node UDM1 from AMF1:
      | parameter          | value                                                         |
      | header.nva.0.name  | {string:eq}(:method)                                          |
      | header.nva.0.value | {string:eq}(GET)                                              |
      | header.nva.1.name  | {string:eq}(:path)                                            |
      | header.nva.1.value | {string:eq}({abotprop.SUT.UDM.SDM.SUBSCRIBED.NSSAI.GET.PATH}) |

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
      | parameter          | value                                       |
      | header.nva.0.name  | :method                                     |
      | header.nva.0.value | GET                                         |
      | header.nva.1.name  | :path                                       |
      | header.nva.1.value | {abotprop.SUT.NNSSF.NSSELECTION.SLICE.INFO} |

    Then I receive and validate HTTPV2 message HTTPV2_NNSSF_NETWORK_SLICE_SELECTION_GET_REQ on interface N22 with the following details on node NSSF1 from AMF1:
      | parameter          | value                                                    |
      | header.nva.0.name  | {string:eq}(:method)                                     |
      | header.nva.0.value | {string:eq}(GET)                                         |
      | header.nva.1.name  | {string:eq}(:path)                                       |
      | header.nva.1.value | {string:eq}({abotprop.SUT.NNSSF.NSSELECTION.SLICE.INFO}) |

    When I send HTTPV2 message HTTPV2_NNSSF_NETWORK_SLICE_SELECTION_GET_RES_200 on interface N22 with the following details from node NSSF1 to AMF1:
      | parameter                                                                                                                | value                                      |
      | header.nva.0.name                                                                                                        | :status                                    |
      | header.nva.0.value                                                                                                       | 200                                        |
      | header.nva.1.name                                                                                                        | content-type                               |
      | header.nva.1.value                                                                                                       | application/json                           |
      | authorized_network_slice_info.target_amf_set                                                                             | {abotprop.SUT.TARGET.AMF.SET}              |
      | authorized_network_slice_info.allowed_nssai_list.0.allowed_nssai.allowed_snssai_list.0.allowed_snssai.allowed_snssai.sst | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB} |
      | authorized_network_slice_info.allowed_nssai_list.0.allowed_nssai.access_type                                             | {abotprop.SUT.ACCESS.TYPE.3GPP}            |

    Then I receive and validate HTTPV2 message HTTPV2_NNSSF_NETWORK_SLICE_SELECTION_GET_RES_200 on interface N22 with the following details on node AMF1 from NSSF1:
      | parameter                                                                                                                | value                                                   |
      | header.nva.0.name                                                                                                        | {string:eq}(:status)                                    |
      | header.nva.0.value                                                                                                       | {string:eq}(200)                                        |
      | header.nva.1.name                                                                                                        | {string:eq}(content-type)                               |
      | header.nva.1.value                                                                                                       | {string:eq}(application/json)                           |
      | authorized_network_slice_info.target_amf_set                                                                             | {string:eq}({abotprop.SUT.TARGET.AMF.SET})              |
      | authorized_network_slice_info.allowed_nssai_list.0.allowed_nssai.allowed_snssai_list.0.allowed_snssai.allowed_snssai.sst | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}) |
      | authorized_network_slice_info.allowed_nssai_list.0.allowed_nssai.access_type                                             | {string:eq}({abotprop.SUT.ACCESS.TYPE.3GPP})            |

### UE Security Context Setup

    When I send NGAP message NG_DOWNLINK_NAS_SECURITY_MODE_CMD on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                            | value                          |
      | amf_ue_ngap_id                                       | $(AMF_UE_NGAP_ID)              |
      | ran_ue_ngap_id                                       | $(RAN_UE_NGAP_ID)              |
      | nas_pdu.extended_protocol_discriminator              | {abotprop.SUT.NAS.EDP}         |
      | nas_pdu.security_header_type                         | 0x03                           |
      | nas_pdu.message_type                                 | {abotprop.SUT.NAS.SEC.CMD.MSG} |
      | nas_pdu.security_mode_command.nas_security_algorithm | {abotprop.SUT.NAS.SEC.ALGO}    |
      | nas_pdu.security_mode_command.nas_key_set_identifier | {abotprop.SUT.NAS.KSI}         |
      | nas_pdu.security_mode_command.ue_security_capability | {abotprop.SUT.NAS.UE.SEC.CAPA} |

    Then I receive and validate NGAP message NG_DOWNLINK_NAS_SECURITY_MODE_CMD on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                            | value                                       |
      | amf_ue_ngap_id                                       | {string:eq}($(AMF_UE_NGAP_ID))              |
      | ran_ue_ngap_id                                       | {string:eq}($(RAN_UE_NGAP_ID))              |
      | nas_pdu.extended_protocol_discriminator              | {string:eq}({abotprop.SUT.NAS.EDP})         |
      | nas_pdu.security_header_type                         | {string:eq}(0x03)                           |
      | nas_pdu.message_type                                 | {string:eq}({abotprop.SUT.NAS.SEC.CMD.MSG}) |
      | nas_pdu.security_mode_command.nas_security_algorithm | {string:eq}({abotprop.SUT.NAS.SEC.ALGO})    |
      | nas_pdu.security_mode_command.nas_key_set_identifier | {string:eq}({abotprop.SUT.NAS.KSI})         |
      | nas_pdu.security_mode_command.ue_security_capability | {string:eq}({abotprop.SUT.NAS.UE.SEC.CAPA}) |

    When I send NGAP message NG_UPLINK_NAS_SECURITY_MODE_COMPLETE on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                      | value                                     |
      | amf_ue_ngap_id                                                                                                                 | $(AMF_UE_NGAP_ID)                         |
      | ran_ue_ngap_id                                                                                                                 | $(RAN_UE_NGAP_ID)                         |
      | nas_pdu.extended_protocol_discriminator                                                                                        | {abotprop.SUT.NAS.EDP}                    |
      | nas_pdu.security_header_type                                                                                                   | 0x01                                      |
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
      | nas_pdu.security_header_type                                                                         | {string:eq}(0x01)                                      |
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
      | parameter                                       | value                                 |
      | header.nva.0.name                               | :method                               |
      | header.nva.0.value                              | PUT                                   |
      | header.nva.1.name                               | :path                                 |
      | header.nva.1.value                              | {abotprop.SUT.HEADER.REG.3GPP.ACCESS} |
      | header.nva.2.name                               | content-type                          |
      | header.nva.2.value                              | application/json                      |
      | amf_3gpp_access_registration.amf_id             | {abotprop.SUT.AMF.REG.AMF.ID}         |
      | amf_3gpp_access_registration.dereg_callback_uri | {abotprop.SUT.AMF.DEREG.CALLBACK.URI} |
      | amf_3gpp_access_registration.guami.plmn_id.mcc  | {abotprop.SUT.MCC}                    |
      | amf_3gpp_access_registration.guami.plmn_id.mnc  | {abotprop.SUT.MNC}                    |
      | amf_3gpp_access_registration.guami.amf_id       | {abotprop.SUT.AMF.REG.AMF.ID}         |
      | amf_3gpp_access_registration.rat_type           | {abotprop.SUT.RATTYPE1}               |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UECM_3GPP_ACCESS_REGISTRATION_PUT_REQ on interface N8 with the following details on node UDM1 from AMF1:
      | parameter                                       | value                                              |
      | header.nva.0.name                               | {string:eq}(:method)                               |
      | header.nva.0.value                              | {string:eq}(PUT)                                   |
      | header.nva.1.name                               | {string:eq}(:path)                                 |
      | header.nva.1.value                              | {string:eq}({abotprop.SUT.HEADER.REG.3GPP.ACCESS}) |
      | header.nva.2.name                               | {string:eq}(content-type)                          |
      | header.nva.2.value                              | {string:eq}(application/json)                      |
      | amf_3gpp_access_registration.amf_id             | save(AMF_ID)                                       |
      | amf_3gpp_access_registration.dereg_callback_uri | save(DREG_CALLBACK_URI)                            |
      | amf_3gpp_access_registration.guami.plmn_id.mcc  | save(GUAMI_PLMN_MCC)                               |
      | amf_3gpp_access_registration.guami.plmn_id.mnc  | save(GUAMI_PLMN_MNC)                               |
      | amf_3gpp_access_registration.guami.amf_id       | save(GUAMI_AMF_ID)                                 |
      | amf_3gpp_access_registration.rat_type           | save(RAT_TYPE)                                     |

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
      | parameter          | value                                  |
      | header.nva.0.name  | :method                                |
      | header.nva.0.value | GET                                    |
      | header.nva.1.name  | :path                                  |
      | header.nva.1.value | {abotprop.SUT.HEADER.NUDM.SDM.DATASET} |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_GET_REQ on interface N8 with the following details on node UDM1 from AMF1:
      | parameter          | value                                               |
      | header.nva.0.name  | {string:eq}(:method)                                |
      | header.nva.0.value | {string:eq}(GET)                                    |
      | header.nva.1.name  | {string:eq}(:path)                                  |
      | header.nva.1.value | {string:eq}({abotprop.SUT.HEADER.NUDM.SDM.DATASET}) |

    When I send HTTPV2 message HTTPV2_NUDM_SDM_GET_RES_200 on interface N8 with the following details from node UDM1 to AMF1:
      | parameter                                                                                         | value                                      |
      | header.nva.0.name                                                                                 | :status                                    |
      | header.nva.0.value                                                                                | 200                                        |
      | header.nva.1.name                                                                                 | content-type                               |
      | header.nva.1.value                                                                                | application/json                           |
      | subscription_data_sets.am_data.gpsis.0.gpsi                                                       | {abotprop.SUT.GPSI.START}                  |
      | subscription_data_sets.am_data.subscribed_ue_ambr.uplink                                          | {abotprop.SUT.UE.AMBR.UL}                  |
      | subscription_data_sets.am_data.subscribed_ue_ambr.downlink                                        | {abotprop.SUT.UE.AMBR.DL}                  |
      | subscription_data_sets.am_data.nssai.default_single_nssais.0.snssai.sst                           | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB} |
      | subscription_data_sets.am_data.rat_restrictions.0.rat_type                                        | {abotprop.SUT.RATTYPE1}                    |
      | subscription_data_sets.am_data.rat_restrictions.1.rat_type                                        | {abotprop.SUT.RATTYPE2}                    |
      | subscription_data_sets.am_data.core_network_type_restrictions.0.core_network_type                 | 5GC                                        |
      | subscription_data_sets.smf_sel_data.subscribed_snssai_info.0.snssai_info.single_nssai.sst         | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB} |
      | subscription_data_sets.smf_sel_data.subscribed_snssai_info.0.snssai_info.dnn_infos.0.dnn_info.dnn | {abotprop.SUT.DNN1}                        |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_GET_RES_200 on interface N8 with the following details on node AMF1 from UDM1:
      | parameter                                                                                         | value                                                   |
      | header.nva.0.name                                                                                 | {string:eq}(:status)                                    |
      | header.nva.0.value                                                                                | {string:eq}(200)                                        |
      | header.nva.1.name                                                                                 | {string:eq}(content-type)                               |
      | header.nva.1.value                                                                                | {string:eq}(application/json)                           |
      | subscription_data_sets.am_data.gpsis.0.gpsi                                                       | {string:eq}({abotprop.SUT.GPSI.START})                  |
      | subscription_data_sets.am_data.subscribed_ue_ambr.uplink                                          | {string:eq}({abotprop.SUT.UE.AMBR.UL})                  |
      | subscription_data_sets.am_data.subscribed_ue_ambr.downlink                                        | {string:eq}({abotprop.SUT.UE.AMBR.DL})                  |
      | subscription_data_sets.am_data.nssai.default_single_nssais.0.snssai.sst                           | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}) |
      | subscription_data_sets.am_data.rat_restrictions.0.rat_type                                        | {string:eq}({abotprop.SUT.RATTYPE1})                    |
      | subscription_data_sets.am_data.rat_restrictions.1.rat_type                                        | {string:eq}({abotprop.SUT.RATTYPE2})                    |
      | subscription_data_sets.am_data.core_network_type_restrictions.0.core_network_type                 | {string:eq}(5GC)                                        |
      | subscription_data_sets.smf_sel_data.subscribed_snssai_info.0.snssai_info.single_nssai.sst         | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}) |
      | subscription_data_sets.smf_sel_data.subscribed_snssai_info.0.snssai_info.dnn_infos.0.dnn_info.dnn | {string:eq}({abotprop.SUT.DNN1})                        |

    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_REQ on interface N8 with the following details from node AMF1 to UDM1:
      | parameter                                      | value                                       |
      | header.nva.0.name                              | :method                                     |
      | header.nva.0.value                             | POST                                        |
      | header.nva.1.name                              | :path                                       |
      | header.nva.1.value                             | {abotprop.SUT.SDM.SUBSCRIPTIONS}            |
      | header.nva.2.name                              | content-type                                |
      | header.nva.2.value                             | application/json                            |
      | sdm_subscription.callback_reference            | {abotprop.SUT.SDM.SUB.CALLBACK.NOTIFY}      |
      | sdm_subscription.monitored_resource_uris.0.uri | {abotprop.SUT.SDM.SUB.MONITOR.RESOURCE.URI} |
      | sdm_subscription.nf_instance_id                | 668611d7-2ea0-42a3-a06d-d4bea2ac65eb        |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_REQ on interface N8 with the following details on node UDM1 from AMF1:
      | parameter                                      | value                                             |
      | header.nva.0.name                              | {string:eq}(:method)                              |
      | header.nva.0.value                             | {string:eq}(POST)                                 |
      | header.nva.1.name                              | {string:eq}(:path)                                |
      | header.nva.1.value                             | {string:eq}({abotprop.SUT.SDM.SUBSCRIPTIONS})     |
      | header.nva.2.name                              | {string:eq}(content-type)                         |
      | header.nva.2.value                             | {string:eq}(application/json)                     |
      | sdm_subscription.callback_reference            | save(SUB_CALLBACK_NOTIFY)                         |
      | sdm_subscription.monitored_resource_uris.0.uri | save(SUB_MONITORED_RESOURCE_URI)                  |
      | sdm_subscription.nf_instance_id                | {string:eq}(668611d7-2ea0-42a3-a06d-d4bea2ac65eb) |

    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_RES_201 on interface N8 with the following details from node UDM1 to AMF1:
      | parameter                                      | value                                                                                       |
      | header.nva.0.name                              | :status                                                                                     |
      | header.nva.0.value                             | 201                                                                                         |
      | header.nva.1.name                              | location                                                                                    |
      | header.nva.1.value                             | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscriptions/subscriptionId1 |
      | header.nva.2.name                              | content-type                                                                                |
      | header.nva.2.value                             | application/json                                                                            |
      | sdm_subscription.callback_reference            | {abotprop.SUT.SDM.SUB.CALLBACK.NOTIFY}                                                      |
      | sdm_subscription.monitored_resource_uris.0.uri | {abotprop.SUT.SDM.SUB.MONITOR.RESOURCE.URI}                                                 |
      | sdm_subscription.nf_instance_id                | 668611d7-2ea0-42a3-a06d-d4bea2ac65eb                                                        |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_RES_201 on interface N8 with the following details on node AMF1 from UDM1:
      | parameter                                      | value                                                                                                    |
      | header.nva.0.name                              | {string:eq}(:status)                                                                                     |
      | header.nva.0.value                             | {string:eq}(201)                                                                                         |
      | header.nva.1.name                              | {string:eq}(location)                                                                                    |
      | header.nva.1.value                             | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscriptions/subscriptionId1) |
      | header.nva.2.name                              | {string:eq}(content-type)                                                                                |
      | header.nva.2.value                             | {string:eq}(application/json)                                                                            |
      | sdm_subscription.callback_reference            | save(SUB_CALLBACK_NOTIFY)                                                                                |
      | sdm_subscription.monitored_resource_uris.0.uri | save(SUB_MONITOR_RESOURCE_URI)                                                                           |
      | sdm_subscription.nf_instance_id                | {string:eq}(668611d7-2ea0-42a3-a06d-d4bea2ac65eb)                                                        |

    When I send NGAP message NG_INIT_CTXT_SET_REQ_NAS_REGIS_ACC on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                                                                       | value                                                            |
      | amf_ue_ngap_id                                                                                  | $(AMF_UE_NGAP_ID)                                                |
      | ran_ue_ngap_id                                                                                  | $(RAN_UE_NGAP_ID)                                                |
      | nas_pdu.extended_protocol_discriminator                                                         | {abotprop.SUT.NAS.EDP}                                           |
      | nas_pdu.security_header_type                                                                    | 0x01                                                             |
      | nas_pdu.message_type                                                                            | {abotprop.SUT.NAS.REG.ACC.MSG}                                   |
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
      | guami.plmn_identity.mcc                                                                         | {abotprop.SUT.MCC}                                               |
      | guami.plmn_identity.mnc                                                                         | {abotprop.SUT.MNC}                                               |
      | guami.amf_region_id                                                                             | {abotprop.SUT.GUAMI.AMF.REGION.ID}                               |
      | guami.amf_set_id                                                                                | {abotprop.SUT.GUAMI.AMF.SET.ID}                                  |
      | guami.pointer.amf_pointer                                                                       | {abotprop.SUT.GUAMI.AMF.POINTER}                                 |
      | allowed_s-nssai_list.0.sst                                                                      | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}                       |
      | ue_security_capabilities.nr_encryption_algo                                                     | 0xc000                                                           |
      | ue_security_capabilities.nr_integrity_protection_algo                                           | 0xc000                                                           |
      | ue_security_capabilities.e_utra_encryption_algo                                                 | 0x0000                                                           |
      | ue_security_capabilities.e_utra_integrity_protection_algo                                       | 0x0000                                                           |
      | security_key                                                                                    | a8202f2d5e1d4307b751e0ac558025f2865d9c25eebb409d9a5560145dd8e765 |

    Then I receive and validate NGAP message NG_INIT_CTXT_SET_REQ_NAS_REGIS_ACC on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                                                                       | value                                                                         |
      | amf_ue_ngap_id                                                                                  | {string:eq}($(AMF_UE_NGAP_ID))                                                |
      | ran_ue_ngap_id                                                                                  | {string:eq}($(RAN_UE_NGAP_ID))                                                |
      | nas_pdu.extended_protocol_discriminator                                                         | {string:eq}({abotprop.SUT.NAS.EDP})                                           |
      | nas_pdu.security_header_type                                                                    | {string:eq}(0x01)                                                             |
      | nas_pdu.message_type                                                                            | {string:eq}({abotprop.SUT.NAS.REG.ACC.MSG})                                   |
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
      | guami.plmn_identity.mcc                                                                         | {string:eq}({abotprop.SUT.MCC})                                               |
      | guami.plmn_identity.mnc                                                                         | {string:eq}({abotprop.SUT.MNC})                                               |
      | guami.amf_region_id                                                                             | {string:eq}({abotprop.SUT.GUAMI.AMF.REGION.ID})                               |
      | guami.amf_set_id                                                                                | {string:eq}({abotprop.SUT.GUAMI.AMF.SET.ID})                                  |
      | guami.pointer.amf_pointer                                                                       | {string:eq}({abotprop.SUT.GUAMI.AMF.POINTER})                                 |
      | allowed_s-nssai_list.0.sst                                                                      | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB})                       |
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
      | parameter                                                                       | value                          |
      | amf_ue_ngap_id                                                                  | $(AMF_UE_NGAP_ID)              |
      | ran_ue_ngap_id                                                                  | $(RAN_UE_NGAP_ID)              |
      | nas_pdu.extended_protocol_discriminator                                         | {abotprop.SUT.NAS.EDP}         |
      | nas_pdu.security_header_type                                                    | 0x01                           |
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
      | ran_ue_ngap_id                                                                  | {string:eq}($(RAN_UE_NGAP_ID))              |
      | nas_pdu.extended_protocol_discriminator                                         | {string:eq}({abotprop.SUT.NAS.EDP})         |
      | nas_pdu.security_header_type                                                    | {string:eq}(0x01)                           |
      | nas_pdu.message_type                                                            | {string:eq}({abotprop.SUT.NAS.REG.COM.MSG}) |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {string:eq}({abotprop.SUT.MCC})             |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {string:eq}({abotprop.SUT.MNC})             |
      | user_location_information.nr_user_location_information.tai.tac                  | {string:eq}({abotprop.SUT.TAC})             |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {string:eq}({abotprop.SUT.MCC})             |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {string:eq}({abotprop.SUT.MNC})             |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {string:eq}({abotprop.SUT.NR.CELL.IDN})     |

    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTION_MODIFICATION_PATCH_REQ on interface N10 with the following details from node SMF1 to UDM1:
      | parameter                     | value                                                                                       |
      | header.nva.0.name             | :method                                                                                     |
      | header.nva.0.value            | PATCH                                                                                       |
      | header.nva.1.name             | :path                                                                                       |
      | header.nva.1.value            | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscriptions/subscriptionId1 |
      | header.nva.2.name             | content-type                                                                                |
      | header.nva.2.value            | application/merge-patch+json                                                                |
      | sdm_subs_modification.expires | 10000000                                                                                    |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTION_MODIFICATION_PATCH_REQ on interface N10 with the following details on node UDM1 from SMF1:
      | parameter                     | value                                                                                                    |
      | header.nva.0.name             | {string:eq}(:method)                                                                                     |
      | header.nva.0.value            | {string:eq}(PATCH)                                                                                       |
      | header.nva.1.name             | {string:eq}(:path)                                                                                       |
      | header.nva.1.value            | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscriptions/subscriptionId1) |
      | header.nva.2.name             | {string:eq}(content-type)                                                                                |
      | header.nva.2.value            | {string:eq}(application/merge-patch+json}                                                                |
      | sdm_subs_modification.expires | {string:eq}(10000000)                                                                                    |

    
    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTION_MODIFICATION_PATCH_RES_200 on interface N10 with the following details from node UDM1 to SMF1:
      | parameter                                      | value                                                                                           |
      | header.nva.0.name                              | :status                                                                                         |
      | header.nva.0.value                             | 200                                                                                             |
      | header.nva.1.name                              | content                                                                                         |
      | header.nva.1.value                             | application/json                                                                                |
      | sdm_subscription.callback_reference            | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/callback-subs-notify |
      | sdm_subscription.nf_instance_id                | 668611d7-2ea0-42a3-a06d-d4bea2ac65eb                                                            |
      | sdm_subscription.monitored_resource_uris.0.uri | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/                     |
      | sdm_subscription.expires                       | 10000000                                                                                        |
	  
    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTION_MODIFICATION_PATCH_RES_200 on interface N10 with the following details on node SMF1 from UDM1:
      | parameter                                      | value                                                                                                        |
      | header.nva.0.name                              | {string:eq}(:status)                                                                                         |
      | header.nva.0.value                             | {string:eq}(200)                                                                                             |
      | header.nva.1.name                              | {string:eq}(content)                                                                                         |
      | header.nva.1.value                             | {string:eq}(application/json)                                                                                |
      | sdm_subscription.callback_reference            | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/callback-subs-notify) |
      | sdm_subscription.nf_instance_id                | {string:eq}(668611d7-2ea0-42a3-a06d-d4bea2ac65eb)                                                            |
      | sdm_subscription.monitored_resource_uris.0.uri | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/)                     |
      | sdm_subscription.expires                       | {string:eq}(10000000)                                                                                        |
	  
##SMF Subscribes to be Notified via the following message

    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_REQ on interface N10 with the following details from node SMF1 to UDM1:
      | parameter                                      | value                                                                                           |
      | header.nva.0.name                              | :method                                                                                         |
      | header.nva.0.value                             | POST                                                                                            |
      | header.nva.1.name                              | :path                                                                                           |
      | header.nva.1.value                             | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscriptions                     |
      | header.nva.2.name                              | content-type                                                                                    |
      | header.nva.2.value                             | application/json                                                                                |
      | sdm_subscription.callback_reference            | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/callback-subs-notify |
      | sdm_subscription.monitored_resource_uris.0.uri | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/                     |
      | sdm_subscription.nf_instance_id                | 668611d7-2ea0-42a3-a06d-d4bea2ac65eb                                                            |
	  
    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_REQ on interface N10 with the following details on node UDM1 from SMF1:
      | parameter                                      | value                                                                                                        |
      | header.nva.0.name                              | {string:eq}(:method)                                                                                         |
      | header.nva.0.value                             | {string:eq}(POST)                                                                                            |
      | header.nva.1.name                              | {string:eq}(:path)                                                                                           |
      | header.nva.1.value                             | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscriptions)                     |
      | header.nva.2.name                              | {string:eq}(content-type)                                                                                    |
      | header.nva.2.value                             | {string:eq}(application/json)                                                                                |
      | sdm_subscription.callback_reference            | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/callback-subs-notify) |
      | sdm_subscription.monitored_resource_uris.0.uri | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/)                     |
      | sdm_subscription.nf_instance_id                | {string:eq}(668611d7-2ea0-42a3-a06d-d4bea2ac65eb)                                                            |

###use in case of smf below
	
    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_RES_201 on interface N10 with the following details from node UDM1 to SMF1:
      | parameter                                      | value                                                                                           |
      | header.nva.0.name                              | :status                                                                                         |
      | header.nva.0.value                             | 201                                                                                             |
      | header.nva.1.name                              | location                                                                                        |
      | header.nva.1.value                             | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscriptions/subscriptionId1     |
      | header.nva.2.name                              | content-type                                                                                    |
      | header.nva.2.value                             | application/json                                                                                |
      | sdm_subscription.callback_reference            | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/callback-subs-notify |
      | sdm_subscription.monitored_resource_uris.0.uri | /127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/smData               |
      | sdm_subscription.nf_instance_id                | 668611d7-2ea0-42a3-a06d-d4bea2ac65eb                                                            |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_RES_201 on interface N10 with the following details on node SMF1 from UDM1:
      | parameter                                      | value                                                                                                        |
      | header.nva.0.name                              | {string:eq}(:status)                                                                                         |
      | header.nva.0.value                             | {string:eq}(201)                                                                                             |
      | header.nva.1.name                              | {string:eq}(location)                                                                                        |
      | header.nva.1.value                             | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscriptions/subscriptionId1)     |
      | header.nva.2.name                              | {string:eq}(content-type)                                                                                    |
      | header.nva.2.value                             | {string:eq}(application/json)                                                                                |
      | sdm_subscription.callback_reference            | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/callback-subs-notify) |
      | sdm_subscription.monitored_resource_uris.0.uri | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr(imsi-404309990000001,1)/sdm-subscription/smData)               |
      | sdm_subscription.nf_instance_id                | {string:eq}(668611d7-2ea0-42a3-a06d-d4bea2ac65eb)                                                            |
	
