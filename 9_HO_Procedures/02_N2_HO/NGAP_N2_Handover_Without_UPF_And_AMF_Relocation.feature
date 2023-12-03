@ngap-n2-handover-without-upf-and-amf-relocation @ngap-n2-handover @ngap-messages @all-messages @5g-core @5g-core-sanity

Feature: NGAP N2 Handover

  Scenario: NG N2 Handover scenario testing

    Given the test data is in file /featureFiles/MESSAGE_BUNDLES/EPC_MESSAGES.xml

    Given all configured endpoints for EPC are connected successfully

    Given that I execute dependency feature /featureFiles/3GPP-23502-5G/11_HO_Procedures/02_N2_HO/NGAP_N2_HO_Without_UPF_And_AMF_Rel_Dependency.feature
    
# N2 Ho Procedure
    When I send NGAP message NG_HANDOVER_REQUIRED on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                    | value                                                                          |
      | amf_ue_ngap_id                                                                                               | $(AMF_UE_NGAP_ID)                                                              |
      | ran_ue_ngap_id                                                                                               | $(RAN_UE_NGAP_ID)                                                              |
      | handover_type                                                                                                | {abotprop.SUT.HO.TYPE.INTRA5GS}                                                |
      | cause.transport                                                                                              | 0                                                                              |
      | target_id.ng_ran.global_ran_node_id.global_gnb_id.plmn_identity.mcc                                          | {abotprop.SUT.MCC}                                                             |
      | target_id.ng_ran.global_ran_node_id.global_gnb_id.plmn_identity.mnc                                          | {abotprop.SUT.MNC}                                                             |
      | target_id.ng_ran.global_ran_node_id.global_gnb_id.gnb_id                                                     | {abotprop.SUT.GLOBAL.GNB2.ID}                                                  |
      | target_id.ng_ran.tai.plmn_identity.mcc                                                                       | {abotprop.SUT.MCC}                                                             |
      | target_id.ng_ran.tai.plmn_identity.mnc                                                                       | {abotprop.SUT.MNC}                                                             |
      | target_id.ng_ran.tai.tac                                                                                     | {abotprop.SUT.HANDOVER.TARGET.TAC}                                             |
      | source_to_target_transparent_container                                                                       | 60040003900000400100090000004800050009f1070000035840000109f1070000035840000130 |
      | pdu_session_resource_setup_ho_required_list.0.pdu_session_id                                                 | {abotprop.SUT.PDU.SESS.ID}                                                     |
      | pdu_session_resource_setup_ho_required_list.0.handover_required_transfer.direct_forwarding_path_availability | {abotprop.SUT.PDU_SESS_HO_REQUIRED.DIRECT_FORWD_PATH_AVAIL}                    |
      
    Then I receive and validate NGAP message NG_HANDOVER_REQUIRED on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                                    | value                                                                    |
      | amf_ue_ngap_id                                                                                               | {string:eq}($(AMF_UE_NGAP_ID))                                           |
      | ran_ue_ngap_id                                                                                               | {string:eq}($(RAN_UE_NGAP_ID))                                           |
      | handover_type                                                                                                | save(HO_TYPE)                                                            |
      | cause.transport                                                                                              | save(CAUSE_VALUE)                                                        |
      | target_id.ng_ran.global_ran_node_id.global_gnb_id.plmn_identity.mcc                                          | {string:eq}({abotprop.SUT.MCC})                                          |
      | target_id.ng_ran.global_ran_node_id.global_gnb_id.plmn_identity.mnc                                          | {string:eq}({abotprop.SUT.MNC})                                          |
      | target_id.ng_ran.global_ran_node_id.global_gnb_id.gnb_id                                                     | {string:eq}({abotprop.SUT.GLOBAL.GNB2.ID})                               |
      | target_id.ng_ran.tai.plmn_identity.mcc                                                                       | {string:eq}({abotprop.SUT.MCC})                                          |
      | target_id.ng_ran.tai.plmn_identity.mnc                                                                       | {string:eq}({abotprop.SUT.MNC})                                          |
      | target_id.ng_ran.tai.tac                                                                                     | {string:eq}({abotprop.SUT.HANDOVER.TARGET.TAC})                          |
      | source_to_target_transparent_container                                                                       | save(SRC_TO_TRGT_TRANS_CONTAINER)                                        |
      | pdu_session_resource_setup_ho_required_list.0.pdu_session_id                                                 | {string:eq}({abotprop.SUT.PDU.SESS.ID})                                  |
      | pdu_session_resource_setup_ho_required_list.0.handover_required_transfer.direct_forwarding_path_availability | {string:eq}({abotprop.SUT.PDU_SESS_HO_REQUIRED.DIRECT_FORWD_PATH_AVAIL}) |

    When I send NGAP message NG_HANDOVER_REQ on interface N1-N2 with the following details from node AMF1 to gNodeB2:
      | parameter                                                                                                                                                                                                       | value                                                        |
      | amf_ue_ngap_id                                                                                                                                                                                                  | incr(1234,1)                                                 |
      | handover_type                                                                                                                                                                                                   | $(HO_TYPE)                                                   |
      | cause.transport                                                                                                                                                                                                 | $(CAUSE_VALUE)                                               |
      | ue_security_capabilities.nr_encryption_algo                                                                                                                                                                     | {abotprop.SUT.NR.ENCRYPTION.ALGO}                            |
      | ue_security_capabilities.nr_integrity_protection_algo                                                                                                                                                           | {abotprop.SUT.NR.INT.PROTECT.ALGO}                           |
      | ue_security_capabilities.e_utra_encryption_algo                                                                                                                                                                 | {abotprop.SUT.EUTRA.ENCRYPTION.ALGO}                         |
      | ue_security_capabilities.e_utra_integrity_protection_algo                                                                                                                                                       | {abotprop.SUT.EUTRA.INT.PROTECT.ALGO}                       |
      | security_context.next_hop_chaining_count                                                                                                                                                                        | 2                                                            |
      | security_context.next_hop_nh.security_key                                                                                                                                                                       | {abotprop.SUT.NH.SECURITY.KEY}                               |
      | ue_ambr.dl.bit_rate                                                                                                                                                                                             | {abotprop.SUT.UE.AMBR.DL}                                    |
      | ue_ambr.ul.bit_rate                                                                                                                                                                                             | {abotprop.SUT.UE.AMBR.UL}                                    |
      | pdu_session_resource_setup_ho_req_list.0.pdu_session_id                                                                                                                                                         | {abotprop.SUT.PDU.SESS.ID}                                   |
      | pdu_session_resource_setup_ho_req_list.0.s-nssai.sst                                                                                                                                                            | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST}                        |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate                 | {abotprop.SUT.AGGR.MAX.BIT.RATE.DL}                          |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate                 | {abotprop.SUT.AGGR.MAX.BIT.RATE.UL}                          |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                      | $(GTP_UL_IP_UPF)                                             |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                     | $(GTP_UL_TEID_UPF)                                           |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                                 | {abotprop.SUT.NAS.N2-PDU-SETUP-REQ-TRANSFR.PDU_SESSION_TYPE} |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                                    | {abotprop.SUT.AUTO.RSP.PDU.SESS.QFI}                         |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi         | {abotprop.SUT.AUTO.RSP.PDU.SESS.5QI}                         |
      #| pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.priority_level | {abotprop.SUT.QOS.5QI.PRIORITY}                              |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                                 | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PRIORITY.LEVEL}          |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                             | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.CAPABILITY}      |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                          | {abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.VULNERABILITY}   |
      | allowed_s-nssai_list.0.sst                                                                                                                                                                                      | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST}                        |
      | source_to_target_transparent_container                                                                                                                                                                          | $(SRC_TO_TRGT_TRANS_CONTAINER)                               |
      | guami.plmn_identity.mcc                                                                                                                                                                                         | {abotprop.SUT.MCC}                                           |
      | guami.plmn_identity.mnc                                                                                                                                                                                         | {abotprop.SUT.MNC}                                           |
      | guami.amf_region_id                                                                                                                                                                                             | {abotprop.SUT.GUAMI.AMF.REGION.ID}                           |
      | guami.amf_set_id                                                                                                                                                                                                | {abotprop.SUT.GUAMI.AMF.SET.ID}                              |
      | guami.pointer.amf_pointer                                                                                                                                                                                       | {abotprop.SUT.GUAMI.AMF.POINTER}                             |
        
    Then I receive and validate NGAP message NG_HANDOVER_REQ on interface N1-N2 with the following details on node gNodeB2 from AMF1:
      | parameter                                                                                                                                                                                                       | value                                                                     |
      | amf_ue_ngap_id                                                                                                                                                                                                  | save(AMF_UE_NGAP_ID_2)                                                    |
      | handover_type                                                                                                                                                                                                   | save(HO_TYPE)                                                             |
      | cause.transport                                                                                                                                                                                                 | save(CAUSE_VALUE)                                                         |
      | ue_security_capabilities.nr_encryption_algo                                                                                                                                                                     | save(UE_SEC_CAP_NR_ENCRYP_ALGO)                                           |
      | ue_security_capabilities.nr_integrity_protection_algo                                                                                                                                                           | save(UE_SEC_CAP_NR_INTE_PROTEC_ALGO)                                      |
      | ue_security_capabilities.e_utra_encryption_algo                                                                                                                                                                 | save(UE_SEC_CAP_EUTRA_ENCRYP_ALGO)                                        |
      | ue_security_capabilities.e_utra_integrity_protection_algo                                                                                                                                                       | save(UE_SEC_CAP_EUTRA_INTE_PROTEC_ALGO)                                   |
      | security_context.next_hop_chaining_count                                                                                                                                                                        | {string:eq}(2)                                                            |
      | security_context.next_hop_nh.security_key                                                                                                                                                                       | {string:eq}({abotprop.SUT.NH.SECURITY.KEY})                               |
      | ue_ambr.dl.bit_rate                                                                                                                                                                                             | save(UE_AMBR_DL_BIT_RATE)                                                 |
      | ue_ambr.ul.bit_rate                                                                                                                                                                                             | save(UE_AMBR_UL_BIT_RATE)                                                 |
      | pdu_session_resource_setup_ho_req_list.0.pdu_session_id                                                                                                                                                         | {string:eq}({abotprop.SUT.PDU.SESS.ID})                                   |
      | pdu_session_resource_setup_ho_req_list.0.s-nssai.sst                                                                                                                                                            | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST})                        |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_dl.bit_rate                 | {string:eq}({abotprop.SUT.AGGR.MAX.BIT.RATE.DL})                          |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.pdu_session_aggregate_maximum_bit_rate.pdu_session_aggr_max_bit_rate_ul.bit_rate                 | {string:eq}({abotprop.SUT.AGGR.MAX.BIT.RATE.UL})                          |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.transport_layer_address                                      | save(GTP_UL_IP_UPF)                                                       |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.ul_ng_up_tnl_information.gtp_tunnel.gtp_teid                                                     | save(GTP_UL_TEID_UPF)                                                     |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.pdu_session_type                                                                                 | {string:eq}({abotprop.SUT.NAS.N2-PDU-SETUP-REQ-TRANSFR.PDU_SESSION_TYPE}) |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qfi                                                                    | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.QFI})                         |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.fiveqi         | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.5QI})                         |
      #| pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.qos_characteristics.nondynamic_5qi_desc.priority_level | {string:eq}({abotprop.SUT.QOS.5QI.PRIORITY})                              |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.priority_level_arp                                 | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PRIORITY.LEVEL})          |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_capability                             | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.CAPABILITY})      |
      | pdu_session_resource_setup_ho_req_list.0.handover_request_transfer.pdu_session_resource_setup_request_transfer.qos_flow_setup_req_list.0.qos_flow_params.arp.pre_emption_vulnerability                          | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.ARP.PREEMPT.VULNERABILITY})   |
      | allowed_s-nssai_list.0.sst                                                                                                                                                                                      | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST})                        |
      | source_to_target_transparent_container                                                                                                                                                                          | save(SRC_TO_TRGT_TRANS_CONTAINER)                                         |
      | guami.plmn_identity.mcc                                                                                                                                                                                         | {string:eq}({abotprop.SUT.MCC})                                           |
      | guami.plmn_identity.mnc                                                                                                                                                                                         | {string:eq}({abotprop.SUT.MNC})                                           |
      | guami.amf_region_id                                                                                                                                                                                             | save(GUAMI_AMF_REGION_ID_2)                                               |
      | guami.amf_set_id                                                                                                                                                                                                | save(GUAMI_AMF_SET_ID_2)                                                  |
      | guami.pointer.amf_pointer                                                                                                                                                                                       | save(GUAMI_AMF_POINTER_2)                                                 |
    
    When I send NGAP message NG_HANDOVER_REQ_ACK on interface N1-N2 with the following details from node gNodeB2 to AMF1:
      | parameter                                                                                                                                                            | value                                    |
      | amf_ue_ngap_id                                                                                                                                                       | $(AMF_UE_NGAP_ID_2)                      |
      | ran_ue_ngap_id                                                                                                                                                       | incr(3013298712,1)                       |
      | pdu_session_resource_admitted_list.0.pdu_session_id                                                                                                                  | {abotprop.SUT.PDU.SESS.ID}               |
      #| pdu_session_resource_admitted_list.0.handover_request_acknowledge_transfer                                                                                           | 0x1234                                   |
      | pdu_session_resource_admitted_list.0.handover_request_acknowledge_transfer.dl_ngu_up_transport_layer_info.up_transport_layer_info.gtp_tunnel.transport_layer_address | {abotprop.SUT.AUTO.RSP.GTP.DL.IP}        |
      | pdu_session_resource_admitted_list.0.handover_request_acknowledge_transfer.dl_ngu_up_transport_layer_info.up_transport_layer_info.gtp_tunnel.gtp_teid                | {abotprop.SUT.AUTO.RSP.GTP.DL.TEID}      |
      | pdu_session_resource_admitted_list.0.handover_request_acknowledge_transfer.qos_flow_setup_response_list.0.qfi                                                        | {abotprop.SUT.AUTO.RSP.PDU.SESS.QFI}     |
      | pdu_session_resource_admitted_list.0.handover_request_acknowledge_transfer.qos_flow_setup_response_list.0.data_forwarding_accepted                                   | 0                                        |
      #| target_to_source_transparent_container                                                                                                                               | {abotprop.SUT.EPS.NAS.MESSAGE.CONTAINER} |
      | target_to_source_transparent_container                                                                                                                               | 600400039000                             |

    Then I receive and validate NGAP message NG_HANDOVER_REQ_ACK on interface N1-N2 with the following details on node AMF1 from gNodeB2:
      | parameter                                                                                                                                                            | value                                             |
      | amf_ue_ngap_id                                                                                                                                                       | save(AMF_UE_NGAP_ID_2)                            |
      | ran_ue_ngap_id                                                                                                                                                       | save(RAN_UE_NGAP_ID_2)                            |
      | pdu_session_resource_admitted_list.0.pdu_session_id                                                                                                                  | {string:eq}({abotprop.SUT.PDU.SESS.ID})           |
      | pdu_session_resource_admitted_list.0.handover_request_acknowledge_transfer.dl_ngu_up_transport_layer_info.up_transport_layer_info.gtp_tunnel.transport_layer_address | save(GTP_DL_IP_GNB)                               |
      | pdu_session_resource_admitted_list.0.handover_request_acknowledge_transfer.dl_ngu_up_transport_layer_info.up_transport_layer_info.gtp_tunnel.gtp_teid                | save(GTP_DL_TEID_GNB)                             |
      | pdu_session_resource_admitted_list.0.handover_request_acknowledge_transfer.qos_flow_setup_response_list.0.qfi                                                        | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.QFI}) |
      | pdu_session_resource_admitted_list.0.handover_request_acknowledge_transfer.qos_flow_setup_response_list.0.data_forwarding_accepted                                   | {string:eq}(0)                                    |
      | target_to_source_transparent_container                                                                                                                               | save(TARGT_TO_SRC_TRANS_CONTAINER)                |

    When I send NGAP message NG_HANDOVER_CMD on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                                                   | value                           |
      | amf_ue_ngap_id                                                              | $(AMF_UE_NGAP_ID)               |
      | ran_ue_ngap_id                                                              | $(RAN_UE_NGAP_ID)               |
      | handover_type                                                               | {abotprop.SUT.HO.TYPE.INTRA5GS} |
      | pdu_session_resource_ho_list.0.pdu_session_resource_ho_item.pdu_session_id  | {abotprop.SUT.PDU.SESS.ID}      |
      | pdu_session_resource_ho_list.0.pdu_session_resource_ho_item.ho_cmd_transfer | 0x00                            |
      | target_to_source_transparent_container                                      | $(TARGT_TO_SRC_TRANS_CONTAINER) |
      
    Then I receive and validate NGAP message NG_HANDOVER_CMD on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                                                   | value                                        |
      | amf_ue_ngap_id                                                              | {string:eq}($(AMF_UE_NGAP_ID))               |
      | ran_ue_ngap_id                                                              | {string:eq}($(RAN_UE_NGAP_ID))               |
      | handover_type                                                               | {string:eq}({abotprop.SUT.HO.TYPE.INTRA5GS}) |
      | pdu_session_resource_ho_list.0.pdu_session_resource_ho_item.pdu_session_id  | {string:eq}({abotprop.SUT.PDU.SESS.ID})      |
      | pdu_session_resource_ho_list.0.pdu_session_resource_ho_item.ho_cmd_transfer | {string:eq}(0x00)                            |
      | target_to_source_transparent_container                                      | save(TARGT_TO_SRC_TRANS_CONTAINER)           |

    When I send NGAP message NG_UL_RAN_STATUS_TRANSFER on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                                                                                                                                     | value                                                         |
      | amf_ue_ngap_id                                                                                                                                                                                | $(AMF_UE_NGAP_ID)                                             |
      | ran_ue_ngap_id                                                                                                                                                                                | $(RAN_UE_NGAP_ID)                                             |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_id                                                                  | {abotprop.SUT.RAN_STATUS_TRANSFER_CONTAINER.DRB_ID}           |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_ul.drb_status_ul12_count.count_value_pdcp_sn12.pdcp_sn12     | {abotprop.SUT.UL.RAN_STATUS_TRANSFER_CONTAINER.PDCP_SN12}     |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_ul.drb_status_ul12_count.count_value_pdcp_sn12.hfn_pdcp_sn12 | {abotprop.SUT.UL.RAN_STATUS_TRANSFER_CONTAINER.HFN_PDCP_SN12} |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_ul.drb_status_ul18_count.count_value_pdcp_sn18.pdcp_sn18     | {abotprop.SUT.UL.RAN_STATUS_TRANSFER_CONTAINER.PDCP_SN18}     |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_ul.drb_status_ul18_count.count_value_pdcp_sn18.hfn_pdcp_sn18 | {abotprop.SUT.UL.RAN_STATUS_TRANSFER_CONTAINER.HFN_PDCP_SN18} |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_dl.drb_status_dl12_count.count_value_pdcp_sn12.pdcp_sn12     | {abotprop.SUT.UL.RAN_STATUS_TRANSFER_CONTAINER.PDCP_SN12}     |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_dl.drb_status_dl12_count.count_value_pdcp_sn12.hfn_pdcp_sn12 | {abotprop.SUT.UL.RAN_STATUS_TRANSFER_CONTAINER.HFN_PDCP_SN12} |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_dl.drb_status_dl18_count.count_value_pdcp_sn18.pdcp_sn18     | {abotprop.SUT.UL.RAN_STATUS_TRANSFER_CONTAINER.PDCP_SN18}     |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_dl.drb_status_dl18_count.count_value_pdcp_sn18.hfn_pdcp_sn18 | {abotprop.SUT.UL.RAN_STATUS_TRANSFER_CONTAINER.HFN_PDCP_SN18} |

    Then I receive and validate NGAP message NG_UL_RAN_STATUS_TRANSFER on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                                                                                                                                     | value                                                                      |
      | amf_ue_ngap_id                                                                                                                                                                                | {string:eq}($(AMF_UE_NGAP_ID))                                             |
      | ran_ue_ngap_id                                                                                                                                                                                | {string:eq}($(RAN_UE_NGAP_ID))                                             |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_id                                                                  | {string:eq}({abotprop.SUT.RAN_STATUS_TRANSFER_CONTAINER.DRB_ID})           |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_ul.drb_status_ul12_count.count_value_pdcp_sn12.pdcp_sn12     | {string:eq}({abotprop.SUT.UL.RAN_STATUS_TRANSFER_CONTAINER.PDCP_SN12})     |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_ul.drb_status_ul12_count.count_value_pdcp_sn12.hfn_pdcp_sn12 | {string:eq}({abotprop.SUT.UL.RAN_STATUS_TRANSFER_CONTAINER.HFN_PDCP_SN12}) |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_ul.drb_status_ul18_count.count_value_pdcp_sn18.pdcp_sn18     | {string:eq}({abotprop.SUT.UL.RAN_STATUS_TRANSFER_CONTAINER.PDCP_SN18})     |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_ul.drb_status_ul18_count.count_value_pdcp_sn18.hfn_pdcp_sn18 | {string:eq}({abotprop.SUT.UL.RAN_STATUS_TRANSFER_CONTAINER.HFN_PDCP_SN18}) |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_dl.drb_status_dl12_count.count_value_pdcp_sn12.pdcp_sn12     | {string:eq}({abotprop.SUT.UL.RAN_STATUS_TRANSFER_CONTAINER.PDCP_SN12})     |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_dl.drb_status_dl12_count.count_value_pdcp_sn12.hfn_pdcp_sn12 | {string:eq}({abotprop.SUT.UL.RAN_STATUS_TRANSFER_CONTAINER.HFN_PDCP_SN12}) |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_dl.drb_status_dl18_count.count_value_pdcp_sn18.pdcp_sn18     | {string:eq}({abotprop.SUT.UL.RAN_STATUS_TRANSFER_CONTAINER.PDCP_SN18})     |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_dl.drb_status_dl18_count.count_value_pdcp_sn18.hfn_pdcp_sn18 | {string:eq}({abotprop.SUT.UL.RAN_STATUS_TRANSFER_CONTAINER.HFN_PDCP_SN18}) |

    When I send NGAP message NG_DL_RAN_STATUS_TRANSFER on interface N1-N2 with the following details from node AMF1 to gNodeB2:
      | parameter                                                                                                                                                                                     | value                                                         |
      | amf_ue_ngap_id                                                                                                                                                                                | $(AMF_UE_NGAP_ID_2)                                           |
      | ran_ue_ngap_id                                                                                                                                                                                | $(RAN_UE_NGAP_ID_2)                                           |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_id                                                                  | {abotprop.SUT.RAN_STATUS_TRANSFER_CONTAINER.DRB_ID}           |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_ul.drb_status_ul12_count.count_value_pdcp_sn12.pdcp_sn12     | {abotprop.SUT.DL.RAN_STATUS_TRANSFER_CONTAINER.PDCP_SN12}     |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_ul.drb_status_ul12_count.count_value_pdcp_sn12.hfn_pdcp_sn12 | {abotprop.SUT.DL.RAN_STATUS_TRANSFER_CONTAINER.HFN_PDCP_SN12} |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_ul.drb_status_ul18_count.count_value_pdcp_sn18.pdcp_sn18     | {abotprop.SUT.DL.RAN_STATUS_TRANSFER_CONTAINER.PDCP_SN18}     |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_ul.drb_status_ul18_count.count_value_pdcp_sn18.hfn_pdcp_sn18 | {abotprop.SUT.DL.RAN_STATUS_TRANSFER_CONTAINER.HFN_PDCP_SN18} |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_dl.drb_status_dl12_count.count_value_pdcp_sn12.pdcp_sn12     | {abotprop.SUT.DL.RAN_STATUS_TRANSFER_CONTAINER.PDCP_SN12}     |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_dl.drb_status_dl12_count.count_value_pdcp_sn12.hfn_pdcp_sn12 | {abotprop.SUT.DL.RAN_STATUS_TRANSFER_CONTAINER.HFN_PDCP_SN12} |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_dl.drb_status_dl18_count.count_value_pdcp_sn18.pdcp_sn18     | {abotprop.SUT.DL.RAN_STATUS_TRANSFER_CONTAINER.PDCP_SN18}     |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_dl.drb_status_dl18_count.count_value_pdcp_sn18.hfn_pdcp_sn18 | {abotprop.SUT.DL.RAN_STATUS_TRANSFER_CONTAINER.HFN_PDCP_SN18} |

    Then I receive and validate NGAP message NG_DL_RAN_STATUS_TRANSFER on interface N1-N2 with the following details on node gNodeB2 from AMF1:
      | parameter                                                                                                                                                                                     | value                                                                      |
      | amf_ue_ngap_id                                                                                                                                                                                | {string:eq}($(AMF_UE_NGAP_ID_2))                                           |
      | ran_ue_ngap_id                                                                                                                                                                                | save(RAN_UE_NGAP_ID_2)                                                     |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_id                                                                  | {string:eq}({abotprop.SUT.RAN_STATUS_TRANSFER_CONTAINER.DRB_ID})           |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_ul.drb_status_ul12_count.count_value_pdcp_sn12.pdcp_sn12     | {string:eq}({abotprop.SUT.DL.RAN_STATUS_TRANSFER_CONTAINER.PDCP_SN12})     |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_ul.drb_status_ul12_count.count_value_pdcp_sn12.hfn_pdcp_sn12 | {string:eq}({abotprop.SUT.DL.RAN_STATUS_TRANSFER_CONTAINER.HFN_PDCP_SN12}) |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_ul.drb_status_ul18_count.count_value_pdcp_sn18.pdcp_sn18     | {string:eq}({abotprop.SUT.DL.RAN_STATUS_TRANSFER_CONTAINER.PDCP_SN18})     |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_ul.drb_status_ul18_count.count_value_pdcp_sn18.hfn_pdcp_sn18 | {string:eq}({abotprop.SUT.DL.RAN_STATUS_TRANSFER_CONTAINER.HFN_PDCP_SN18}) |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_dl.drb_status_dl12_count.count_value_pdcp_sn12.pdcp_sn12     | {string:eq}({abotprop.SUT.DL.RAN_STATUS_TRANSFER_CONTAINER.PDCP_SN12})     |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_dl.drb_status_dl12_count.count_value_pdcp_sn12.hfn_pdcp_sn12 | {string:eq}({abotprop.SUT.DL.RAN_STATUS_TRANSFER_CONTAINER.HFN_PDCP_SN12}) |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_dl.drb_status_dl18_count.count_value_pdcp_sn18.pdcp_sn18     | {string:eq}({abotprop.SUT.DL.RAN_STATUS_TRANSFER_CONTAINER.PDCP_SN18})     |
      | ran_status_transfer_transparent_container.drbs_subject_to_status_transfer_list.0.drbs_subject_to_status_transfer_item.drb_status_dl.drb_status_dl18_count.count_value_pdcp_sn18.hfn_pdcp_sn18 | {string:eq}({abotprop.SUT.DL.RAN_STATUS_TRANSFER_CONTAINER.HFN_PDCP_SN18}) |

    When I send NGAP message NG_HANDOVER_NOTIFY on interface N1-N2 with the following details from node gNodeB2 to AMF1:
      | parameter                                                                       | value                      |
      | amf_ue_ngap_id                                                                  | $(AMF_UE_NGAP_ID_2)        |
      | ran_ue_ngap_id                                                                  | incr(3013298712,1)         |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {abotprop.SUT.MCC}         |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {abotprop.SUT.MNC}         |
      | user_location_information.nr_user_location_information.tai.tac                  | {abotprop.SUT.TAC}         |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {abotprop.SUT.MCC}         |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {abotprop.SUT.MNC}         |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {abotprop.SUT.NR.CELL.IDN} |

    Then I receive and validate NGAP message NG_HANDOVER_NOTIFY on interface N1-N2 with the following details on node AMF1 from gNodeB2:
      | parameter                                                                       | value                                   |
      | amf_ue_ngap_id                                                                  | {string:eq}($(AMF_UE_NGAP_ID_2))        |
      | ran_ue_ngap_id                                                                  | {string:eq}($(RAN_UE_NGAP_ID_2))        |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mcc    | {string:eq}({abotprop.SUT.MCC})         |
      | user_location_information.nr_user_location_information.tai.plmn_identity.mnc    | {string:eq}({abotprop.SUT.MNC})         |
      | user_location_information.nr_user_location_information.tai.tac                  | {string:eq}({abotprop.SUT.TAC})         |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mcc | {string:eq}({abotprop.SUT.MCC})         |
      | user_location_information.nr_user_location_information.nr_cgi.plmn_identity.mnc | {string:eq}({abotprop.SUT.MNC})         |
      | user_location_information.nr_user_location_information.nr_cgi.nr_cell_identity  | {string:eq}({abotprop.SUT.NR.CELL.IDN}) |

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
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | {abotprop.SUT.AUTO.RSP.GTP.DL.IP}                                                       |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | {abotprop.SUT.AUTO.RSP.GTP.DL.TEID}                                                     |
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
      | multipart_related.json_data.sm_context_update_data.pei                                                                                                                                          | {string:eq}({abotprop.SUT.PEI})                                                                      |
      | multipart_related.json_data.sm_context_update_data.s_nssai.sst                                                                                                                                  | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB})                                              |
      | multipart_related.json_data.sm_context_update_data.up_cnx_state                                                                                                                                 | {string:eq}(ACTIVATED)                                                                               |
      | multipart_related.json_data.sm_context_update_data.n2_sm_info.content_id                                                                                                                        | {string:eq}(n2-pdu-session-resource-setup-response-transfer-ie)                                      |
      | multipart_related.json_data.sm_context_update_data.n2_sm_info_type                                                                                                                              | {string:eq}(PDU_RES_SETUP_RSP)                                                                       |
      | multipart_related.binary_data_n2_sm_information.content_type                                                                                                                                    | {string:eq}(application/vnd.3gpp.ngap)                                                               |
      | multipart_related.binary_data_n2_sm_information.content_id                                                                                                                                      | {string:eq}(n2-pdu-session-resource-setup-response-transfer-ie)                                      |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.transport_layer_address | save(GTP_DL_IP)                                                                                      |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.up_transport_layer_info.gtp_tunnel.gtp_teid                | save(GTP_DL_TEID)                                                                                    |
      | multipart_related.binary_data_n2_sm_information.content.pdu_session_resource_setup_response_transfer.dl_qos_flow_per_tnl_information.associated_qos_flow_list.0.qfi                             | {string:eq}({abotprop.SUT.AUTO.RSP.PDU.SESS.QFI})                                                    |

    When I send PFCP message PFCP_SESSION_MODIFICATION_REQ on interface N4 with the following details from node SMF1 to UPF1:
      | parameter                                                              | value                                                 |
      | header.message_type                                                    | {abotprop.SUT.PFCP.HEADER.MSG.TYPE.MOD.REQ}           |
      | header.seid                                                            | $(PFCP_HDR_FSEID_UPF)                                 |
      | header.seq_number                                                      | incr(3,3)                                             |
      | update_far.0.far_id                                                    | {abotprop.SUT.PFCP.PDR.0.FAR_ID}                      |
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
      | update_far.0.far_id                                                    | {string:eq}({abotprop.SUT.PFCP.PDR.0.FAR_ID})                      |
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

    When I send NGAP message NG_UE_CTXT_RELEASE_CMD on interface N1-N2 with the following details from node AMF1 to gNodeB1:
      | parameter                                         | value             |
      | ue_ngap_ids_choice.ue_ngap_id_pair.amf_ue_ngap_id | $(AMF_UE_NGAP_ID) |
      | ue_ngap_ids_choice.ue_ngap_id_pair.ran_ue_ngap_id | $(RAN_UE_NGAP_ID) |
      | cause.transport                                   | $(CAUSE_VALUE)    |
      
    Then I receive and validate NGAP message NG_UE_CTXT_RELEASE_CMD on interface N1-N2 with the following details on node gNodeB1 from AMF1:
      | parameter                                         | value                          |
      | ue_ngap_ids_choice.ue_ngap_id_pair.amf_ue_ngap_id | {string:eq}($(AMF_UE_NGAP_ID)) |
      | ue_ngap_ids_choice.ue_ngap_id_pair.ran_ue_ngap_id | {string:eq}($(RAN_UE_NGAP_ID)) |
      #| cause.transport                                   | {string:eq}(0)                 |
      | cause.transport                                   | save(CAUSE_VALUE)              |
    When I send NGAP message NG_UE_CTXT_RELEASE_COMPLETE on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter      | value             |
      | amf_ue_ngap_id | $(AMF_UE_NGAP_ID) |
      | ran_ue_ngap_id | $(RAN_UE_NGAP_ID) |
      
      
    Then I receive and validate NGAP message NG_UE_CTXT_RELEASE_COMPLETE on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter      | value                          |
      | amf_ue_ngap_id | {string:eq}($(AMF_UE_NGAP_ID)) |
      | ran_ue_ngap_id | {string:eq}($(RAN_UE_NGAP_ID)) |
