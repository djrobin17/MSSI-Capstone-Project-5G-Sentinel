@5gs-initialreg5gaka-pdusess-ssc-mode3-upf-anchor-change-by-smf @04-session-mgmt-procedures @23502-5gs @5g-core-sanity @5g-core

Feature: 5GS Initial Registration, PDU Session Establishment with SSC Mode 3, SMF Initiated UPF Anchor change

  Scenario: 5GS Initial Registration with 5G AKA, Single PDU Session Establishment with SSC Mode 3 and SMF Initiated UPF Anchor Change

    Given the test data is in file /featureFiles/MESSAGE_BUNDLES/EPC_MESSAGES.xml

    Given all configured endpoints for EPC are connected successfully

    Given that I execute dependency feature /featureFiles/3GPP-23502-5G/02_Registration_Management_Procedures/5GS_UE_Initial_Registration_With_5G_AKA_Authentication.feature

### Session Association Req/Res between (SMF1 and UPF1)

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
	  
  
### Session Association Req/Res between (SMF1 and UPF2)
    When I send PFCP message PFCP_ASSOCIATION_SETUP_REQ on interface N4 with the following details from node SMF1 to UPF2:
      | parameter            | value                                    |
      | header.message_type  | 5                                        |
      | header.seq_number    | incr(1,4)                                |
      | node_id.type         | {abotprop.SUT.PFCP_NODE_ID_TYPE}         |
      | node_id.value        | $({abotprop.SMF1.SecureShell.IPAddress}) |
      | cp_function_features | {abotprop.SUT.CP_FUNC_FEATURES}          |
      | recovery_timestamp   | {abotprop.SUT.PFCP_RECOVERY_TIMESTAMP}   |

    Then I receive and validate PFCP message PFCP_ASSOCIATION_SETUP_REQ on interface N4 with the following details on node UPF2 from SMF1:
      | parameter            | value                                                 |
      | header.message_type  | {string:eq}(5)                                        |
      | header.seq_number    | save(PFCP_HDR_SEQ_NO)                                 |
      | node_id.type         | {string:eq}({abotprop.SUT.PFCP_NODE_ID_TYPE})         |
      | node_id.value        | {string:eq}($({abotprop.SMF1.SecureShell.IPAddress})) |
      | cp_function_features | save(CP_FUNC_FEATURES)                                |
      | recovery_timestamp   | save(CP_RECOVERY_TIMESTAMP)                           |

    When I send PFCP message PFCP_ASSOCIATION_SETUP_RES on interface N4 with the following details from node UPF2 to SMF1:
      | parameter            | value                                    |
      | header.message_type  | 6                                        |
      | header.seq_number    | $(PFCP_HDR_SEQ_NO)                       |
      | node_id.type         | {abotprop.SUT.PFCP_NODE_ID_TYPE}         |
      | node_id.value        | $({abotprop.UPF2.SecureShell.IPAddress}) |
      | up_function_features | {abotprop.SUT.PFCP_UP_FUNC_FEATURES}     |
      | cause                | {abotprop.SUT.PFCP_REQUEST_ACCEPTED}     |
      | recovery_timestamp   | {abotprop.SUT.PFCP_RECOVERY_TIMESTAMP}   |

    Then I receive and validate PFCP message PFCP_ASSOCIATION_SETUP_RES on interface N4 with the following details on node SMF1 from UPF2:
      | parameter            | value                                                 |
      | header.message_type  | {string:eq}(6)                                        |
      | header.seq_number    | save(PFCP_HDR_SEQ_NO)                                 |
      | node_id.type         | {string:eq}({abotprop.SUT.PFCP_NODE_ID_TYPE})         |
      | node_id.value        | {string:eq}($({abotprop.UPF2.SecureShell.IPAddress})) |
      | up_function_features | save(UP_FUNC_FEATURES)                                |
      | cause                | {string:eq}({abotprop.SUT.PFCP_REQUEST_ACCEPTED})     |
      | recovery_timestamp   | save(UP_RECOVERY_TIMESTAMP)                           |


###########################################################################
### SSC Mode 3 : First UE PDU Sesion Establishment with SMF1 : Anchor UPF1
###########################################################################

### N2 - PDU Session Establishment (gNodeB to AMF : UE Initiated Single PDU Session Establishment Request)

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

### N11 - Create PDU Session Context (AMF to SMF - Initite PDU Session Establishment and PDU Session Context Creation)

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
      | multipart_related.json_data.sm_context_create_data.sm_context_status_uri                                    | save(SM_CTXT_STATUS_URI_AT_SMF)                                                                      |
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
	  
### SMF to UDM - UE PDU Session Registration

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

## N4 (CUPS) - Session Establishment (SMF to UPF : 1. Trigger setup of SMF allocated UPF N3 Tunnel Endpoint, 2. UE Static IP Allocated by SMF)
## Configure : Forwarding Incoming Uplink Packets - PDR Rule Id 1, mapped to FAR Rule ID 1, for UPF N3 Tunnel (Source Interface - Access(0), Destination interface - Core(1))
##             Forwarding Incoming Downlink Packets - PDR Rule Id 2, mapped to FAR Rule ID 2, for destination UE IP Address towards GNB N3 Tunnel (Source Interface - Core(1), Destination interface - Access(0))
##                                                    GNB N3 Tunnel forwarding is updated in FAR Rule ID 2 in Session Modification from SMF when it receives it from GNB via AMF

    When I send PFCP message PFCP_SESSION_ESTABLISH_REQ on interface N4 with the following details from node SMF1 to UPF1:
      | parameter                                               | value                                                                         |
      | header.message_type                                     | 50                                                                            |
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
      | header.message_type                                     | {string:eq}(50)                                                    |
      | header.seid                                             | {string:eq}(0)                                                     |
      | header.seq_number                                       | save(PFCP_HDR_SEQ_NO)                                              |
      | node_id.type                                            | {string:eq}({abotprop.SUT.PFCP_NODE_ID_TYPE})                      |
      | node_id.value                                           | save(PFCP_NODE_IP_SMF)                                             |
      | cp_f_seid.flag                                          | {string:eq}({abotprop.SUT.PFCP.CP.F-SEID.FLAG})                    |
      | cp_f_seid.seid                                          | save(PFCP_HDR_FSEID_SMF)                                           |
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
      | parameter            | value                                      |
      | header.message_type  | 51                                         |
      | header.seid          | $(PFCP_HDR_FSEID_SMF)                      |
      | header.seq_number    | $(PFCP_HDR_SEQ_NO)                         |
      | node_id.type         | {abotprop.SUT.PFCP_NODE_ID_TYPE}           |
      | node_id.value        | $({abotprop.UPF1.SecureShell.IPAddress})   |
      | cause                | {abotprop.SUT.PFCP.RESPOSE.CAUSE.ACCEPTED} |
      | up_f_seid.flag       | {abotprop.SUT.PFCP.UP.F-SEID.FLAG}         |
      | up_f_seid.seid       | incr(20000000,1)                           |
      | up_f_seid.ipv4_addr  | 5.6.7.8                                    |
      | created_pdr.0.pdr_id | {abotprop.SUT.PFCP.PDR.0.PDR_ID}           |
      | created_pdr.1.pdr_id | {abotprop.SUT.PFCP.PDR.1.PDR_ID}           |

    Then I receive and validate PFCP message PFCP_SESSION_ESTABLISH_RES on interface N4 with the following details on node SMF1 from UPF1:
      | parameter            | value                                                   |
      | header.message_type  | {string:eq}(51)                                         |
      | header.seid          | save(PFCP_HDR_FSEID_SMF)                                |
      | header.seq_number    | save(PFCP_HDR_SEQ_NO)                                   |
      | node_id.type         | {string:eq}({abotprop.SUT.PFCP_NODE_ID_TYPE})           |
      | node_id.value        | save(PFCP_NODE_IP_UPF)                                  |
      | cause                | {string:eq}({abotprop.SUT.PFCP.RESPOSE.CAUSE.ACCEPTED}) |
      | up_f_seid.flag       | {string:eq}({abotprop.SUT.PFCP.UP.F-SEID.FLAG})         |
      | up_f_seid.seid       | save(PFCP_HDR_FSEID_UPF)                                |
      | up_f_seid.ipv4_addr  | save(PFCP_MSG_IP_UPF)                                   |
      | created_pdr.0.pdr_id | {string:eq}({abotprop.SUT.PFCP.PDR.0.PDR_ID})           |
      | created_pdr.1.pdr_id | {string:eq}({abotprop.SUT.PFCP.PDR.1.PDR_ID})           |

    When I send HTTPV2 message HTTPV2_NAMF_COMM_N1N2_MSG_TRANSFER_POST_REQ on interface N11 with the following details from node SMF1 to AMF1:
      | parameter                                                                                                                                                                                         | value                                                                                                    |
      | header.nva.0.name                                                                                                                                                                                 | :method                                                                                                  |
      | header.nva.0.value                                                                                                                                                                                | POST                                                                                                     |
      | header.nva.1.name                                                                                                                                                                                 | :path                                                                                                    |
      | header.nva.1.value                                                                                                                                                                                | /127.0.0.1:12348/namf-comm/v1/ue-contexts/incr($({abotprop.SUT.SUPI}),1)/n1-n2-messages                  |
      | header.nva.2.name                                                                                                                                                                                 | content-type                                                                                             |
      | header.nva.2.value                                                                                                                                                                                | multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json                  |
      | multipart_related.json_data.content_type                                                                                                                                                          | application/json                                                                                         |
      | multipart_related.json_data.content_id                                                                                                                                                            | n1n2-message-transfer-req-data                                                                           |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1_message_container.n1_message_class                                                                                                  | SM                                                                                                       |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1_message_container.n1_message_content.content_id                                                                                     | n1-pdu-session-establishment-accept                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.n2_information_class                                                                                                 | SM                                                                                                       |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.n2_info_content.ngap_ie_type                                                                                 | PDU_RES_SETUP_REQ                                                                                        |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.n2_info_content.ngap_data.content_id                                                                         | n2-pdu-session-resource-setup-request-transfer-ie                                                        |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.pdu_session_id                                                                                               | {abotprop.SUT.PDU.SESS.ID}                                                                               |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.s_nssai.sst                                                                                                  | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}                                                               |
      | multipart_related.json_data.n1n2_message_transfer_req_data.skip_ind                                                                                                                               | false                                                                                                    |
      | multipart_related.json_data.n1n2_message_transfer_req_data.pdu_session_id                                                                                                                         | {abotprop.SUT.PDU.SESS.ID}                                                                               |
      | multipart_related.json_data.n1n2_message_transfer_req_data.5qi                                                                                                                                    | {abotprop.SUT.AUTO.RSP.PDU.SESS.5QI}                                                                     |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1n2_failure_txf_notif_u_r_i                                                                                                           | /127.0.0.1:12348/namf-comm/v1/ue-contexts/incr($({abotprop.SUT.SUPI}),1)/n1-n2-messages/callback-failure |
      | multipart_related.json_data.n1n2_message_transfer_req_data.smf_reallocation_ind                                                                                                                   | false                                                                                                    |
      | multipart_related.binary_data_n1_message.content_type                                                                                                                                             | application/vnd.3gpp.5gnas                                                                               |
      | multipart_related.binary_data_n1_message.content_id                                                                                                                                               | n1-pdu-session-establishment-accept                                                                      |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.extended_protocol_discriminator                                                                                                       | {abotprop.SUT.NAS.PDU.SM_EDP}                                                                            |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_session_id                                                                                                                        | {abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID}                                                                |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pti                                                                                                                                   | {abotprop.SUT.NAS.PTI}                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.message_type                                                                                                                          | {abotprop.SUT.NAS.PDU.SESS.ESTD.ACC.MSG}                                                                 |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.selected_pdu_sess_type                                                                                             | {abotprop.SUT.NAS.N1-SM-INFO.SELECTED.PDU_SESSION_TYPE}                                                  |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.selected_ssc_mode                                                                                                  | {abotprop.SUT.NAS.SELECTED.SSC.MODE}                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.session_ambr                                                                                                       | {abotprop.SUT.NAS.N1-SM-INFO.SESSION.AMBR}                                                               |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.pdu_address                                                                                                        | {abotprop.SUT.PDU.ADDRESS}                                                                               |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.snssai                                                                                                             | {abotprop.SUT.SUBSCRIBEDNSSAI}                                                                           |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.dnn                                                                                                                | {abotprop.SUT.DNN1}                                                                                      |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.qri                                                                               | 0x01                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.op_code_dqr_bit_no_of_pkt_filters                                                 | 0x31                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.precedence                                                                        | 0x01                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.segr_bit_qfi                                                                      | 0x09                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.dir_id                                                       | 0x21                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.type                                   | 0x11                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.ipv4_local_address_mask                | 0xac10000affff0000                                                                                       |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.type                                   | 0x10                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.ipv4_remote_address_mask               | 0x2be1377fffff0000                                                                                       |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.type                                   | 0x30                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.ipv4_proto_id_or_ipv6_next_hdr         | 0x11                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.type                                   | 0x41                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.local_port_range                       | 0x13881770                                                                                               |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.type                                   | 0x51                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.remote_port_range                      | 0x1b581f40                                                                                               |
      | multipart_related.binary_data_n2_information.content_type                                                                                                                                         | application/vnd.3gpp.ngap                                                                                |
      | multipart_related.binary_data_n2_information.content_id                                                                                                                                           | n2-pdu-session-resource-setup-request-transfer-ie                                                        |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate                 | {abotprop.SUT.AGGR.MAX.BIT.RATE.DL}                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate                 | {abotprop.SUT.AGGR.MAX.BIT.RATE.UL}                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                      | {abotprop.SUT.AUTO.RSP.GTP.UL.IP}                                                                        |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                     | incr(30000000,1)                                                                                         |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                                 | {abotprop.SUT.NAS.N2-PDU-SETUP-REQ-TRANSFR.PDU_SESSION_TYPE}                                             |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                                    | {abotprop.SUT.AUTO.RSP.PDU.SESS.QFI}                                                                     |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi         | {abotprop.SUT.AUTO.RSP.PDU.SESS.5QI}                                                                     |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.priority_level | {abotprop.SUT.QOS.5QI.PRIORITY}                                                                          |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                                 | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PRIORITY.LEVEL}                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                             | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.CAPABILITY}                                                  |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                          | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.VULNERABILITY}                                               |

    Then I receive and validate HTTPV2 message HTTPV2_NAMF_COMM_N1N2_MSG_TRANSFER_POST_REQ on interface N11 with the following details on node AMF1 from SMF1:
      | parameter                                                                                                                                                                                         | value                                                                                                                 |
      | header.nva.0.name                                                                                                                                                                                 | {string:eq}(:method)                                                                                                  |
      | header.nva.0.value                                                                                                                                                                                | {string:eq}(POST)                                                                                                     |
      | header.nva.1.name                                                                                                                                                                                 | {string:eq}(:path)                                                                                                    |
      | header.nva.1.value                                                                                                                                                                                | {string:eq}(/127.0.0.1:12348/namf-comm/v1/ue-contexts/incr($({abotprop.SUT.SUPI}),1)/n1-n2-messages)                  |
      | header.nva.2.name                                                                                                                                                                                 | {string:eq}(content-type)                                                                                             |
      | header.nva.2.value                                                                                                                                                                                | {string:eq}(multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json)                  |
      | multipart_related.json_data.content_type                                                                                                                                                          | {string:eq}(application/json)                                                                                         |
      | multipart_related.json_data.content_id                                                                                                                                                            | {string:eq}(n1n2-message-transfer-req-data)                                                                           |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1_message_container.n1_message_class                                                                                                  | {string:eq}(SM)                                                                                                       |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1_message_container.n1_message_content.content_id                                                                                     | {string:eq}(n1-pdu-session-establishment-accept)                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.n2_information_class                                                                                                 | {string:eq}(SM)                                                                                                       |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.n2_info_content.ngap_ie_type                                                                                 | {string:eq}(PDU_RES_SETUP_REQ)                                                                                        |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.n2_info_content.ngap_data.content_id                                                                         | {string:eq}(n2-pdu-session-resource-setup-request-transfer-ie)                                                        |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.pdu_session_id                                                                                               | {string:eq}({abotprop.SUT.PDU.SESS.ID})                                                                               |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.s_nssai.sst                                                                                                  | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB})                                                               |
      | multipart_related.json_data.n1n2_message_transfer_req_data.skip_ind                                                                                                                               | {string:eq}(false)                                                                                                    |
      | multipart_related.json_data.n1n2_message_transfer_req_data.pdu_session_id                                                                                                                         | {string:eq}({abotprop.SUT.PDU.SESS.ID})                                                                               |
      | multipart_related.json_data.n1n2_message_transfer_req_data.5qi                                                                                                                                    | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.5QI})                                                                     |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1n2_failure_txf_notif_u_r_i                                                                                                           | {string:eq}(/127.0.0.1:12348/namf-comm/v1/ue-contexts/incr($({abotprop.SUT.SUPI}),1)/n1-n2-messages/callback-failure) |
      | multipart_related.json_data.n1n2_message_transfer_req_data.smf_reallocation_ind                                                                                                                   | {string:eq}(false)                                                                                                    |
      | multipart_related.binary_data_n1_message.content_type                                                                                                                                             | {string:eq}(application/vnd.3gpp.5gnas)                                                                               |
      | multipart_related.binary_data_n1_message.content_id                                                                                                                                               | {string:eq}(n1-pdu-session-establishment-accept)                                                                      |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.extended_protocol_discriminator                                                                                                       | {string:eq}({abotprop.SUT.NAS.PDU.SM_EDP})                                                                            |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_session_id                                                                                                                        | {string:eq}({abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID})                                                                |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pti                                                                                                                                   | {string:eq}({abotprop.SUT.NAS.PTI})                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.message_type                                                                                                                          | {string:eq}({abotprop.SUT.NAS.PDU.SESS.ESTD.ACC.MSG})                                                                 |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.selected_pdu_sess_type                                                                                             | {string:eq}({abotprop.SUT.NAS.N1-SM-INFO.SELECTED.PDU_SESSION_TYPE})                                                  |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.selected_ssc_mode                                                                                                  | {string:eq}({abotprop.SUT.NAS.SELECTED.SSC.MODE})                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.session_ambr                                                                                                       | {string:eq}({abotprop.SUT.NAS.N1-SM-INFO.SESSION.AMBR})                                                               |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.pdu_address                                                                                                        | save(UE_IP)                                                                                                           |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.snssai                                                                                                             | {string:eq}({abotprop.SUT.SUBSCRIBEDNSSAI})                                                                           |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.dnn                                                                                                                | {string:eq}({abotprop.SUT.DNN1})                                                                                      |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.qri                                                                               | {string:eq}(0x01)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.op_code_dqr_bit_no_of_pkt_filters                                                 | {string:eq}(0x31)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.precedence                                                                        | {string:eq}(0x01)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.segr_bit_qfi                                                                      | {string:eq}(0x09)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.dir_id                                                       | {string:eq}(0x21)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.type                                   | {string:eq}(0x11)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.ipv4_local_address_mask                | {string:eq}(0xac10000affff0000)                                                                                       |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.type                                   | {string:eq}(0x10)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.ipv4_remote_address_mask               | {string:eq}(0x2be1377fffff0000)                                                                                       |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.type                                   | {string:eq}(0x30)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.ipv4_proto_id_or_ipv6_next_hdr         | {string:eq}(0x11)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.type                                   | {string:eq}(0x41)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.local_port_range                       | {string:eq}(0x13881770)                                                                                               |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.type                                   | {string:eq}(0x51)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.remote_port_range                      | {string:eq}(0x1b581f40)                                                                                               |
      | multipart_related.binary_data_n2_information.content_type                                                                                                                                         | {string:eq}(application/vnd.3gpp.ngap)                                                                                |
      | multipart_related.binary_data_n2_information.content_id                                                                                                                                           | {string:eq}(n2-pdu-session-resource-setup-request-transfer-ie)                                                        |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate                 | {string:eq}({abotprop.SUT.AGGR.MAX.BIT.RATE.DL})                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate                 | {string:eq}({abotprop.SUT.AGGR.MAX.BIT.RATE.UL})                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                      | save(GTP_UL_IP_UPF)                                                                                                   |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                     | save(GTP_UL_TEID_UPF)                                                                                                 |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                                 | {string:eq}({abotprop.SUT.NAS.N2-PDU-SETUP-REQ-TRANSFR.PDU_SESSION_TYPE})                                             |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                                    | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.QFI})                                                                     |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi         | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.5QI})                                                                     |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.priority_level | {string:eq}({abotprop.SUT.QOS.5QI.PRIORITY})                                                                          |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                                 | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PRIORITY.LEVEL})                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                             | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.CAPABILITY})                                                  |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                          | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.VULNERABILITY})                                               |
 
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
	  
## N2 - Update PDU Session Context (AMF sends SMF : 1. gNodeB N3 Downlink Tunnel Endpoint)

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

## N11 - Update PDU Session Context (AMF sends SMF : 1. gNodeB N3 Downlink Tunnel Endpoint)

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

## N4 (CUPS) - Session Modification (SMF informs UPF : gNodeB N3 Tunnel Endpoint)
## Configure : Forward Incoming Downlink packets at UPF to gNodeB N3 (PDR Rule ID 2, FAR Rule ID 2 : Source Interface - Core (1), Destination Interface - Access (0))

    When I send PFCP message PFCP_SESSION_MODIFICATION_REQ on interface N4 with the following details from node SMF1 to UPF1:
      | parameter                                                              | value                                                 |
      | header.message_type                                                    | 52                                                    |
      | header.seid                                                            | $(PFCP_HDR_FSEID_UPF)                                 |
      | header.seq_number                                                      | incr(3,3)                                             |
      | update_far.0.far_id                                                    | {abotprop.SUT.PFCP.PDR.1.FAR_ID}                      |
      | update_far.0.apply_action                                              | 2                                                     |
      | update_far.0.update_forwarding_parms.destination_interface             | {abotprop.SUT.PFCP.PDR.0.DESTINATION_INTERFCE.ACCESS} |
      | update_far.0.update_forwarding_parms.outer_header_creation.description | 0x100                                                 |
      | update_far.0.update_forwarding_parms.outer_header_creation.teid        | $(GTP_DL_TEID_GNB)                                    |
      | update_far.0.update_forwarding_parms.outer_header_creation.ipv4_addr   | $(GTP_DL_IP_GNB)                                      |

    Then I receive and validate PFCP message PFCP_SESSION_MODIFICATION_REQ on interface N4 with the following details on node UPF1 from SMF1:
      | parameter                                                              | value                                                              |
      | header.message_type                                                    | {string:eq}(52)                                                    |
      | header.seid                                                            | save(PFCP_HDR_FSEID_UPF)                                           |
      | header.seq_number                                                      | save(PFCP_HDR_SEQ_NO)                                              |
      | update_far.0.far_id                                                    | {string:eq}({abotprop.SUT.PFCP.PDR.1.FAR_ID})                      |
      | update_far.0.apply_action                                              | {string:eq}(2)                                                     |
      | update_far.0.update_forwarding_parms.destination_interface             | {string:eq}({abotprop.SUT.PFCP.PDR.0.DESTINATION_INTERFCE.ACCESS}) |
      | update_far.0.update_forwarding_parms.outer_header_creation.description | save(GTP_DL_OUT_HDR_CREATE_DESC)                                   |
      | update_far.0.update_forwarding_parms.outer_header_creation.teid        | save(GTP_DL_TEID_GNB)                                              |
      | update_far.0.update_forwarding_parms.outer_header_creation.ipv4_addr   | save(GTP_DL_IP_GNB)                                                |

    When I send PFCP message PFCP_SESSION_MODIFICATION_RES on interface N4 with the following details from node UPF1 to SMF1:
      | parameter           | value                                      |
      | header.message_type | 53                                         |
      | header.seid         | $(PFCP_HDR_FSEID_SMF)                      |
      | header.seq_number   | $(PFCP_HDR_SEQ_NO)                         |
      | cause               | {abotprop.SUT.PFCP.RESPOSE.CAUSE.ACCEPTED} |

    Then I receive and validate PFCP message PFCP_SESSION_MODIFICATION_RES on interface N4 with the following details on node SMF1 from UPF1:
      | parameter           | value                                                   |
      | header.message_type | {string:eq}(53)                                         |
      | header.seid         | save(PFCP_HDR_FSEID_SMF)                                |
      | header.seq_number   | save(PFCP_HDR_SEQ_NO)                                   |
      | cause               | {string:eq}({abotprop.SUT.PFCP.RESPOSE.CAUSE.ACCEPTED}) |


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
	  
### UL/DL Data Flow

    When I send GTPV1U message GTPV1U_G_PDUS on interface N3 with the following details from node gNodeB1 to UPF1:
      | parameter               | value                                                |
      | type                    | 5g                                                   |
      | qfi                     | 9                                                    |
      | payload.tx.file_to_send | /etc/rebaca-test-suite/conf/gtpv1u/payloads/ping.txt |

    When I send GTPV1U message GTPV1U_G_PDUS on interface N3 with the following details from node UPF1 to gNodeB1:
      | parameter               | value                                                |
      | type                    | 5g                                                   |
      | qfi                     | 9                                                    |
      | payload.tx.file_to_send | /etc/rebaca-test-suite/conf/gtpv1u/payloads/ping.txt |


    Given the execution is paused for {abotprop.WAIT_1_SEC} seconds

#############################################################################################################
### SSC Mode 3 : SMF Initiated PDU Session Modification for Establishing New PDU Session with New Anchor UPF2
#############################################################################################################


### SMF Initiated PDU Session Modificaiton

### SMF to AMF : SMF initiated PDU Session Modification with NAS - PDU Session Modification Command

    When I send HTTPV2 message HTTPV2_NAMF_COMM_N1N2_MSG_TRANSFER_POST_REQ on interface N11 with the following details from node SMF1 to AMF1:
      | parameter                                                                                                                 | value                                                                                                    |
      | header.nva.0.name                                                                                                         | :method                                                                                                  |
      | header.nva.0.value                                                                                                        | POST                                                                                                     |
      | header.nva.1.name                                                                                                         | :path                                                                                                    |
      | header.nva.1.value                                                                                                        | /127.0.0.1:12348/namf-comm/v1/ue-contexts/incr($({abotprop.SUT.SUPI}),1)/n1-n2-messages                  |
      | header.nva.2.name                                                                                                         | content-type                                                                                             |
      | header.nva.2.value                                                                                                        | multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json                  |
      | multipart_related.json_data.content_type                                                                                  | application/json                                                                                         |
      | multipart_related.json_data.content_id                                                                                    | n1n2-message-transfer-req-data                                                                           |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1_message_container.n1_message_class                          | SM                                                                                                       |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1_message_container.n1_message_content.content_id             | n1-pdu-session-modification-command                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.skip_ind                                                       | false                                                                                                    |
      | multipart_related.json_data.n1n2_message_transfer_req_data.pdu_session_id                                                 | {abotprop.SUT.PDU.SESS.ID}                                                                               |
      | multipart_related.json_data.n1n2_message_transfer_req_data.5qi                                                            | {abotprop.SUT.AUTO.RSP.PDU.SESS.5QI}                                                                     |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1n2_failure_txf_notif_u_r_i                                   | /127.0.0.1:12348/namf-comm/v1/ue-contexts/incr($({abotprop.SUT.SUPI}),1)/n1-n2-messages/callback-failure |
      | multipart_related.json_data.n1n2_message_transfer_req_data.smf_reallocation_ind                                           | false                                                                                                    |
      | multipart_related.binary_data_n1_message.content_type                                                                     | application/vnd.3gpp.5gnas                                                                               |
      | multipart_related.binary_data_n1_message.content_id                                                                       | n1-pdu-session-modification-command                                                                      |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.extended_protocol_discriminator                               | {abotprop.SUT.NAS.PDU.SM_EDP}                                                                            |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_session_id                                                | {abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID}                                                                |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pti                                                           | {abotprop.SUT.NAS.PTI}                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.message_type                                                  | {abotprop.SUT.NAS.PDU.SESS.MOD.CMD.MSG}                                                                  |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_mod_cmd.5gsm_cause                                   | {abotprop.SUT.NAS.PDU_SESSION.5GSM.CAUSE.REACTIVATION}                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_mod_cmd.extended_pco.num_protocol_id_or_container_id | 0x01                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_mod_cmd.extended_pco.protocol_contents.0.id          | 0x001e                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_mod_cmd.extended_pco.protocol_contents.0.length      | 0x02                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_mod_cmd.extended_pco.protocol_contents.0.contents    | 0x0e10                                                                                                   |

    Then I receive and validate HTTPV2 message HTTPV2_NAMF_COMM_N1N2_MSG_TRANSFER_POST_REQ on interface N11 with the following details on node AMF1 from SMF1:
      | parameter                                                                                                                 | value                                                                                                                 |
      | header.nva.0.name                                                                                                         | {string:eq}(:method)                                                                                                  |
      | header.nva.0.value                                                                                                        | {string:eq}(POST)                                                                                                     |
      | header.nva.1.name                                                                                                         | {string:eq}(:path)                                                                                                    |
      | header.nva.1.value                                                                                                        | {string:eq}(/127.0.0.1:12348/namf-comm/v1/ue-contexts/incr($({abotprop.SUT.SUPI}),1)/n1-n2-messages)                  |
      | header.nva.2.name                                                                                                         | {string:eq}(content-type)                                                                                             |
      | header.nva.2.value                                                                                                        | {string:eq}(multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json)                  |
      | multipart_related.json_data.content_type                                                                                  | {string:eq}(application/json)                                                                                         |
      | multipart_related.json_data.content_id                                                                                    | {string:eq}(n1n2-message-transfer-req-data)                                                                           |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1_message_container.n1_message_class                          | {string:eq}(SM)                                                                                                       |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1_message_container.n1_message_content.content_id             | {string:eq}(n1-pdu-session-modification-command)                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.skip_ind                                                       | {string:eq}(false)                                                                                                    |
      | multipart_related.json_data.n1n2_message_transfer_req_data.pdu_session_id                                                 | {string:eq}({abotprop.SUT.PDU.SESS.ID})                                                                               |
      | multipart_related.json_data.n1n2_message_transfer_req_data.5qi                                                            | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.5QI})                                                                     |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1n2_failure_txf_notif_u_r_i                                   | {string:eq}(/127.0.0.1:12348/namf-comm/v1/ue-contexts/incr($({abotprop.SUT.SUPI}),1)/n1-n2-messages/callback-failure) |
      | multipart_related.json_data.n1n2_message_transfer_req_data.smf_reallocation_ind                                           | {string:eq}(false)                                                                                                    |
      | multipart_related.binary_data_n1_message.content_type                                                                     | {string:eq}(application/vnd.3gpp.5gnas)                                                                               |
      | multipart_related.binary_data_n1_message.content_id                                                                       | {string:eq}(n1-pdu-session-modification-command)                                                                      |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.extended_protocol_discriminator                               | {string:eq}({abotprop.SUT.NAS.PDU.SM_EDP})                                                                            |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_session_id                                                | {string:eq}({abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID})                                                                |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pti                                                           | {string:eq}({abotprop.SUT.NAS.PTI})                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.message_type                                                  | {string:eq}({abotprop.SUT.NAS.PDU.SESS.MOD.CMD.MSG})                                                                  |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_mod_cmd.5gsm_cause                                   | {string:eq}({abotprop.SUT.NAS.PDU_SESSION.5GSM.CAUSE.REACTIVATION})                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_mod_cmd.extended_pco.num_protocol_id_or_container_id | {string:eq}(0x01)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_mod_cmd.extended_pco.protocol_contents.0.id          | {string:eq}(0x001e)                                                                                                   |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_mod_cmd.extended_pco.protocol_contents.0.length      | {string:eq}(0x02)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_mod_cmd.extended_pco.protocol_contents.0.contents    | {string:eq}(0x0e10)                                                                                                   |
    
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



### AMF to gNodeb : Forward SMF PDU Session Modificaiton Command (NAS) to gNodeB

    When I send NGAP message NG_DOWNLINK_NAS_DL_NAS_TRANS_PDU_SESS_MOD_CMD on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                                                                                                                                | value                                                  |
      | amf_ue_ngap_id                                                                                                                                           | $(AMF_UE_NGAP_ID)                                      |
      | ran_ue_ngap_id                                                                                                                                           | $(RAN_UE_NGAP_ID)                                      |
      | nas_pdu.extended_protocol_discriminator                                                                                                                  | {abotprop.SUT.NAS.EDP}                                 |
      | nas_pdu.security_header_type                                                                                                                             | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}                      |
      | nas_pdu.message_type                                                                                                                                     | {abotprop.SUT.NAS.DL.NAS.TRANS.MSG}                    |
      | nas_pdu.dl_nas_transport.pdu_session_identity                                                                                                            | {abotprop.SUT.NAS.PDU_SESSION_ID6}                     |
      | nas_pdu.dl_nas_transport.payload_container_type                                                                                                          | {abotprop.SUT.NAS.PAYLOAD.CONTAINER}                   |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator                               | {abotprop.SUT.NAS.PDU.SM_EDP}                          |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                                                | {abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID}              |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                                                           | {abotprop.SUT.NAS.PTI}                                 |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                                                  | {abotprop.SUT.NAS.PDU.SESS.MOD.CMD.MSG}                |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_mod_cmd.5gsm_cause                                   | {abotprop.SUT.NAS.PDU_SESSION.5GSM.CAUSE.REACTIVATION} |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_mod_cmd.extended_pco.num_protocol_id_or_container_id | 0x01                                                   |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_mod_cmd.extended_pco.protocol_contents.0.id          | 0x001e                                                 |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_mod_cmd.extended_pco.protocol_contents.0.length      | 0x02                                                   |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_mod_cmd.extended_pco.protocol_contents.0.contents    | 0x0e10                                                 |

    Then I receive and validate NGAP message NG_DOWNLINK_NAS_DL_NAS_TRANS_PDU_SESS_MOD_CMD on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                                                                                                                                | value                                                               |
      | amf_ue_ngap_id                                                                                                                                           | {string:eq}($(AMF_UE_NGAP_ID))                                      |
      | ran_ue_ngap_id                                                                                                                                           | {string:eq}($(RAN_UE_NGAP_ID))                                      |
      | nas_pdu.extended_protocol_discriminator                                                                                                                  | {string:eq}({abotprop.SUT.NAS.EDP})                                 |
      | nas_pdu.security_header_type                                                                                                                             | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.PLAIN})                      |
      | nas_pdu.message_type                                                                                                                                     | {string:eq}({abotprop.SUT.NAS.DL.NAS.TRANS.MSG})                    |
      | nas_pdu.dl_nas_transport.pdu_session_identity                                                                                                            | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_ID6})                     |
      | nas_pdu.dl_nas_transport.payload_container_type                                                                                                          | {string:eq}({abotprop.SUT.NAS.PAYLOAD.CONTAINER})                   |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator                               | {string:eq}({abotprop.SUT.NAS.PDU.SM_EDP})                          |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                                                | {string:eq}({abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID})              |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                                                           | {string:eq}({abotprop.SUT.NAS.PTI})                                 |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                                                  | {string:eq}({abotprop.SUT.NAS.PDU.SESS.MOD.CMD.MSG})                |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_mod_cmd.5gsm_cause                                   | {string:eq}({abotprop.SUT.NAS.PDU_SESSION.5GSM.CAUSE.REACTIVATION}) |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_mod_cmd.extended_pco.num_protocol_id_or_container_id | {string:eq}(0x01)                                                   |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_mod_cmd.extended_pco.protocol_contents.0.id          | {string:eq}(0x001e)                                                 |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_mod_cmd.extended_pco.protocol_contents.0.length      | {string:eq}(0x02)                                                   |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_mod_cmd.extended_pco.protocol_contents.0.contents    | {string:eq}(0x0e10)                                                 |




### gNodeB to AMF : PDU Session Modificaiton Complete (Response to PDU Session Modification Command)

    When I send NGAP message NG_UPLINK_NAS_UL_NAS_TRANS_PDU_SESS_MOD_COMPL on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                  | value                                                |
      | amf_ue_ngap_id                                                                                                             | $(AMF_UE_NGAP_ID)                                    |
      | ran_ue_ngap_id                                                                                                             | $(RAN_UE_NGAP_ID)                                    |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                                               | {abotprop.SUT.MCC}                                   |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                                               | {abotprop.SUT.MNC}                                   |
      | user_location_information.nr_user_location_information.tai.tac                                                             | {abotprop.SUT.TAC}                                   |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                                            | {abotprop.SUT.MCC}                                   |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                                            | {abotprop.SUT.MNC}                                   |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                                             | {abotprop.SUT.NR.CELL.IDN}                           |
      | nas_pdu.extended_protocol_discriminator                                                                                    | {abotprop.SUT.NAS.EDP}                               |
      | nas_pdu.security_header_type                                                                                               | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}                    |
      | nas_pdu.message_type                                                                                                       | {abotprop.SUT.NAS.UL.NAS.TRANS.MSG}                  |
      | nas_pdu.ul_nas_transport.pdu_session_identity                                                                              | {abotprop.SUT.NAS.PDU_SESSION_ID6}                   |
      | nas_pdu.ul_nas_transport.request_type                                                                                      | {abotprop.SUT.NAS.PDU_SESSION_REQ_TYPE_EXISTING_PDU} |
      | nas_pdu.ul_nas_transport.snssai                                                                                            | {abotprop.SUT.SUBSCRIBEDNSSAI}                       |
      | nas_pdu.ul_nas_transport.dnn                                                                                               | {abotprop.SUT.DNN1}                                  |
      | nas_pdu.ul_nas_transport.payload_container_type                                                                            | {abotprop.SUT.NAS.PAYLOAD.CONTAINER}                 |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator | {abotprop.SUT.NAS.PDU.SM_EDP}                        |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                  | {abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID}            |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                             | {abotprop.SUT.NAS.PTI}                               |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                    | {abotprop.SUT.NAS.PDU.SESS.MOD.COM.MSG}              |

    Then I receive and validate NGAP message NG_UPLINK_NAS_UL_NAS_TRANS_PDU_SESS_MOD_COMPL on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                                                  | value                                                             |
      | amf_ue_ngap_id                                                                                                             | {string:eq}($(AMF_UE_NGAP_ID))                                    |
      | ran_ue_ngap_id                                                                                                             | {string:eq}($(RAN_UE_NGAP_ID))                                    |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                                               | {string:eq}({abotprop.SUT.MCC})                                   |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                                               | {string:eq}({abotprop.SUT.MNC})                                   |
      | user_location_information.nr_user_location_information.tai.tac                                                             | {string:eq}({abotprop.SUT.TAC})                                   |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                                            | {string:eq}({abotprop.SUT.MCC})                                   |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                                            | {string:eq}({abotprop.SUT.MNC})                                   |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                                             | {string:eq}({abotprop.SUT.NR.CELL.IDN})                           |
      | nas_pdu.extended_protocol_discriminator                                                                                    | {string:eq}({abotprop.SUT.NAS.EDP})                               |
      | nas_pdu.security_header_type                                                                                               | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.PLAIN})                    |
      | nas_pdu.message_type                                                                                                       | {string:eq}({abotprop.SUT.NAS.UL.NAS.TRANS.MSG})                  |
      | nas_pdu.ul_nas_transport.pdu_session_identity                                                                              | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_ID6})                   |
      | nas_pdu.ul_nas_transport.request_type                                                                                      | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_REQ_TYPE_EXISTING_PDU}) |
      | nas_pdu.ul_nas_transport.snssai                                                                                            | {string:eq}({abotprop.SUT.SUBSCRIBEDNSSAI})                       |
      | nas_pdu.ul_nas_transport.dnn                                                                                               | {string:eq}({abotprop.SUT.DNN1})                                  |
      | nas_pdu.ul_nas_transport.payload_container_type                                                                            | {string:eq}({abotprop.SUT.NAS.PAYLOAD.CONTAINER})                 |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator | {string:eq}({abotprop.SUT.NAS.PDU.SM_EDP})                        |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                  | {string:eq}({abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID})            |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                             | {string:eq}({abotprop.SUT.NAS.PTI})                               |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                    | {string:eq}({abotprop.SUT.NAS.PDU.SESS.MOD.COM.MSG})              |





### AMF to SMF Update SM Contect - forward UE NAS Message PDU Session Modification Complete (N1 NAS)

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details from node AMF1 to SMF1:
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
      | multipart_related.json_data.sm_context_update_data.s_nssai.sst                                 | {abotprop.SUT.SUBSCRIBEDNSSAI}                                                          |
      | multipart_related.json_data.sm_context_update_data.n1_sm_msg.content_id                        | n1-pdu-session-modification-complete                                                    |
      | multipart_related.binary_data_n1_sm_message.content_type                                       | application/vnd.3gpp.5gnas                                                              |
      | multipart_related.binary_data_n1_sm_message.content_id                                         | n1-pdu-session-modification-complete                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator | {abotprop.SUT.NAS.PDU.SM_EDP}                                                           |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                  | {abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID}                                               |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                             | {abotprop.SUT.NAS.PTI}                                                                  |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                    | {abotprop.SUT.NAS.PDU.SESS.MOD.COM.MSG}                                                 |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details on node SMF1 from AMF1:
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
      | multipart_related.json_data.sm_context_update_data.s_nssai.sst                                 | {string:eq}({abotprop.SUT.SUBSCRIBEDNSSAI})                                                          |
      | multipart_related.json_data.sm_context_update_data.n1_sm_msg.content_id                        | {string:eq}(n1-pdu-session-modification-complete)                                                    |
      | multipart_related.binary_data_n1_sm_message.content_type                                       | {string:eq}(application/vnd.3gpp.5gnas)                                                              |
      | multipart_related.binary_data_n1_sm_message.content_id                                         | {string:eq}(n1-pdu-session-modification-complete)                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator | {string:eq}({abotprop.SUT.NAS.PDU.SM_EDP})                                                           |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                  | {string:eq}({abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID})                                               |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                             | {string:eq}({abotprop.SUT.NAS.PTI})                                                                  |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                    | {string:eq}({abotprop.SUT.NAS.PDU.SESS.MOD.COM.MSG})                                                 |

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_204 on interface N11 with the following details from node SMF1 to AMF1:
      | parameter          | value   |
      | header.nva.0.name  | :status |
      | header.nva.0.value | 204     |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_204 on interface N11 with the following details on node AMF1 from SMF1:
      | parameter          | value                |
      | header.nva.0.name  | {string:eq}(:status) |
      | header.nva.0.value | {string:eq}(204)     |

#######################################################################################
### SSC Mode 3 : Second UE PDU Sesion Establishment with SMF1/UPF2 (SMF Anchor Change)
#######################################################################################

### N2 - PDU Session Establishment (gNodeB to AMF : UE Initiated Single PDU Session Establishment Request)

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
      | nas_pdu.security_header_type                                                                                                            | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}                   |
      | nas_pdu.message_type                                                                                                                    | {abotprop.SUT.NAS.UL.NAS.TRANS.MSG}                 |
      | nas_pdu.ul_nas_transport.pdu_session_identity                                                                                           | {abotprop.SUT.NAS.PDU_SESSION_ID7}                  |
      | nas_pdu.ul_nas_transport.old_pdu_session_identity                                                                                       | 0x5906                                              |
      | nas_pdu.ul_nas_transport.request_type                                                                                                   | {abotprop.SUT.NAS.PDU_SESSION_REQ_TYPE_INITIAL}     |
      | nas_pdu.ul_nas_transport.snssai                                                                                                         | {abotprop.SUT.SUBSCRIBEDNSSAI}                      |
      | nas_pdu.ul_nas_transport.dnn                                                                                                            | {abotprop.SUT.DNN1}                                 |
      | nas_pdu.ul_nas_transport.payload_container_type                                                                                         | {abotprop.SUT.NAS.PAYLOAD.CONTAINER}                |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator              | {abotprop.SUT.NAS.PDU.SM_EDP}                       |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                               | {abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID7}          |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                                          | {abotprop.SUT.NAS.PTI2}                             |
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
      | nas_pdu.security_header_type                                                                                                            | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.PLAIN})                   |
      | nas_pdu.message_type                                                                                                                    | {string:eq}({abotprop.SUT.NAS.UL.NAS.TRANS.MSG})                 |
      | nas_pdu.ul_nas_transport.pdu_session_identity                                                                                           | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_ID7})                  |
      | nas_pdu.ul_nas_transport.old_pdu_session_identity                                                                                       | {string:eq}(0x5906)                                              |
      | nas_pdu.ul_nas_transport.request_type                                                                                                   | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_REQ_TYPE_INITIAL})     |
      | nas_pdu.ul_nas_transport.snssai                                                                                                         | {string:eq}({abotprop.SUT.SUBSCRIBEDNSSAI})                      |
      | nas_pdu.ul_nas_transport.dnn                                                                                                            | {string:eq}({abotprop.SUT.DNN1})                                 |
      | nas_pdu.ul_nas_transport.payload_container_type                                                                                         | {string:eq}({abotprop.SUT.NAS.PAYLOAD.CONTAINER})                |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator              | {string:eq}({abotprop.SUT.NAS.PDU.SM_EDP})                       |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                               | {string:eq}({abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID7})          |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                                          | {string:eq}({abotprop.SUT.NAS.PTI2})                             |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                                 | {string:eq}({abotprop.SUT.NAS.PDU.SESS.ESTD.REQ.MSG})            |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_req.int_protect_max_data_rate | {string:eq}({abotprop.SUT.NAS.PDU.INTRIGRITY.PRO.MAX.DATA.RATE}) |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_req.pdu_sess_type             | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_TYPE.IPV4})            |

### N11 - Create PDU Session Context (AMF to SMF - Initite PDU Session Establishment and PDU Session Context Creation)

    When I send HTTPV2 message HTTPV2_NSMF_CREATE_SM_CONTEXT_REQ on interface N11 with the following details from node AMF1 to SMF1:
      | parameter                                                                                                   | value                                                                                                        |
      | header.nva.0.name                                                                                           | :method                                                                                                      |
      | header.nva.0.value                                                                                          | POST                                                                                                         |
      | header.nva.1.name                                                                                           | :path                                                                                                        |
      | header.nva.1.value                                                                                          | /127.0.0.1:12349/nsmf-pdusession/v1/sm-contexts                                                              |
      | header.nva.2.name                                                                                           | content-type                                                                                                 |
      | header.nva.2.value                                                                                          | multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json                      |
      | multipart_related.json_data.content_type                                                                    | application/json                                                                                             |
      | multipart_related.json_data.content_id                                                                      | sm-context-create-data                                                                                       |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.plmn_id.mcc                 | {abotprop.SUT.MCC}                                                                                           |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.plmn_id.mnc                 | {abotprop.SUT.MNC}                                                                                           |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.nr_cell_id                  | {abotprop.SUT.NR.CELL.IDN}                                                                                   |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.plmn_id.mcc                  | {abotprop.SUT.MCC}                                                                                           |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.plmn_id.mnc                  | {abotprop.SUT.MNC}                                                                                           |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.tac                          | {abotprop.SUT.TAC}                                                                                           |
      | multipart_related.json_data.sm_context_create_data.sm_context_status_uri                                    | /$({abotprop.AMF1.SecureShell.IPAddress}):$({abotprop.AMF1.N11.Server.Port})/v1/sm-contexts/smctx-2/status/7 |
      | multipart_related.json_data.sm_context_create_data.gpsi                                                     | {abotprop.SUT.GPSI.START}                                                                                    |
      | multipart_related.json_data.sm_context_create_data.pdu_session_id                                           | {abotprop.SUT.PDU.SESSION.ID.SECONDARY}                                                                      |
      | multipart_related.json_data.sm_context_create_data.old_pdu_session_id                                       | {abotprop.SUT.PDU.SESS.ID}                                                                                   |
      | multipart_related.json_data.sm_context_create_data.n1_sm_msg.content_id                                     | n1-pdu-session-establishment-request                                                                         |
      | multipart_related.json_data.sm_context_create_data.an_type                                                  | {abotprop.SUT.ACCESS.TYPE.3GPP}                                                                              |
      | multipart_related.json_data.sm_context_create_data.supi                                                     | incr({abotprop.SUT.SUPI},1)                                                                                  |
      | multipart_related.json_data.sm_context_create_data.s_nssai.sst                                              | {abotprop.SUT.SUBSCRIBEDNSSAI}                                                                               |
      | multipart_related.json_data.sm_context_create_data.serving_nf_id                                            | {abotprop.SUT.AMF1.NFINSTANCEID}                                                                             |
      | multipart_related.json_data.sm_context_create_data.pei                                                      | incr({abotprop.SUT.PEI},1)                                                                                   |
      | multipart_related.json_data.sm_context_create_data.request_type                                             | INITIAL_REQUEST                                                                                              |
      | multipart_related.json_data.sm_context_create_data.dnn                                                      | {abotprop.SUT.DNN1}                                                                                          |
      | multipart_related.json_data.sm_context_create_data.guami.plmn_id.mcc                                        | {abotprop.SUT.MCC}                                                                                           |
      | multipart_related.json_data.sm_context_create_data.guami.plmn_id.mnc                                        | {abotprop.SUT.MNC}                                                                                           |
      | multipart_related.json_data.sm_context_create_data.guami.amf_id                                             | {abotprop.SUT.AMF.REG.AMF.ID}                                                                                |
      | multipart_related.json_data.sm_context_create_data.serving_network.mcc                                      | {abotprop.SUT.MCC}                                                                                           |
      | multipart_related.json_data.sm_context_create_data.serving_network.mnc                                      | {abotprop.SUT.MNC}                                                                                           |
      | multipart_related.json_data.sm_context_create_data.pdu_sessions_activate_list.0.pdu_session_id              | {abotprop.SUT.PDU.SESSION.ID.SECONDARY}                                                                      |
      | multipart_related.binary_data_n1_sm_message.content_type                                                    | application/vnd.3gpp.5gnas                                                                                   |
      | multipart_related.binary_data_n1_sm_message.content_id                                                      | n1-pdu-session-establishment-request                                                                         |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator              | {abotprop.SUT.NAS.PDU.SM_EDP}                                                                                |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                               | {abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID7}                                                                   |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                                          | {abotprop.SUT.NAS.PTI2}                                                                                      |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                                 | {abotprop.SUT.NAS.PDU.SESS.ESTD.REQ.MSG}                                                                     |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_estab_req.int_protect_max_data_rate | {abotprop.SUT.NAS.PDU.INTRIGRITY.PRO.MAX.DATA.RATE}                                                          |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_estab_req.pdu_sess_type             | {abotprop.SUT.NAS.PDU_SESSION_TYPE.IPV4}                                                                     |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_CREATE_SM_CONTEXT_REQ on interface N11 with the following details on node SMF1 from AMF1:
      | parameter                                                                                                   | value                                                                                                |
      | header.nva.0.name                                                                                           | {string:eq}(content-type)                                                                            |
      | header.nva.0.value                                                                                          | {string:eq}(multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json) |
      | multipart_related.json_data.content_type                                                                    | {string:eq}(application/json)                                                                        |
      | multipart_related.json_data.content_id                                                                      | {string:eq}(sm-context-create-data)                                                                  |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.plmn_id.mcc                 | {string:eq}({abotprop.SUT.MCC})                                                                      |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.plmn_id.mnc                 | {string:eq}({abotprop.SUT.MNC})                                                                      |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.ncgi.nr_cell_id                  | {string:eq}({abotprop.SUT.NR.CELL.IDN})                                                              |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.plmn_id.mcc                  | {string:eq}({abotprop.SUT.MCC})                                                                      |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.plmn_id.mnc                  | {string:eq}({abotprop.SUT.MNC})                                                                      |
      | multipart_related.json_data.sm_context_create_data.ue_location.nr_location.tai.tac                          | {string:eq}({abotprop.SUT.TAC})                                                                      |
      | multipart_related.json_data.sm_context_create_data.sm_context_status_uri                                    | save(SM_CTXT_STATUS_URI_1)                                                                           |
      | multipart_related.json_data.sm_context_create_data.gpsi                                                     | {string:eq}({abotprop.SUT.GPSI.START})                                                               |
      | multipart_related.json_data.sm_context_create_data.pdu_session_id                                           | {string:eq}({abotprop.SUT.PDU.SESSION.ID.SECONDARY})                                                 |
      | multipart_related.json_data.sm_context_create_data.old_pdu_session_id                                       | {string:eq}({abotprop.SUT.PDU.SESS.ID})                                                              |
      | multipart_related.json_data.sm_context_create_data.n1_sm_msg.content_id                                     | {string:eq}(n1-pdu-session-establishment-request)                                                    |
      | multipart_related.json_data.sm_context_create_data.an_type                                                  | {string:eq}({abotprop.SUT.ACCESS.TYPE.3GPP})                                                         |
      | multipart_related.json_data.sm_context_create_data.supi                                                     | save(SUPI)                                                                                           |
      | multipart_related.json_data.sm_context_create_data.s_nssai.sst                                              | {string:eq}({abotprop.SUT.SUBSCRIBEDNSSAI})                                                          |
      | multipart_related.json_data.sm_context_create_data.serving_nf_id                                            | {string:eq}({abotprop.SUT.AMF1.NFINSTANCEID})                                                        |
      | multipart_related.json_data.sm_context_create_data.pei                                                      | {string:eq}($(PEI))                                                                                  |
      | multipart_related.json_data.sm_context_create_data.request_type                                             | {string:eq}(INITIAL_REQUEST)                                                                         |
      | multipart_related.json_data.sm_context_create_data.dnn                                                      | {string:eq}({abotprop.SUT.DNN1})                                                                     |
      | multipart_related.json_data.sm_context_create_data.guami.plmn_id.mcc                                        | {string:eq}({abotprop.SUT.MCC})                                                                      |
      | multipart_related.json_data.sm_context_create_data.guami.plmn_id.mnc                                        | {string:eq}({abotprop.SUT.MNC})                                                                      |
      | multipart_related.json_data.sm_context_create_data.guami.amf_id                                             | {string:eq}({abotprop.SUT.AMF.REG.AMF.ID})                                                           |
      | multipart_related.json_data.sm_context_create_data.serving_network.mcc                                      | {string:eq}({abotprop.SUT.MCC})                                                                      |
      | multipart_related.json_data.sm_context_create_data.serving_network.mnc                                      | {string:eq}({abotprop.SUT.MNC})                                                                      |
      | multipart_related.json_data.sm_context_create_data.pdu_sessions_activate_list.0.pdu_session_id              | {string:eq}({abotprop.SUT.PDU.SESSION.ID.SECONDARY})                                                 |
      | multipart_related.binary_data_n1_sm_message.content_type                                                    | {string:eq}(application/vnd.3gpp.5gnas)                                                              |
      | multipart_related.binary_data_n1_sm_message.content_id                                                      | {string:eq}(n1-pdu-session-establishment-request)                                                    |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator              | {string:eq}({abotprop.SUT.NAS.PDU.SM_EDP})                                                           |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                               | {string:eq}({abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID7})                                              |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                                          | {string:eq}({abotprop.SUT.NAS.PTI2})                                                                 |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                                 | {string:eq}({abotprop.SUT.NAS.PDU.SESS.ESTD.REQ.MSG})                                                |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_estab_req.int_protect_max_data_rate | {string:eq}({abotprop.SUT.NAS.PDU.INTRIGRITY.PRO.MAX.DATA.RATE})                                     |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_estab_req.pdu_sess_type             | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_TYPE.IPV4})                                                |

### SMF to UDM - UE PDU Session Registration

    When I send HTTPV2 message HTTPV2_NUDM_UECM_SMF_REG_PUT_REQ on interface N10 with the following details from node SMF1 to UDM1:
      | parameter                         | value                                                                                           |
      | header.nva.0.name                 | :method                                                                                         |
      | header.nva.0.value                | PUT                                                                                             |
      | header.nva.1.name                 | :path                                                                                           |
      | header.nva.1.value                | /127.0.0.1:12348/nudm-uecm/v1/incr($({abotprop.SUT.SUPI}),1))/registrations/smf-registrations/7 |
      | header.nva.2.name                 | content-type                                                                                    |
      | header.nva.2.value                | application/json                                                                                |
      | smf_registration.smf_instance_id  | {abotprop.SUT.SMF1.NFINSTANCEID}                                                                |
      | smf_registration.pdu_session_id   | {abotprop.SUT.PDU.SESSION.ID.SECONDARY}                                                         |
      | smf_registration.single_nssai.sst | {abotprop.SUT.SUBSCRIBEDNSSAI}                                                                  |
      | smf_registration.plmn_id.mcc      | {abotprop.SUT.MCC}                                                                              |
      | smf_registration.plmn_id.mnc      | {abotprop.SUT.MNC}                                                                              |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UECM_SMF_REG_PUT_REQ on interface N10 with the following details on node UDM1 from SMF1:
      | parameter                         | value                                                                                                        |
      | header.nva.0.name                 | {string:eq}(:method)                                                                                         |
      | header.nva.0.value                | {string:eq}(PUT)                                                                                             |
      | header.nva.1.name                 | {string:eq}(:path)                                                                                           |
      | header.nva.1.value                | {string:eq}(/127.0.0.1:12348/nudm-uecm/v1/incr($({abotprop.SUT.SUPI}),1))/registrations/smf-registrations/7) |
      | header.nva.2.name                 | {string:eq}(content-type)                                                                                    |
      | header.nva.2.value                | {string:eq}(application/json)                                                                                |
      | smf_registration.smf_instance_id  | {string:eq}({abotprop.SUT.SMF1.NFINSTANCEID})                                                                |
      | smf_registration.pdu_session_id   | {string:eq}({abotprop.SUT.PDU.SESSION.ID.SECONDARY})                                                         |
      | smf_registration.single_nssai.sst | {string:eq}({abotprop.SUT.SUBSCRIBEDNSSAI})                                                                  |
      | smf_registration.plmn_id.mcc      | {string:eq}({abotprop.SUT.MCC})                                                                              |
      | smf_registration.plmn_id.mnc      | {string:eq}({abotprop.SUT.MNC})                                                                              |

    When I send HTTPV2 message HTTPV2_NUDM_UECM_SMF_REG_PUT_RES_201 on interface N10 with the following details from node UDM1 to SMF1:
      | parameter                         | value                                                                                           |
      | header.nva.0.name                 | :status                                                                                         |
      | header.nva.0.value                | 201                                                                                             |
      | header.nva.1.name                 | location                                                                                        |
      | header.nva.1.value                | /127.0.0.1:12348/nudm-uecm/v1/incr($({abotprop.SUT.SUPI}),1))/registrations/smf-registrations/7 |
      | header.nva.2.name                 | content-type                                                                                    |
      | header.nva.2.value                | application/json                                                                                |
      | smf_registration.smf_instance_id  | {abotprop.SUT.SMF1.NFINSTANCEID}                                                                |
      | smf_registration.pdu_session_id   | {abotprop.SUT.PDU.SESSION.ID.SECONDARY}                                                         |
      | smf_registration.single_nssai.sst | {abotprop.SUT.SUBSCRIBEDNSSAI}                                                                  |
      | smf_registration.plmn_id.mcc      | {abotprop.SUT.MCC}                                                                              |
      | smf_registration.plmn_id.mnc      | {abotprop.SUT.MNC}                                                                              |

    Then I receive and validate HTTPV2 message HTTPV2_NUDM_UECM_SMF_REG_PUT_RES_201 on interface N10 with the following details on node SMF1 from UDM1:
      | parameter                         | value                                                                                                        |
      | header.nva.0.name                 | {string:eq}(:status)                                                                                         |
      | header.nva.0.value                | {string:eq}(201)                                                                                             |
      | header.nva.1.name                 | {string:eq}(location)                                                                                        |
      | header.nva.1.value                | {string:eq}(/127.0.0.1:12348/nudm-uecm/v1/incr($({abotprop.SUT.SUPI}),1))/registrations/smf-registrations/7) |
      | header.nva.2.name                 | {string:eq}(content-type)                                                                                    |
      | header.nva.2.value                | {string:eq}(application/json)                                                                                |
      | smf_registration.smf_instance_id  | {string:eq}({abotprop.SUT.SMF1.NFINSTANCEID})                                                                |
      | smf_registration.pdu_session_id   | {string:eq}({abotprop.SUT.PDU.SESSION.ID.SECONDARY})                                                         |
      | smf_registration.single_nssai.sst | {string:eq}({abotprop.SUT.SUBSCRIBEDNSSAI})                                                                  |
      | smf_registration.plmn_id.mcc      | {string:eq}({abotprop.SUT.MCC})                                                                              |
      | smf_registration.plmn_id.mnc      | {string:eq}({abotprop.SUT.MNC})                                                                              |

    When I send HTTPV2 message HTTPV2_NSMF_CREATE_SM_CONTEXT_RES_201 on interface N11 with the following details from node SMF1 to AMF1:
      | parameter                                               | value                                                         |
      | header.nva.0.name                                       | :status                                                       |
      | header.nva.0.value                                      | 201                                                           |
      | header.nva.1.name                                       | content-type                                                  |
      | header.nva.1.value                                      | application/json                                              |
      | header.nva.2.name                                       | location                                                      |
      | header.nva.2.value                                      | http://127.0.0.1:12352/nsmf-pdusession/v1/sm-contexts/smctx-2 |
      | application_json.sm_context_created_data.h_smf_uri      | http://127.0.0.1:12352                                        |
      | application_json.sm_context_created_data.pdu_session_id | {abotprop.SUT.PDU.SESSION.ID.SECONDARY}                       |
      | application_json.sm_context_created_data.s_nssai.sst    | {abotprop.SUT.SUBSCRIBEDNSSAI}                                |
      | application_json.sm_context_created_data.up_cnx_state   | ACTIVATED                                                     |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_CREATE_SM_CONTEXT_RES_201 on interface N11 with the following details on node AMF1 from SMF1:
      | parameter                                               | value                                                                      |
      | header.nva.0.name                                       | {string:eq}(:status)                                                       |
      | header.nva.0.value                                      | {string:eq}(201)                                                           |
      | header.nva.1.name                                       | {string:eq}(content-type)                                                  |
      | header.nva.1.value                                      | {string:eq}(application/json)                                              |
      | header.nva.2.name                                       | {string:eq}(location)                                                      |
      | header.nva.2.value                                      | {string:eq}(http://127.0.0.1:12352/nsmf-pdusession/v1/sm-contexts/smctx-2) |
      | application_json.sm_context_created_data.h_smf_uri      | {string:eq}(http://127.0.0.1:12352)                                        |
      | application_json.sm_context_created_data.pdu_session_id | {string:eq}({abotprop.SUT.PDU.SESSION.ID.SECONDARY})                       |
      | application_json.sm_context_created_data.s_nssai.sst    | {string:eq}({abotprop.SUT.SUBSCRIBEDNSSAI})                                |
      | application_json.sm_context_created_data.up_cnx_state   | {string:eq}(ACTIVATED)                                                     |

## SM Policy Association for New PDU Session (SMF to PCF : Setup SM Policy Association for the UE with PCF for Session Management control)

    When I send HTTPV2 message HTTPV2_NPCFSM_POLICY_CONTROL_CREATE_POST_REQ on interface N7 with the following details from node SMF1 to PCF1:
      | parameter                               | value                                                                                                                          |
      | header.nva.0.name                       | :method                                                                                                                        |
      | header.nva.0.value                      | POST                                                                                                                           |
      | header.nva.1.name                       | :path                                                                                                                          |
      | header.nva.1.value                      | /127.0.0.1:12348/npcf-smpolicycontrol/v1/sm-policies                                                                           |
      | header.nva.2.name                       | content-type                                                                                                                   |
      | header.nva.2.value                      | application/json                                                                                                               |
      | sm_policy_context_data.supi             | incr({abotprop.SUT.SUPI},1)                                                                                                    |
      | sm_policy_context_data.pdu_session_id   | {abotprop.SUT.PDU.SESSION.ID.SECONDARY}                                                                                        |
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
      | sm_policy_context_data.pdu_session_id   | {string:eq}({abotprop.SUT.PDU.SESSION.ID.SECONDARY})                      |
      | sm_policy_context_data.pdu_session_type | {string:eq}({abotprop.SUT.HTTP2.PDU_SESSION_TYPE})                        |
      | sm_policy_context_data.dnn              | {string:eq}({abotprop.SUT.DNN1})                                          |
      | sm_policy_context_data.notification_uri | save(SMF_NOTIFICATION_URI1)                                               |
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
      | sm_policy_decision.pcc_rules.pccruleid1.pcc_rule_id    | save(PCC_RULE_ID2)                                                       |
      | sm_policy_decision.sess_rules.sessruleid1.sess_rule_id | save(SESSION_RULE_ID2)                                                   |
      | sm_policy_decision.qos_decs.qosid1.qos_id              | save(QOS_RULE_ID2)                                                       |

## N4 (CUPS) - Session Establishment (SMF to UPF : 1. Trigger setup of SMF allocated UPF N3 Tunnel Endpoint, 2. UE Static IP Allocated by SMF)
## Configure : Forwarding Incoming Uplink Packets - PDR Rule Id 1, mapped to FAR Rule ID 1, for UPF N3 Tunnel (Source Interface - Access(0), Destination interface - Core(1))
##             Forwarding Incoming Downlink Packets - PDR Rule Id 2, mapped to FAR Rule ID 2, for destination UE IP Address towards GNB N3 Tunnel (Source Interface - Core(1), Destination interface - Access(0))
##                                                    GNB N3 Tunnel forwarding is updated in FAR Rule ID 2 in Session Modification from SMF when it receives it from GNB via AMF

    When I send PFCP message PFCP_SESSION_ESTABLISH_REQ on interface N4 with the following details from node SMF1 to UPF2:
      | parameter                                               | value                                                                         |
      | header.message_type                                     | 50                                                                            |
      | header.seid                                             | 0                                                                             |
      | header.seq_number                                       | incr(2,3)                                                                     |
      | node_id.type                                            | {abotprop.SUT.PFCP_NODE_ID_TYPE}                                              |
      | node_id.value                                           | $({abotprop.SMF1.SecureShell.IPAddress})                                      |
      | cp_f_seid.flag                                          | {abotprop.SUT.PFCP.CP.F-SEID.FLAG}                                            |
      | cp_f_seid.seid                                          | incr(50000000,1)                                                              |
      | cp_f_seid.ipv4_addr                                     | $({abotprop.SMF1.SecureShell.IPAddress})                                      |
      | pdn_type                                                | {abotprop.SUT.3GPP.PDN_TYPE}                                                  |
      | create_pdr.0.pdr_id                                     | {abotprop.SUT.PFCP.PDR.0.PDR_ID}                                              |
      | create_pdr.0.precedence                                 | 1                                                                             |
      | create_pdr.0.pdi.source_interface                       | {abotprop.SUT.PFCP.PDR.0.SOURCE_INTERFCE.ACCESS}                              |
      | create_pdr.0.pdi.local_fteid.flag                       | 1                                                                             |
      | create_pdr.0.pdi.local_fteid.teid                       | {abotprop.SUT.AUTO.RSP.GTP.UL.TEID}                                           |
      | create_pdr.0.pdi.local_fteid.ipv4_addr                  | 10.10.10.70                                                                   |
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

    Then I receive and validate PFCP message PFCP_SESSION_ESTABLISH_REQ on interface N4 with the following details on node UPF2 from SMF1:
      | parameter                                               | value                                                              |
      | header.message_type                                     | {string:eq}(50)                                                    |
      | header.seid                                             | {string:eq}(0)                                                     |
      | header.seq_number                                       | save(PFCP_HDR_SEQ_NO)                                              |
      | node_id.type                                            | {string:eq}({abotprop.SUT.PFCP_NODE_ID_TYPE})                      |
      | node_id.value                                           | save(PFCP_NODE_IP_SMF)                                             |
      | cp_f_seid.flag                                          | {string:eq}({abotprop.SUT.PFCP.CP.F-SEID.FLAG})                    |
      | cp_f_seid.seid                                          | save(PFCP_HDR_SEID_SMF1_AT_UPF2)                                   |
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

    When I send PFCP message PFCP_SESSION_ESTABLISH_RES on interface N4 with the following details from node UPF2 to SMF1:
      | parameter            | value                                      |
      | header.message_type  | 51                                         |
      | header.seid          | $(PFCP_HDR_SEID_SMF1_AT_UPF2)              |
      | header.seq_number    | $(PFCP_HDR_SEQ_NO)                         |
      | node_id.type         | {abotprop.SUT.PFCP_NODE_ID_TYPE}           |
      | node_id.value        | $({abotprop.UPF2.SecureShell.IPAddress})   |
      | cause                | {abotprop.SUT.PFCP.RESPOSE.CAUSE.ACCEPTED} |
      | up_f_seid.flag       | {abotprop.SUT.PFCP.UP.F-SEID.FLAG}         |
      | up_f_seid.seid       | {abotprop.SUT.AUTO.RSP.GTP.DL.TEID}        |
      | up_f_seid.ipv4_addr  | 9.10.11.12                                 |
      | created_pdr.0.pdr_id | {abotprop.SUT.PFCP.PDR.0.PDR_ID}           |
      | created_pdr.1.pdr_id | {abotprop.SUT.PFCP.PDR.1.PDR_ID}           |

    Then I receive and validate PFCP message PFCP_SESSION_ESTABLISH_RES on interface N4 with the following details on node SMF1 from UPF2:
      | parameter            | value                                                   |
      | header.message_type  | {string:eq}(51)                                         |
      | header.seid          | save(PFCP_HDR_SEID_SMF1_AT_SMF1)                        |
      | header.seq_number    | save(PFCP_HDR_SEQ_NO)                                   |
      | node_id.type         | {string:eq}({abotprop.SUT.PFCP_NODE_ID_TYPE})           |
      | node_id.value        | {string:eq}($({abotprop.UPF2.SecureShell.IPAddress}))   |
      | cause                | {string:eq}({abotprop.SUT.PFCP.RESPOSE.CAUSE.ACCEPTED}) |
      | up_f_seid.flag       | {string:eq}({abotprop.SUT.PFCP.UP.F-SEID.FLAG})         |
      | up_f_seid.seid       | save(PFCP_HDR_SEID_UPF2_AT_SMF1)                        |
      | up_f_seid.ipv4_addr  | save(PFCP_MSG_IP_UPF)                                   |
      | created_pdr.0.pdr_id | {string:eq}({abotprop.SUT.PFCP.PDR.0.PDR_ID})           |
      | created_pdr.1.pdr_id | {string:eq}({abotprop.SUT.PFCP.PDR.1.PDR_ID})           |

    When I send HTTPV2 message HTTPV2_NAMF_COMM_N1N2_MSG_TRANSFER_POST_REQ on interface N11 with the following details from node SMF1 to AMF1:
      | parameter                                                                                                                                                                                         | value                                                                                                    |
      | header.nva.0.name                                                                                                                                                                                 | :method                                                                                                  |
      | header.nva.0.value                                                                                                                                                                                | POST                                                                                                     |
      | header.nva.1.name                                                                                                                                                                                 | :path                                                                                                    |
      | header.nva.1.value                                                                                                                                                                                | /127.0.0.1:12348/namf-comm/v1/ue-contexts/incr($({abotprop.SUT.SUPI}),1)/n1-n2-messages                  |
      | header.nva.2.name                                                                                                                                                                                 | content-type                                                                                             |
      | header.nva.2.value                                                                                                                                                                                | multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json                  |
      | multipart_related.json_data.content_type                                                                                                                                                          | application/json                                                                                         |
      | multipart_related.json_data.content_id                                                                                                                                                            | n1n2-message-transfer-req-data                                                                           |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1_message_container.n1_message_class                                                                                                  | SM                                                                                                       |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1_message_container.n1_message_content.content_id                                                                                     | n1-pdu-session-establishment-accept                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.n2_information_class                                                                                                 | SM                                                                                                       |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.n2_info_content.ngap_ie_type                                                                                 | PDU_RES_SETUP_REQ                                                                                        |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.n2_info_content.ngap_data.content_id                                                                         | n2-pdu-session-resource-setup-request-transfer-ie                                                        |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.pdu_session_id                                                                                               | {abotprop.SUT.PDU.SESSION.ID.SECONDARY}                                                                  |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.s_nssai.sst                                                                                                  | {abotprop.SUT.SUBSCRIBEDNSSAI}                                                                           |
      | multipart_related.json_data.n1n2_message_transfer_req_data.skip_ind                                                                                                                               | false                                                                                                    |
      | multipart_related.json_data.n1n2_message_transfer_req_data.pdu_session_id                                                                                                                         | {abotprop.SUT.PDU.SESSION.ID.SECONDARY}                                                                  |
      | multipart_related.json_data.n1n2_message_transfer_req_data.5qi                                                                                                                                    | {abotprop.SUT.AUTO.RSP.PDU.SESS.5QI}                                                                     |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1n2_failure_txf_notif_u_r_i                                                                                                           | /127.0.0.1:12348/namf-comm/v1/ue-contexts/incr($({abotprop.SUT.SUPI}),1)/n1-n2-messages/callback-failure |
      | multipart_related.json_data.n1n2_message_transfer_req_data.smf_reallocation_ind                                                                                                                   | false                                                                                                    |
      | multipart_related.binary_data_n1_message.content_type                                                                                                                                             | application/vnd.3gpp.5gnas                                                                               |
      | multipart_related.binary_data_n1_message.content_id                                                                                                                                               | n1-pdu-session-establishment-accept                                                                      |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.extended_protocol_discriminator                                                                                                       | {abotprop.SUT.NAS.PDU.SM_EDP}                                                                            |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_session_id                                                                                                                        | {abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID7}                                                               |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pti                                                                                                                                   | {abotprop.SUT.NAS.PTI2}                                                                                  |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.message_type                                                                                                                          | {abotprop.SUT.NAS.PDU.SESS.ESTD.ACC.MSG}                                                                 |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.selected_pdu_sess_type                                                                                             | {abotprop.SUT.NAS.N1-SM-INFO.SELECTED.PDU_SESSION_TYPE}                                                  |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.selected_ssc_mode                                                                                                  | {abotprop.SUT.NAS.SELECTED.SSC.MODE3}                                                                    |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.session_ambr                                                                                                       | {abotprop.SUT.NAS.N1-SM-INFO.SESSION.AMBR}                                                               |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.pdu_address                                                                                                        | incr(172.16.0.10,1)                                                                                      |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.snssai                                                                                                             | {abotprop.SUT.SUBSCRIBEDNSSAI}                                                                           |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.dnn                                                                                                                | {abotprop.SUT.DNN1}                                                                                      |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.qri                                                                               | 0x01                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.op_code_dqr_bit_no_of_pkt_filters                                                 | 0x31                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.precedence                                                                        | 0x01                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.segr_bit_qfi                                                                      | 0x09                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.dir_id                                                       | 0x21                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.type                                   | 0x11                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.ipv4_local_address_mask                | 0xac10000affff0000                                                                                       |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.type                                   | 0x10                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.ipv4_remote_address_mask               | 0x2be1377fffff0000                                                                                       |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.type                                   | 0x30                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.ipv4_proto_id_or_ipv6_next_hdr         | 0x11                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.type                                   | 0x41                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.local_port_range                       | 0x13881770                                                                                               |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.type                                   | 0x51                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.remote_port_range                      | 0x1b581f40                                                                                               |
      | multipart_related.binary_data_n2_information.content_type                                                                                                                                         | application/vnd.3gpp.ngap                                                                                |
      | multipart_related.binary_data_n2_information.content_id                                                                                                                                           | n2-pdu-session-resource-setup-request-transfer-ie                                                        |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate                 | {abotprop.SUT.AGGR.MAX.BIT.RATE.DL}                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate                 | {abotprop.SUT.AGGR.MAX.BIT.RATE.UL}                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                      | {abotprop.SUT.AUTO.RSP.GTP.UL.IP}                                                                        |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                     | {abotprop.SUT.AUTO.RSP.GTP.UL.TEID}                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                                 | {abotprop.SUT.NAS.N2-PDU-SETUP-REQ-TRANSFR.PDU_SESSION_TYPE}                                             |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                                    | {abotprop.SUT.AUTO.RSP.PDU.SESS.QFI}                                                                     |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi         | {abotprop.SUT.AUTO.RSP.PDU.SESS.5QI}                                                                     |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.priority_level | {abotprop.SUT.QOS.5QI.PRIORITY}                                                                          |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                                 | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PRIORITY.LEVEL}                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                             | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.CAPABILITY}                                                  |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                          | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.VULNERABILITY}                                               |

    Then I receive and validate HTTPV2 message HTTPV2_NAMF_COMM_N1N2_MSG_TRANSFER_POST_REQ on interface N11 with the following details on node AMF1 from SMF1:
      | parameter                                                                                                                                                                                         | value                                                                                                                 |
      | header.nva.0.name                                                                                                                                                                                 | {string:eq}(:method)                                                                                                  |
      | header.nva.0.value                                                                                                                                                                                | {string:eq}(POST)                                                                                                     |
      | header.nva.1.name                                                                                                                                                                                 | {string:eq}(:path)                                                                                                    |
      | header.nva.1.value                                                                                                                                                                                | {string:eq}(/127.0.0.1:12348/namf-comm/v1/ue-contexts/incr($({abotprop.SUT.SUPI}),1)/n1-n2-messages)                  |
      | header.nva.2.name                                                                                                                                                                                 | {string:eq}(content-type)                                                                                             |
      | header.nva.2.value                                                                                                                                                                                | {string:eq}(multipart/related; boundary=Sfrrfg32kUf2k1Rb5bkdlgYvertsgt6sccA9; type=application/json)                  |
      | multipart_related.json_data.content_type                                                                                                                                                          | {string:eq}(application/json)                                                                                         |
      | multipart_related.json_data.content_id                                                                                                                                                            | {string:eq}(n1n2-message-transfer-req-data)                                                                           |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1_message_container.n1_message_class                                                                                                  | {string:eq}(SM)                                                                                                       |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1_message_container.n1_message_content.content_id                                                                                     | {string:eq}(n1-pdu-session-establishment-accept)                                                                      |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.n2_information_class                                                                                                 | {string:eq}(SM)                                                                                                       |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.n2_info_content.ngap_ie_type                                                                                 | {string:eq}(PDU_RES_SETUP_REQ)                                                                                        |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.n2_info_content.ngap_data.content_id                                                                         | {string:eq}(n2-pdu-session-resource-setup-request-transfer-ie)                                                        |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.pdu_session_id                                                                                               | {string:eq}({abotprop.SUT.PDU.SESSION.ID.SECONDARY})                                                                  |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n2_info_container.sm_info.s_nssai.sst                                                                                                  | {string:eq}({abotprop.SUT.SUBSCRIBEDNSSAI})                                                                           |
      | multipart_related.json_data.n1n2_message_transfer_req_data.skip_ind                                                                                                                               | {string:eq}(false)                                                                                                    |
      | multipart_related.json_data.n1n2_message_transfer_req_data.pdu_session_id                                                                                                                         | {string:eq}({abotprop.SUT.PDU.SESSION.ID.SECONDARY})                                                                  |
      | multipart_related.json_data.n1n2_message_transfer_req_data.5qi                                                                                                                                    | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.5QI})                                                                     |
      | multipart_related.json_data.n1n2_message_transfer_req_data.n1n2_failure_txf_notif_u_r_i                                                                                                           | {string:eq}(/127.0.0.1:12348/namf-comm/v1/ue-contexts/incr($({abotprop.SUT.SUPI}),1)/n1-n2-messages/callback-failure) |
      | multipart_related.json_data.n1n2_message_transfer_req_data.smf_reallocation_ind                                                                                                                   | {string:eq}(false)                                                                                                    |
      | multipart_related.binary_data_n1_message.content_type                                                                                                                                             | {string:eq}(application/vnd.3gpp.5gnas)                                                                               |
      | multipart_related.binary_data_n1_message.content_id                                                                                                                                               | {string:eq}(n1-pdu-session-establishment-accept)                                                                      |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.extended_protocol_discriminator                                                                                                       | {string:eq}({abotprop.SUT.NAS.PDU.SM_EDP})                                                                            |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_session_id                                                                                                                        | {string:eq}({abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID7})                                                               |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pti                                                                                                                                   | {string:eq}({abotprop.SUT.NAS.PTI2})                                                                                  |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.message_type                                                                                                                          | {string:eq}({abotprop.SUT.NAS.PDU.SESS.ESTD.ACC.MSG})                                                                 |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.selected_pdu_sess_type                                                                                             | {string:eq}({abotprop.SUT.NAS.N1-SM-INFO.SELECTED.PDU_SESSION_TYPE})                                                  |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.selected_ssc_mode                                                                                                  | {string:eq}({abotprop.SUT.NAS.SELECTED.SSC.MODE3})                                                                    |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.session_ambr                                                                                                       | {string:eq}({abotprop.SUT.NAS.N1-SM-INFO.SESSION.AMBR})                                                               |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.pdu_address                                                                                                        | save(UE_IP)                                                                                                           |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.snssai                                                                                                             | {string:eq}({abotprop.SUT.SUBSCRIBEDNSSAI})                                                                           |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.dnn                                                                                                                | {string:eq}({abotprop.SUT.DNN1})                                                                                      |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.qri                                                                               | {string:eq}(0x01)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.op_code_dqr_bit_no_of_pkt_filters                                                 | {string:eq}(0x31)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.precedence                                                                        | {string:eq}(0x01)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.segr_bit_qfi                                                                      | {string:eq}(0x09)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.dir_id                                                       | {string:eq}(0x21)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.type                                   | {string:eq}(0x11)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.0.ipv4_local_address_mask                | {string:eq}(0xac10000affff0000)                                                                                       |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.type                                   | {string:eq}(0x10)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.1.ipv4_remote_address_mask               | {string:eq}(0x2be1377fffff0000)                                                                                       |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.type                                   | {string:eq}(0x30)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.2.ipv4_proto_id_or_ipv6_next_hdr         | {string:eq}(0x11)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.type                                   | {string:eq}(0x41)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.3.local_port_range                       | {string:eq}(0x13881770)                                                                                               |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.type                                   | {string:eq}(0x51)                                                                                                     |
      | multipart_related.binary_data_n1_message.content.n1_sm_info.pdu_sess_estab_acc.authorized_qos_rules.qos_rules.0.packet_filter_list.0.packet_filter_comps.4.remote_port_range                      | {string:eq}(0x1b581f40)                                                                                               |
      | multipart_related.binary_data_n2_information.content_type                                                                                                                                         | {string:eq}(application/vnd.3gpp.ngap)                                                                                |
      | multipart_related.binary_data_n2_information.content_id                                                                                                                                           | {string:eq}(n2-pdu-session-resource-setup-request-transfer-ie)                                                        |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate                 | {string:eq}({abotprop.SUT.AGGR.MAX.BIT.RATE.DL})                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate                 | {string:eq}({abotprop.SUT.AGGR.MAX.BIT.RATE.UL})                                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                      | save(GTP_UL_IP)                                                                                                       |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                     | save(GTP_UL_TEID)                                                                                                     |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                                 | {string:eq}({abotprop.SUT.NAS.N2-PDU-SETUP-REQ-TRANSFR.PDU_SESSION_TYPE})                                             |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                                    | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.QFI})                                                                     |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi         | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.5QI})                                                                     |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.priority_level | {string:eq}({abotprop.SUT.QOS.5QI.PRIORITY})                                                                          |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                                 | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PRIORITY.LEVEL})                                                      |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                             | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.CAPABILITY})                                                  |
      | multipart_related.binary_data_n2_information.content.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                          | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.VULNERABILITY})                                               |

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

## N2 - Update PDU Session Context (AMF sends SMF : 1. gNodeB N3 Downlink Tunnel Endpoint)

    When I send NGAP message NG_PDU_SESS_RESRC_SETUP_REQ on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                                                                                                                                                                                                                                                              | value                                                        |
      | amf_ue_ngap_id                                                                                                                                                                                                                                                                         | $(AMF_UE_NGAP_ID)                                            |
      | ran_ue_ngap_id                                                                                                                                                                                                                                                                         | $(RAN_UE_NGAP_ID)                                            |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.extended_protocol_discriminator                                                                                                                                                                                  | {abotprop.SUT.NAS.EDP}                                       |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.security_header_type                                                                                                                                                                                             | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}                            |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.message_type                                                                                                                                                                                                     | {abotprop.SUT.NAS.DL.NAS.TRANS.MSG}                          |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.pdu_session_identity                                                                                                                                                                            | {abotprop.SUT.NAS.PDU_SESSION_ID7}                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_type                                                                                                                                                                          | {abotprop.SUT.NAS.PAYLOAD.CONTAINER}                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator                                                                                               | {abotprop.SUT.NAS.PDU.SM_EDP}                                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                                                                                                                | {abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID7}                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                                                                                                                           | {abotprop.SUT.NAS.PTI2}                                      |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                                                                                                                  | {abotprop.SUT.NAS.PDU.SESS.ESTD.ACC.MSG}                     |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.selected_pdu_sess_type                                                                                     | {abotprop.SUT.NAS.N1-SM-INFO.SELECTED.PDU_SESSION_TYPE}      |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.selected_ssc_mode                                                                                          | {abotprop.SUT.NAS.SELECTED.SSC.MODE3}                        |
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
      | pdu_session_resource_setup_request_list.0.pdu_session_id                                                                                                                                                                                                                               | {abotprop.SUT.PDU.SESSION.ID.SECONDARY}                      |
      | pdu_session_resource_setup_request_list.0.s-nssai.sst                                                                                                                                                                                                                                  | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate                                                                                                                 | {abotprop.SUT.AGGR.MAX.BIT.RATE.DL}                          |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate                                                                                                                 | {abotprop.SUT.AGGR.MAX.BIT.RATE.UL}                          |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                                                                                                                      | $(GTP_UL_IP)                                                 |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                                                                                                                     | $(GTP_UL_TEID)                                               |
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
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.security_header_type                                                                                                                                                                                             | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.PLAIN})                            |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.message_type                                                                                                                                                                                                     | {string:eq}({abotprop.SUT.NAS.DL.NAS.TRANS.MSG})                          |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.pdu_session_identity                                                                                                                                                                            | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_ID7})                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_type                                                                                                                                                                          | {string:eq}({abotprop.SUT.NAS.PAYLOAD.CONTAINER})                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator                                                                                               | {string:eq}({abotprop.SUT.NAS.PDU.SM_EDP})                                |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                                                                                                                | {string:eq}({abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID7})                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                                                                                                                           | {string:eq}({abotprop.SUT.NAS.PTI2})                                      |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                                                                                                                  | {string:eq}({abotprop.SUT.NAS.PDU.SESS.ESTD.ACC.MSG})                     |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.selected_pdu_sess_type                                                                                     | {string:eq}({abotprop.SUT.NAS.N1-SM-INFO.SELECTED.PDU_SESSION_TYPE})      |
      | pdu_session_resource_setup_request_list.0.pdu_session_nas_pdu.nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_estab_acc.selected_ssc_mode                                                                                          | {string:eq}({abotprop.SUT.NAS.SELECTED.SSC.MODE3})                        |
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
      | pdu_session_resource_setup_request_list.0.pdu_session_id                                                                                                                                                                                                                               | {string:eq}({abotprop.SUT.PDU.SESSION.ID.SECONDARY})                      |
      | pdu_session_resource_setup_request_list.0.s-nssai.sst                                                                                                                                                                                                                                  | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB})                   |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate                                                                                                                 | {string:eq}({abotprop.SUT.AGGR.MAX.BIT.RATE.DL})                          |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate                                                                                                                 | {string:eq}({abotprop.SUT.AGGR.MAX.BIT.RATE.UL})                          |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                                                                                                                      | save(GTP_UL_IP)                                                           |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                                                                                                                     | save(GTP_UL_TEID)                                                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                                                                                                                                 | {string:eq}({abotprop.SUT.NAS.N2-PDU-SETUP-REQ-TRANSFR.PDU_SESSION_TYPE}) |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                                                                                                                                    | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.QFI})                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi                                                                                                         | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.5QI})                         |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.priority_level                                                                                                 | {string:eq}({abotprop.SUT.QOS.5QI.PRIORITY})                              |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                                                                                                                                 | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PRIORITY.LEVEL})          |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                                                                                                                             | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.CAPABILITY})      |
      | pdu_session_resource_setup_request_list.0.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                                                                                                                          | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.VULNERABILITY})   |

    When I send NGAP message NG_PDU_SESS_RESRC_SETUP_RES on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                                                                          | value                                   |
      | amf_ue_ngap_id                                                                                                                                                                     | $(AMF_UE_NGAP_ID)                       |
      | ran_ue_ngap_id                                                                                                                                                                     | $(RAN_UE_NGAP_ID)                       |
      | pdu_session_resource_setup_response_list.0.pdu_session_id                                                                                                                          | {abotprop.SUT.PDU.SESSION.ID.SECONDARY} |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | {abotprop.SUT.AUTO.RSP.GTP.DL.TEID}     |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | incr(80000000,1)                        |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | {abotprop.SUT.AUTO.RSP.PDU.SESS.QFI}    |

    Then I receive and validate NGAP message NG_PDU_SESS_RESRC_SETUP_RES on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                                                                                                          | value                                                |
      | amf_ue_ngap_id                                                                                                                                                                     | {string:eq}($(AMF_UE_NGAP_ID))                       |
      | ran_ue_ngap_id                                                                                                                                                                     | {string:eq}($(RAN_UE_NGAP_ID))                       |
      | pdu_session_resource_setup_response_list.0.pdu_session_id                                                                                                                          | {string:eq}({abotprop.SUT.PDU.SESSION.ID.SECONDARY}) |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | save(GTP_DL_IP)                                      |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | save(GTP_DL_TEID)                                    |
      | pdu_session_resource_setup_response_list.0.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.QFI})    |

## N11 - Update PDU Session Context (AMF sends SMF : 1. gNodeB N3 Downlink Tunnel Endpoint)

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details from node AMF1 to SMF1:
      | parameter                                                                                                                                                                                       | value                                                                                   |
      | header.nva.0.name                                                                                                                                                                               | :method                                                                                 |
      | header.nva.0.value                                                                                                                                                                              | POST                                                                                    |
      | header.nva.1.name                                                                                                                                                                               | :path                                                                                   |
      | header.nva.1.value                                                                                                                                                                              | /127.0.0.1:12348/nsmf-pdusession/v1/sm-contexts/smctx-2/modify                          |
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
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | $(GTP_DL_IP)                                                                            |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | $(GTP_DL_TEID)                                                                          |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | {abotprop.SUT.AUTO.RSP.PDU.SESS.QFI}                                                    |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details on node SMF1 from AMF1:
      | parameter                                                                                                                                                                                       | value                                                                                                |
      | header.nva.0.name                                                                                                                                                                               | {string:eq}(:method)                                                                                 |
      | header.nva.0.value                                                                                                                                                                              | {string:eq}(POST)                                                                                    |
      | header.nva.1.name                                                                                                                                                                               | {string:eq}(:path)                                                                                   |
      | header.nva.1.value                                                                                                                                                                              | {string:eq}(/127.0.0.1:12348/nsmf-pdusession/v1/sm-contexts/smctx-2/modify)                          |
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
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | save(GTP_DL_IP)                                                                                      |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | save(GTP_DL_TEID)                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.QFI})                                                    |

## N4 (CUPS) - Session Modification (SMF informs UPF : gNodeB N3 Tunnel Endpoint)
## Configure : Forward Incoming Downlink packets at UPF to gNodeB N3 (PDR Rule ID 2, FAR Rule ID 2 : Source Interface - Core (1), Destination Interface - Access (0))

    When I send PFCP message PFCP_SESSION_MODIFICATION_REQ on interface N4 with the following details from node SMF1 to UPF2:
      | parameter                                                              | value                                                 |
      | header.message_type                                                    | 52                                                    |
      | header.seid                                                            | $(PFCP_HDR_SEID_UPF2_AT_SMF1)                         |
      | header.seq_number                                                      | incr(2,3)                                             |
      | update_far.0.far_id                                                    | {abotprop.SUT.PFCP.PDR.1.FAR_ID}                      |
      | update_far.0.apply_action                                              | 2                                                     |
      | update_far.0.update_forwarding_parms.destination_interface             | {abotprop.SUT.PFCP.PDR.0.DESTINATION_INTERFCE.ACCESS} |
      | update_far.0.update_forwarding_parms.outer_header_creation.description | 0x100                                                 |
      | update_far.0.update_forwarding_parms.outer_header_creation.teid        | $(GTP_DL_TEID)                                        |
      | update_far.0.update_forwarding_parms.outer_header_creation.ipv4_addr   | $(GTP_DL_IP)                                          |

    Then I receive and validate PFCP message PFCP_SESSION_MODIFICATION_REQ on interface N4 with the following details on node UPF2 from SMF1:
      | parameter                                                              | value                                                              |
      | header.message_type                                                    | {string:eq}(52)                                                    |
      | header.seid                                                            | save(PFCP_HDR_SEID_UPF2_AT_UPF2)                                   |
      | header.seq_number                                                      | save(PFCP_HDR_SEQ_NO)                                              |
      | update_far.0.far_id                                                    | {string:eq}({abotprop.SUT.PFCP.PDR.1.FAR_ID})                      |
      | update_far.0.apply_action                                              | {string:eq}(2)                                                     |
      | update_far.0.update_forwarding_parms.destination_interface             | {string:eq}({abotprop.SUT.PFCP.PDR.0.DESTINATION_INTERFCE.ACCESS}) |
      | update_far.0.update_forwarding_parms.outer_header_creation.description | save(OUT_HDR_CREATE_DESC)                                          |
      | update_far.0.update_forwarding_parms.outer_header_creation.teid        | save(GTP_DL_TEID)                                                  |
      | update_far.0.update_forwarding_parms.outer_header_creation.ipv4_addr   | save(GTP_DL_IP)                                                    |

    When I send PFCP message PFCP_SESSION_MODIFICATION_RES on interface N4 with the following details from node UPF2 to SMF1:
      | parameter           | value                                      |
      | header.message_type | 53                                         |
      | header.seid         | $(PFCP_HDR_SEID_SMF1_AT_UPF2)              |
      | header.seq_number   | $(PFCP_HDR_SEQ_NO)                         |
      | cause               | {abotprop.SUT.PFCP.RESPOSE.CAUSE.ACCEPTED} |

    Then I receive and validate PFCP message PFCP_SESSION_MODIFICATION_RES on interface N4 with the following details on node SMF1 from UPF2:
      | parameter           | value                                                   |
      | header.message_type | {string:eq}(53)                                         |
      | header.seid         | save(PFCP_HDR_SEID_SMF1_AT_SMF1)                        |
      | header.seq_number   | save(PFCP_HDR_SEQ_NO)                                   |
      | cause               | {string:eq}({abotprop.SUT.PFCP.RESPOSE.CAUSE.ACCEPTED}) |

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





### UL/DL Data Flow

    When I send GTPV1U message GTPV1U_G_PDUS on interface N3 with the following details from node gNodeB1 to UPF2:
      | parameter               | value                                                |
      | type                    | 5g                                                   |
      | qfi                     | 9                                                    |
      | payload.tx.file_to_send | /etc/rebaca-test-suite/conf/gtpv1u/payloads/ping.txt |

    When I send GTPV1U message GTPV1U_G_PDUS on interface N3 with the following details from node UPF2 to gNodeB1:
      | parameter               | value                                                |
      | type                    | 5g                                                   |
      | qfi                     | 9                                                    |
      | payload.tx.file_to_send | /etc/rebaca-test-suite/conf/gtpv1u/payloads/ping.txt |





    Given the execution is paused for {abotprop.WAIT_1_SEC} seconds

##########################################################################################################
### SSC Mode 3 : UE Initiated PDU Session Termination with Anchor UPF1 (Anchor changed to UPF2 from UPF1)
##########################################################################################################

### UE Initiated PDU Session Release Request NAS Message

    When I send NGAP message NG_UPLINK_NAS_UL_NAS_TRANS_PDU_SESS_RELEASE_REQ on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                  | value                                                |
      | amf_ue_ngap_id                                                                                                             | $(AMF_UE_NGAP_ID)                                    |
      | ran_ue_ngap_id                                                                                                             | $(RAN_UE_NGAP_ID)                                    |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                                               | {abotprop.SUT.MCC}                                   |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                                               | {abotprop.SUT.MNC}                                   |
      | user_location_information.nr_user_location_information.tai.tac                                                             | {abotprop.SUT.TAC}                                   |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                                            | {abotprop.SUT.MCC}                                   |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                                            | {abotprop.SUT.MNC}                                   |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                                             | {abotprop.SUT.NR.CELL.IDN}                           |
      | nas_pdu.extended_protocol_discriminator                                                                                    | {abotprop.SUT.NAS.EDP}                               |
      | nas_pdu.security_header_type                                                                                               | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}                    |
      | nas_pdu.message_type                                                                                                       | {abotprop.SUT.NAS.UL.NAS.TRANS.MSG}                  |
      | nas_pdu.ul_nas_transport.pdu_session_identity                                                                              | {abotprop.SUT.NAS.PDU_SESSION_ID6}                   |
      | nas_pdu.ul_nas_transport.request_type                                                                                      | {abotprop.SUT.NAS.PDU_SESSION_REQ_TYPE_EXISTING_PDU} |
      | nas_pdu.ul_nas_transport.snssai                                                                                            | {abotprop.SUT.SUBSCRIBEDNSSAI}                       |
      | nas_pdu.ul_nas_transport.dnn                                                                                               | {abotprop.SUT.DNN1}                                  |
      | nas_pdu.ul_nas_transport.payload_container_type                                                                            | {abotprop.SUT.NAS.PAYLOAD.CONTAINER}                 |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator | {abotprop.SUT.NAS.PDU.SM_EDP}                        |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                  | {abotprop.SUT.PDU.SESS.ID}                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                             | {abotprop.SUT.NAS.PTI}                               |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                    | {abotprop.SUT.NAS.PDU.SESS.RELS.REQ.MSG}             |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_release_req.5gsm_cause | {abotprop.SUT.NAS.PDU_SESSION_REL.5GSM.CAUSE}        |

    Then I receive and validate NGAP message NG_UPLINK_NAS_UL_NAS_TRANS_PDU_SESS_RELEASE_REQ on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                                                  | value                                                             |
      | amf_ue_ngap_id                                                                                                             | {string:eq}($(AMF_UE_NGAP_ID))                                    |
      | ran_ue_ngap_id                                                                                                             | {string:eq}($(RAN_UE_NGAP_ID))                                    |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                                               | {string:eq}({abotprop.SUT.MCC})                                   |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                                               | {string:eq}({abotprop.SUT.MNC})                                   |
      | user_location_information.nr_user_location_information.tai.tac                                                             | {string:eq}({abotprop.SUT.TAC})                                   |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                                            | {string:eq}({abotprop.SUT.MCC})                                   |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                                            | {string:eq}({abotprop.SUT.MNC})                                   |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                                             | {string:eq}({abotprop.SUT.NR.CELL.IDN})                           |
      | nas_pdu.extended_protocol_discriminator                                                                                    | {string:eq}({abotprop.SUT.NAS.EDP})                               |
      | nas_pdu.security_header_type                                                                                               | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.PLAIN})                    |
      | nas_pdu.message_type                                                                                                       | {string:eq}({abotprop.SUT.NAS.UL.NAS.TRANS.MSG})                  |
      | nas_pdu.ul_nas_transport.pdu_session_identity                                                                              | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_ID6})                   |
      | nas_pdu.ul_nas_transport.request_type                                                                                      | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_REQ_TYPE_EXISTING_PDU}) |
      | nas_pdu.ul_nas_transport.snssai                                                                                            | {string:eq}({abotprop.SUT.SUBSCRIBEDNSSAI})                       |
      | nas_pdu.ul_nas_transport.dnn                                                                                               | {string:eq}({abotprop.SUT.DNN1})                                  |
      | nas_pdu.ul_nas_transport.payload_container_type                                                                            | {string:eq}({abotprop.SUT.NAS.PAYLOAD.CONTAINER})                 |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator | {string:eq}({abotprop.SUT.NAS.PDU.SM_EDP})                        |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                  | {string:eq}({abotprop.SUT.PDU.SESS.ID})                           |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                             | {string:eq}({abotprop.SUT.NAS.PTI})                               |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                    | {string:eq}({abotprop.SUT.NAS.PDU.SESS.RELS.REQ.MSG})             |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_release_req.5gsm_cause | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_REL.5GSM.CAUSE})        |

### AMF to SMF Update SM Contect - forward UE NAS Message PDU Session Release Request

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details from node AMF1 to SMF1:
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
      | multipart_related.json_data.sm_context_update_data.s_nssai.sst                                 | {abotprop.SUT.SUBSCRIBEDNSSAI}                                                          |
      | multipart_related.json_data.sm_context_update_data.n1_sm_msg.content_id                        | n1-pdu-session-release-request                                                          |
      | multipart_related.binary_data_n1_sm_message.content_type                                       | application/vnd.3gpp.5gnas                                                              |
      | multipart_related.binary_data_n1_sm_message.content_id                                         | n1-pdu-session-release-request                                                          |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator | {abotprop.SUT.NAS.PDU.SM_EDP}                                                           |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                  | {abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID}                                               |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                             | {abotprop.SUT.NAS.PTI}                                                                  |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                    | {abotprop.SUT.NAS.PDU.SESS.RELS.REQ.MSG}                                                |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_release_req.5gsm_cause | {abotprop.SUT.NAS.PDU_SESSION_REL.5GSM.CAUSE}                                           |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details on node SMF1 from AMF1:
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
      | multipart_related.json_data.sm_context_update_data.s_nssai.sst                                 | {string:eq}({abotprop.SUT.SUBSCRIBEDNSSAI})                                                          |
      | multipart_related.json_data.sm_context_update_data.n1_sm_msg.content_id                        | {string:eq}(n1-pdu-session-release-request)                                                          |
      | multipart_related.binary_data_n1_sm_message.content_type                                       | {string:eq}(application/vnd.3gpp.5gnas)                                                              |
      | multipart_related.binary_data_n1_sm_message.content_id                                         | {string:eq}(n1-pdu-session-release-request)                                                          |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator | {string:eq}({abotprop.SUT.NAS.PDU.SM_EDP})                                                           |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                  | {string:eq}({abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID})                                               |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                             | {string:eq}({abotprop.SUT.NAS.PTI})                                                                  |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                    | {string:eq}({abotprop.SUT.NAS.PDU.SESS.RELS.REQ.MSG})                                                |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_release_req.5gsm_cause | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_REL.5GSM.CAUSE})                                           |

### SMF to UPF - Delete PDU Session and associated resources

    When I send PFCP message PFCP_SESSION_DELETION_REQ on interface N4 with the following details from node SMF1 to UPF1:
      | parameter           | value                 |
      | header.message_type | 54                    |
      | header.seid         | $(PFCP_HDR_FSEID_UPF) |
      | header.seq_number   | incr(3,3)             |

    Then I receive and validate PFCP message PFCP_SESSION_DELETION_REQ on interface N4 with the following details on node UPF1 from SMF1:
      | parameter           | value                    |
      | header.message_type | {string:eq}(54)          |
      | header.seid         | save(PFCP_HDR_FSEID_UPF) |
      | header.seq_number   | save(PFCP_HDR_SEQ_NO)    |

    When I send PFCP message PFCP_SESSION_DELETION_RES on interface N4 with the following details from node UPF1 to SMF1:
      | parameter           | value                                      |
      | header.message_type | 55                                         |
      | header.seid         | $(PFCP_HDR_FSEID_SMF)                      |
      | header.seq_number   | $(PFCP_HDR_SEQ_NO)                         |
      | cause               | {abotprop.SUT.PFCP.RESPOSE.CAUSE.ACCEPTED} |

    Then I receive and validate PFCP message PFCP_SESSION_DELETION_RES on interface N4 with the following details on node SMF1 from UPF1:
      | parameter           | value                                                   |
      | header.message_type | {string:eq}(55)                                         |
      | header.seid         | save(PFCP_HDR_FSEID_SMF)                                |
      | header.seq_number   | save(PFCP_HDR_SEQ_NO)                                   |
      | cause               | {string:eq}({abotprop.SUT.PFCP.RESPOSE.CAUSE.ACCEPTED}) |

### SMF to AMF Update SM Context Reponse - SMF NAS Message (N1) PDU Session Release Command & SMF Ngap IE (N2) SM PDU Session Resource Release Command Transfer

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_200 on interface N11 with the following details from node SMF1 to AMF1:
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
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_command_transfer.cause.nas | {abotprop.SUT.NAS.PDU.REL.CMD.CAUSE}                                                    |
      | multipart_related.binary_data_n1_sm_message.content_type                                                        | application/vnd.3gpp.5gnas                                                              |
      | multipart_related.binary_data_n1_sm_message.content_id                                                          | n1-pdu-session-release-command                                                          |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator                  | {abotprop.SUT.NAS.PDU.SM_EDP}                                                           |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                                   | {abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID}                                               |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                                              | {abotprop.SUT.NAS.PTI}                                                                  |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                                     | {abotprop.SUT.NAS.PDU.SESS.RELS.CMD.MSG}                                                |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_release_cmd.5gsm_cause                  | {abotprop.SUT.NAS.PDU_SESSION_REL.5GSM.CAUSE}                                           |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_200 on interface N11 with the following details on node AMF1 from SMF1:
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
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_command_transfer.cause.nas | {string:eq}({abotprop.SUT.NAS.PDU.REL.CMD.CAUSE})                                                    |
      | multipart_related.binary_data_n1_sm_message.content_type                                                        | {string:eq}(application/vnd.3gpp.5gnas)                                                              |
      | multipart_related.binary_data_n1_sm_message.content_id                                                          | {string:eq}(n1-pdu-session-release-command)                                                          |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator                  | {string:eq}({abotprop.SUT.NAS.PDU.SM_EDP})                                                           |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                                   | {string:eq}({abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID})                                               |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                                              | {string:eq}({abotprop.SUT.NAS.PTI})                                                                  |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                                     | {string:eq}({abotprop.SUT.NAS.PDU.SESS.RELS.CMD.MSG})                                                |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_sess_release_cmd.5gsm_cause                  | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_REL.5GSM.CAUSE})                                           |

### AMF to gNodeB PDU Session Resource Release Command Message - forward SMF NAS Message (N1) PDU Session Release Command & SMF Ngap IE (N2) SM PDU Session Resource Release Command Transfer

    When I send NGAP message NG_PDU_SESS_RESRC_REL_CMD on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                                                                                                  | value                                         |
      | amf_ue_ngap_id                                                                                                             | $(AMF_UE_NGAP_ID)                             |
      | ran_ue_ngap_id                                                                                                             | $(RAN_UE_NGAP_ID)                             |
      | nas_pdu.extended_protocol_discriminator                                                                                    | {abotprop.SUT.NAS.EDP}                        |
      | nas_pdu.security_header_type                                                                                               | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}             |
      | nas_pdu.message_type                                                                                                       | {abotprop.SUT.NAS.DL.NAS.TRANS.MSG}           |
      | nas_pdu.dl_nas_transport.pdu_session_identity                                                                              | {abotprop.SUT.NAS.PDU_SESSION_ID6}            |
      | nas_pdu.dl_nas_transport.payload_container_type                                                                            | {abotprop.SUT.NAS.PAYLOAD.CONTAINER}          |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator | {abotprop.SUT.NAS.PDU.SM_EDP}                 |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                  | {abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID}     |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                             | {abotprop.SUT.NAS.PTI}                        |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                    | {abotprop.SUT.NAS.PDU.SESS.RELS.CMD.MSG}      |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_release_cmd.5gsm_cause | {abotprop.SUT.NAS.PDU_SESSION_REL.5GSM.CAUSE} |
      | pdu_session_resource_to_release_list.0.pdu_session_id                                                                      | {abotprop.SUT.PDU.SESS.ID}                    |
      | pdu_session_resource_to_release_list.0.pdu_session_resource_release_command_transfer.cause.nas                             | {abotprop.SUT.NAS.PDU.REL.CMD.CAUSE}          |

    Then I receive and validate NGAP message NG_PDU_SESS_RESRC_REL_CMD on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                                                                                                  | value                                                      |
      | amf_ue_ngap_id                                                                                                             | {string:eq}($(AMF_UE_NGAP_ID))                             |
      | ran_ue_ngap_id                                                                                                             | {string:eq}($(RAN_UE_NGAP_ID))                             |
      | nas_pdu.extended_protocol_discriminator                                                                                    | {string:eq}({abotprop.SUT.NAS.EDP})                        |
      | nas_pdu.security_header_type                                                                                               | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.PLAIN})             |
      | nas_pdu.message_type                                                                                                       | {string:eq}({abotprop.SUT.NAS.DL.NAS.TRANS.MSG})           |
      | nas_pdu.dl_nas_transport.pdu_session_identity                                                                              | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_ID6})            |
      | nas_pdu.dl_nas_transport.payload_container_type                                                                            | {string:eq}({abotprop.SUT.NAS.PAYLOAD.CONTAINER})          |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator | {string:eq}({abotprop.SUT.NAS.PDU.SM_EDP})                 |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                  | {string:eq}({abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID})     |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                             | {string:eq}({abotprop.SUT.NAS.PTI})                        |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                    | {string:eq}({abotprop.SUT.NAS.PDU.SESS.RELS.CMD.MSG})      |
      | nas_pdu.dl_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_sess_release_cmd.5gsm_cause | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_REL.5GSM.CAUSE}) |
      | pdu_session_resource_to_release_list.0.pdu_session_id                                                                      | {string:eq}({abotprop.SUT.PDU.SESS.ID})                    |
      | pdu_session_resource_to_release_list.0.pdu_session_resource_release_command_transfer.cause.nas                             | {string:eq}({abotprop.SUT.NAS.PDU.REL.CMD.CAUSE})          |

### gNodeB to AMF - N2 Reponse (N2) SM PDU Session Resource Release Response Transfer IE

    When I send NGAP message NG_PDU_SESS_RESRC_REL_RES on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                                                                                                         | value                                |
      | amf_ue_ngap_id                                                                                                                                                                                                    | $(AMF_UE_NGAP_ID)                    |
      | ran_ue_ngap_id                                                                                                                                                                                                    | $(RAN_UE_NGAP_ID)                    |
      | pdu_session_resource_released_list.0.pdu_session_id                                                                                                                                                               | {abotprop.SUT.PDU.SESS.ID}           |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.rat_type                                                                    | 0                                    |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.start_timestamp    | 0x00                                 |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.end_timestamp      | 0x0a                                 |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.usage_count_ul     | 1000                                 |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.usage_count_dl     | 1000                                 |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qfi                                                                    | {abotprop.SUT.AUTO.RSP.PDU.SESS.QFI} |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.rat_type                                                               | 0                                    |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.start_timestamp | 0x00                                 |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.end_timestamp   | 0x0a                                 |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.usage_count_ul  | 1000                                 |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.usage_count_dl  | 1000                                 |

    Then I receive and validate NGAP message NG_PDU_SESS_RESRC_REL_RES on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                                                                                                                                         | value                                             |
      | amf_ue_ngap_id                                                                                                                                                                                                    | {string:eq}($(AMF_UE_NGAP_ID))                    |
      | ran_ue_ngap_id                                                                                                                                                                                                    | {string:eq}($(RAN_UE_NGAP_ID))                    |
      | pdu_session_resource_released_list.0.pdu_session_id                                                                                                                                                               | {abotprop.SUT.PDU.SESS.ID}                        |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.rat_type                                                                    | 0                                                 |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.start_timestamp    | 0x00                                              |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.end_timestamp      | 0x0a                                              |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.usage_count_ul     | 1000                                              |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.pdu_session_usage_report.pdu_session_timed_report_list.volume_timed_report_list.0.usage_count_dl     | 1000                                              |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qfi                                                                    | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.QFI}) |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.rat_type                                                               | 0                                                 |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.start_timestamp | 0x00                                              |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.end_timestamp   | 0x0a                                              |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.usage_count_ul  | 1000                                              |
      | pdu_session_resource_released_list.0.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.usage_count_dl  | 1000                                              |

### AMF to SMF Update SM Context Message - forward gNodebB NGAP IE PDU Session Resource Release Response Transfer (N2 IE)

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details from node AMF1 to SMF1:
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
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qfi                                                                    | {abotprop.SUT.AUTO.RSP.PDU.SESS.QFI}                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.rat_type                                                               | 0                                                                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.start_timestamp | 0x00                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.end_timestamp   | 0x0a                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.usage_count_ul  | 1000                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.usage_count_dl  | 1000                                                                                    |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details on node SMF1 from AMF1:
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
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qfi                                                                    | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.QFI})                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.rat_type                                                               | {string:eq}(0)                                                                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.start_timestamp | {string:eq}(0x00)                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.end_timestamp   | {string:eq}(0x0a)                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.usage_count_ul  | {string:eq}(1000)                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_release_response_transfer.secondary_rat_usage_info.qos_flows_usage_report_list.0.qos_flows_timed_report_list.volume_timed_report_list.0.usage_count_dl  | {string:eq}(1000)                                                                                    |

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_204 on interface N11 with the following details from node SMF1 to AMF1:
      | parameter          | value   |
      | header.nva.0.name  | :status |
      | header.nva.0.value | 204     |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_204 on interface N11 with the following details on node AMF1 from SMF1:
      | parameter          | value                |
      | header.nva.0.name  | {string:eq}(:status) |
      | header.nva.0.value | {string:eq}(204)     |

### gNodeB to AMF - PDU Session Resource Release Complete (N1 NAS PDU)

    When I send NGAP message NG_UPLINK_NAS_UL_NAS_TRANS_PDU_SESS_RELEASE_COMPL on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                  | value                                                |
      | amf_ue_ngap_id                                                                                                             | $(AMF_UE_NGAP_ID)                                    |
      | ran_ue_ngap_id                                                                                                             | $(RAN_UE_NGAP_ID)                                    |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                                               | {abotprop.SUT.MCC}                                   |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                                               | {abotprop.SUT.MNC}                                   |
      | user_location_information.nr_user_location_information.tai.tac                                                             | {abotprop.SUT.TAC}                                   |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                                            | {abotprop.SUT.MCC}                                   |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                                            | {abotprop.SUT.MNC}                                   |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                                             | {abotprop.SUT.NR.CELL.IDN}                           |
      | nas_pdu.extended_protocol_discriminator                                                                                    | {abotprop.SUT.NAS.EDP}                               |
      | nas_pdu.security_header_type                                                                                               | {abotprop.SUT.NAS.SEC.HEAD.PLAIN}                    |
      | nas_pdu.message_type                                                                                                       | {abotprop.SUT.NAS.UL.NAS.TRANS.MSG}                  |
      | nas_pdu.ul_nas_transport.pdu_session_identity                                                                              | {abotprop.SUT.NAS.PDU_SESSION_ID6}                   |
      | nas_pdu.ul_nas_transport.request_type                                                                                      | {abotprop.SUT.NAS.PDU_SESSION_REQ_TYPE_EXISTING_PDU} |
      | nas_pdu.ul_nas_transport.snssai                                                                                            | {abotprop.SUT.SUBSCRIBEDNSSAI}                       |
      | nas_pdu.ul_nas_transport.dnn                                                                                               | {abotprop.SUT.DNN1}                                  |
      | nas_pdu.ul_nas_transport.payload_container_type                                                                            | {abotprop.SUT.NAS.PAYLOAD.CONTAINER}                 |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator | {abotprop.SUT.NAS.PDU.SM_EDP}                        |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                  | {abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID}            |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                             | {abotprop.SUT.NAS.PTI}                               |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                    | {abotprop.SUT.NAS.PDU.SESS.RELS.COM.MSG}             |

    Then I receive and validate NGAP message NG_UPLINK_NAS_UL_NAS_TRANS_PDU_SESS_RELEASE_COMPL on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                                                  | value                                                             |
      | amf_ue_ngap_id                                                                                                             | {string:eq}($(AMF_UE_NGAP_ID))                                    |
      | ran_ue_ngap_id                                                                                                             | {string:eq}($(RAN_UE_NGAP_ID))                                    |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc                                               | {string:eq}({abotprop.SUT.MCC})                                   |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc                                               | {string:eq}({abotprop.SUT.MNC})                                   |
      | user_location_information.nr_user_location_information.tai.tac                                                             | {string:eq}({abotprop.SUT.TAC})                                   |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc                                            | {string:eq}({abotprop.SUT.MCC})                                   |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc                                            | {string:eq}({abotprop.SUT.MNC})                                   |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity                                             | {string:eq}({abotprop.SUT.NR.CELL.IDN})                           |
      | nas_pdu.extended_protocol_discriminator                                                                                    | {string:eq}({abotprop.SUT.NAS.EDP})                               |
      | nas_pdu.security_header_type                                                                                               | {string:eq}({abotprop.SUT.NAS.SEC.HEAD.PLAIN})                    |
      | nas_pdu.message_type                                                                                                       | {string:eq}({abotprop.SUT.NAS.UL.NAS.TRANS.MSG})                  |
      | nas_pdu.ul_nas_transport.pdu_session_identity                                                                              | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_ID6})                   |
      | nas_pdu.ul_nas_transport.request_type                                                                                      | {string:eq}({abotprop.SUT.NAS.PDU_SESSION_REQ_TYPE_EXISTING_PDU}) |
      | nas_pdu.ul_nas_transport.snssai                                                                                            | {string:eq}({abotprop.SUT.SUBSCRIBEDNSSAI})                       |
      | nas_pdu.ul_nas_transport.dnn                                                                                               | {string:eq}({abotprop.SUT.DNN1})                                  |
      | nas_pdu.ul_nas_transport.payload_container_type                                                                            | {string:eq}({abotprop.SUT.NAS.PAYLOAD.CONTAINER})                 |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.extended_protocol_discriminator | {string:eq}({abotprop.SUT.NAS.PDU.SM_EDP})                        |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pdu_session_id                  | {string:eq}({abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID})            |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.pti                             | {string:eq}({abotprop.SUT.NAS.PTI})                               |
      | nas_pdu.ul_nas_transport.payload_container_entry_list.0.payload_container_entry.n1_sm_info.message_type                    | {string:eq}({abotprop.SUT.NAS.PDU.SESS.RELS.COM.MSG})             |

### AMF to SMF Update SM Contect - forward UE NAS Message PDU Session Release Complete (N1 NAS)

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details from node AMF1 to SMF1:
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
      | multipart_related.json_data.sm_context_update_data.s_nssai.sst                                 | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}                                              |
      | multipart_related.json_data.sm_context_update_data.n1_sm_msg.content_id                        | n1-pdu-session-release-complete                                                         |
      | multipart_related.binary_data_n1_sm_message.content_type                                       | application/vnd.3gpp.5gnas                                                              |
      | multipart_related.binary_data_n1_sm_message.content_id                                         | n1-pdu-session-release-complete                                                         |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator | {abotprop.SUT.NAS.PDU.SM_EDP}                                                           |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                  | {abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID}                                               |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                             | {abotprop.SUT.NAS.PTI}                                                                  |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                    | {abotprop.SUT.NAS.PDU.SESS.RELS.COM.MSG}                                                |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_REQ on interface N11 with the following details on node SMF1 from AMF1:
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
      | multipart_related.json_data.sm_context_update_data.s_nssai.sst                                 | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB})                                              |
      | multipart_related.json_data.sm_context_update_data.n1_sm_msg.content_id                        | {string:eq}(n1-pdu-session-release-complete)                                                         |
      | multipart_related.binary_data_n1_sm_message.content_type                                       | {string:eq}(application/vnd.3gpp.5gnas)                                                              |
      | multipart_related.binary_data_n1_sm_message.content_id                                         | {string:eq}(n1-pdu-session-release-complete)                                                         |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.extended_protocol_discriminator | {string:eq}({abotprop.SUT.NAS.PDU.SM_EDP})                                                           |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pdu_session_id                  | {string:eq}({abotprop.SUT.NAS.SM_INFO.PDU.SESSION.ID})                                               |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.pti                             | {string:eq}({abotprop.SUT.NAS.PTI})                                                                  |
      | multipart_related.binary_data_n1_sm_message.content.n1_sm_info.message_type                    | {string:eq}({abotprop.SUT.NAS.PDU.SESS.RELS.COM.MSG})                                                |

    When I send HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_204 on interface N11 with the following details from node SMF1 to AMF1:
      | parameter          | value   |
      | header.nva.0.name  | :status |
      | header.nva.0.value | 204     |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_UPDATE_SM_CONTEXT_RES_204 on interface N11 with the following details on node AMF1 from SMF1:
      | parameter          | value                |
      | header.nva.0.name  | {string:eq}(:status) |
      | header.nva.0.value | {string:eq}(204)     |


### SMF to AMF - Notify SM Context Released Status

    When I send HTTPV2 message HTTPV2_NSMF_NOTIFY_SM_CONTEXT_STATUS_REQ on interface N11 with the following details from node SMF1 to AMF1:
      | parameter                                                  | value                        |
      | header.nva.0.name                                          | :method                      |
      | header.nva.0.value                                         | POST                         |
      | header.nva.1.name                                          | :path                        |
      | header.nva.1.value                                         | $(SM_CTXT_STATUS_URI_AT_SMF) |
      | header.nva.2.name                                          | content-type                 |
      | header.nva.2.value                                         | application/json             |
      | sm_context_status_notification.status_info.resource_status | RELEASED                     |
      | sm_context_status_notification.status_info.cause           | INSUFFICIENT_UP_RESOURCES    |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_NOTIFY_SM_CONTEXT_STATUS_REQ on interface N11 with the following details on node AMF1 from SMF1:
      | parameter                                                  | value                                  |
      | header.nva.0.name                                          | {string:eq}(:method)                   |
      | header.nva.0.value                                         | {string:eq}(POST)                      |
      | header.nva.1.name                                          | {string:eq}(:path)                     |
      | header.nva.1.value                                         | save(SM_CTXT_STATUS_URI_HDR_AT_AMF)    |
      | header.nva.2.name                                          | {string:eq}(content-type)              |
      | header.nva.2.value                                         | {string:eq}(application/json)          |
      | sm_context_status_notification.status_info.resource_status | {string:eq}(RELEASED)                  |
      | sm_context_status_notification.status_info.cause           | {string:eq}(INSUFFICIENT_UP_RESOURCES) |

    When I send HTTPV2 message HTTPV2_NSMF_NOTIFY_SM_CONTEXT_STATUS_RES_204 on interface N11 with the following details from node AMF1 to SMF1:
      | parameter          | value   |
      | header.nva.0.name  | :status |
      | header.nva.0.value | 204     |

    Then I receive and validate HTTPV2 message HTTPV2_NSMF_NOTIFY_SM_CONTEXT_STATUS_RES_204 on interface N11 with the following details on node SMF1 from AMF1:
      | parameter          | value                |
      | header.nva.0.name  | {string:eq}(:status) |
      | header.nva.0.value | {string:eq}(204)     |


### SMF to PCF - SM Policy Delete for deleting PDU Session Policy at PCF

    When I send HTTPV2 message HTTPV2_NPCFSM_POLICY_CONTROL_DELETE_POST_REQ on interface N7 with the following details from node SMF1 to PCF1:
      | parameter                                                                | value                                                              |
      | header.nva.0.name                                                        | :method                                                            |
      | header.nva.0.value                                                       | POST                                                               |
      | header.nva.1.name                                                        | :path                                                              |
      | header.nva.1.value                                                       | /127.0.0.1:12348/npcf-smpolicycontrol/v1/sm-policies/smPol1/delete |
      | sm_policy_delete_data.ran_nas_rel_causes.0.ran_nas_rel_cause.5g_sm_cause | 36                                                                 |
      

    Then I receive and validate HTTPV2 message HTTPV2_NPCFSM_POLICY_CONTROL_DELETE_POST_REQ on interface N7 with the following details on node PCF1 from SMF1:
      | parameter                                                                | value                                                                           |
      | header.nva.0.name                                                        | {string:eq}(:method)                                                            |
      | header.nva.0.value                                                       | {string:eq}(POST)                                                               |
      | header.nva.1.name                                                        | {string:eq}(:path)                                                              |
      | header.nva.1.value                                                       | {string:eq}(/127.0.0.1:12348/npcf-smpolicycontrol/v1/sm-policies/smPol1/delete) |
      | sm_policy_delete_data.ran_nas_rel_causes.0.ran_nas_rel_cause.5g_sm_cause | {string:eq}(36)                                                                 |

    When I send HTTPV2 message HTTPV2_NPCFSM_POLICY_CONTROL_DELETE_POST_RES_204 on interface N7 with the following details from node PCF1 to SMF1:
      | parameter          | value   |
      | header.nva.0.name  | :status |
      | header.nva.0.value | 204     |

    Then I receive and validate HTTPV2 message HTTPV2_NPCFSM_POLICY_CONTROL_DELETE_POST_RES_204 on interface N7 with the following details on node SMF1 from PCF1:
      | parameter          | value                |
      | header.nva.0.name  | {string:eq}(:status) |
      | header.nva.0.value | {string:eq}(204)     |
### SMF to UDM UECM Deregistration of PDU Session

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
