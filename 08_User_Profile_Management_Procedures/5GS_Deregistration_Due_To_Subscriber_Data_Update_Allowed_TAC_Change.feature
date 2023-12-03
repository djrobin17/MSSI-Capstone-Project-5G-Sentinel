@5gs-ntwk-dereg-due-to-subs-update @08-usr-prof-mgmt-proc @23502-5gs @5g-core-sanity @5g-core

Feature: User Profile Management Feature

  Scenario: Network Initiated Detach due to Subsciption Update - Allowed TACs are changed in UDM

    Given the steps below will be executed at the end
    When I run the SSH command {abotprop.SUT.DEFAULT.GENB.CONFIG} at node gNodeB1
    When I run the SSH command {abotprop.SUT.DEFAULT.AMF.CONFIG} at node AMF1
    Then the ending steps are complete
    Given the test data is in file /featureFiles/MESSAGE_BUNDLES/EPC_MESSAGES.xml

    When I run the SSH command {abotprop.SUT.CUSTOM.GENB.CONFIG} and pause for {abotprop.WAIT_5_SEC} seconds at node gNodeB1
    When I run the SSH command {abotprop.SUT.CUSTOM.ENB.CONFIG} and pause for {abotprop.WAIT_5_SEC} seconds at node AMF1

    Given all configured endpoints for EPC are connected successfully

    Given that I execute dependency feature /featureFiles/3GPP-23502-5G/01_Interface_Management_Procedures/01_gNB_AMF_procedures/01_NG_Setup_Procedure/NG_Setup_Request.feature
     
    When I send PFCP message PFCP_ASSOCIATION_SETUP_REQ on interface N4 with the following details from node SMF1 to UPF1:
      | parameter            | value                                               |
      | header.message_type  | {abotprop.SUT.PFCP.HEADER.MSG.TYPE.ASSOCIATION.REQ} |
      | header.seq_number    | incr(1,4)                                           |
      | node_id.type         | {abotprop.SUT.PFCP_NODE_ID_TYPE}                    |
      | node_id.value        | {abotprop.SUT.PFCP_NODE_ID}                         |
      | cp_function_features | {abotprop.SUT.CP_FUNC_FEATURES}                     |
      | recovery_timestamp   | {abotprop.SUT.PFCP_RECOVERY_TIMESTAMP}              |

    Then I receive and validate PFCP message PFCP_ASSOCIATION_SETUP_REQ on interface N4 with the following details on node UPF1 from SMF1:
      | parameter            | value                                                            |
      | header.message_type  | {string:eq}({abotprop.SUT.PFCP.HEADER.MSG.TYPE.ASSOCIATION.REQ}) |
      | header.seq_number    | save(PFCP_HDR_SEQ_NO)                                            |
      | node_id.type         | {string:eq}({abotprop.SUT.PFCP_NODE_ID_TYPE})                    |
      | node_id.value        | {string:eq}({abotprop.SUT.PFCP_NODE_ID})                         |
      | cp_function_features | save(CP_FUNC_FEATURES)                                           |
      | recovery_timestamp   | save(CP_RECOVERY_TIMESTAMP)                                      |

    When I send PFCP message PFCP_ASSOCIATION_SETUP_RES on interface N4 with the following details from node UPF1 to SMF1:
      | parameter            | value                                               |
      | header.message_type  | {abotprop.SUT.PFCP.HEADER.MSG.TYPE.ASSOCIATION.RES} |
      | header.seq_number    | $(PFCP_HDR_SEQ_NO)                                  |
      | node_id.type         | {abotprop.SUT.PFCP_NODE_ID_TYPE}                    |
      | node_id.value        | {abotprop.SUT.PFCP_NODE_ID}                         |
      | up_function_features | {abotprop.SUT.PFCP_UP_FUNC_FEATURES}                |
      | cause                | {abotprop.SUT.PFCP_REQUEST_ACCEPTED}                |
      | recovery_timestamp   | {abotprop.SUT.PFCP_RECOVERY_TIMESTAMP}              |

    Then I receive and validate PFCP message PFCP_ASSOCIATION_SETUP_RES on interface N4 with the following details on node SMF1 from UPF1:
      | parameter            | value                                                            |
      | header.message_type  | {string:eq}({abotprop.SUT.PFCP.HEADER.MSG.TYPE.ASSOCIATION.RES}) |
      | header.seq_number    | save(PFCP_HDR_SEQ_NO)                                            |
      | node_id.type         | {string:eq}({abotprop.SUT.PFCP_NODE_ID_TYPE})                    |
      | node_id.value        | {string:eq}({abotprop.SUT.PFCP_NODE_ID})                         |
      | up_function_features | save(UP_FUNC_FEATURES)                                           |
      | cause                | {string:eq}({abotprop.SUT.PFCP_REQUEST_ACCEPTED})                |
      | recovery_timestamp   | save(UP_RECOVERY_TIMESTAMP)                                      |

### UE Initial Registration

    When I send NGAP message NG_INIT_UE_MSG_NAS_REGIS_REQ on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                         | value                                     |
      | ran_ue_ngap_id                                                                    | incr(4294967295,1)                        |
      | nas_pdu.extended_protocol_discriminator                                           | {abotprop.SUT.NAS.EDP}                    |
      | nas_pdu.security_header_type                                                      | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}         |
      | nas_pdu.message_type                                                              | {abotprop.SUT.NAS.REG.REQ.MSG}            |
      | nas_pdu.registration_request.5gs_registration_type                                | {abotprop.SUT.NAS.5GS.REG.TYPE.INI.REG}   |
      | nas_pdu.registration_request.nas_key_set_identifier                               | {abotprop.SUT.UE.NAS.KSI_NONE}            |
      | nas_pdu.registration_request.5gs_mob_id_choice.type_of_id                         | {abotprop.SUT.NAS.5GS_MOB_ID.TYPE.SUCI}   |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_format                   | {abotprop.SUT.NAS.5GS_MOB_ID.SUPI_FORMAT} |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_netwrk_id.mcc  | {abotprop.SUT.MCC}                        |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_netwrk_id.mnc  | {abotprop.SUT.MNC}                        |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.routing_ind         | 0                                         |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.prot_scheme_id      | 0                                         |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.home_net_pub_key_id | 0                                         |
      | nas_pdu.registration_request.5gs_mob_id_choice.suci.supi_imsi.msin                | incr({abotprop.SUT.NAS.5GS.MOB.MSIN},1)   |
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
      | parameter                                                                       | value                                                |
      | ran_ue_ngap_id                                                                  | save(RAN_UE_NGAP_ID)                                 |
      | nas_pdu.extended_protocol_discriminator                                         | {string:eq}({abotprop.SUT.NAS.EDP})                  |
      | nas_pdu.security_header_type                                                    | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.PLAIN})       |
      | nas_pdu.message_type                                                            | {string:eq}({abotprop.SUT.NAS.REG.REQ.MSG})          |
      | nas_pdu.registration_request.5gs_registration_type                              | {string:eq}({abotprop.SUT.NAS.5GS.REG.TYPE.INI.REG}) |
      | nas_pdu.registration_request.5gs_mobile_identity                                | save(MOBILE_IDENTITY_5GS)                            |
      | nas_pdu.registration_request.ue_security_capability                             | {string:eq}({abotprop.SUT.NAS.UE.SEC.CAPA})          |
      | nas_pdu.registration_request.ue_status                                          | {string:eq}({abotprop.SUT.NAS.UE.STAT})              |
      | rrc_establishment_cause                                                         | {string:eq}({abotprop.SUT.RRC.ESTD.CAUSE})           |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {string:eq}({abotprop.SUT.MCC})                      |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {string:eq}({abotprop.SUT.MNC})                      |
      | user_location_information.nr_user_location_information.tai.tac                  | {string:eq}({abotprop.SUT.TAC})                      |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {string:eq}({abotprop.SUT.MCC})                      |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {string:eq}({abotprop.SUT.MNC})                      |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {string:eq}({abotprop.SUT.NR.CELL.IDN})              |
      | ue_context_request                                                              | {string:eq}(0)                                       |

    When I send HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_AUTHENTICATE_REQ on interface N12 with the following details from node AMF1 to AUSF1:
      | parameter                                | value                                             |
      | header.nva.0.name                        | :method                                           |
      | header.nva.0.value                       | POST                                              |
      | header.nva.1.name                        | :path                                             |
      | header.nva.1.value                       | /127.0.0.1:12348/nausf-auth/v1/ue-authentications |
      | header.nva.2.name                        | content-type                                      |
      | header.nva.2.value                       | application/json                                  |
      | authentication_info.supi_or_suci         | incr($({abotprop.SUT.SUCI}),1)                    |
      | authentication_info.serving_network_name | {abotprop.SUT.SERVICE.NETWORK.NAME}               |
      | authentication_info.amf_instance_id      | {abotprop.SUT.AMF1.NFINSTANCEID}                  |

    Then I receive and validate HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_AUTHENTICATE_REQ on interface N12 with the following details on node AUSF1 from AMF1:
      | parameter                                | value                                                          |
      | header.nva.0.name                        | {string:eq}(:method)                                           |
      | header.nva.0.value                       | {string:eq}(POST)                                              |
      | header.nva.1.name                        | {string:eq}(:path)                                             |
      | header.nva.1.value                       | {string:eq}(/127.0.0.1:12348/nausf-auth/v1/ue-authentications) |
      | header.nva.2.name                        | {string:eq}(content-type)                                      |
      | header.nva.2.value                       | {string:eq}(application/json)                                  |
      | authentication_info.supi_or_suci         | save(SUCI)                                                     |
      | authentication_info.serving_network_name | {string:eq}({abotprop.SUT.SERVICE.NETWORK.NAME})               |
      | authentication_info.amf_instance_id      | {string:eq}({abotprop.SUT.AMF1.NFINSTANCEID})                  |

    When I send HTTPV2 message HTTPV2_NUDM_UEAU_GEN_AUTH_DATA_REQ on interface N13 with the following details from node AUSF1 to UDM1:
      | parameter                                        | value                                                                                                |
      | header.nva.0.name                                | :method                                                                                              |
      | header.nva.0.value                               | POST                                                                                                 |
      | header.nva.1.name                                | :path                                                                                                |
      | header.nva.1.value                               | /127.0.0.1:12348/nudm-ueau/v1/incr($({abotprop.SUT.SUCI}),1)/security-information/generate-auth-data |
      | header.nva.2.name                                | content-type                                                                                         |
      | header.nva.2.value                               | application/json                                                                                     |
      | authentication_info_request.serving_network_name | {abotprop.SUT.SERVICE.NETWORK.NAME}                                                                  |
      | authentication_info_request.ausf_instance_id     | {abotprop.SUT.AUSF1.NFINSTANCEID}                                                                    |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UEAU_GEN_AUTH_DATA_REQ on interface N13 with the following details on node UDM1 from AUSF1:
      | parameter                                        | value                                                                                                             |
      | header.nva.0.name                                | {string:eq}(:method)                                                                                              |
      | header.nva.0.value                               | {string:eq}(POST)                                                                                                 |
      | header.nva.1.name                                | {string:eq}(:path)                                                                                                |
      | header.nva.1.value                               | {string:eq}(/127.0.0.1:12348/nudm-ueau/v1/incr($({abotprop.SUT.SUCI}),1)/security-information/generate-auth-data) |
      | header.nva.2.name                                | {string:eq}(content-type)                                                                                         |
      | header.nva.2.value                               | {string:eq}(application/json)                                                                                     |
      | authentication_info_request.serving_network_name | {string:eq}({abotprop.SUT.SERVICE.NETWORK.NAME})                                                                  |
      | authentication_info_request.ausf_instance_id     | {string:eq}({abotprop.SUT.AUSF1.NFINSTANCEID})                                                                    |

    When I send HTTPV2 message HTTPV2_NUDM_UEAU_GEN_AUTH_DATA_RES_200 on interface N13 with the following details from node UDM1 to AUSF1:
      | parameter                                                                          | value                               |
      | header.nva.0.name                                                                  | :status                             |
      | header.nva.0.value                                                                 | 200                                 |
      | header.nva.1.name                                                                  | content-type                        |
      | header.nva.1.value                                                                 | application/json                    |
      | authentication_info_result.authentication_vector.av_5G_he_aka.av_type              | {abotprop.SUT.AUTH.TYPE.5GAKA}      |
      | authentication_info_result.authentication_vector.av_5G_he_aka.rand                 | {abotprop.SUT.5GAKA.RAND}           |
      | authentication_info_result.authentication_vector.av_5G_he_aka.autn                 | 00000000000000000000000000000000    |
      | authentication_info_result.authentication_vector.av_5G_he_aka.xres_star            | {abotprop.SUT.5GAKA.XRES.STAR}      |
      | authentication_info_result.authentication_vector.av_5G_he_aka.kausf                | {abotprop.SUT.5GAKA.KAUSF}          |
      | authentication_info_result.authentication_vector.av_5G_he_aka.serving_network_name | {abotprop.SUT.SERVICE.NETWORK.NAME} |
      | authentication_info_result.authentication_vector.av_5G_he_aka.AMF                  | {abotprop.SUT.5GAKA.AMF}            |
      | authentication_info_result.authentication_vector.av_5G_he_aka.K                    | {abotprop.SUT.5GAKA.K}              |
      | authentication_info_result.authentication_vector.av_5G_he_aka.OP                   | {abotprop.SUT.5GAKA.OP}             |
      | authentication_info_result.supi                                                    | incr({abotprop.SUT.SUPI},1)         |
      | authentication_info_result.authentication_vector.av_5G_he_aka.seq_no               | {abotprop.SUT.5GAKA.SQN}            |

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
      | parameter                                              | value                                                                                                       |
      | header.nva.0.name                                      | :status                                                                                                     |
      | header.nva.0.value                                     | 201                                                                                                         |
      | header.nva.1.name                                      | location                                                                                                    |
      | header.nva.1.value                                     | /127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr($({abotprop.SUT.SUCI}),1)                            |
      | header.nva.2.name                                      | content-type                                                                                                |
      | header.nva.2.value                                     | application/3gppHal+json                                                                                    |
      | ue_authentication_ctx.auth_type                        | {abotprop.SUT.AUTH.TYPE.5GAKA}                                                                              |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.rand      | $(5G_AKA_RAND_AT_AUSF1)                                                                                     |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.autn      | $(5G_AKA_AUTN_AT_AUSF1)                                                                                     |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.hxresstar | 00000000000000000000000000000000                                                                            |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.kSeaf     | 0000000000000000000000000000000000000000000000000000000000000000                                            |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.xres_star | $(5G_AKA_XRES_STAR_AT_AUSF1)                                                                                |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.kausf     | $(5G_AKA_KAUSF_AT_AUSF1)                                                                                    |
      | ue_authentication_ctx._links.linkname                  | 5g-aka                                                                                                      |
      | ue_authentication_ctx._links.linkvalue.0.href          | http://127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr($({abotprop.SUT.SUCI}),1)/5g-aka-confirmation  |
      | ue_authentication_ctx._links.linkvalue.1.href          | http://127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr($({abotprop.SUT.SUCI}),1)/5g-aka-confirmation2 |
      | ue_authentication_ctx.serving_network_name             | {abotprop.SUT.SERVICE.NETWORK.NAME}                                                                         |

    Then I receive and validate HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_AUTHENTICATE_RES_201 on interface N12 with the following details on node AMF1 from AUSF1:
      | parameter                                              | value                                                                                                                    |
      | header.nva.0.name                                      | {string:eq}(:status)                                                                                                     |
      | header.nva.0.value                                     | {string:eq}(201)                                                                                                         |
      | header.nva.1.name                                      | {string:eq}(location)                                                                                                    |
      | header.nva.1.value                                     | {string:eq}(/127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr($({abotprop.SUT.SUCI}),1))                            |
      | header.nva.2.name                                      | {string:eq}(content-type)                                                                                                |
      | header.nva.2.value                                     | {string:eq}(application/3gppHal+json)                                                                                    |
      | ue_authentication_ctx.auth_type                        | {string:eq}({abotprop.SUT.AUTH.TYPE.5GAKA})                                                                              |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.rand      | save(5G_AKA_RAND_AT_AMF1)                                                                                                |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.autn      | save(5G_AKA_AUTN_AT_AMF1)                                                                                                |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.hxresstar | save(5G_AKA_HXRES_STAR_AT_AMF1)                                                                                          |
      | ue_authentication_ctx.5g_auth_data.av_5g_aka.kSeaf     | save(5G_AKA_KSEAF_AT_AMF1)                                                                                               |
      | ue_authentication_ctx._links.linkname                  | {string:eq}(5g-aka)                                                                                                      |
      | ue_authentication_ctx._links.linkvalue.0.href          | {string:eq}(http://127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr($({abotprop.SUT.SUCI}),1)/5g-aka-confirmation)  |
      | ue_authentication_ctx._links.linkvalue.1.href          | {string:eq}(http://127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr($({abotprop.SUT.SUCI}),1)/5g-aka-confirmation2) |
      | ue_authentication_ctx.serving_network_name             | {string:eq}({abotprop.SUT.SERVICE.NETWORK.NAME})                                                                         |

    When I send NGAP message NG_DOWNLINK_NAS_AUTHENTICATION_REQ on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                                    | value                             |
      | amf_ue_ngap_id                                               | {abotprop.SUT.AMF.UE.NGAP.ID}     |
      | ran_ue_ngap_id                                               | $(RAN_UE_NGAP_ID)                 |
      | nas_pdu.extended_protocol_discriminator                      | {abotprop.SUT.NAS.EDP}            |
      | nas_pdu.security_header_type                                 | {abotprop.SUT.NAS.SEC.HEAD.PLAIN} |
      | nas_pdu.message_type                                         | {abotprop.SUT.NAS.AUTN.REQ.MSG}   |
      | nas_pdu.authentication_request.nas_key_set_identifier        | {abotprop.SUT.NAS.KSI}            |
      | nas_pdu.authentication_request.abba                          | 0x0000                            |
      | nas_pdu.authentication_request.authentication_parameter_autn | $(5G_AKA_AUTN_AT_AMF1)            |
      | nas_pdu.authentication_request.authentication_parameter_rand | $(5G_AKA_RAND_AT_AMF1)            |
      | nas_pdu.authentication_request.kseaf                         | $(5G_AKA_KSEAF_AT_AMF1)           |
      | nas_pdu.authentication_request.supi                          | incr({abotprop.SUT.SUPI},1)       |

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
      | nas_pdu.authentication_request.K                             | 8BAF473F2F8FD09487CCCBD7097C6862               |
      | nas_pdu.authentication_request.OP                            | 1006020F0A478BF6B699F15C062E42B3               |
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
      | parameter                      | value                                                                                                |
      | header.nva.0.name              | :method                                                                                              |
      | header.nva.0.value             | PUT                                                                                                  |
      | header.nva.1.name              | :path                                                                                                |
      | header.nva.1.value             | /127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr($({abotprop.SUT.SUCI}),1)/5g-aka-confirmation |
      | header.nva.2.name              | content-type                                                                                         |
      | header.nva.2.value             | application/json                                                                                     |
      | confirmation_data.res_star     | $(UE_5G_AKA_RES_STAR_AT_AMF1)                                                                        |
      | confirmation_data.supi_or_suci | incr($({abotprop.SUT.SUCI}),1)                                                                       |

    Then I receive and validate HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_5G_AKA_CONF_REQ on interface N12 with the following details on node AUSF1 from AMF1:
      | parameter                      | value                                                                                                             |
      | header.nva.0.name              | {string:eq}(:method)                                                                                              |
      | header.nva.0.value             | {string:eq}(PUT)                                                                                                  |
      | header.nva.1.name              | {string:eq}(:path)                                                                                                |
      | header.nva.1.value             | {string:eq}(/127.0.0.1:12348/nausf-auth/v1/ue-authentications/incr($({abotprop.SUT.SUCI}),1)/5g-aka-confirmation) |
      | header.nva.2.name              | {string:eq}(content-type)                                                                                         |
      | header.nva.2.value             | {string:eq}(application/json)                                                                                     |
      | confirmation_data.res_star     | {string:eq}($(5G_AKA_XRES_STAR_AT_AUSF1))                                                                         |
      | confirmation_data.supi_or_suci | {string:eq}(incr($({abotprop.SUT.SUCI}),1))                                                                       |

    When I send HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_5G_AKA_CONF_RES_200 on interface N12 with the following details from node AUSF1 to AMF1:
      | parameter                              | value                           |
      | header.nva.0.name                      | :status                         |
      | header.nva.0.value                     | 200                             |
      | header.nva.1.name                      | content-type                    |
      | header.nva.1.value                     | application/json                |
      | confirmation_data_response.auth_result | {abotprop.SUT.AUTH.RESULT.SUCC} |
      | confirmation_data_response.supi        | incr($({abotprop.SUT.SUPI}),1)  |

    Then I receive and validate HTTPV2 message HTTPV2_NAUSF_UE_AUTHENTICATE_5G_AKA_CONF_RES_200 on interface N12 with the following details on node AMF1 from AUSF1:
      | parameter                              | value                                        |
      | header.nva.0.name                      | {string:eq}(:status)                         |
      | header.nva.0.value                     | {string:eq}(200)                             |
      | header.nva.1.name                      | {string:eq}(content-type)                    |
      | header.nva.1.value                     | {string:eq}(application/json)                |
      | confirmation_data_response.auth_result | {string:eq}({abotprop.SUT.AUTH.RESULT.SUCC}) |
      | confirmation_data_response.supi        | {string:eq}(incr($({abotprop.SUT.SUPI}),1))  |

    When I send HTTPV2 message HTTPV2_NUDM_UEAU_CONF_AUTH_REQ on interface N13 with the following details from node AUSF1 to UDM1:
      | parameter                 | value                                                                    |
      | header.nva.0.name         | :method                                                                  |
      | header.nva.0.value        | POST                                                                     |
      | header.nva.1.name         | :path                                                                    |
      | header.nva.1.value        | /127.0.0.1:12348/nudm-ueau/v1/incr($({abotprop.SUT.SUPI}),1)/auth-events |
      | header.nva.2.name         | content-type                                                             |
      | header.nva.2.value        | application/json                                                         |
      | auth_event.nf_instance_id | {abotprop.SUT.AMF1.NFINSTANCEID}                                         |
      | auth_event.success        | true                                                                     |
      | auth_event.time_stamp     | 2020-02-24T17:00:22Z                                                     |
      | auth_event.auth_type      | {abotprop.SUT.AUTH.TYPE.5GAKA}                                           |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UEAU_CONF_AUTH_REQ on interface N13 with the following details on node UDM1 from AUSF1:
      | parameter                 | value                                                                                 |
      | header.nva.0.name         | {string:eq}(:method)                                                                  |
      | header.nva.0.value        | {string:eq}(POST)                                                                     |
      | header.nva.1.name         | {string:eq}(:path)                                                                    |
      | header.nva.1.value        | {string:eq}(/127.0.0.1:12348/nudm-ueau/v1/incr($({abotprop.SUT.SUPI}),1)/auth-events) |
      | header.nva.2.name         | {string:eq}(content-type)                                                             |
      | header.nva.2.value        | {string:eq}(application/json)                                                         |
      | auth_event.nf_instance_id | {string:eq}({abotprop.SUT.AMF1.NFINSTANCEID})                                         |
      | auth_event.success        | {string:eq}(true)                                                                     |
      | auth_event.time_stamp     | {string:eq}(2020-02-24T17:00:22Z)                                                     |
      | auth_event.auth_type      | {string:eq}({abotprop.SUT.AUTH.TYPE.5GAKA})                                           |

    When I send HTTPV2 message HTTPV2_NUDM_UEAU_CONF_AUTH_RES_201 on interface N13 with the following details from node UDM1 to AUSF1:
      | parameter                 | value                            |
      | header.nva.0.name         | :status                          |
      | header.nva.0.value        | 201                              |
      | header.nva.1.name         | content-type                     |
      | header.nva.1.value        | application/json                 |
      | auth_event.nf_instance_id | {abotprop.SUT.AMF1.NFINSTANCEID} |
      | auth_event.success        | true                             |
      | auth_event.time_stamp     | 2020-02-24T17:00:22Z             |
      | auth_event.auth_type      | {abotprop.SUT.AUTH.TYPE.5GAKA}   |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UEAU_CONF_AUTH_RES_201 on interface N13 with the following details on node AUSF1 from UDM1:
      | parameter                 | value                                         |
      | header.nva.0.name         | {string:eq}(:status)                          |
      | header.nva.0.value        | {string:eq}(201)                              |
      | header.nva.1.name         | {string:eq}(content-type)                     |
      | header.nva.1.value        | {string:eq}(application/json)                 |
      | auth_event.nf_instance_id | {string:eq}({abotprop.SUT.AMF1.NFINSTANCEID}) |
      | auth_event.success        | {string:eq}(true)                             |
      | auth_event.time_stamp     | {string:eq}(2020-02-24T17:00:22Z)             |
      | auth_event.auth_type      | {string:eq}({abotprop.SUT.AUTH.TYPE.5GAKA})   |

### UE Slice Selection Subscription data, NSSF get AMF Set for NSSAI

    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIBED_NSSAI_GET_REQ on interface N8 with the following details from node AMF1 to UDM1:
      | parameter          | value                                                                                                                                   |
      | header.nva.0.name  | :method                                                                                                                                 |
      | header.nva.0.value | GET                                                                                                                                     |
      | header.nva.1.name  | :path                                                                                                                                   |
      | header.nva.1.value | /127.0.0.1:12349/nudm-sdm/v2/incr($({abotprop.SUT.SUPI}),1)/nssai?plmn-id={"mcc":"$({abotprop.SUT.MCC})","mnc":"$({abotprop.SUT.MNC})"} |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIBED_NSSAI_GET_REQ on interface N8 with the following details on node UDM1 from AMF1:
      | parameter          | value                                                                                                                                                |
      | header.nva.0.name  | {string:eq}(:method)                                                                                                                                 |
      | header.nva.0.value | {string:eq}(GET)                                                                                                                                     |
      | header.nva.1.name  | {string:eq}(:path)                                                                                                                                   |
      | header.nva.1.value | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr($({abotprop.SUT.SUPI}),1)/nssai?plmn-id={"mcc":"$({abotprop.SUT.MCC})","mnc":"$({abotprop.SUT.MNC})"}) |

    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIBED_NSSAI_GET_RES_200 on interface N8 with the following details from node UDM1 to AMF1:
      | parameter                                | value                                      |
      | header.nva.0.name                        | :status                                    |
      | header.nva.0.value                       | 200                                        |
      | header.nva.1.name                        | content-type                               |
      | header.nva.1.value                       | application/json                           |
      | nssai.default_single_nssais.0.snssai.sst | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB} |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIBED_NSSAI_GET_RES_200 on interface N8 with the following details on node AMF1 from UDM1:
      | parameter                                | value                                                   |
      | header.nva.0.name                        | {string:eq}(:status)                                    |
      | header.nva.0.value                       | {string:eq}(200)                                        |
      | header.nva.1.name                        | {string:eq}(content-type)                               |
      | header.nva.1.value                       | {string:eq}(application/json)                           |
      | nssai.default_single_nssais.0.snssai.sst | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}) |

    When I send HTTPV2 message HTTPV2_NNSSF_NETWORK_SLICE_SELECTION_GET_REQ on interface N22 with the following details from node AMF1 to NSSF1:
      | parameter          | value                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | header.nva.0.name  | :method                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | header.nva.0.value | GET                                                                                                                                                                                                                                                                                                                                                                                                                                        |
      | header.nva.1.name  | :path                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | header.nva.1.value | /127.0.0.1:12348/nnssf-nsselection/v2/network-slice-information?nf-type=AMF&nf-id=5a2b84e4-0cb7-4575-ac08-46a2812bec0d&slice-info-request-for-registration={"requestedNssai":[{"sst":1}],"subscribedNssai":[{"subscribedSnssai":{"sst":1},"defaultIndication":true}]}&tai:{"plmnId":{"mcc":"$({abotprop.SUT.MCC})","mnc":"$({abotprop.SUT.MNC})"},"tac":"0001"}&home-plmn-id:{"mcc":"$({abotprop.SUT.MCC})","mnc":"$({abotprop.SUT.MNC})"} |

    Then I receive and validate HTTPV2 message HTTPV2_NNSSF_NETWORK_SLICE_SELECTION_GET_REQ on interface N22 with the following details on node NSSF1 from AMF1:
      | parameter          | value                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
      | header.nva.0.name  | {string:eq}(:method)                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | header.nva.0.value | {string:eq}(GET)                                                                                                                                                                                                                                                                                                                                                                                                                                        |
      | header.nva.1.name  | {string:eq}(:path)                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | header.nva.1.value | {string:eq}(/127.0.0.1:12348/nnssf-nsselection/v2/network-slice-information?nf-type=AMF&nf-id=5a2b84e4-0cb7-4575-ac08-46a2812bec0d&slice-info-request-for-registration={"requestedNssai":[{"sst":1}],"subscribedNssai":[{"subscribedSnssai":{"sst":1},"defaultIndication":true}]}&tai:{"plmnId":{"mcc":"$({abotprop.SUT.MCC})","mnc":"$({abotprop.SUT.MNC})"},"tac":"0001"}&home-plmn-id:{"mcc":"$({abotprop.SUT.MCC})","mnc":"$({abotprop.SUT.MNC})"}) |


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
      | parameter                                            | value                               |
      | amf_ue_ngap_id                                       | $(AMF_UE_NGAP_ID)                   |
      | ran_ue_ngap_id                                       | $(RAN_UE_NGAP_ID)                   |
      | nas_pdu.extended_protocol_discriminator              | {abotprop.SUT.NAS.EDP}              |
      | nas_pdu.security_header_type                         | {abotprop.SUT.NAS.SEC.HEAD.MOD.CMD} |
      | nas_pdu.message_type                                 | {abotprop.SUT.NAS.SEC.CMD.MSG}      |
      | nas_pdu.security_mode_command.nas_security_algorithm | 0x01                                |
      | nas_pdu.security_mode_command.nas_key_set_identifier | {abotprop.SUT.NAS.KSI}              |
      | nas_pdu.security_mode_command.ue_security_capability | {abotprop.SUT.NAS.UE.SEC.CAPA}      |

    Then I receive and validate NGAP message NG_DOWNLINK_NAS_SECURITY_MODE_CMD on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                            | value                                            |
      | amf_ue_ngap_id                                       | {string:eq}($(AMF_UE_NGAP_ID))                   |
      | ran_ue_ngap_id                                       | {string:eq}($(RAN_UE_NGAP_ID))                   |
      | nas_pdu.extended_protocol_discriminator              | {string:eq}({abotprop.SUT.NAS.EDP})              |
      | nas_pdu.security_header_type                         | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.MOD.CMD}) |
      | nas_pdu.message_type                                 | {string:eq}({abotprop.SUT.NAS.SEC.CMD.MSG})      |
      | nas_pdu.security_mode_command.nas_security_algorithm | {string:eq}(0x01)                                |
      | nas_pdu.security_mode_command.nas_key_set_identifier | {string:eq}({abotprop.SUT.NAS.KSI})              |
      | nas_pdu.security_mode_command.ue_security_capability | {string:eq}({abotprop.SUT.NAS.UE.SEC.CAPA})      |

    When I send NGAP message NG_UPLINK_NAS_SECURITY_MODE_COMPLETE on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                      | value                                     |
      | amf_ue_ngap_id                                                                                                                 | $(AMF_UE_NGAP_ID)                         |
      | ran_ue_ngap_id                                                                                                                 | $(RAN_UE_NGAP_ID)                         |
      | nas_pdu.extended_protocol_discriminator                                                                                        | {abotprop.SUT.NAS.EDP}                    |
      | nas_pdu.security_header_type                                                                                                   | {abotprop.SUT.NAS.SEC.HEAD.MOD.CMD}       |
      | nas_pdu.message_type                                                                                                           | {abotprop.SUT.NAS.SEC.COM.MSG}            |
      | nas_pdu.security_mode_complete.nas_message_container.extended_protocol_discriminator                                           | {abotprop.SUT.NAS.EDP}                    |
      | nas_pdu.security_mode_complete.nas_message_container.security_header_type                                                      | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}         |
      | nas_pdu.security_mode_complete.nas_message_container.message_type                                                              | {abotprop.SUT.NAS.REG.REQ.MSG}            |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_registration_type                                | {abotprop.SUT.NAS.5GS.REG.TYPE.INI.REG}   |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.nas_key_set_identifier                               | {abotprop.SUT.NAS.KSI}                    |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.type_of_id                         | {abotprop.SUT.NAS.5GS_MOB_ID.TYPE.SUCI}   |
      | nas_pdu.security_mode_complete.nas_message_container.registration_request.5gs_mob_id_choice.suci.supi_format                   | {abotprop.SUT.NAS.5GS_MOB_ID.SUPI_FORMAT} |
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
      | nas_pdu.security_header_type                                                                         | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.MOD.CMD})       |
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
      | parameter                                       | value                                                                                                    |
      | header.nva.0.name                               | :method                                                                                                  |
      | header.nva.0.value                              | PUT                                                                                                      |
      | header.nva.1.name                               | :path                                                                                                    |
      | header.nva.1.value                              | /127.0.0.1:12349/nudm-uecm/v1/incr($({abotprop.SUT.SUPI}),1)/registrations/amf-3gpp-access               |
      | header.nva.2.name                               | content-type                                                                                             |
      | header.nva.2.value                              | application/json                                                                                         |
      | amf_3gpp_access_registration.amf_id             | {abotprop.SUT.AMF.REG.AMF.ID}                                                                            |
      | amf_3gpp_access_registration.dereg_callback_uri | /127.0.0.1:12349/nudm-uecm/v1/incr($({abotprop.SUT.SUPI}),1)/registrations/amf-3gpp-access/dereg-calback |
      | amf_3gpp_access_registration.guami.plmn_id.mcc  | {abotprop.SUT.MCC}                                                                                       |
      | amf_3gpp_access_registration.guami.plmn_id.mnc  | {abotprop.SUT.MNC}                                                                                       |
      | amf_3gpp_access_registration.guami.amf_id       | {abotprop.SUT.AMF.REG.AMF.ID}                                                                            |
      | amf_3gpp_access_registration.rat_type           | {abotprop.SUT.RATTYPE1}                                                                                  |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UECM_3GPP_ACCESS_REGISTRATION_PUT_REQ on interface N8 with the following details on node UDM1 from AMF1:
      | parameter                                       | value                                                                                                   |
      | header.nva.0.name                               | {string:eq}(:method)                                                                                    |
      | header.nva.0.value                              | {string:eq}(PUT)                                                                                        |
      | header.nva.1.name                               | {string:eq}(:path)                                                                                      |
      | header.nva.1.value                              | {string:eq}(/127.0.0.1:12349/nudm-uecm/v1/incr($({abotprop.SUT.SUPI}),1)/registrations/amf-3gpp-access) |
      | header.nva.2.name                               | {string:eq}(content-type)                                                                               |
      | header.nva.2.value                              | {string:eq}(application/json)                                                                           |
      | amf_3gpp_access_registration.amf_id             | save(AMF_ID)                                                                                            |
      | amf_3gpp_access_registration.dereg_callback_uri | save(DREG_CALLBACK_URI)                                                                                 |
      | amf_3gpp_access_registration.guami.plmn_id.mcc  | save(GUAMI_PLMN_MCC)                                                                                    |
      | amf_3gpp_access_registration.guami.plmn_id.mnc  | save(GUAMI_PLMN_MNC)                                                                                    |
      | amf_3gpp_access_registration.guami.amf_id       | save(GUAMI_AMF_ID)                                                                                      |
      | amf_3gpp_access_registration.rat_type           | save(RAT_TYPE)                                                                                          |

    When I send HTTPV2 message HTTPV2_NUDM_UECM_3GPP_ACCESS_REGISTRATION_PUT_RES_201 on interface N8 with the following details from node UDM1 to AMF1:
      | parameter                                       | value                                                                                      |
      | header.nva.0.name                               | :status                                                                                    |
      | header.nva.0.value                              | 201                                                                                        |
      | header.nva.1.name                               | location                                                                                   |
      | header.nva.1.value                              | /127.0.0.1:12349/nudm-uecm/v1/incr($({abotprop.SUT.SUPI}),1)/registrations/amf-3gpp-access |
      | amf_3gpp_access_registration.amf_id             | $(AMF_ID)                                                                                  |
      | amf_3gpp_access_registration.dereg_callback_uri | $(DREG_CALLBACK_URI)                                                                       |
      | amf_3gpp_access_registration.guami.plmn_id.mcc  | $(GUAMI_PLMN_MCC)                                                                          |
      | amf_3gpp_access_registration.guami.plmn_id.mnc  | $(GUAMI_PLMN_MNC)                                                                          |
      | amf_3gpp_access_registration.guami.amf_id       | $(GUAMI_AMF_ID)                                                                            |
      | amf_3gpp_access_registration.rat_type           | $(RAT_TYPE)                                                                                |

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
      | parameter          | value                                                                                                                                                      |
      | header.nva.0.name  | :method                                                                                                                                                    |
      | header.nva.0.value | GET                                                                                                                                                        |
      | header.nva.1.name  | :path                                                                                                                                                      |
      | header.nva.1.value | /127.0.0.1:12349/nudm-sdm/v2/incr($({abotprop.SUT.SUPI}),1)?dataset-names=AM,SMF_SEL&plmn-id={"mcc":"$({abotprop.SUT.MCC})","mnc":"$({abotprop.SUT.MNC})"} |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_GET_REQ on interface N8 with the following details on node UDM1 from AMF1:
      | parameter          | value                                                                                                                                                                   |
      | header.nva.0.name  | {string:eq}(:method)                                                                                                                                                    |
      | header.nva.0.value | {string:eq}(GET)                                                                                                                                                        |
      | header.nva.1.name  | {string:eq}(:path)                                                                                                                                                      |
      | header.nva.1.value | {string:eq}(/127.0.0.1:12349/nudm-sdm/v2/incr($({abotprop.SUT.SUPI}),1)?dataset-names=AM,SMF_SEL&plmn-id={"mcc":"$({abotprop.SUT.MCC})","mnc":"$({abotprop.SUT.MNC})"}) |

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
      | subscription_data_sets.smf_sel_data.subscribed_snssai_info.0.snssai_info.dnn_infos.0.dnn_info.dnn | {abotprop.SUT.DNN}                         |

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
      | subscription_data_sets.smf_sel_data.subscribed_snssai_info.0.snssai_info.dnn_infos.0.dnn_info.dnn | {string:eq}({abotprop.SUT.DNN})                         |
      


### AMF to UDM : AM Data Change Notification Subscription

    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_REQ on interface N8 with the following details from node AMF1 to UDM1:
      | parameter                                      | value                                                                                                                                                        |
      | header.nva.0.name                              | :method                                                                                                                                                      |
      | header.nva.0.value                             | POST                                                                                                                                                         |
      | header.nva.1.name                              | :path                                                                                                                                                        |
      | header.nva.1.value                             | /$({abotprop.UDM1.SecureShell.IPAddress}):$({abotprop.UDM1.N8.Server.Port})/nudm-sdm/v2/incr($({abotprop.SUT.SUPI}),1)/sdm-subscriptions                     |
      | header.nva.2.name                              | content-type                                                                                                                                                 |
      | header.nva.2.value                             | application/json                                                                                                                                             |
      | sdm_subscription.callback_reference            | /$({abotprop.AMF1.SecureShell.IPAddress}):$({abotprop.AMF1.N8.Server.Port})/nudm-sdm/v2/incr($({abotprop.SUT.SUPI}),1)/sdm-subscription/callback-subs-notify |
      | sdm_subscription.monitored_resource_uris.0.uri | /$({abotprop.UDM1.SecureShell.IPAddress}):$({abotprop.UDM1.N8.Server.Port})/nudm-sdm/v2/incr($({abotprop.SUT.SUPI}),1)/sdm-subscription/amData               |
      | sdm_subscription.nf_instance_id                | {abotprop.SUT.AMF1.NFINSTANCEID}                                                                                                                             |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_REQ on interface N8 with the following details on node UDM1 from AMF1:
      | parameter                                      | value                                                                                                                                                 |
      | header.nva.0.name                              | {string:eq}(:method)                                                                                                                                  |
      | header.nva.0.value                             | {string:eq}(POST)                                                                                                                                     |
      | header.nva.1.name                              | {string:eq}(:path)                                                                                                                                    |
      | header.nva.1.value                             | {string:eq}(/$({abotprop.UDM1.SecureShell.IPAddress}):$({abotprop.UDM1.N8.Server.Port})/nudm-sdm/v2/incr($({abotprop.SUT.SUPI}),1)/sdm-subscriptions) |
      | header.nva.2.name                              | {string:eq}(content-type)                                                                                                                             |
      | header.nva.2.value                             | {string:eq}(application/json)                                                                                                                         |
      | sdm_subscription.callback_reference            | save(AMF_SUB_CALLBACK_NOTIFY)                                                                                                                         |
      | sdm_subscription.monitored_resource_uris.0.uri | save(AMF_SUB_MONITORED_RESOURCE_URI)                                                                                                                  |
      | sdm_subscription.nf_instance_id                | {string:eq}({abotprop.SUT.AMF1.NFINSTANCEID})                                                                                                         |

    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_RES_201 on interface N8 with the following details from node UDM1 to AMF1:
      | parameter                                      | value                                                                                                                                                    |
      | header.nva.0.name                              | :status                                                                                                                                                  |
      | header.nva.0.value                             | 201                                                                                                                                                      |
      | header.nva.1.name                              | location                                                                                                                                                 |
      | header.nva.1.value                             | /$({abotprop.UDM1.SecureShell.IPAddress}):$({abotprop.UDM1.N8.Server.Port})/nudm-sdm/v2/incr($({abotprop.SUT.SUPI}),1)/sdm-subscriptions/subscriptionId1 |
      | header.nva.2.name                              | content-type                                                                                                                                             |
      | header.nva.2.value                             | application/json                                                                                                                                         |
      | sdm_subscription.callback_reference            | $(AMF_SUB_CALLBACK_NOTIFY)                                                                                                                               |
      | sdm_subscription.monitored_resource_uris.0.uri | $(AMF_SUB_MONITORED_RESOURCE_URI)                                                                                                                        |
      | sdm_subscription.nf_instance_id                | {abotprop.SUT.AMF1.NFINSTANCEID}                                                                                                                         |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_POST_RES_201 on interface N8 with the following details on node AMF1 from UDM1:
      | parameter                                      | value                                         |
      | header.nva.0.name                              | {string:eq}(:status)                          |
      | header.nva.0.value                             | {string:eq}(201)                              |
      | header.nva.1.name                              | {string:eq}(location)                         |
      | header.nva.1.value                             | save(AMF_SUBS_LOCATION_URI)                   |
      | header.nva.2.name                              | {string:eq}(content-type)                     |
      | header.nva.2.value                             | {string:eq}(application/json)                 |
      | sdm_subscription.callback_reference            | save(AMF_SUB_CALLBACK_NOTIFY)                 |
      | sdm_subscription.monitored_resource_uris.0.uri | save(AMF_SUB_MONITOR_RESOURCE_URI)            |
      | sdm_subscription.nf_instance_id                | {string:eq}({abotprop.SUT.AMF1.NFINSTANCEID}) |



    When I send HTTPV2 message HTTPV2_NPCFAM_POLICY_CONTROL_CREATE_POST_REQ on interface N15 with the following details from node AMF1 to PCF1:
      | parameter                                   | value                                                      |
      | header.nva.0.name                           | :method                                                    |
      | header.nva.0.value                          | POST                                                       |
      | header.nva.1.name                           | :path                                                      |
      | header.nva.1.value                          | /127.0.0.1:12348/npcf-am-policy-control/v1/policies        |
      | header.nva.2.name                           | content-type                                               |
      | header.nva.2.value                          | application/json                                           |
      | policy_association_request.notification_uri | /127.0.0.1:12348/npcf-am-policy-control/v1/policies/amPol1 |
      | policy_association_request.supi             | incr($({abotprop.SUT.SUPI}),1)                             |
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
      | policy_association_request.supi             | {string:eq}(incr($({abotprop.SUT.SUPI}),1))                             |
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
      | parameter                                                                                       | value                                                      |
      | amf_ue_ngap_id                                                                                  | $(AMF_UE_NGAP_ID)                                          |
      | ran_ue_ngap_id                                                                                  | $(RAN_UE_NGAP_ID)                                          |
      | nas_pdu.extended_protocol_discriminator                                                         | {abotprop.SUT.NAS.EDP}                                     |
      | nas_pdu.security_header_type                                                                    | {abotprop.SUT.NAS.SEC.HEAD.INTEGRITY}                      |
      | nas_pdu.message_type                                                                            | {abotprop.SUT.NAS.REG.ACC.MSG}                             |
      | nas_pdu.registration_accept.5gs_reg_result                                                      | {abotprop.SUT.NAS.5GS_REG_RESULT.3GPP_ACCESS.SMS_OVER_NAS} |
      #| nas_pdu.registration_accept.5gs_mobile_identity                                                 | 0xf200f1100100415b855ff4                                   |
      | nas_pdu.registration_accept.5gs_mob_id_choice.type_of_id                                        | {abotprop.SUT.NAS.5GS_MOB_ID.TYPE.5G-GUTI}                 |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.mcc                                       | {abotprop.SUT.MCC}                                         |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.mnc                                       | {abotprop.SUT.MNC}                                         |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_region_id                             | {abotprop.SUT.GUAMI.AMF.REGION.ID}                         |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_set_id                                | {abotprop.SUT.GUAMI.AMF.SET.ID}                            |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_pointer                               | {abotprop.SUT.GUAMI.AMF.POINTER}                           |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.5g_tmsi                                   | incr({abotprop.SUT.5GTMSI.START},1)                        |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.type_of_list                            | {abotprop.SUT.NAS.TAC.TPYE_OF_LIST1}                       |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.no_of_elements                          | 1                                                          |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.mcc            | {abotprop.SUT.MCC}                                         |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.mnc            | {abotprop.SUT.MNC}                                         |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.tac_list.0.tac | {abotprop.SUT.TAC}                                         |
      | guami.plmn_identity.mcc                                                                         | {abotprop.SUT.MCC}                                         |
      | guami.plmn_identity.mnc                                                                         | {abotprop.SUT.MNC}                                         |
      | guami.amf_region_id                                                                             | {abotprop.SUT.GUAMI.AMF.REGION.ID}                         |
      | guami.amf_set_id                                                                                | {abotprop.SUT.GUAMI.AMF.SET.ID}                            |
      | guami.pointer.amf_pointer                                                                       | {abotprop.SUT.GUAMI.AMF.POINTER}                           |
      | allowed_s-nssai_list.0.sst                                                                      | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}                 |
      | ue_security_capabilities.nr_encryption_algo                                                     | {abotprop.SUT.NR.ENCRYPTION.ALGO}                          |
      | ue_security_capabilities.nr_integrity_protection_algo                                           | {abotprop.SUT.NR.INT.PROTECT.ALGO}                         |
      | ue_security_capabilities.e_utra_encryption_algo                                                 | {abotprop.SUT.EUTRA.ENCRYPTION.ALGO}                       |
      | ue_security_capabilities.e_utra_integrity_protection_algo                                       | {abotprop.SUT.EUTRA.INT.PROTECT.ALGO}                      |
      | security_key                                                                                    | {abotprop.SUT.NH.SECURITY.KEY}                             |

    Then I receive and validate NGAP message NG_INIT_CTXT_SET_REQ_NAS_REGIS_ACC on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                                                                       | value                                                                   |
      | amf_ue_ngap_id                                                                                  | {string:eq}($(AMF_UE_NGAP_ID))                                          |
      | ran_ue_ngap_id                                                                                  | {string:eq}($(RAN_UE_NGAP_ID))                                          |
      | nas_pdu.extended_protocol_discriminator                                                         | {string:eq}({abotprop.SUT.NAS.EDP})                                     |
      | nas_pdu.security_header_type                                                                    | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.INTEGRITY})                      |
      | nas_pdu.message_type                                                                            | {string:eq}({abotprop.SUT.NAS.REG.ACC.MSG})                             |
      | nas_pdu.registration_accept.5gs_reg_result                                                      | {string:eq}({abotprop.SUT.NAS.5GS_REG_RESULT.3GPP_ACCESS.SMS_OVER_NAS}) |
      #| nas_pdu.registration_accept.5gs_mobile_identity                                                 | {string:eq}(0xf200f1100100415b855ff4)                                   |
      | nas_pdu.registration_accept.5gs_mob_id_choice.type_of_id                                        | {string:eq}({abotprop.SUT.NAS.5GS_MOB_ID.TYPE.5G-GUTI})                 |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.mcc                                       | save(MCC)                                                               |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.mnc                                       | save(MNC)                                                               |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_region_id                             | save(AMF_REGION_ID)                                                     |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_set_id                                | save(AMF_SET_ID)                                                        |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.amf_pointer                               | save(AMF_POINTER)                                                       |
      | nas_pdu.registration_accept.5gs_mob_id_choice.5g_guti.5g_tmsi                                   | save(5G_TMSI)                                                           |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.type_of_list                            | {string:eq}({abotprop.SUT.NAS.TAC.TPYE_OF_LIST1})                       |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.no_of_elements                          | {string:eq}(1)                                                          |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.mcc            | {string:eq}({abotprop.SUT.MCC})                                         |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.mnc            | {string:eq}({abotprop.SUT.MNC})                                         |
      | nas_pdu.registration_accept.5gs_tracking_area_id_list.0.partial_tai_list_type_00.tac_list.0.tac | {string:eq}({abotprop.SUT.TAC})                                         |
      | guami.plmn_identity.mcc                                                                         | save(MCC)                                                               |
      | guami.plmn_identity.mnc                                                                         | save(MNC)                                                               |
      | guami.amf_region_id                                                                             | save(AMF_REGION_ID)                                                     |
      | guami.amf_set_id                                                                                | save(AMF_SET_ID)                                                        |
      | guami.pointer.amf_pointer                                                                       | save(AMF_POINTER)                                                       |
      | allowed_s-nssai_list.0.sst                                                                      | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB})                 |
      | ue_security_capabilities.nr_encryption_algo                                                     | {string:eq}({abotprop.SUT.NR.ENCRYPTION.ALGO})                          |
      | ue_security_capabilities.nr_integrity_protection_algo                                           | {string:eq}({abotprop.SUT.NR.INT.PROTECT.ALGO})                         |
      | ue_security_capabilities.e_utra_encryption_algo                                                 | {string:eq}({abotprop.SUT.EUTRA.ENCRYPTION.ALGO})                       |
      | ue_security_capabilities.e_utra_integrity_protection_algo                                       | {string:eq}({abotprop.SUT.EUTRA.INT.PROTECT.ALGO})                      |
      | security_key                                                                                    | {string:eq}({abotprop.SUT.NH.SECURITY.KEY})                             |
   
    When I send NGAP message NG_INIT_CTXT_SET_RES on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter      | value             |
      | amf_ue_ngap_id | $(AMF_UE_NGAP_ID) |
      | ran_ue_ngap_id | $(RAN_UE_NGAP_ID) |

    Then I receive and validate NGAP message NG_INIT_CTXT_SET_RES on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter      | value                          |
      | amf_ue_ngap_id | {string:eq}($(AMF_UE_NGAP_ID)) |
      | ran_ue_ngap_id | {string:eq}($(RAN_UE_NGAP_ID)) |

    When I send NGAP message NG_UPLINK_NAS_REGIS_COMPLETE on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                       | value                                 |
      | amf_ue_ngap_id                                                                  | $(AMF_UE_NGAP_ID)                     |
      | ran_ue_ngap_id                                                                  | $(RAN_UE_NGAP_ID)                     |
      | nas_pdu.extended_protocol_discriminator                                         | {abotprop.SUT.NAS.EDP}                |
      | nas_pdu.security_header_type                                                    | {abotprop.SUT.NAS.SEC.HEAD.INTEGRITY} |
      | nas_pdu.message_type                                                            | {abotprop.SUT.NAS.REG.COM.MSG}        |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {abotprop.SUT.MCC}                    |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {abotprop.SUT.MNC}                    |
      | user_location_information.nr_user_location_information.tai.tac                  | {abotprop.SUT.TAC}                    |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {abotprop.SUT.MCC}                    |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {abotprop.SUT.MNC}                    |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {abotprop.SUT.NR.CELL.IDN}            |

    Then I receive and validate NGAP message NG_UPLINK_NAS_REGIS_COMPLETE on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                       | value                                              |
      | amf_ue_ngap_id                                                                  | {string:eq}($(AMF_UE_NGAP_ID))                     |
      | ran_ue_ngap_id                                                                  | {string:eq}($(RAN_UE_NGAP_ID))                     |
      | nas_pdu.extended_protocol_discriminator                                         | {string:eq}({abotprop.SUT.NAS.EDP})                |
      | nas_pdu.security_header_type                                                    | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.INTEGRITY}) |
      | nas_pdu.message_type                                                            | {string:eq}({abotprop.SUT.NAS.REG.COM.MSG})        |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {string:eq}({abotprop.SUT.MCC})                    |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {string:eq}({abotprop.SUT.MNC})                    |
      | user_location_information.nr_user_location_information.tai.tac                  | {string:eq}({abotprop.SUT.TAC})                    |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {string:eq}({abotprop.SUT.MCC})                    |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {string:eq}({abotprop.SUT.MNC})                    |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {string:eq}({abotprop.SUT.NR.CELL.IDN})            |

### Single PDU Session Establishment

    When I send NGAP message NG_UPLINK_NAS_UL_NAS_TRANS_PDU_SESS_ESTAB_REQ on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                               | value                                               |
      | amf_ue_ngap_id                                                                                                                          | $(AMF_UE_NGAP_ID)                                   |
      | ran_ue_ngap_id                                                                                                                          | $(RAN_UE_NGAP_ID)                                   |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                                                            | {abotprop.SUT.MCC}                                  |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                                                            | {abotprop.SUT.MNC}                                  |
      | user_location_information.nr_user_location_information.tai.tac                                                                          | {abotprop.SUT.TAC}                                  |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                                                         | {abotprop.SUT.MCC}                                  |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                                                         | {abotprop.SUT.MNC}                                  |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                                                          | {abotprop.SUT.NR.CELL.IDN}                          |
      | nas_pdu.extended_protocol_discriminator                                                                                                 | {abotprop.SUT.NAS.EDP}                              |
      | nas_pdu.security_header_type                                                                                                            | {abotprop.SUT.NAS.SEC.HEAD.INTEGRITY}               |
      | nas_pdu.message_type                                                                                                                    | {abotprop.SUT.NAS.UL.NAS.TRANS.MSG}                 |
      | nas_pdu.ul_nas_transport.pdu_session_identity                                                                                           | {abotprop.SUT.NAS.PDU_SESSION_ID6}                  |
      | nas_pdu.ul_nas_transport.request_type                                                                                                   | {abotprop.SUT.NAS.PDU_SESSION_REQ_TYPE_INITIAL}     |
      | nas_pdu.ul_nas_transport.snssai                                                                                                         | {abotprop.SUT.SUBSCRIBEDNSSAI}                      |
      | nas_pdu.ul_nas_transport.dnn                                                                                                            | {abotprop.SUT.DNN1}                                 |
      | nas_pdu.ul_nas_transport.payload_container_type                                                                                         | {abotprop.SUT.NAS.PAYLOAD.CONTAINER}                |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator              | {abotprop.SUT.NAS.PDU.SM_EDP}                       |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                               | {abotprop.SUT.PDU.SESS.ID}                          |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                                          | {abotprop.SUT.NAS.PTI}                              |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                                 | {abotprop.SUT.NAS.PDU.SESS.ESTD.REQ.MSG}            |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_req.int_protect_max_data_rate | {abotprop.SUT.NAS.PDU.INTRIGRITY.PRO.MAX.DATA.RATE} |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_req.pdu_sess_type             | {abotprop.SUT.NAS.PDU_SESSION_TYPE.IPV4}            |

    Then I receive and validate NGAP message NG_UPLINK_NAS_UL_NAS_TRANS_PDU_SESS_ESTAB_REQ on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                                                               | value                                                            |
      | amf_ue_ngap_id                                                                                                                          | {string:eq}($(AMF_UE_NGAP_ID))                                   |
      | ran_ue_ngap_id                                                                                                                          | {string:eq}($(RAN_UE_NGAP_ID))                                   |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                                                            | {string:eq}({abotprop.SUT.MCC})                                  |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                                                            | {string:eq}({abotprop.SUT.MNC})                                  |
      | user_location_information.nr_user_location_information.tai.tac                                                                          | {string:eq}({abotprop.SUT.TAC})                                  |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                                                         | {string:eq}({abotprop.SUT.MCC})                                  |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                                                         | {string:eq}({abotprop.SUT.MNC})                                  |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                                                          | {string:eq}({abotprop.SUT.NR.CELL.IDN})                          |
      | nas_pdu.extended_protocol_discriminator                                                                                                 | {string:eq}({abotprop.SUT.NAS.EDP})                              |
      | nas_pdu.security_header_type                                                                                                            | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.INTEGRITY})               |
      | nas_pdu.message_type                                                                                                                    | {string:eq}({abotprop.SUT.NAS.UL.NAS.TRANS.MSG})                 |
      | nas_pdu.ul_nas_transport.pdu_session_identity                                                                                           | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_ID6})                  |
      | nas_pdu.ul_nas_transport.request_type                                                                                                   | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_REQ_TYPE_INITIAL})     |
      | nas_pdu.ul_nas_transport.snssai                                                                                                         | {string:eq}({abotprop.SUT.SUBSCRIBEDNSSAI})                      |
      | nas_pdu.ul_nas_transport.dnn                                                                                                            | {string:eq}({abotprop.SUT.DNN1})                                 |
      | nas_pdu.ul_nas_transport.payload_container_type                                                                                         | {string:eq}({abotprop.SUT.NAS.PAYLOAD.CONTAINER})                |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator              | {string:eq}({abotprop.SUT.NAS.PDU.SM_EDP})                       |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                               | {string:eq}({abotprop.SUT.PDU.SESS.ID})                          |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                                          | {string:eq}({abotprop.SUT.NAS.PTI})                              |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                                 | {string:eq}({abotprop.SUT.NAS.PDU.SESS.ESTD.REQ.MSG})            |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_req.int_protect_max_data_rate | {string:eq}({abotprop.SUT.NAS.PDU.INTRIGRITY.PRO.MAX.DATA.RATE}) |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_req.pdu_sess_type             | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_TYPE.IPV4})            |

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
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.plmn_id.mcc                 | {abotprop.SUT.MCC}                                                                      |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.plmn_id.mnc                 | {abotprop.SUT.MNC}                                                                      |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.nr_cell_id                  | {abotprop.SUT.NR.CELL.IDN}                                                              |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.plmn_id.mcc                  | {abotprop.SUT.MCC}                                                                      |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.plmn_id.mnc                  | {abotprop.SUT.MNC}                                                                      |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.tac                          | {abotprop.SUT.TAC}                                                                      |
      | multipart_related.json_data.sm_context_create_data.sm_context_status_uri                                    | http://127.0.0.1:12349/namf-comm/v1/sm-contexts/smctx-1/status/6                        |
      | multipart_related.json_data.sm_context_create_data.gpsi                                                     | {abotprop.SUT.GPSI.START}                                                               |
      | multipart_related.json_data.sm_context_create_data.pdu_session_id                                           | {abotprop.SUT.PDU.SESS.ID}                                                              |
      | multipart_related.json_data.sm_context_create_data.n1_sm_msg.content_id                                     | n1-pdu-session-establishment-request                                                    |
      | multipart_related.json_data.sm_context_create_data.an_type                                                  | {abotprop.SUT.ACCESS.TYPE.3GPP}                                                         |
      | multipart_related.json_data.sm_context_create_data.supi                                                     | incr($({abotprop.SUT.SUPI}),1)                                                          |
      | multipart_related.json_data.sm_context_create_data.s_nssai.sst                                              | {abotprop.SUT.SUBSCRIBEDNSSAI}                                                          |
      | multipart_related.json_data.sm_context_create_data.serving_nf_id                                            | {abotprop.SUT.AMF1.NFINSTANCEID}                                                        |
      | multipart_related.json_data.sm_context_create_data.pei                                                      | incr({abotprop.SUT.PEI},1)                                                              |
      | multipart_related.json_data.sm_context_create_data.request_type                                             | INITIAL_REQUEST                                                                         |
      | multipart_related.json_data.sm_context_create_data.dnn                                                      | {abotprop.SUT.DNN1}                                                                     |
      | multipart_related.json_data.sm_context_create_data.guami.plmn_id.mcc                                        | {abotprop.SUT.MCC}                                                                      |
      | multipart_related.json_data.sm_context_create_data.guami.plmn_id.mnc                                        | {abotprop.SUT.MNC}                                                                      |
      | multipart_related.json_data.sm_context_create_data.guami.amf_id                                             | {abotprop.SUT.AMF.REG.AMF.ID}                                                           |
      | multipart_related.json_data.sm_context_create_data.serving_network.mcc                                      | {abotprop.SUT.MCC}                                                                      |
      | multipart_related.json_data.sm_context_create_data.serving_network.mnc                                      | {abotprop.SUT.MNC}                                                                      |
      | multipart_related.json_data.sm_context_create_data.pdu_sessions_activate_list.0.pdu_session_id              | {abotprop.SUT.PDU.SESS.ID}                                                              |
      | multipart_related.binary_data_n1_sm_message.content_type                                                    | application/vnd.3gpp.5gnas                                                              |
      | multipart_related.binary_data_n1_sm_message.content_id                                                      | n1-pdu-session-establishment-request                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator              | {abotprop.SUT.NAS.PDU.SM_EDP}                                                           |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                               | {abotprop.SUT.PDU.SESS.ID}                                                              |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                                          | {abotprop.SUT.NAS.PTI}                                                                  |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                                 | {abotprop.SUT.NAS.PDU.SESS.ESTD.REQ.MSG}                                                |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_estab_req.int_protect_max_data_rate | {abotprop.SUT.NAS.PDU.INTRIGRITY.PRO.MAX.DATA.RATE}                                     |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_estab_req.pdu_sess_type             | {abotprop.SUT.NAS.PDU_SESSION_TYPE.IPV4}                                                |

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
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.plmn_id.mcc                 | {string:eq}({abotprop.SUT.MCC})                                                                      |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.plmn_id.mnc                 | {string:eq}({abotprop.SUT.MNC})                                                                      |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.nr_cell_id                  | {string:eq}({abotprop.SUT.NR.CELL.IDN})                                                              |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.plmn_id.mcc                  | {string:eq}({abotprop.SUT.MCC})                                                                      |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.plmn_id.mnc                  | {string:eq}({abotprop.SUT.MNC})                                                                      |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.tac                          | {string:eq}({abotprop.SUT.TAC})                                                                      |
      | multipart_related.json_data.sm_context_create_data.sm_context_status_uri                                    | {string:eq}(http://127.0.0.1:12349/namf-comm/v1/sm-contexts/smctx-1/status/6)                        |
      | multipart_related.json_data.sm_context_create_data.gpsi                                                     | {string:eq}({abotprop.SUT.GPSI.START})                                                               |
      | multipart_related.json_data.sm_context_create_data.pdu_session_id                                           | {string:eq}({abotprop.SUT.PDU.SESS.ID})                                                              |
      | multipart_related.json_data.sm_context_create_data.n1_sm_msg.content_id                                     | {string:eq}(n1-pdu-session-establishment-request)                                                    |
      | multipart_related.json_data.sm_context_create_data.an_type                                                  | {string:eq}({abotprop.SUT.ACCESS.TYPE.3GPP})                                                         |
      | multipart_related.json_data.sm_context_create_data.supi                                                     | {string:eq}(incr($({abotprop.SUT.SUPI}),1))                                                          |
      | multipart_related.json_data.sm_context_create_data.s_nssai.sst                                              | {string:eq}({abotprop.SUT.SUBSCRIBEDNSSAI})                                                          |
      | multipart_related.json_data.sm_context_create_data.serving_nf_id                                            | {string:eq}({abotprop.SUT.AMF1.NFINSTANCEID})                                                        |
      | multipart_related.json_data.sm_context_create_data.pei                                                      | save(PEI)                                                                                            |
      | multipart_related.json_data.sm_context_create_data.request_type                                             | {string:eq}(INITIAL_REQUEST)                                                                         |
      | multipart_related.json_data.sm_context_create_data.dnn                                                      | {string:eq}({abotprop.SUT.DNN1})                                                                     |
      | multipart_related.json_data.sm_context_create_data.guami.plmn_id.mcc                                        | {string:eq}({abotprop.SUT.MCC})                                                                      |
      | multipart_related.json_data.sm_context_create_data.guami.plmn_id.mnc                                        | {string:eq}({abotprop.SUT.MNC})                                                                      |
      | multipart_related.json_data.sm_context_create_data.guami.amf_id                                             | {string:eq}({abotprop.SUT.AMF.REG.AMF.ID})                                                           |
      | multipart_related.json_data.sm_context_create_data.serving_network.mcc                                      | {string:eq}({abotprop.SUT.MCC})                                                                      |
      | multipart_related.json_data.sm_context_create_data.serving_network.mnc                                      | {string:eq}({abotprop.SUT.MNC})                                                                      |
      | multipart_related.json_data.sm_context_create_data.pdu_sessions_activate_list.0.pdu_session_id              | {string:eq}({abotprop.SUT.PDU.SESS.ID})                                                              |
      | multipart_related.binary_data_n1_sm_message.content_type                                                    | {string:eq}(application/vnd.3gpp.5gnas)                                                              |
      | multipart_related.binary_data_n1_sm_message.content_id                                                      | {string:eq}(n1-pdu-session-establishment-request)                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator              | {string:eq}({abotprop.SUT.NAS.PDU.SM_EDP})                                                           |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                               | {string:eq}({abotprop.SUT.PDU.SESS.ID})                                                              |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                                          | {string:eq}({abotprop.SUT.NAS.PTI})                                                                  |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                                 | {string:eq}({abotprop.SUT.NAS.PDU.SESS.ESTD.REQ.MSG})                                                |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_estab_req.int_protect_max_data_rate | {string:eq}({abotprop.SUT.NAS.PDU.INTRIGRITY.PRO.MAX.DATA.RATE})                                     |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_estab_req.pdu_sess_type             | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_TYPE.IPV4})                                                |
	  
    When I send HTTPV2 message HTTPV2_NUDM_UECM_SMF_REG_PUT_REQ on interface N10 with the following details from node SMF1 to UDM1:
      | parameter                         | value                                                                                          |
      | header.nva.0.name                 | :method                                                                                        |
      | header.nva.0.value                | PUT                                                                                            |
      | header.nva.1.name                 | :path                                                                                          |
      | header.nva.1.value                | /127.0.0.1:12348/nudm-uecm/v1/incr($({abotprop.SUT.SUPI}),1)/registrations/smf-registrations/6 |
      | header.nva.2.name                 | content-type                                                                                   |
      | header.nva.2.value                | application/json                                                                               |
      | smf_registration.smf_instance_id  | {abotprop.SUT.SMF1.NFINSTANCEID}                                                               |
      | smf_registration.pdu_session_id   | {abotprop.SUT.PDU.SESS.ID}                                                                     |
      | smf_registration.single_nssai.sst | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}                                                     |
      | smf_registration.plmn_id.mcc      | {abotprop.SUT.MCC}                                                                             |
      | smf_registration.plmn_id.mnc      | {abotprop.SUT.MNC}                                                                             |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UECM_SMF_REG_PUT_REQ on interface N10 with the following details on node UDM1 from SMF1:
      | parameter                         | value                                                                                                       |
      | header.nva.0.name                 | {string:eq}(:method)                                                                                        |
      | header.nva.0.value                | {string:eq}(PUT)                                                                                            |
      | header.nva.1.name                 | {string:eq}(:path)                                                                                          |
      | header.nva.1.value                | {string:eq}(/127.0.0.1:12348/nudm-uecm/v1/incr($({abotprop.SUT.SUPI}),1)/registrations/smf-registrations/6) |
      | header.nva.2.name                 | {string:eq}(content-type)                                                                                   |
      | header.nva.2.value                | {string:eq}(application/json)                                                                               |
      | smf_registration.smf_instance_id  | {string:eq}({abotprop.SUT.SMF1.NFINSTANCEID})                                                               |
      | smf_registration.pdu_session_id   | {string:eq}({abotprop.SUT.PDU.SESS.ID})                                                                     |
      | smf_registration.single_nssai.sst | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB})                                                     |
      | smf_registration.plmn_id.mcc      | {string:eq}({abotprop.SUT.MCC})                                                                             |
      | smf_registration.plmn_id.mnc      | {string:eq}({abotprop.SUT.MNC})                                                                             |

    When I send HTTPV2 message HTTPV2_NUDM_UECM_SMF_REG_PUT_RES_201 on interface N10 with the following details from node UDM1 to SMF1:
      | parameter                         | value                                                                                          |
      | header.nva.0.name                 | :status                                                                                        |
      | header.nva.0.value                | 201                                                                                            |
      | header.nva.1.name                 | location                                                                                       |
      | header.nva.1.value                | /127.0.0.1:12348/nudm-uecm/v1/incr($({abotprop.SUT.SUPI}),1)/registrations/smf-registrations/6 |
      | header.nva.2.name                 | content-type                                                                                   |
      | header.nva.2.value                | application/json                                                                               |
      | smf_registration.smf_instance_id  | {abotprop.SUT.SMF1.NFINSTANCEID}                                                               |
      | smf_registration.pdu_session_id   | {abotprop.SUT.PDU.SESS.ID}                                                                     |
      | smf_registration.single_nssai.sst | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}                                                     |
      | smf_registration.plmn_id.mcc      | {abotprop.SUT.MCC}                                                                             |
      | smf_registration.plmn_id.mnc      | {abotprop.SUT.MNC}                                                                             |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UECM_SMF_REG_PUT_RES_201 on interface N10 with the following details on node SMF1 from UDM1:
      | parameter                         | value                                                                                                       |
      | header.nva.0.name                 | {string:eq}(:status)                                                                                        |
      | header.nva.0.value                | {string:eq}(201)                                                                                            |
      | header.nva.1.name                 | {string:eq}(location)                                                                                       |
      | header.nva.1.value                | {string:eq}(/127.0.0.1:12348/nudm-uecm/v1/incr($({abotprop.SUT.SUPI}),1)/registrations/smf-registrations/6) |
      | header.nva.2.name                 | {string:eq}(content-type)                                                                                   |
      | header.nva.2.value                | {string:eq}(application/json)                                                                               |
      | smf_registration.smf_instance_id  | {string:eq}({abotprop.SUT.SMF1.NFINSTANCEID})                                                               |
      | smf_registration.pdu_session_id   | {string:eq}({abotprop.SUT.PDU.SESS.ID})                                                                     |
      | smf_registration.single_nssai.sst | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB})                                                     |
      | smf_registration.plmn_id.mcc      | {string:eq}({abotprop.SUT.MCC})                                                                             |
      | smf_registration.plmn_id.mnc      | {string:eq}({abotprop.SUT.MNC})                                                                             |

    When I send HTTPV2 message HTTPV2_NSMF_CREATE_SM_CONTEXT_RES_201 on interface N11 with the following details from node SMF1 to AMF1:
      | parameter                                               | value                                                         |
      | header.nva.0.name                                       | :status                                                       |
      | header.nva.0.value                                      | 201                                                           |
      | header.nva.1.name                                       | content-type                                                  |
      | header.nva.1.value                                      | application/json                                              |
      | header.nva.2.name                                       | location                                                      |
      | header.nva.2.value                                      | http://127.0.0.1:12352/nsmf-pdusession/v1/sm-contexts/smctx-1 |
      | application_json.sm_context_created_data.h_smf_uri      | http://127.0.0.1:12352                                        |
      | application_json.sm_context_created_data.pdu_session_id | {abotprop.SUT.PDU.SESS.ID}                                    |
      | application_json.sm_context_created_data.s_nssai.sst    | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}                    |
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
      | application_json.sm_context_created_data.pdu_session_id | {string:eq}({abotprop.SUT.PDU.SESS.ID})                                    |
      | application_json.sm_context_created_data.s_nssai.sst    | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB})                    |
      | application_json.sm_context_created_data.up_cnx_state   | {string:eq}(ACTIVATED)                                                     |

## SM Policy Association for New PDU Session (SMF to PCF : Setup SM Policy Association for the UE with PCF for Session Management control)

    When I send HTTPV2 message HTTPV2_NPCFSM_POLICY_CONTROL_CREATE_POST_REQ on interface N7 with the following details from node SMF1 to PCF1:
      | parameter                               | value                                                           |
      | header.nva.0.name                       | :method                                                         |
      | header.nva.0.value                      | POST                                                            |
      | header.nva.1.name                       | :path                                                           |
      | header.nva.1.value                      | /127.0.0.1:12348/npcf-smpolicycontrol/v1/sm-policies            |
      | header.nva.2.name                       | content-type                                                    |
      | header.nva.2.value                      | application/json                                                |
      | sm_policy_context_data.supi             | incr({abotprop.SUT.SUPI},1)                                     |
      | sm_policy_context_data.pdu_session_id   | {abotprop.SUT.PDU.SESS.ID}                                      |
      | sm_policy_context_data.pdu_session_type | 0                                                               |
      | sm_policy_context_data.dnn              | {abotprop.SUT.DNN1}                                             |
      | sm_policy_context_data.notification_uri | /192.168.40.150:2532/npcf-smpolicycontrol/v1/sm-policies/smPol1 |
      | sm_policy_context_data.slice_info.sst   | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}                      |

    Then I receive and validate HTTPV2 message HTTPV2_NPCFSM_POLICY_CONTROL_CREATE_POST_REQ on interface N7 with the following details on node PCF1 from SMF1:
      | parameter                               | value                                                                        |
      | header.nva.0.name                       | {string:eq}(:method)                                                         |
      | header.nva.0.value                      | {string:eq}(POST)                                                            |
      | header.nva.1.name                       | {string:eq}(:path)                                                           |
      | header.nva.1.value                      | {string:eq}(/127.0.0.1:12348/npcf-smpolicycontrol/v1/sm-policies)            |
      | header.nva.2.name                       | {string:eq}(content-type)                                                    |
      | header.nva.2.value                      | {string:eq}(application/json)                                                |
      | sm_policy_context_data.supi             | save(SUPI)                                                                   |
      | sm_policy_context_data.pdu_session_id   | {string:eq}({abotprop.SUT.PDU.SESS.ID})                                      |
      | sm_policy_context_data.pdu_session_type | {string:eq}(0)                                                               |
      | sm_policy_context_data.dnn              | {string:eq}({abotprop.SUT.DNN1})                                             |
      | sm_policy_context_data.notification_uri | {string:eq}(/192.168.40.150:2532/npcf-smpolicycontrol/v1/sm-policies/smPol1) |
      | sm_policy_context_data.slice_info.sst   | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB})                      |

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
      | sm_policy_decision.pcc_rules.pccruleid1.pcc_rule_id                                       | pccruleid1                                                                    |
      | sm_policy_decision.pcc_rules.pccruleid1.precedence                                        | {abotprop.SUT.PCCRULE.PRECEDENCE}                                             |
      | sm_policy_decision.pcc_rules.pccruleid1.flow_infos.0.flow_information.flow_description    | permit out 17 from 43.225.55.127/16 {7000-8000} to 172.16.0.10/16 {5000-6000} |
      | sm_policy_decision.pcc_rules.pccruleid1.flow_infos.0.flow_information.pack_filt_id        | packetfilterid1                                                               |
      | sm_policy_decision.pcc_rules.pccruleid1.flow_infos.0.flow_information.packet_filter_usage | true                                                                          |
      | sm_policy_decision.pcc_rules.pccruleid1.flow_infos.0.flow_information.tos_traffic_class   | 0                                                                             |
      | sm_policy_decision.pcc_rules.pccruleid1.flow_infos.0.flow_information.flow_direction      | DOWNLINK                                                                      |
      | sm_policy_decision.pcc_rules.pccruleid1.ref_qos_data.0.ref_qos_data_item                  | qosid1                                                                        |
      | sm_policy_decision.sess_rules.sessruleid1.sess_rule_id                                    | sessruleid1                                                                   |
      #| sm_policy_decision.sess_rules.sessruleid1.auth_sess_ambr.uplink                           | 20000 Kbps                                                                    |
      #| sm_policy_decision.sess_rules.sessruleid1.auth_sess_ambr.downlink                         | 30000 Kbps                                                                    |
      | sm_policy_decision.sess_rules.sessruleid1.auth_sess_ambr.uplink                           | {abotprop.SUT.SESSION.AMBR.UL}                                                |
      | sm_policy_decision.sess_rules.sessruleid1.auth_sess_ambr.downlink                         | {abotprop.SUT.SESSION.AMBR.DL}                                                |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.5qi                                | {abotprop.SUT.AUTO.RSP.PDU.SESS.5QI}                                          |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.priority_level                     | {abotprop.SUT.QOS.5QI.PRIORITY}                                               |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.arp.priority_level                 | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PRIORITY.LEVEL}                           |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.arp.preemption_cap                 | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.CAPABILITY}                       |
      | sm_policy_decision.sess_rules.sessruleid1.auth_def_qos.arp.preempt_vuln                   | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.VULNERABILITY}                    |
      | sm_policy_decision.qos_decs.qosid1.qos_id                                                 | qosid1                                                                        |
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
      | sm_policy_decision.pcc_rules.pccruleid1.pcc_rule_id    | {string:eq}(pccruleid1)                                                  |
      | sm_policy_decision.sess_rules.sessruleid1.sess_rule_id | {string:eq}(sessruleid1)                                                 |
      | sm_policy_decision.qos_decs.qosid1.qos_id              | {string:eq}(qosid1)                                                      |
	  
    When I send PFCP message PFCP_SESSION_ESTABLISH_REQ on interface N4 with the following details from node SMF1 to UPF1:
      | parameter                                               | value                                                                         |
      | header.message_type                                     | {abotprop.SUT.PFCP.HEADER.MSG.TYPE.EST.REQ}                                   |
      | header.seid                                             | 0                                                                             |
      | header.seq_number                                       | incr(2,3)                                                                     |
      | node_id.type                                            | {abotprop.SUT.PFCP_NODE_ID_TYPE}                                              |
      | node_id.value                                           | $({abotprop.SMF1.SecureShell.IPAddress})                                      |
      | cp_f_seid.flag                                          | {abotprop.SUT.PFCP.CP.F-SEID.FLAG}                                            |
      | cp_f_seid.seid                                          | incr(10000000,1)                                                              |
      | cp_f_seid.ipv4_addr                                     | $({abotprop.SMF1.SecureShell.IPAddress})                                      |
      | pdn_type                                                | {abotprop.SUT.3GPP.PDN_TYPE}                                                  |
      | create_pdr.0.pdr_id                                     | {abotprop.SUT.PFCP.PDR.0.PDR_ID}                                              |
      | create_pdr.0.precedence                                 | 1                                                                             |
      | create_pdr.0.pdi.source_interface                       | {abotprop.SUT.PFCP.PDR.0.SOURCE_INTERFCE.ACCESS}                              |
      | create_pdr.0.pdi.local_fteid.flag                       | 1                                                                             |
      | create_pdr.0.pdi.local_fteid.teid                       | {abotprop.SUT.AUTO.RSP.GTP.UL.TEID}                                           |
      | create_pdr.0.pdi.local_fteid.ipv4_addr                  | 10.10.10.10                                                                   |
      | create_pdr.0.pdi.qfi                                    | {abotprop.SUT.AUTO.RSP.PDU.SESS.QFI}                                          |
      | create_pdr.0.outer_header_removal.outer_head_remov_desc | 0                                                                             |
      | create_pdr.0.outer_header_removal.gtpu_ext_head_desc    | 0                                                                             |
      | create_pdr.0.far_id                                     | {abotprop.SUT.PFCP.PDR.0.FAR_ID}                                              |
      | create_pdr.0.qer_id                                     | {abotprop.SUT.PFCP.PDR.0.QER_ID}                                              |
      | create_pdr.1.pdr_id                                     | {abotprop.SUT.PFCP.PDR.1.PDR_ID}                                              |
      | create_pdr.1.precedence                                 | 1                                                                             |
      | create_pdr.1.pdi.source_interface                       | {abotprop.SUT.PFCP.PDR.0.SOURCE_INTERFCE.CORE}                                |
      | create_pdr.1.pdi.ue_ip_addr.flag                        | 6                                                                             |
      | create_pdr.1.pdi.ue_ip_addr.ipv4_addr                   | incr(172.16.0.10,1)                                                           |
      | create_pdr.1.pdi.qfi                                    | {abotprop.SUT.AUTO.RSP.PDU.SESS.QFI}                                          |
      | create_pdr.1.pdi.sdf_filter.flow_description            | permit out 17 from 43.225.55.127/16 {7000-8000} to 172.16.0.10/16 {5000-6000} |
      | create_pdr.1.far_id                                     | {abotprop.SUT.PFCP.PDR.1.FAR_ID}                                              |
      | create_pdr.1.qer_id                                     | {abotprop.SUT.PFCP.PDR.0.QER_ID}                                              |
      | create_far.0.far_id                                     | {abotprop.SUT.PFCP.PDR.0.FAR_ID}                                              |
      | create_far.0.apply_action                               | 2                                                                             |
      | create_far.0.forwarding_parms.destination_interface     | {abotprop.SUT.PFCP.PDR.0.DESTINATION_INTERFCE.CORE}                           |
      | create_far.1.far_id                                     | {abotprop.SUT.PFCP.PDR.1.FAR_ID}                                              |
      | create_far.1.apply_action                               | 2                                                                             |
      | create_far.1.forwarding_parms.destination_interface     | {abotprop.SUT.PFCP.PDR.0.DESTINATION_INTERFCE.ACCESS}                         |
      | create_qer.0.qer_id                                     | {abotprop.SUT.PFCP.PDR.0.QER_ID}                                              |
      | create_qer.0.gate_status.ul_gate                        | 0                                                                             |
      | create_qer.0.gate_status.dl_gate                        | 0                                                                             |
      | create_qer.0.mbr.ul_mbr                                 | {abotprop.SUT.AGGR.MAX.BIT.RATE.UL}                                           |
      | create_qer.0.mbr.dl_mbr                                 | {abotprop.SUT.AGGR.MAX.BIT.RATE.DL}                                           |
      | create_qer.0.qfi                                        | {abotprop.SUT.AUTO.RSP.PDU.SESS.QFI}                                          |

    Then I receive and validate PFCP message PFCP_SESSION_ESTABLISH_REQ on interface N4 with the following details on node UPF1 from SMF1:
      | parameter                                               | value                                                              |
      | header.message_type                                     | {string:eq}({abotprop.SUT.PFCP.HEADER.MSG.TYPE.EST.REQ})           |
      | header.seid                                             | {string:eq}(0)                                                     |
      | header.seq_number                                       | save(PFCP_HDR_SEQ_NO)                                              |
      | node_id.type                                            | {string:eq}({abotprop.SUT.PFCP_NODE_ID_TYPE})                      |
      | node_id.value                                           | save(PFCP_NODE_IP_SMF)                                             |
      | cp_f_seid.flag                                          | {string:eq}({abotprop.SUT.PFCP.CP.F-SEID.FLAG})                    |
      | cp_f_seid.seid                                          | save(PFCP_SEID_N4_UPF1_SMF1)                                       |
      | cp_f_seid.ipv4_addr                                     | save(PFCP_MSG_IP_SMF)                                              |
      | pdn_type                                                | {string:eq}({abotprop.SUT.3GPP.PDN_TYPE})                          |
      | create_pdr.0.pdr_id                                     | {string:eq}({abotprop.SUT.PFCP.PDR.0.PDR_ID})                      |
      | create_pdr.0.precedence                                 | {string:eq}(1)                                                     |
      | create_pdr.0.pdi.source_interface                       | {string:eq}({abotprop.SUT.PFCP.PDR.0.SOURCE_INTERFCE.ACCESS})      |
      | create_pdr.0.pdi.local_fteid.flag                       | {string:eq}(1)                                                     |
      | create_pdr.0.pdi.local_fteid.teid                       | save(GTP_UL_TEID_UPF)                                              |
      | create_pdr.0.pdi.local_fteid.ipv4_addr                  | save(GTP_UL_IP_UPF)                                                |
      | create_pdr.0.pdi.qfi                                    | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.QFI})                  |
      | create_pdr.0.outer_header_removal.outer_head_remov_desc | {string:eq}(0)                                                     |
      | create_pdr.0.outer_header_removal.gtpu_ext_head_desc    | {string:eq}(0)                                                     |
      | create_pdr.0.far_id                                     | {string:eq}({abotprop.SUT.PFCP.PDR.0.FAR_ID})                      |
      | create_pdr.0.qer_id                                     | {string:eq}({abotprop.SUT.PFCP.PDR.0.QER_ID})                      |
      | create_pdr.1.pdr_id                                     | {string:eq}({abotprop.SUT.PFCP.PDR.1.PDR_ID})                      |
      | create_pdr.1.precedence                                 | {string:eq}(1)                                                     |
      | create_pdr.1.pdi.source_interface                       | {string:eq}({abotprop.SUT.PFCP.PDR.0.SOURCE_INTERFCE.CORE})        |
      | create_pdr.1.pdi.ue_ip_addr.flag                        | {string:eq}(6)                                                     |
      | create_pdr.1.pdi.ue_ip_addr.ipv4_addr                   | save(UE_IP)                                                        |
      | create_pdr.1.pdi.qfi                                    | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.QFI})                  |
      | create_pdr.1.pdi.sdf_filter.flow_description            | save(FLOW_DESC)                                                    |
      | create_pdr.1.far_id                                     | {string:eq}({abotprop.SUT.PFCP.PDR.1.FAR_ID})                      |
      | create_pdr.1.qer_id                                     | {string:eq}({abotprop.SUT.PFCP.PDR.0.QER_ID})                      |
      | create_far.0.far_id                                     | {string:eq}({abotprop.SUT.PFCP.PDR.0.FAR_ID})                      |
      | create_far.0.apply_action                               | {string:eq}(2)                                                     |
      | create_far.0.forwarding_parms.destination_interface     | {string:eq}({abotprop.SUT.PFCP.PDR.0.DESTINATION_INTERFCE.CORE})   |
      | create_far.1.far_id                                     | {string:eq}({abotprop.SUT.PFCP.PDR.1.FAR_ID})                      |
      | create_far.1.apply_action                               | {string:eq}(2)                                                     |
      | create_far.1.forwarding_parms.destination_interface     | {string:eq}({abotprop.SUT.PFCP.PDR.0.DESTINATION_INTERFCE.ACCESS}) |
      | create_qer.0.qer_id                                     | {string:eq}({abotprop.SUT.PFCP.PDR.0.QER_ID})                      |
      | create_qer.0.gate_status.ul_gate                        | {string:eq}(0)                                                     |
      | create_qer.0.gate_status.dl_gate                        | {string:eq}(0)                                                     |
      | create_qer.0.mbr.ul_mbr                                 | {string:eq}({abotprop.SUT.AGGR.MAX.BIT.RATE.UL})                   |
      | create_qer.0.mbr.dl_mbr                                 | {string:eq}({abotprop.SUT.AGGR.MAX.BIT.RATE.DL})                   |
      | create_qer.0.qfi                                        | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.QFI})                  |

    When I send PFCP message PFCP_SESSION_ESTABLISH_RES on interface N4 with the following details from node UPF1 to SMF1:
      | parameter            | value                                       |
      | header.message_type  | {abotprop.SUT.PFCP.HEADER.MSG.TYPE.EST.RES} |
      | header.seid          | $(PFCP_SEID_N4_UPF1_SMF1)                   |
      | header.seq_number    | $(PFCP_HDR_SEQ_NO)                          |
      | node_id.type         | {abotprop.SUT.PFCP_NODE_ID_TYPE}            |
      | node_id.value        | $({abotprop.UPF1.SecureShell.IPAddress})    |
      | cause                | {abotprop.SUT.PFCP.RESPOSE.CAUSE.ACCEPTED}  |
      | up_f_seid.flag       | {abotprop.SUT.PFCP.UP.F-SEID.FLAG}          |
      | up_f_seid.seid       | incr(20000000,1)                            |
      | up_f_seid.ipv4_addr  | 5.6.7.8                                     |
      | created_pdr.0.pdr_id | {abotprop.SUT.PFCP.PDR.0.PDR_ID}            |
      | created_pdr.1.pdr_id | {abotprop.SUT.PFCP.PDR.1.PDR_ID}            |

    Then I receive and validate PFCP message PFCP_SESSION_ESTABLISH_RES on interface N4 with the following details on node SMF1 from UPF1:
      | parameter            | value                                                    |
      | header.message_type  | {string:eq}({abotprop.SUT.PFCP.HEADER.MSG.TYPE.EST.RES}) |
      | header.seid          | save(PFCP_SEID_N4_UPF1_SMF1)                             |
      | header.seq_number    | save(PFCP_HDR_SEQ_NO)                                    |
      | node_id.type         | {string:eq}({abotprop.SUT.PFCP_NODE_ID_TYPE})            |
      | node_id.value        | save(PFCP_NODE_IP_UPF)                                   |
      | cause                | {string:eq}({abotprop.SUT.PFCP.RESPOSE.CAUSE.ACCEPTED})  |
      | up_f_seid.flag       | {string:eq}({abotprop.SUT.PFCP.UP.F-SEID.FLAG})          |
      | up_f_seid.seid       | save(PFCP_SEID_N4_SMF1_UPF1)                             |
      | up_f_seid.ipv4_addr  | save(PFCP_MSG_IP_UPF)                                    |
      | created_pdr.0.pdr_id | {string:eq}({abotprop.SUT.PFCP.PDR.0.PDR_ID})            |
      | created_pdr.1.pdr_id | {string:eq}({abotprop.SUT.PFCP.PDR.1.PDR_ID})            |
	  
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
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.pdu_session_id                                                                                               | {abotprop.SUT.PDU.SESS.ID}                                                                             |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.s_nssai.sst                                                                                                  | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}                                                             |
      | multipart_related.json_data.n1n2_message_transfer_req_data.skip_ind                                                                                                                               | false                                                                                                  |
      | multipart_related.json_data.n1n2_message_transfer_req_data.pdu_session_id                                                                                                                         | {abotprop.SUT.PDU.SESS.ID}                                                                             |
      | multipart_related.json_data.n1n2_message_transfer_req_data.5qi                                                                                                                                    | {abotprop.SUT.AUTO.RSP.PDU.SESS.5QI}                                                                   |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1n2_failure_txf_notif_u_r_i                                                                                                           | /127.0.0.1:12348/namf-comm/v1/ue-contexts/incr(imsi-404309990000001,1)/n1-n2-messages/callback-failure |
      | multipart_related.json_data.n1n2_message_transfer_req_data.smf_reallocation_ind                                                                                                                   | false                                                                                                  |
      | multipart_related.binary_data_n1_message.content_type                                                                                                                                             | application/vnd.3gpp.5gnas                                                                             |
      | multipart_related.binary_data_n1_message.content_id                                                                                                                                               | n1-pdu-session-establishment-accept                                                                    |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.extended_protocol_discriminator                                                                                                       | {abotprop.SUT.NAS.PDU.SM_EDP}                                                                          |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_session_id                                                                                                                        | {abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID}                                                              |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pti                                                                                                                                   | {abotprop.SUT.NAS.PTI}                                                                                 |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.message_type                                                                                                                          | {abotprop.SUT.NAS.PDU.SESS.ESTD.ACC.MSG}                                                               |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.selected_pdu_sess_type                                                                                             | {abotprop.SUT.NAS.N1-SM-INFO.SELECTED.PDU_SESSION_TYPE}                                                |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.selected_ssc_mode                                                                                                  | {abotprop.SUT.NAS.SELECTED.SSC.MODE}                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.session_ambr                                                                                                       | {abotprop.SUT.NAS.N1-SM-INFO.SESSION.AMBR}                                                             |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.pdu_address                                                                                                        | {abotprop.SUT.PDU.ADDRESS}                                                                             |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.snssai                                                                                                             | {abotprop.SUT.SUBSCRIBEDNSSAI}                                                                         |
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
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate                 | {abotprop.SUT.AGGR.MAX.BIT.RATE.DL}                                                                    |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate                 | {abotprop.SUT.AGGR.MAX.BIT.RATE.UL}                                                                    |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                      | {abotprop.SUT.AUTO.RSP.GTP.UL.IP}                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                     | incr(30000000,1)                                                                                       |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                                 | {abotprop.SUT.NAS.N2-PDU-SETUP-REQ-TRANSFR.PDU_SESSION_TYPE}                                           |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                                    | {abotprop.SUT.AUTO.RSP.PDU.SESS.QFI}                                                                   |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi         | {abotprop.SUT.AUTO.RSP.PDU.SESS.5QI}                                                                   |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.priority_level | {abotprop.SUT.QOS.5QI.PRIORITY}                                                                        |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                                 | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PRIORITY.LEVEL}                                                    |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                             | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.CAPABILITY}                                                |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                          | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.VULNERABILITY}                                             |

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
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.pdu_session_id                                                                                               | {string:eq}({abotprop.SUT.PDU.SESS.ID})                                                                             |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.s_nssai.sst                                                                                                  | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB})                                                             |
      | multipart_related.json_data.n1n2_message_transfer_req_data.skip_ind                                                                                                                               | {string:eq}(false)                                                                                                  |
      | multipart_related.json_data.n1n2_message_transfer_req_data.pdu_session_id                                                                                                                         | {string:eq}({abotprop.SUT.PDU.SESS.ID})                                                                             |
      | multipart_related.json_data.n1n2_message_transfer_req_data.5qi                                                                                                                                    | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.5QI})                                                                   |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1n2_failure_txf_notif_u_r_i                                                                                                           | {string:eq}(/127.0.0.1:12348/namf-comm/v1/ue-contexts/incr(imsi-404309990000001,1)/n1-n2-messages/callback-failure) |
      | multipart_related.json_data.n1n2_message_transfer_req_data.smf_reallocation_ind                                                                                                                   | {string:eq}(false)                                                                                                  |
      | multipart_related.binary_data_n1_message.content_type                                                                                                                                             | {string:eq}(application/vnd.3gpp.5gnas)                                                                             |
      | multipart_related.binary_data_n1_message.content_id                                                                                                                                               | {string:eq}(n1-pdu-session-establishment-accept)                                                                    |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.extended_protocol_discriminator                                                                                                       | {string:eq}({abotprop.SUT.NAS.PDU.SM_EDP})                                                                          |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_session_id                                                                                                                        | {string:eq}({abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID})                                                              |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pti                                                                                                                                   | {string:eq}({abotprop.SUT.NAS.PTI})                                                                                 |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.message_type                                                                                                                          | {string:eq}({abotprop.SUT.NAS.PDU.SESS.ESTD.ACC.MSG})                                                               |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.selected_pdu_sess_type                                                                                             | {string:eq}({abotprop.SUT.NAS.N1-SM-INFO.SELECTED.PDU_SESSION_TYPE})                                                |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.selected_ssc_mode                                                                                                  | {string:eq}({abotprop.SUT.NAS.SELECTED.SSC.MODE})                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.session_ambr                                                                                                       | {string:eq}({abotprop.SUT.NAS.N1-SM-INFO.SESSION.AMBR})                                                             |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.pdu_address                                                                                                        | save(UE_IP)                                                                                                         |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.snssai                                                                                                             | {string:eq}({abotprop.SUT.SUBSCRIBEDNSSAI})                                                                         |
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
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate                 | {string:eq}({abotprop.SUT.AGGR.MAX.BIT.RATE.DL})                                                                    |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate                 | {string:eq}({abotprop.SUT.AGGR.MAX.BIT.RATE.UL})                                                                    |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                      | save(GTP_UL_IP_UPF)                                                                                                 |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                     | save(GTP_UL_TEID_UPF)                                                                                               |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                                 | {string:eq}({abotprop.SUT.NAS.N2-PDU-SETUP-REQ-TRANSFR.PDU_SESSION_TYPE})                                           |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                                    | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.QFI})                                                                   |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi         | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.5QI})                                                                   |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.priority_level | {string:eq}({abotprop.SUT.QOS.5QI.PRIORITY})                                                                        |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                                 | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PRIORITY.LEVEL})                                                    |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                             | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.CAPABILITY})                                                |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                          | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.VULNERABILITY})                                             |
 
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

    When I send NGAP message NG_PDU_SESS_RESRC_SETUP_REQ on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                                                                                                                                                                                                                                                              | value                                                        |
      | amf_ue_ngap_id                                                                                                                                                                                                                                                                         | $(AMF_UE_NGAP_ID)                                            |
      | ran_ue_ngap_id                                                                                                                                                                                                                                                                         | $(RAN_UE_NGAP_ID)                                            |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.extended_protocol_discriminator                                                                                                                                                                                  | {abotprop.SUT.NAS.EDP}                                       |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.security_header_type                                                                                                                                                                                             | {abotprop.SUT.NAS.SEC.HEAD.INTEGRITY}                        |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.message_type                                                                                                                                                                                                     | {abotprop.SUT.NAS.DL.NAS.TRANS.MSG}                          |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.pdu_session_identity                                                                                                                                                                            | {abotprop.SUT.NAS.PDU_SESSION_ID6}                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_type                                                                                                                                                                          | {abotprop.SUT.NAS.PAYLOAD.CONTAINER}                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator                                                                                               | {abotprop.SUT.NAS.PDU.SM_EDP}                                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                                                                                                                | {abotprop.SUT.PDU.SESS.ID}                                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                                                                                                                           | {abotprop.SUT.NAS.PTI}                                       |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                                                                                                                  | {abotprop.SUT.NAS.PDU.SESS.ESTD.ACC.MSG}                     |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.selected_pdu_sess_type                                                                                     | {abotprop.SUT.NAS.N1-SM-INFO.SELECTED.PDU_SESSION_TYPE}      |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.selected_ssc_mode                                                                                          | {abotprop.SUT.NAS.SELECTED.SSC.MODE}                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.session_ambr                                                                                               | {abotprop.SUT.NAS.N1-SM-INFO.SESSION.AMBR}                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.pdu_address                                                                                                | $(UE_IP)                                                     |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.snssai                                                                                                     | {abotprop.SUT.SUBSCRIBEDNSSAI}                               |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.dnn                                                                                                        | {abotprop.SUT.DNN1}                                          |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.qri                                                                       | 0x01                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.op_code_dqr_bit_no_of_pkt_filters                                         | 0x31                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.precedence                                                                | 0x01                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.segr_bit_qfi                                                              | 0x09                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.dir_id                                               | 0x21                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.type                           | 0x11                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.ipv4_local_address_mask        | 0xac10000affff0000                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.type                           | 0x10                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.ipv4_remote_address_mask       | 0x2be1377fffff0000                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.type                           | 0x30                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.ipv4_proto_id_or_ipv6_next_hdr | 0x11                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.type                           | 0x41                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.local_port_range               | 0x13881770                                                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.type                           | 0x51                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.remote_port_range              | 0x1b581f40                                                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_id                                                                                                                                                                                                                               | {abotprop.SUT.PDU.SESS.ID}                                   |
      | pdu_session_resource_setup_request_list.0.s-nssai.sst                                                                                                                                                                                                                                  | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate                                                                                                                 | {abotprop.SUT.AGGR.MAX.BIT.RATE.DL}                          |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate                                                                                                                 | {abotprop.SUT.AGGR.MAX.BIT.RATE.UL}                          |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                                                                                                                      | $(GTP_UL_IP_UPF)                                             |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                                                                                                                     | $(GTP_UL_TEID_UPF)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                                                                                                                                 | {abotprop.SUT.NAS.N2-PDU-SETUP-REQ-TRANSFR.PDU_SESSION_TYPE} |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                                                                                                                                    | {abotprop.SUT.AUTO.RSP.PDU.SESS.QFI}                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi                                                                                                         | {abotprop.SUT.AUTO.RSP.PDU.SESS.5QI}                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.priority_level                                                                                                 | {abotprop.SUT.QOS.5QI.PRIORITY}                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                                                                                                                                 | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PRIORITY.LEVEL}          |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                                                                                                                             | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.CAPABILITY}      |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                                                                                                                          | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.VULNERABILITY}   |

    Then I receive and validate NGAP message NG_PDU_SESS_RESRC_SETUP_REQ on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                                                                                                                                                                                                                                                              | value                                                                     |
      | amf_ue_ngap_id                                                                                                                                                                                                                                                                         | {string:eq}($(AMF_UE_NGAP_ID))                                            |
      | ran_ue_ngap_id                                                                                                                                                                                                                                                                         | {string:eq}($(RAN_UE_NGAP_ID))                                            |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.extended_protocol_discriminator                                                                                                                                                                                  | {string:eq}({abotprop.SUT.NAS.EDP})                                       |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.security_header_type                                                                                                                                                                                             | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.INTEGRITY})                        |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.message_type                                                                                                                                                                                                     | {string:eq}({abotprop.SUT.NAS.DL.NAS.TRANS.MSG})                          |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.pdu_session_identity                                                                                                                                                                            | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_ID6})                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_type                                                                                                                                                                          | {string:eq}({abotprop.SUT.NAS.PAYLOAD.CONTAINER})                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator                                                                                               | {string:eq}({abotprop.SUT.NAS.PDU.SM_EDP})                                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                                                                                                                | {string:eq}({abotprop.SUT.PDU.SESS.ID})                                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                                                                                                                           | {string:eq}({abotprop.SUT.NAS.PTI})                                       |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                                                                                                                  | {string:eq}({abotprop.SUT.NAS.PDU.SESS.ESTD.ACC.MSG})                     |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.selected_pdu_sess_type                                                                                     | {string:eq}({abotprop.SUT.NAS.N1-SM-INFO.SELECTED.PDU_SESSION_TYPE})      |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.selected_ssc_mode                                                                                          | {string:eq}({abotprop.SUT.NAS.SELECTED.SSC.MODE})                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.session_ambr                                                                                               | {string:eq}({abotprop.SUT.NAS.N1-SM-INFO.SESSION.AMBR})                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.pdu_address                                                                                                | save(UE_IP)                                                               |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.snssai                                                                                                     | {string:eq}({abotprop.SUT.SUBSCRIBEDNSSAI})                               |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.dnn                                                                                                        | {string:eq}({abotprop.SUT.DNN1})                                          |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.qri                                                                       | {string:eq}(0x01)                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.op_code_dqr_bit_no_of_pkt_filters                                         | {string:eq}(0x31)                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.precedence                                                                | {string:eq}(0x01)                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.segr_bit_qfi                                                              | {string:eq}(0x09)                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.dir_id                                               | {string:eq}(0x21)                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.type                           | {string:eq}(0x11)                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.ipv4_local_address_mask        | {string:eq}(0xac10000affff0000)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.type                           | {string:eq}(0x10)                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.ipv4_remote_address_mask       | {string:eq}(0x2be1377fffff0000)                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.type                           | {string:eq}(0x30)                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.ipv4_proto_id_or_ipv6_next_hdr | {string:eq}(0x11)                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.type                           | {string:eq}(0x41)                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.local_port_range               | {string:eq}(0x13881770)                                                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.type                           | {string:eq}(0x51)                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.remote_port_range              | {string:eq}(0x1b581f40)                                                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_id                                                                                                                                                                                                                               | {string:eq}({abotprop.SUT.PDU.SESS.ID})                                   |
      | pdu_session_resource_setup_request_list.0.s-nssai.sst                                                                                                                                                                                                                                  | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB})                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate                                                                                                                 | {string:eq}({abotprop.SUT.AGGR.MAX.BIT.RATE.DL})                          |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate                                                                                                                 | {string:eq}({abotprop.SUT.AGGR.MAX.BIT.RATE.UL})                          |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                                                                                                                      | save(GTP_UL_IP_UPF)                                                       |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                                                                                                                     | save(GTP_UL_TEID_UPF)                                                     |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                                                                                                                                 | {string:eq}({abotprop.SUT.NAS.N2-PDU-SETUP-REQ-TRANSFR.PDU_SESSION_TYPE}) |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                                                                                                                                    | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.QFI})                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi                                                                                                         | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.5QI})                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.priority_level                                                                                                 | {string:eq}({abotprop.SUT.QOS.5QI.PRIORITY})                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                                                                                                                                 | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PRIORITY.LEVEL})          |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                                                                                                                             | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.CAPABILITY})      |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                                                                                                                          | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.VULNERABILITY})   |

    When I send NGAP message NG_PDU_SESS_RESRC_SETUP_RES on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                                                                          | value                                |
      | amf_ue_ngap_id                                                                                                                                                                     | $(AMF_UE_NGAP_ID)                    |
      | ran_ue_ngap_id                                                                                                                                                                     | $(RAN_UE_NGAP_ID)                    |
      | pdu_session_resource_setup_response_list.0.pdu_session_id                                                                                                                          | {abotprop.SUT.PDU.SESS.ID}           |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | {abotprop.SUT.AUTO.RSP.GTP.DL.IP}    |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | incr(40000000,1)                     |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | {abotprop.SUT.AUTO.RSP.PDU.SESS.QFI} |

    Then I receive and validate NGAP message NG_PDU_SESS_RESRC_SETUP_RES on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                                                                                                          | value                                             |
      | amf_ue_ngap_id                                                                                                                                                                     | {string:eq}($(AMF_UE_NGAP_ID))                    |
      | ran_ue_ngap_id                                                                                                                                                                     | {string:eq}($(RAN_UE_NGAP_ID))                    |
      | pdu_session_resource_setup_response_list.0.pdu_session_id                                                                                                                          | {string:eq}({abotprop.SUT.PDU.SESS.ID})           |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | save(GTP_DL_IP_GNB)                               |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | save(GTP_DL_TEID_GNB)                             |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.QFI}) |

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
      | multipart_related.json_data.sm_context_update_data.s_nssai.sst                                                                                                                                  | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}                                              |
      | multipart_related.json_data.sm_context_update_data.up_cnx_state                                                                                                                                 | ACTIVATED                                                                               |
      | multipart_related.json_data.sm_context_update_data.n2_sm_info.content_id                                                                                                                        | n2-pdu-session-resource-setup-response-transfer-ie                                      |
      | multipart_related.json_data.sm_context_update_data.n2_sm_info_type                                                                                                                              | PDU_RES_SETUP_RSP                                                                       |
      | multipart_related.binary_data_n2_sm_information.content_type                                                                                                                                    | application/vnd.3gpp.ngap                                                               |
      | multipart_related.binary_data_n2_sm_information.content_id                                                                                                                                      | n2-pdu-session-resource-setup-response-transfer-ie                                      |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | $(GTP_DL_IP_GNB)                                                                        |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | $(GTP_DL_TEID_GNB)                                                                      |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | {abotprop.SUT.AUTO.RSP.PDU.SESS.QFI}                                                    |

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
      | multipart_related.json_data.sm_context_update_data.s_nssai.sst                                                                                                                                  | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB})                                              |
      | multipart_related.json_data.sm_context_update_data.up_cnx_state                                                                                                                                 | {string:eq}(ACTIVATED)                                                                               |
      | multipart_related.json_data.sm_context_update_data.n2_sm_info.content_id                                                                                                                        | {string:eq}(n2-pdu-session-resource-setup-response-transfer-ie)                                      |
      | multipart_related.json_data.sm_context_update_data.n2_sm_info_type                                                                                                                              | {string:eq}(PDU_RES_SETUP_RSP)                                                                       |
      | multipart_related.binary_data_n2_sm_information.content_type                                                                                                                                    | {string:eq}(application/vnd.3gpp.ngap)                                                               |
      | multipart_related.binary_data_n2_sm_information.content_id                                                                                                                                      | {string:eq}(n2-pdu-session-resource-setup-response-transfer-ie)                                      |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | save(GTP_DL_IP_GNB)                                                                                  |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | save(GTP_DL_TEID_GNB)                                                                                |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.QFI})                                                    |

    When I send PFCP message PFCP_SESSION_MODIFICATION_REQ on interface N4 with the following details from node SMF1 to UPF1:
      | parameter                                                              | value                                                 |
      | header.message_type                                                    | {abotprop.SUT.PFCP.HEADER.MSG.TYPE.MOD.REQ}           |
      | header.seid                                                            | $(PFCP_SEID_N4_SMF1_UPF1)                             |
      | header.seq_number                                                      | incr(3,3)                                             |
      | update_far.0.far_id                                                    | {abotprop.SUT.PFCP.PDR.1.FAR_ID}                      |
      | update_far.0.apply_action                                              | 2                                                     |
      | update_far.0.update_forwarding_parms.destination_interface             | {abotprop.SUT.PFCP.PDR.0.DESTINATION_INTERFCE.ACCESS} |
      | update_far.0.update_forwarding_parms.outer_header_creation.description | 0x100                                                 |
      | update_far.0.update_forwarding_parms.outer_header_creation.teid        | $(GTP_DL_TEID_GNB)                                    |
      | update_far.0.update_forwarding_parms.outer_header_creation.ipv4_addr   | $(GTP_DL_IP_GNB)                                      |

    Then I receive and validate PFCP message PFCP_SESSION_MODIFICATION_REQ on interface N4 with the following details on node UPF1 from SMF1:
      | parameter                                                              | value                                                              |
      | header.message_type                                                    | {string:eq}({abotprop.SUT.PFCP.HEADER.MSG.TYPE.MOD.REQ})           |
      | header.seid                                                            | save(PFCP_SEID_N4_SMF1_UPF1)                                       |
      | header.seq_number                                                      | save(PFCP_HDR_SEQ_NO)                                              |
      | update_far.0.far_id                                                    | {string:eq}({abotprop.SUT.PFCP.PDR.1.FAR_ID})                      |
      | update_far.0.apply_action                                              | {string:eq}(2)                                                     |
      | update_far.0.update_forwarding_parms.destination_interface             | {string:eq}({abotprop.SUT.PFCP.PDR.0.DESTINATION_INTERFCE.ACCESS}) |
      | update_far.0.update_forwarding_parms.outer_header_creation.description | save(GTP_DL_OUT_HDR_CREATE_DESC)                                   |
      | update_far.0.update_forwarding_parms.outer_header_creation.teid        | save(GTP_DL_TEID_GNB)                                              |
      | update_far.0.update_forwarding_parms.outer_header_creation.ipv4_addr   | save(GTP_DL_IP_GNB)                                                |

    When I send PFCP message PFCP_SESSION_MODIFICATION_RES on interface N4 with the following details from node UPF1 to SMF1:
      | parameter           | value                                       |
      | header.message_type | {abotprop.SUT.PFCP.HEADER.MSG.TYPE.MOD.RES} |
      | header.seid         | $(PFCP_SEID_N4_UPF1_SMF1))                  |
      | header.seq_number   | $(PFCP_HDR_SEQ_NO)                          |
      | cause               | {abotprop.SUT.PFCP.RESPOSE.CAUSE.ACCEPTED}  |

    Then I receive and validate PFCP message PFCP_SESSION_MODIFICATION_RES on interface N4 with the following details on node SMF1 from UPF1:
      | parameter           | value                                                    |
      | header.message_type | {string:eq}({abotprop.SUT.PFCP.HEADER.MSG.TYPE.MOD.RES}) |
      | header.seid         | save($(PFCP_SEID_N4_UPF1_SMF1))                          |
      | header.seq_number   | save(PFCP_HDR_SEQ_NO)                                    |
      | cause               | {string:eq}({abotprop.SUT.PFCP.RESPOSE.CAUSE.ACCEPTED})  |


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
	  
###callbackreference uri : value to be filled in
###notify_items : monitored URI to be filled in
	
    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_DATA_CHANGE_NOTIFICATION_POST_REQ on interface N8 with the following details from node UDM1 to AMF1:
      | parameter                                                                             | value                                                                                                                                          |
      | header.nva.0.name                                                                     | :method                                                                                                                                        |
      | header.nva.0.value                                                                    | POST                                                                                                                                           |
      | header.nva.1.name                                                                     | :path                                                                                                                                          |
      | header.nva.1.value                                                                    | $(AMF_SUB_CALLBACK_NOTIFY)                                                                                                                     |
      | header.nva.2.name                                                                     | content-type                                                                                                                                   |
      | header.nva.2.value                                                                    | application/json                                                                                                                               |
      | modification_notification.notify_items.0.notify_item.resource_id                      | /$({abotprop.UDM1.SecureShell.IPAddress}):$({abotprop.UDM1.N8.Server.Port})/nudm-sdm/v2/incr($({abotprop.SUT.SUPI}),1)/sdm-subscription/amData |
      | modification_notification.notify_items.0.notify_item.changes.0.change_item.op         | REPLACE                                                                                                                                        |
      | modification_notification.notify_items.0.notify_item.changes.0.change_item.path       | /serviceAreaRestriction                                                                                                                        |
      | modification_notification.notify_items.0.notify_item.changes.0.change_item.orig_value | {\"restrictionType\":\"ALLOWED_AREAS\",\"areas\":[{\"tacs\":[\"000001\",\"000002\"]},{\"tacs\":[\"000003\",\"000004\"]}],\"maxNumOfTAs\":2}    |
      | modification_notification.notify_items.0.notify_item.changes.0.change_item.new_value  | {\"restrictionType\":\"ALLOWED_AREAS\",\"areas\":[{\"tacs\":[\"000005\",\"000006\"]},{\"tacs\":[\"000007\",\"000008\"]}],\"maxNumOfTAs\":2}    |
	
    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUBSCRIPTIONS_DATA_CHANGE_NOTIFICATION_POST_REQ on interface N8 with the following details on node AMF1 from UDM1:
      | parameter                                                                             | value                                                                                                                                                       |
      | header.nva.0.name                                                                     | {string:eq}(:method)                                                                                                                                        |
      | header.nva.0.value                                                                    | {string:eq}(POST)                                                                                                                                           |
      | header.nva.1.name                                                                     | {string:eq}(:path)                                                                                                                                          |
      | header.nva.1.value                                                                    | {string:eq}($(AMF_SUB_CALLBACK_NOTIFY))                                                                                                                     |
      | header.nva.2.name                                                                     | {string:eq}(content-type)                                                                                                                                   |
      | header.nva.2.value                                                                    | {string:eq}(application/json)                                                                                                                               |
      | modification_notification.notify_items.0.notify_item.resource_id                      | {string:eq}(/$({abotprop.UDM1.SecureShell.IPAddress}):$({abotprop.UDM1.N8.Server.Port})/nudm-sdm/v2/incr($({abotprop.SUT.SUPI}),1)/sdm-subscription/amData) |
      | modification_notification.notify_items.0.notify_item.changes.0.change_item.op         | {string:eq}(REPLACE)                                                                                                                                        |
      | modification_notification.notify_items.0.notify_item.changes.0.change_item.path       | {string:eq}(/serviceAreaRestriction)                                                                                                                        |
      | modification_notification.notify_items.0.notify_item.changes.0.change_item.orig_value | {string:eq}({"restrictionType":"ALLOWED_AREAS","areas":[{"tacs":["000001","000002"]},{"tacs":["000003","000004"]}],"maxNumOfTAs":2})                        |
      | modification_notification.notify_items.0.notify_item.changes.0.change_item.new_value  | {string:eq}({"restrictionType":"ALLOWED_AREAS","areas":[{"tacs":["000005","000006"]},{"tacs":["000007","000008"]}],"maxNumOfTAs":2})                        |
	
	
    When I send HTTPV2 message HTTPV2_NUDM_SDM_SUSBCRIPTIONS_DATA_CHANGE_NOTIFICATION_RES_204 on interface N8 with the following details from node AMF1 to UDM1:
      | parameter          | value   |
      | header.nva.0.name  | :status |
      | header.nva.0.value | 204     |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_SUSBCRIPTIONS_DATA_CHANGE_NOTIFICATION_RES_204 on interface N8 with the following details on node UDM1 from AMF1:
      | parameter          | value                |
      | header.nva.0.name  | {string:eq}(:status) |
      | header.nva.0.value | {string:eq}(204)     |


###nas_pdu.deregistration_request.deregistration_type --> 0x5, signifies re-registration

    When I send NGAP message NG_DOWNLINK_NAS_DEREGIS_REQ on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                          | value                                                       |
      | amf_ue_ngap_id                                     | $(AMF_UE_NGAP_ID)                                           |
      | ran_ue_ngap_id                                     | $(RAN_UE_NGAP_ID)                                           |
      | nas_pdu.extended_protocol_discriminator            | {abotprop.SUT.NAS.EDP}                                      |
      | nas_pdu.security_header_type                       | {abotprop.SUT.NAS.SEC.HEAD.INTEGRITY}                       |
      | nas_pdu.message_type                               | {abotprop.SUT.NAS.DEREG.REQ.UE.TERM.MSG}                    |
      | nas_pdu.deregistration_request.deregistration_type | {abotprop.SUT.NAS.DEREG_TYPE.3GPP_NORMAL_RE-REGIS_REQUIRED} |
      #| nas_pdu.deregistration_request.5gs_mobile_identity | {abotprop.SUT.NAS.5GS.MOBILE.IDENTITY}                      |

    Then I receive and validate NGAP message NG_DOWNLINK_NAS_DEREGIS_REQ on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                          | value                                                                    |
      | amf_ue_ngap_id                                     | {string:eq}($(AMF_UE_NGAP_ID))                                           |
      | ran_ue_ngap_id                                     | {string:eq}($(RAN_UE_NGAP_ID))                                           |
      | nas_pdu.extended_protocol_discriminator            | {string:eq}({abotprop.SUT.NAS.EDP})                                      |
      | nas_pdu.security_header_type                       | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.INTEGRITY})                       |
      | nas_pdu.message_type                               | {string:eq}({abotprop.SUT.NAS.DEREG.REQ.UE.TERM.MSG})                    |
      | nas_pdu.deregistration_request.deregistration_type | {string:eq}({abotprop.SUT.NAS.DEREG_TYPE.3GPP_NORMAL_RE-REGIS_REQUIRED}) |
      #| nas_pdu.deregistration_request.5gs_mobile_identity | {string:eq}({abotprop.SUT.NAS.5GS.MOBILE.IDENTITY})                      |

    #When I send HTTPV2 message HTTPV2_NUDM_UECM_DEREGISTRATION_NOTIFICATION_POST_RES_204 on interface N8 with the following details from node AMF1 to UDM1:
      #| parameter          | value   |
      #| header.nva.0.name  | :status |
      #| header.nva.0.value | 204     |

    #Then I receive and validate HTTPV2 message HTTPV2_NUDM_UECM_DEREGISTRATION_NOTIFICATION_POST_RES_204 on interface N8 with the following details on node UDM1 from AMF1:
      #| parameter          | value                |
      #| header.nva.0.name  | {string:eq}(:status) |
      #| header.nva.0.value | {string:eq}(204)     |

    When I send HTTPV2 message HTTPV2_NUDM_SDM_UNSUBSCRIBE_DEL_REQ on interface N8 with the following details from node AMF1 to UDM1:
      | parameter          | value                                                                                                                                                    |
      | header.nva.0.name  | :method                                                                                                                                                  |
      | header.nva.0.value | DELETE                                                                                                                                                   |
      | header.nva.1.name  | :path                                                                                                                                                    |
      | header.nva.1.value | /$({abotprop.UDM1.SecureShell.IPAddress}):$({abotprop.UDM1.N8.Server.Port})/nudm-sdm/v2/incr($({abotprop.SUT.SUPI}),1)/sdm-subscriptions/subscriptionId1 |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_UNSUBSCRIBE_DEL_REQ on interface N8 with the following details on node UDM1 from AMF1:
      | parameter          | value                                                                                                                                                                 |
      | header.nva.0.name  | {string:eq}(:method)                                                                                                                                                  |
      | header.nva.0.value | {string:eq}(DELETE)                                                                                                                                                   |
      | header.nva.1.name  | {string:eq}(:path)                                                                                                                                                    |
      | header.nva.1.value | {string:eq}(/$({abotprop.UDM1.SecureShell.IPAddress}):$({abotprop.UDM1.N8.Server.Port})/nudm-sdm/v2/incr($({abotprop.SUT.SUPI}),1)/sdm-subscriptions/subscriptionId1) |

    When I send HTTPV2 message HTTPV2_NUDM_SDM_UNSUBSCRIBE_DEL_RES_204 on interface N8 with the following details from node UDM1 to AMF1:
      | parameter          | value   |
      | header.nva.0.name  | :status |
      | header.nva.0.value | 204     |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_SDM_UNSUBSCRIBE_DEL_RES_204 on interface N8 with the following details on node AMF1 from UDM1:
      | parameter          | value                |
      | header.nva.0.name  | {string:eq}(:status) |
      | header.nva.0.value | {string:eq}(204)     |

    When I send HTTPV2 message HTTPV2_NSMF_RELEASE_SM_CONTEXT_REQ on interface N11 with the following details from node AMF1 to SMF1:
      | parameter                                      | value                                           |
      | header.nva.0.name                              | :method                                         |
      | header.nva.0.value                             | POST                                            |
      | header.nva.1.name                              | :path                                           |
      | header.nva.1.value                             | /nsmf-pdusession/v1/sm-contexts/smctx-1/release |
      | header.nva.2.name                              | content-type                                    |
      | header.nva.2.value                             | application/json                                |
      | application_json.sm_context_release_data.cause | REL_DUE_TO_HO                                   |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_RELEASE_SM_CONTEXT_REQ on interface N11 with the following details on node SMF1 from AMF1:
      | parameter                                      | value                                                        |
      | header.nva.0.name                              | {string:eq}(:method)                                         |
      | header.nva.0.value                             | {string:eq}(POST)                                            |
      | header.nva.1.name                              | {string:eq}(:path)                                           |
      | header.nva.1.value                             | {string:eq}(/nsmf-pdusession/v1/sm-contexts/smctx-1/release) |
      | header.nva.2.name                              | {string:eq}(content-type)                                    |
      | header.nva.2.value                             | {string:eq}(application/json)                                |
      | application_json.sm_context_release_data.cause | {string:eq}(REL_DUE_TO_HO)                                   |

    When I send PFCP message PFCP_SESSION_DELETION_REQ on interface N4 with the following details from node SMF1 to UPF1:
      | parameter           | value                                       |
      | header.message_type | {abotprop.SUT.PFCP.HEADER.MSG.TYPE.DEL.REQ} |
      | header.seid         | $(PFCP_SEID_N4_SMF1_UPF1)                   |
      | header.seq_number   | 400                                         |

    Then I receive and validate PFCP message PFCP_SESSION_DELETION_REQ on interface N4 with the following details on node UPF1 from SMF1:
      | parameter           | value                                                    |
      | header.message_type | {string:eq}({abotprop.SUT.PFCP.HEADER.MSG.TYPE.DEL.REQ}) |
      | header.seid         | save(PFCP_SEID_N4_SMF1_UPF1)                             |
      | header.seq_number   | save(SEQ_NO)                                             |

    When I send PFCP message PFCP_SESSION_DELETION_RES on interface N4 with the following details from node UPF1 to SMF1:
      | parameter           | value                                       |
      | header.message_type | {abotprop.SUT.PFCP.HEADER.MSG.TYPE.DEL.RES} |
      | header.seid         | $(PFCP_SEID_N4_UPF1_SMF1)                   |
      | header.seq_number   | $(SEQ_NO)                                   |
      | cause               | {abotprop.SUT.PFCP.RESPOSE.CAUSE.ACCEPTED}  |

    Then I receive and validate PFCP message PFCP_SESSION_DELETION_RES on interface N4 with the following details on node SMF1 from UPF1:
      | parameter           | value                                                    |
      | header.message_type | {string:eq}({abotprop.SUT.PFCP.HEADER.MSG.TYPE.DEL.RES}) |
      | header.seid         | save(PFCP_SEID_N4_UPF1_SMF1)                             |
      | header.seq_number   | save(SEQ_NO)                                             |
      | cause               | {string:eq}({abotprop.SUT.PFCP.RESPOSE.CAUSE.ACCEPTED})  |

    When I send HTTPV2 message HTTPV2_NSMF_RELEASE_SM_CONTEXT_RES_204 on interface N11 with the following details from node SMF1 to AMF1:
      | parameter          | value   |
      | header.nva.0.name  | :status |
      | header.nva.0.value | 204     |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_RELEASE_SM_CONTEXT_RES_204 on interface N11 with the following details on node AMF1 from SMF1:
      | parameter          | value                |
      | header.nva.0.name  | {string:eq}(:status) |
      | header.nva.0.value | {string:eq}(204)     |

    When I send HTTPV2 message HTTPV2_NUDM_UECM_SMF_DEREG_DELETE_REQ on interface N10 with the following details from node SMF1 to UDM1:
      | parameter          | value                                                                                          |
      | header.nva.0.name  | :method                                                                                        |
      | header.nva.0.value | DELETE                                                                                         |
      | header.nva.1.name  | :path                                                                                          |
      | header.nva.1.value | /127.0.0.1:12348/nudm-uecm/v1/incr($({abotprop.SUT.SUPI}),1)/registrations/smf-registrations/6 |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UECM_SMF_DEREG_DELETE_REQ on interface N10 with the following details on node UDM1 from SMF1:
      | parameter          | value                                                                                                       |
      | header.nva.0.name  | {string:eq}(:method)                                                                                        |
      | header.nva.0.value | {string:eq}(DELETE)                                                                                         |
      | header.nva.1.name  | {string:eq}(:path)                                                                                          |
      | header.nva.1.value | {string:eq}(/127.0.0.1:12348/nudm-uecm/v1/incr($({abotprop.SUT.SUPI}),1)/registrations/smf-registrations/6) |

    When I send HTTPV2 message HTTPV2_NUDM_UECM_SMF_DEREG_DELETE_RES_204 on interface N10 with the following details from node UDM1 to SMF1:
      | parameter          | value   |
      | header.nva.0.name  | :status |
      | header.nva.0.value | 204     |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UECM_SMF_DEREG_DELETE_RES_204 on interface N10 with the following details on node SMF1 from UDM1:
      | parameter          | value                |
      | header.nva.0.name  | {string:eq}(:status) |
      | header.nva.0.value | {string:eq}(204)     |

    When I send HTTPV2 message HTTPV2_NPCFAM_POLICY_CONTROL_DEL_DELETE_REQ on interface N15 with the following details from node AMF1 to PCF1:
      | parameter          | value                                                      |
      | header.nva.0.name  | :method                                                    |
      | header.nva.0.value | DELETE                                                     |
      | header.nva.1.name  | :path                                                      |
      | header.nva.1.value | /127.0.0.1:12348/npcf-am-policy-control/v1/policies/amPol1 |

    Then I receive and validate HTTPV2 message HTTPV2_NPCFAM_POLICY_CONTROL_DEL_DELETE_REQ on interface N15 with the following details on node PCF1 from AMF1:
      | parameter          | value                                                                   |
      | header.nva.0.name  | {string:eq}(:method)                                                    |
      | header.nva.0.value | {string:eq}(DELETE)                                                     |
      | header.nva.1.name  | {string:eq}(:path)                                                      |
      | header.nva.1.value | {string:eq}(/127.0.0.1:12348/npcf-am-policy-control/v1/policies/amPol1) |

    When I send HTTPV2 message HTTPV2_NPCFAM_POLICY_CONTROL_DEL_DELETE_RES_204 on interface N15 with the following details from node PCF1 to AMF1:
      | parameter          | value   |
      | header.nva.0.name  | :status |
      | header.nva.0.value | 204     |

    Then I receive and validate HTTPV2 message HTTPV2_NPCFAM_POLICY_CONTROL_DEL_DELETE_RES_204 on interface N15 with the following details on node AMF1 from PCF1:
      | parameter          | value                |
      | header.nva.0.name  | {string:eq}(:status) |
      | header.nva.0.value | {string:eq}(204)     |

    When I send NGAP message NG_UPLINK_NAS_DEREGIS_ACC on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                       | value                                    |
      | amf_ue_ngap_id                                                                  | $(AMF_UE_NGAP_ID)                        |
      | ran_ue_ngap_id                                                                  | $(RAN_UE_NGAP_ID)                        |
      | nas_pdu.extended_protocol_discriminator                                         | {abotprop.SUT.NAS.EDP}                   |
      | nas_pdu.security_header_type                                                    | {abotprop.SUT.NAS.SEC.HEAD.INTEGRITY}    |
      | nas_pdu.message_type                                                            | {abotprop.SUT.NAS.DEREG.ACC.UE.TERM.MSG} |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {abotprop.SUT.MCC}                       |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {abotprop.SUT.MNC}                       |
      | user_location_information.nr_user_location_information.tai.tac                  | {abotprop.SUT.TAC}                       |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {abotprop.SUT.MCC}                       |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {abotprop.SUT.MNC}                       |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {abotprop.SUT.NR.CELL.IDN}               |

    Then I receive and validate NGAP message NG_UPLINK_NAS_DEREGIS_ACC on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                       | value                                                 |
      | amf_ue_ngap_id                                                                  | {string:eq}($(AMF_UE_NGAP_ID))                        |
      | ran_ue_ngap_id                                                                  | {string:eq}($(RAN_UE_NGAP_ID))                        |
      | nas_pdu.extended_protocol_discriminator                                         | {string:eq}({abotprop.SUT.NAS.EDP})                   |
      | nas_pdu.security_header_type                                                    | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.INTEGRITY})    |
      | nas_pdu.message_type                                                            | {string:eq}({abotprop.SUT.NAS.DEREG.ACC.UE.TERM.MSG}) |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {string:eq}({abotprop.SUT.MCC})                       |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {string:eq}({abotprop.SUT.MNC})                       |
      | user_location_information.nr_user_location_information.tai.tac                  | {string:eq}({abotprop.SUT.TAC})                       |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {string:eq}({abotprop.SUT.MCC})                       |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {string:eq}({abotprop.SUT.MNC})                       |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {string:eq}({abotprop.SUT.NR.CELL.IDN})               |
