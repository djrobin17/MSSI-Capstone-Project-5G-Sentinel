@dependency-xn-ho-5gs-initialreg5gaka-pdusess-bidirectional-video

Feature: UE 5GS Initial Registration, PDU Session, Data Flow

  Scenario: UE 5GS Initial Registration with 5G AKA Authentication, Single PDU Session Establishment, Bidirectional Data flow, Dependency for XN HO

    Given the test data is in file /featureFiles/MESSAGE_BUNDLES/EPC_MESSAGES.xml

    Given all configured endpoints for EPC are connected successfully

    Given that I execute dependency feature /featureFiles/3GPP-23502-5G/02_Registration_Management_Procedures/5GS_UE_Initial_Registration_With_5G_AKA_Authentication.feature

# NG-Setup procedure with gNodeB2
    When I send NGAP message NG_SETUP_REQ on interface N1-N2 with the following details from node gNodeB2 to AMF1:
      | parameter                                                                         | value                                      |
      | global_ran_node_id.global_gnb_id.plmn_identity.mcc                                | {abotprop.SUT.MCC}                         |
      | global_ran_node_id.global_gnb_id.plmn_identity.mnc                                | {abotprop.SUT.MNC}                         |
      | global_ran_node_id.global_gnb_id.gnb_id                                           | {abotprop.SUT.GLOBAL.GNB2.ID}              |
      | supported_ta_list.0.tac                                                           | {abotprop.SUT.TAC}                         |
      | supported_ta_list.0.broadcast_plmns.0.plmn_identity.mcc                           | {abotprop.SUT.MCC}                         |
      | supported_ta_list.0.broadcast_plmns.0.plmn_identity.mnc                           | {abotprop.SUT.MNC}                         |
      | supported_ta_list.0.broadcast_plmns.0.slice_support_list.slice_support_item.0.sst | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB} |
      | paging_drx                                                                        | {abotprop.SUT.PAGING.DRX}                  |

    Then I receive and validate NGAP message NG_SETUP_REQ on interface N1-N2 with the following details on node AMF1 from gNodeB2:
      | parameter                                                                         | value                                                   |
      | global_ran_node_id.global_gnb_id.plmn_identity.mcc                                | {string:eq}({abotprop.SUT.MCC})                         |
      | global_ran_node_id.global_gnb_id.plmn_identity.mnc                                | {string:eq}({abotprop.SUT.MNC})                         |
      | global_ran_node_id.global_gnb_id.gnb_id                                           | {string:eq}({abotprop.SUT.GLOBAL.GNB2.ID})              |
      | supported_ta_list.0.tac                                                           | {string:eq}({abotprop.SUT.TAC})                         |
      | supported_ta_list.0.broadcast_plmns.0.plmn_identity.mcc                           | {string:eq}({abotprop.SUT.MCC})                         |
      | supported_ta_list.0.broadcast_plmns.0.plmn_identity.mnc                           | {string:eq}({abotprop.SUT.MNC})                         |
      | supported_ta_list.0.broadcast_plmns.0.slice_support_list.slice_support_item.0.sst | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}) |
      | paging_drx                                                                        | {string:eq}({abotprop.SUT.PAGING.DRX})                  |

    When I send NGAP message NG_SETUP_RES on interface N1-N2 with the following details from node AMF1 to gNodeB2:
      | parameter                                                       | value                                      |
      | amf_name                                                        | {abotprop.SUT.AMF.NAME}                    |
      | served_guami_list.0.guami.plmn_identity.mcc                     | {abotprop.SUT.MCC}                         |
      | served_guami_list.0.guami.plmn_identity.mnc                     | {abotprop.SUT.MNC}                         |
      | served_guami_list.0.guami.amf_region_id                         | {abotprop.SUT.GUAMI.AMF.REGION.ID}         |
      | served_guami_list.0.guami.amf_set_id                            | {abotprop.SUT.GUAMI.AMF.SET.ID}            |
      | served_guami_list.0.guami.pointer.amf_pointer                   | {abotprop.SUT.GUAMI.AMF.POINTER}           |
      | relative_amf_capacity                                           | {abotprop.SUT.RELATIVE.MME.CAPACITY}       |
      | plmn_support_list.0.plmn_identity.mcc                           | {abotprop.SUT.MCC}                         |
      | plmn_support_list.0.plmn_identity.mnc                           | {abotprop.SUT.MNC}                         |
      | plmn_support_list.0.slice_support_list.slice_support_item.0.sst | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB} |

    Then I receive and validate NGAP message NG_SETUP_RES on interface N1-N2 with the following details on node gNodeB2 from AMF1:
      | parameter                                                       | value                                                   |
      | amf_name                                                        | {string:eq}({abotprop.SUT.AMF.NAME})                    |
      | served_guami_list.0.guami.plmn_identity.mcc                     | {string:eq}({abotprop.SUT.MCC})                         |
      | served_guami_list.0.guami.plmn_identity.mnc                     | {string:eq}({abotprop.SUT.MNC})                         |
      | served_guami_list.0.guami.amf_region_id                         | {string:eq}({abotprop.SUT.GUAMI.AMF.REGION.ID})         |
      | served_guami_list.0.guami.amf_set_id                            | {string:eq}({abotprop.SUT.GUAMI.AMF.SET.ID})            |
      | served_guami_list.0.guami.pointer.amf_pointer                   | {string:eq}({abotprop.SUT.GUAMI.AMF.POINTER})           |
      | relative_amf_capacity                                           | {string:eq}({abotprop.SUT.RELATIVE.MME.CAPACITY})       |
      | plmn_support_list.0.plmn_identity.mcc                           | {string:eq}({abotprop.SUT.MCC})                         |
      | plmn_support_list.0.plmn_identity.mnc                           | {string:eq}({abotprop.SUT.MNC})                         |
      | plmn_support_list.0.slice_support_list.slice_support_item.0.sst | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}) |

# PFCP Association with UPF1

    When I send PFCP message PFCP_ASSOCIATION_SETUP_REQ on interface N4 with the following details from node SMF1 to UPF1:
      | parameter            | value                                               |
      | header.message_type  | {abotprop.SUT.PFCP.HEADER.MSG.TYPE.ASSOCIATION.REQ} |
      | header.seq_number    | incr(1,3)                                           |
      | node_id.type         | {abotprop.SUT.PFCP_NODE_ID_TYPE}                    |
      | node_id.value        | $({abotprop.SMF1.SecureShell.IPAddress})            |
      | cp_function_features | {abotprop.SUT.CP_FUNC_FEATURES}                     |
      | recovery_timestamp   | {abotprop.SUT.PFCP_RECOVERY_TIMESTAMP}              |

    Then I receive and validate PFCP message PFCP_ASSOCIATION_SETUP_REQ on interface N4 with the following details on node UPF1 from SMF1:
      | parameter            | value                                                            |
      | header.message_type  | {string:eq}({abotprop.SUT.PFCP.HEADER.MSG.TYPE.ASSOCIATION.REQ}) |
      | header.seq_number    | save(PFCP_HDR_SEQ_NO)                                            |
      | node_id.type         | {string:eq}({abotprop.SUT.PFCP_NODE_ID_TYPE})                    |
      | node_id.value        | {string:eq}($({abotprop.SMF1.SecureShell.IPAddress}))            |
      | cp_function_features | save(CP_FUNC_FEATURES)                                           |
      | recovery_timestamp   | save(CP_RECOVERY_TIMESTAMP)                                      |

    When I send PFCP message PFCP_ASSOCIATION_SETUP_RES on interface N4 with the following details from node UPF1 to SMF1:
      | parameter            | value                                               |
      | header.message_type  | {abotprop.SUT.PFCP.HEADER.MSG.TYPE.ASSOCIATION.RES} |
      | header.seq_number    | $(PFCP_HDR_SEQ_NO)                                  |
      | node_id.type         | {abotprop.SUT.PFCP_NODE_ID_TYPE}                    |
      | node_id.value        | $({abotprop.UPF1.SecureShell.IPAddress})            |
      | up_function_features | {abotprop.SUT.PFCP_UP_FUNC_FEATURES}                |
      | cause                | {abotprop.SUT.PFCP_REQUEST_ACCEPTED}                |
      | recovery_timestamp   | {abotprop.SUT.PFCP_RECOVERY_TIMESTAMP}              |

    Then I receive and validate PFCP message PFCP_ASSOCIATION_SETUP_RES on interface N4 with the following details on node SMF1 from UPF1:
      | parameter            | value                                                            |
      | header.message_type  | {string:eq}({abotprop.SUT.PFCP.HEADER.MSG.TYPE.ASSOCIATION.RES}) |
      | header.seq_number    | save(PFCP_HDR_SEQ_NO)                                            |
      | node_id.type         | {string:eq}({abotprop.SUT.PFCP_NODE_ID_TYPE})                    |
      | node_id.value        | {string:eq}($({abotprop.UPF1.SecureShell.IPAddress}))            |
      | up_function_features | save(UP_FUNC_FEATURES)                                           |
      | cause                | {string:eq}({abotprop.SUT.PFCP_REQUEST_ACCEPTED})                |
      | recovery_timestamp   | save(UP_RECOVERY_TIMESTAMP)                                      |

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
      | parameter            | value                                       |
      | header.message_type  | {abotprop.SUT.PFCP.HEADER.MSG.TYPE.EST.RES} |
      | header.seid          | $(PFCP_HDR_FSEID_SMF)                       |
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
      | header.seid          | save(PFCP_HDR_FSEID_SMF)                                 |
      | header.seq_number    | save(PFCP_HDR_SEQ_NO)                                    |
      | node_id.type         | {string:eq}({abotprop.SUT.PFCP_NODE_ID_TYPE})            |
      | node_id.value        | save(PFCP_NODE_IP_UPF)                                   |
      | cause                | {string:eq}({abotprop.SUT.PFCP.RESPOSE.CAUSE.ACCEPTED})  |
      | up_f_seid.flag       | {string:eq}({abotprop.SUT.PFCP.UP.F-SEID.FLAG})          |
      | up_f_seid.seid       | save(PFCP_HDR_FSEID_UPF)                                 |
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
      | header.message_type                                                    | {string:eq}({abotprop.SUT.PFCP.HEADER.MSG.TYPE.MOD.REQ})           |
      | header.seid                                                            | save(PFCP_HDR_FSEID_UPF)                                           |
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
      | header.seid         | $(PFCP_HDR_FSEID_SMF)                       |
      | header.seq_number   | $(PFCP_HDR_SEQ_NO)                          |
      | cause               | {abotprop.SUT.PFCP.RESPOSE.CAUSE.ACCEPTED}  |

    Then I receive and validate PFCP message PFCP_SESSION_MODIFICATION_RES on interface N4 with the following details on node SMF1 from UPF1:
      | parameter           | value                                                    |
      | header.message_type | {string:eq}({abotprop.SUT.PFCP.HEADER.MSG.TYPE.MOD.RES}) |
      | header.seid         | save(PFCP_HDR_FSEID_SMF)                                 |
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