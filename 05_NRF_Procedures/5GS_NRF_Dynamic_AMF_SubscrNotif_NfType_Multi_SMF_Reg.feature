@5gs-nrf-dynamic-amf-subscr-notif-nftype-multi-smf-reg @05-nrf-procedures @23502-5gs @5g-core-sanity @5g-core

Feature: 5GS NRF Dynamic Subscription by AMF for Registration event of NF Type SMF with NRF Registration of SMF1 and SMF2 and respective NRF Notification to AMF

  Scenario: 5GS NRF Dynamic Subscription by AMF for Registration event of NF Type SMF with NRF Registration of SMF1 and SMF2 and respective NRF Notification to AMF

    Given the test data is in file /featureFiles/MESSAGE_BUNDLES/EPC_MESSAGES.xml

    Given all configured endpoints for EPC are connected successfully




### AMF1 Registration with NRF with subscription for NF Type SMF for NF Registration Event

    When I send HTTPV2 message HTTPV2_NNRF_NFM_NF_INSTANCE_REGISTRATION_PUT_REQ on interface NNRF with the following details from node AMF1 to NRF1:
      | parameter      | value        |
      | nf_profile_ref | AMF1.profile |

    When I send HTTPV2 message HTTPV2_NNRF_NFM_CREATE_SUBSCRIPTION_POST_REQ on interface NNRF with the following details from node AMF1 to NRF1:
      | parameter                                        | value                                                                                                                |
      | header.nva.0.name                                | :method                                                                                                              |
      | header.nva.0.value                               | POST                                                                                                                 |
      | header.nva.1.name                                | :path                                                                                                                |
      | header.nva.1.value                               | /$({abotprop.NRF1.SecureShell.IPAddress}):$({abotprop.NRF1.NNRF.Server.Port})/nnrf-nfm/v1/subscriptions              |
      | header.nva.2.name                                | content-type                                                                                                         |
      | header.nva.2.value                               | application/json                                                                                                     |
      | subscription_data.nf_status_notification_uri     | http://$({abotprop.AMF1.SecureShell.IPAddress}):$({abotprop.AMF1.NNRF.Server.Port})/nnrf-nfm/v1/subscriptions/notify |
      | subscription_data.req_nf_type                    | AMF                                                                                                                  |
      | subscription_data.req_snssais.0.snssai.sst       | {abotprop.SUT.SLICE.SUPPORT.ITEM.SST.EMBB}                                                                                                                    |
      | subscription_data.req_notif_events.0.notif_event | NF_REGISTERED                                                                                                        |
      | subscription_data.subscr_cond.nf_type            | SMF                                                                                                                  |

    Then I receive and validate HTTPV2 message HTTPV2_NNRF_NFM_CREATE_SUBSCRIPTION_POST_RES_201 on interface NNRF with the following details on node AMF1 from NRF1:
      | parameter                                    | value                                                                                                                             |
      | header.nva.0.name                            | {string:eq}(:status)                                                                                                              |
      | header.nva.0.value                           | {string:eq}(201)                                                                                                                  |
      | header.nva.1.name                            | {string:eq}(location)                                                                                                             |
      | header.nva.1.value                           | save(LOCATION)                                                                                                                    |
      | header.nva.2.name                            | {string:eq}(content-type)                                                                                                         |
      | header.nva.2.value                           | {string:eq}(application/json)                                                                                                     |
      | subscription_data.subscription_id            | save(SUBSCRIPTION_ID)                                                                                                             |
      | subscription_data.nf_status_notification_uri | {string:eq}(http://$({abotprop.AMF1.SecureShell.IPAddress}):$({abotprop.AMF1.NNRF.Server.Port})/nnrf-nfm/v1/subscriptions/notify) |
      | subscription_data.validity_time              | save(VALIDITY_TIME)                                                                                                               |




### SMF1 Registration with NRF, SMF supports Slice 1

    When I send HTTPV2 message HTTPV2_NNRF_NFM_NF_INSTANCE_REGISTRATION_PUT_REQ on interface NNRF with the following details from node SMF1 to NRF1:
      | parameter      | value        |
      | nf_profile_ref | SMF1.profile |



    Given the execution is paused for {abotprop.WAIT_10_SEC} seconds



### NRF Subscription Notification to AMF1 about SMF1 Registration

    #Then I receive and validate HTTPV2 message HTTPV2_NNRF_NFM_SUBSCRIPTION_NOTIFICATION_POST_REQ on interface NNRF with the following details on node AMF1 from NRF1:
      #| parameter                         | value                                                                                                                                                    |
      #| header.nva.0.name                 | {string:eq}(:method)                                                                                                                                     |
      #| header.nva.0.value                | {string:eq}(POST)                                                                                                                                        |
      #| header.nva.1.name                 | {string:eq}(:path)                                                                                                                                       |
      #| header.nva.1.value                | {string:eq}(/$({abotprop.AMF1.SecureShell.IPAddress}):$({abotprop.AMF1.NNRF.Server.Port})/nnrf-nfm/v1/subscriptions/notify)                              |
      #| header.nva.2.name                 | {string:eq}(content-type)                                                                                                                                |
      #| header.nva.2.value                | {string:eq}(application/json)                                                                                                                            |
      #| notification_data.event           | {string:eq}(NF_REGISTERED)                                                                                                                               |
      #| notification_data.nf_instance_uri | {string:eq}(/$({abotprop.NRF1.SecureShell.IPAddress}):$({abotprop.NRF1.NNRF.Server.Port})/nnrf-nfm/v1/nf-instances/668611d7-2ea0-42a3-a06d-d4bea2ac65eb) |

    #When I send HTTPV2 message HTTPV2_NNRF_NFM_SUBSCRIPTION_NOTIFICATION_POST_RES_204 on interface NNRF with the following details from node AMF1 to NRF1:
      #| parameter          | value   |
      #| header.nva.0.name  | :status |
      #| header.nva.0.value | 204     |





### SMF2 Registration with NRF, SMF supports Slice 1

    When I send HTTPV2 message HTTPV2_NNRF_NFM_NF_INSTANCE_REGISTRATION_PUT_REQ on interface NNRF with the following details from node SMF2 to NRF1:
      | parameter      | value        |
      | nf_profile_ref | SMF2.profile |



    Given the execution is paused for {abotprop.WAIT_10_SEC} seconds



### NRF Subscription Notification to AMF1 about SMF2 Registration

    #Then I receive and validate HTTPV2 message HTTPV2_NNRF_NFM_SUBSCRIPTION_NOTIFICATION_POST_REQ on interface NNRF with the following details on node AMF1 from NRF1:
      #| parameter                         | value                                                                                                                                                    |
      #| header.nva.0.name                 | {string:eq}(:method)                                                                                                                                     |
      #| header.nva.0.value                | {string:eq}(POST)                                                                                                                                        |
      #| header.nva.1.name                 | {string:eq}(:path)                                                                                                                                       |
      #| header.nva.1.value                | {string:eq}(/$({abotprop.AMF1.SecureShell.IPAddress}):$({abotprop.AMF1.NNRF.Server.Port})/nnrf-nfm/v1/subscriptions/notify)                              |
      #| header.nva.2.name                 | {string:eq}(content-type)                                                                                                                                |
      #| header.nva.2.value                | {string:eq}(application/json)                                                                                                                            |
      #| notification_data.event           | {string:eq}(NF_REGISTERED)                                                                                                                               |
      #| notification_data.nf_instance_uri | {string:eq}(/$({abotprop.NRF1.SecureShell.IPAddress}):$({abotprop.NRF1.NNRF.Server.Port})/nnrf-nfm/v1/nf-instances/14f88ee7-5290-47c5-9dcd-96f8042f95f0) |
#
    #When I send HTTPV2 message HTTPV2_NNRF_NFM_SUBSCRIPTION_NOTIFICATION_POST_RES_204 on interface NNRF with the following details from node AMF1 to NRF1:
      #| parameter          | value   |
      #| header.nva.0.name  | :status |
      #| header.nva.0.value | 204     |


