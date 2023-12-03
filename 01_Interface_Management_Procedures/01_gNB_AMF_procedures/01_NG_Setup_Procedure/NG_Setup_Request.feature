@5gs-ng-setup-req @01-interface-mgmt-procedure @01-01-gnb-amf-procedures @23502-5gs @5g-core

Feature: NGAP NG Setup Procedure

  Scenario: NG Setup Request with successful NG Setup Response

    Given the steps below will be executed at the end
    When I run the SSH command {abotprop.SUT.DEFAULT.GENB.CONFIG} at node gNodeB1
    When I run the SSH command {abotprop.SUT.DEFAULT.AMF.CONFIG} at node AMF1
    Then the ending steps are complete

    Given the test data is in file /featureFiles/MESSAGE_BUNDLES/EPC_MESSAGES.xml

    When I run the SSH command {abotprop.SUT.CUSTOM.GENB.CONFIG} and pause for {abotprop.WAIT_5_SEC} seconds at node gNodeB1
    When I run the SSH command {abotprop.SUT.CUSTOM.ENB.CONFIG} and pause for {abotprop.WAIT_5_SEC} seconds at node AMF1

    Given all configured endpoints for EPC are connected successfully

    When I send NGAP message NG_SETUP_REQ on interface N1-N2 with the following details from node gNodeB1 to AMF1:
      | parameter                                                                         | value                                      |
      | global_ran_node_id.global_gnb_id.plmn_identity.mcc                                | {abotprop.SUT.MCC}                         |
      | global_ran_node_id.global_gnb_id.plmn_identity.mnc                                | {abotprop.SUT.MNC}                         |
      | global_ran_node_id.global_gnb_id.gnb_id                                           | {abotprop.SUT.GLOBAL.GNB1.ID}              |
      | supported_ta_list.0.tac                                                           | {abotprop.SUT.TAC}                         |
      | supported_ta_list.0.broadcast_plmns.0.plmn_identity.mcc                           | {abotprop.SUT.MCC}                         |
      | supported_ta_list.0.broadcast_plmns.0.plmn_identity.mnc                           | {abotprop.SUT.MNC}                         |
      | supported_ta_list.0.broadcast_plmns.0.slice_support_list.slice_support_item.0.sst | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB} |
      | paging_drx                                                                        | {abotprop.SUT.PAGING.DRX}                  |

    Then I receive and validate NGAP message NG_SETUP_REQ on interface N1-N2 with the following details on node AMF1 from gNodeB1:
      | parameter                                                                         | value                                                   |
      | global_ran_node_id.global_gnb_id.plmn_identity.mcc                                | {string:eq}({abotprop.SUT.MCC})                         |
      | global_ran_node_id.global_gnb_id.plmn_identity.mnc                                | {string:eq}({abotprop.SUT.MNC})                         |
      | global_ran_node_id.global_gnb_id.gnb_id                                           | {string:eq}({abotprop.SUT.GLOBAL.GNB1.ID})              |
      | supported_ta_list.0.tac                                                           | {string:eq}({abotprop.SUT.TAC})                         |
      | supported_ta_list.0.broadcast_plmns.0.plmn_identity.mcc                           | {string:eq}({abotprop.SUT.MCC})                         |
      | supported_ta_list.0.broadcast_plmns.0.plmn_identity.mnc                           | {string:eq}({abotprop.SUT.MNC})                         |
      | supported_ta_list.0.broadcast_plmns.0.slice_support_list.slice_support_item.0.sst | {string:eq}({abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}) |
      | paging_drx                                                                        | {string:eq}({abotprop.SUT.PAGING.DRX})                  |

    When I send NGAP message NG_SETUP_RES on interface N1-N2 with the following details from node AMF1 to gNodeB1:
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

    Then I receive and validate NGAP message NG_SETUP_RES on interface N1-N2 with the following details on node gNodeB1 from AMF1:
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
