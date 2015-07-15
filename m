From: kernel neophyte <neophyte.hacker001@gmail.com>
Subject: Re: Ceph-mon crashing FAILED assert(addr_name.count(p->second) == 0)
Date: Wed, 15 Jul 2015 10:12:03 -0700
Message-ID: <CAFkUHxcbV29rsHcqCU2bZhf-PcEa=stqyyC-zDx3=vC0FUS-Pg@mail.gmail.com>
References: <CAFkUHxe8Qw4-5ggCm51shQdp8aYzdvEp9Bt9Fq11sur2vUf5oQ@mail.gmail.com>
	<55A22474.2040501@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34628 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbbGORME (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jul 2015 13:12:04 -0400
Received: by obre1 with SMTP id e1so30787035obr.1
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2015 10:12:03 -0700 (PDT)
In-Reply-To: <55A22474.2040501@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: raju.kurunkad@sandisk.com, vu@mellanox.com, Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Joao Eduardo Luis <joao@suse.de>

I was able to dig bit further, I see this happening when using XIO as
messenger (Simple & Async works fine).

My Stack details are:

Linux Distro: Ubuntu
Kernel:  3.13.0-24-generic
OFED: I see it happen in both
MLNX_OFED_LINUX-2.4-1.0.4-ubuntu14.04-x86_64 &
MLNX_OFED_LINUX-3.0-1.0.1-ubuntu14.04-x86_64
Accelio: I see it happen in both https://github.com/accelio/accelio
Branch: master & https://github.com/vuhuong/accelio Branch:
master-v1.3-fix


monmap:

monmaptool -p /tmp/monmap

monmaptool: monmap file /tmp/monmap

epoch 0

fsid 41e024e8-b224-41c7-ab13-9d9b681f3b61

last_changed 2015-07-15 09:48:38.037222

created 2015-07-15 09:48:38.037222

0: 10.13.10.189:6789/0 mon.abc-def-ghij07



Debug/Log:

ceph -s

2015-07-15 09:54:07.763512 7f6df0c12700 -1 WARNING: the following
dangerous and experimental features are enabled: ms-type-xio

2015-07-15 09:54:07.766830 7f6df0c12700 -1 WARNING: the following
dangerous and experimental features are enabled: ms-type-xio

2015-07-15 09:54:07.766864 7f6df0c12700 -1 WARNING: experimental
feature 'ms-type-xio' is enabled

Please be aware that this feature is experimental, untested,

unsupported, and may result in data corruption, data loss,

and/or irreparable damage to your cluster.  Do not use

feature with important data.


2015-07-15 09:54:07.767331 7f6df0c12700  2 [debug] xio_mempool.c:500
xio_mempool_create - mempool: using regular allocator


2015-07-15 09:54:07.768458 7f6df0c12700  4 XioMessenger 0x7f6de4018040
get_connection: xio_uri rdma://10.13.10.189:6789

2015-07-15 09:54:07.768466 7f6df0c12700  4 Peer type: mon
throttle_msgs: 1024 throttle_bytes: 536870912

2015-07-15 09:54:07.768483 7f6df0c12700  2 [debug] xio_mempool.c:494
xio_mempool_create - mempool: using huge pages allocator


2015-07-15 09:54:07.768581 7f6df0c12700 20 [trace]
xio_rdma_management.c:2646 xio_rdma_open - xio_rdma_open: [new]
handle:0x7f6de4055d40


2015-07-15 09:54:07.768587 7f6df0c12700 20 [trace] xio_nexus.c:1903
xio_nexus_open - nexus: [new] nexus:0x7f6de4055b20,
transport_hndl:0x7f6de4055d40


2015-07-15 09:54:07.768595 7f6df0c12700 20 [trace] xio_nexus.c:1993
xio_nexus_connect - xio_nexus_connect: nexus:0x7f6de4055b20,
rdma_hndl:0x7f6de4055d40, portal:rdma://10.13.10.189:6789


2015-07-15 09:54:07.768759 7f6df0c12700  2 [debug]
xio_session_client.c:1022 xio_connect - xio_connect:
session:0x7f6de40558f0, connection:0x7f6de4056e20, ctx:0x7f6de40179d0,
nexus:0x7f6de4055b20


2015-07-15 09:54:07.768767 7f6df0c12700  2 new connection xcon:
0x7f6de4055460 up_ready on session 0x7f6de40558f0

2015-07-15 09:54:07.768860 7f6df0c12700  4 _send_message_impl
0x7f6de40578e0 new XioMsg 0x7f6df014f040 req_0 0x7f6df014f160 msg type
17 features: 0 conn 0x7f6de4056e20 sess 0x7f6de40558f0

2015-07-15 09:54:07.768867 7f6df0c12700 10 ex_cnt 0, req_off -1, msg_cnt 1

2015-07-15 09:54:07.768863 7f6de9ac4700  2 [debug]
xio_rdma_management.c:2386 xio_handle_cm_event - cm event:
[RDMA_CM_EVENT_ADDR_RESOLVED], hndl:0x7f6de4055d40, status:0


2015-07-15 09:54:07.769112 7f6de9ac4700  2 [debug]
xio_rdma_management.c:2386 xio_handle_cm_event - cm event:
[RDMA_CM_EVENT_ROUTE_RESOLVED], hndl:0x7f6de4055d40, status:0


2015-07-15 09:54:07.769707 7f6de9ac4700 20 [trace]
xio_rdma_management.c:469 xio_cq_get - comp_vec:17


2015-07-15 09:54:07.770201 7f6de9ac4700  2 [debug]
xio_rdma_management.c:961 xio_qp_create - rdma qp: [new]
handle:0x7f6de4055d40, qp:0x260, max inline:448


2015-07-15 09:54:07.770231 7f6de9ac4700  4 xio_send_msg xio msg: sn: 0
timestamp: 256752506178532

2015-07-15 09:54:07.770232 7f6de9ac4700  4 xio_send_msg ceph header:
front_len: 60 seq: 1 tid: 0 type: 17 prio: 0 name type: 8 name num: -1
version: 1 compat_version: 1 front_len: 60 middle_len: 0 data_len: 0
xio header:  msg_cnt: 1

2015-07-15 09:54:07.770235 7f6de9ac4700  4 xio_send_msg ceph footer:
front_crc: 0 middle_crc: 0 data_crc: 0 sig: 0 flags: 3

2015-07-15 09:54:07.778297 7f6de9ac4700  2 [debug]
xio_rdma_management.c:2386 xio_handle_cm_event - cm event:
[RDMA_CM_EVENT_ESTABLISHED], hndl:0x7f6de4055d40, status:0


2015-07-15 09:54:07.778308 7f6de9ac4700  2 [debug] xio_nexus.c:1632
xio_nexus_on_transport_event - nexus: [notification] - transport
established. nexus:0x7f6de4055b20, transport:0x7f6de4055d40


2015-07-15 09:54:07.778330 7f6de9ac4700 20 [trace]
xio_rdma_verbs.c:240 xio_reg_mr_ex_dev - before ibv_reg_mr


2015-07-15 09:54:07.778399 7f6de9ac4700 20 [trace]
xio_rdma_verbs.c:242 xio_reg_mr_ex_dev - after ibv_reg_mr


2015-07-15 09:54:07.778404 7f6de9ac4700 20 [trace]
xio_rdma_verbs.c:240 xio_reg_mr_ex_dev - before ibv_reg_mr


2015-07-15 09:54:07.778462 7f6de9ac4700 20 [trace]
xio_rdma_verbs.c:242 xio_reg_mr_ex_dev - after ibv_reg_mr


2015-07-15 09:54:07.778480 7f6de9ac4700  2 [debug]
xio_rdma_management.c:1274 xio_rdma_initial_pool_post_create -
post_recv conn_setup rx task:0x7f6ddc009400


2015-07-15 09:54:07.778489 7f6de9ac4700 20 [trace] xio_nexus.c:384
xio_nexus_send_setup_req - send setup request


2015-07-15 09:54:07.778492 7f6de9ac4700 20 [trace] xio_nexus.c:426
xio_nexus_send_setup_req - xio_nexus_send_setup_req:
nexus:0x7f6de4055b20, rdma_hndl:0x7f6de4055d40


2015-07-15 09:54:07.778497 7f6de9ac4700 20 [trace]
xio_rdma_datapath.c:4180 xio_rdma_send_setup_req - rdma send setup
request


2015-07-15 09:54:07.782250 7f6de9ac4700 20 [trace]
xio_rdma_datapath.c:4319 xio_rdma_on_setup_msg - setup complete.
send_buf_sz:17408


2015-07-15 09:54:07.782258 7f6de9ac4700 20 [trace] xio_nexus.c:661
xio_nexus_on_recv_setup_rsp - receiving setup response.
nexus:0x7f6de4055b20


2015-07-15 09:54:07.782261 7f6de9ac4700 20 [trace] xio_nexus.c:714
xio_nexus_on_recv_setup_rsp - xio_nexus_on_recv_setup_rsp:
nexus:0x7f6de4055b20, trans_hndl:0x7f6de4055d40


2015-07-15 09:54:07.782866 7f6de9ac4700 20 [trace]
xio_rdma_verbs.c:240 xio_reg_mr_ex_dev - before ibv_reg_mr


2015-07-15 09:54:07.785038 7f6de9ac4700 20 [trace]
xio_rdma_verbs.c:242 xio_reg_mr_ex_dev - after ibv_reg_mr


2015-07-15 09:54:07.785045 7f6de9ac4700 20 [trace]
xio_rdma_verbs.c:240 xio_reg_mr_ex_dev - before ibv_reg_mr


2015-07-15 09:54:07.785247 7f6de9ac4700 20 [trace]
xio_rdma_verbs.c:242 xio_reg_mr_ex_dev - after ibv_reg_mr


2015-07-15 09:54:07.785257 7f6de9ac4700  2 [debug]
xio_rdma_management.c:1572 xio_rdma_primary_pool_slab_pre_create -
pool buf:0x7f6de31e7000, mr:0x7f6ddc0093b0


2015-07-15 09:54:07.785495 7f6de9ac4700  2 [debug]
xio_session_client.c:793 xio_client_on_nexus_event - session:
[notification] - nexus established. session:0x7f6de40558f0,
nexus:0x7f6de4055b20


2015-07-15 09:54:07.785692 7f6de9ac4700  2 [debug]
xio_session_client.c:503 xio_on_setup_rsp_recv - task recycled


2015-07-15 09:54:07.785700 7f6de9ac4700 20 [trace]
xio_session_client.c:517 xio_on_setup_rsp_recv - session state is now
ONLINE. session:0x7f6de40558f0


2015-07-15 09:54:07.785703 7f6de9ac4700 20 [trace]
xio_session_client.c:547 xio_on_setup_rsp_recv - session state is now
ACCEPT. session:0x7f6de40558f0


2015-07-15 09:54:07.785711 7f6de9ac4700  2 [debug]
xio_connection.c:1719 xio_disconnect_initial_connection - send fin
request. session:0x7f6de40558f0, connection:0x7f6ddc015aa0


2015-07-15 09:54:07.785715 7f6de9ac4700 20 [trace]
xio_connection.c:1726 xio_disconnect_initial_connection - connection
0x7f6ddc015aa0 state change: current_state:ONLINE,
next_state:FIN_WAIT_1


2015-07-15 09:54:07.785725 7f6de9ac4700 20 [trace]
xio_rdma_management.c:2646 xio_rdma_open - xio_rdma_open: [new]
handle:0x7f6ddc0162d0


2015-07-15 09:54:07.785727 7f6de9ac4700 20 [trace] xio_nexus.c:1903
xio_nexus_open - nexus: [new] nexus:0x7f6ddc0160b0,
transport_hndl:0x7f6ddc0162d0


2015-07-15 09:54:07.785728 7f6de9ac4700  2 [debug]
xio_session_client.c:196 xio_session_accept_connections - reconnecting
to rdma://10.13.10.189:6800. connection:0x7f6de4056e20,
nexus:0x7f6ddc0160b0


2015-07-15 09:54:07.785734 7f6de9ac4700 20 [trace] xio_nexus.c:1993
xio_nexus_connect - xio_nexus_connect: nexus:0x7f6ddc0160b0,
rdma_hndl:0x7f6ddc0162d0, portal:rdma://10.13.10.189:6800


2015-07-15 09:54:07.785761 7f6de9ac4700  2 [debug]
xio_connection.c:2526 xio_on_fin_req_recv - fin request received.
session:0x7f6de40558f0, connection:0x7f6ddc015aa0


2015-07-15 09:54:07.785764 7f6de9ac4700  2 [debug]
xio_connection.c:1682 xio_send_fin_ack - send fin response.
session:0x7f6de40558f0, connection:0x7f6ddc015aa0


2015-07-15 09:54:07.785767 7f6de9ac4700  2 [debug]
xio_connection.c:2367 xio_on_fin_req_send_comp - got fin request send
completion. session:0x7f6de40558f0, connection:0x7f6ddc015aa0


2015-07-15 09:54:07.785769 7f6de9ac4700  2 [debug]
xio_connection.c:2454 xio_on_fin_ack_recv - got fin ack.
session:0x7f6de40558f0, connection:0x7f6ddc015aa0


2015-07-15 09:54:07.785771 7f6de9ac4700  2 [debug]
xio_connection.c:2495 xio_on_fin_ack_recv - connection 0x7f6ddc015aa0
state change: current_state:FIN_WAIT_1, next_state:FIN_WAIT_2


2015-07-15 09:54:07.785772 7f6de9ac4700  2 [debug]
xio_connection.c:2560 xio_on_fin_ack_send_comp - fin ack send
completion received. session:0x7f6de40558f0, connection:0x7f6ddc015aa0


2015-07-15 09:54:07.785773 7f6de9ac4700  2 [debug]
xio_connection.c:2583 xio_on_fin_ack_send_comp - connection
0x7f6ddc015aa0 state change: current_state:FIN_WAIT_2,
next_state:TIME_WAIT


2015-07-15 09:54:07.785784 7f6de9ac4700  2 [debug]
xio_rdma_management.c:2386 xio_handle_cm_event - cm event:
[RDMA_CM_EVENT_ADDR_RESOLVED], hndl:0x7f6ddc0162d0, status:0


2015-07-15 09:54:07.786008 7f6de9ac4700  2 [debug]
xio_rdma_management.c:2386 xio_handle_cm_event - cm event:
[RDMA_CM_EVENT_ROUTE_RESOLVED], hndl:0x7f6ddc0162d0, status:0


2015-07-15 09:54:07.786468 7f6de9ac4700  2 [debug]
xio_rdma_management.c:961 xio_qp_create - rdma qp: [new]
handle:0x7f6ddc0162d0, qp:0x262, max inline:448


2015-07-15 09:54:07.787793 7f6de9ac4700  2 [debug]
xio_connection.c:2383 xio_close_time_wait - connection 0x7f6ddc015aa0
state change: current_state:TIME_WAIT, next_state:CLOSED


2015-07-15 09:54:07.787804 7f6de9ac4700  2 [debug]
xio_connection.c:2183 xio_connection_destroy - xio_connection_destroy.
session:0x7f6de40558f0, connection:0x7f6ddc015aa0 nexus:0x7f6de4055b20
nr:1, state:CLOSED


2015-07-15 09:54:07.787807 7f6de9ac4700  2 [debug]
xio_connection.c:2108 xio_connection_post_destroy -
xio_connection_post_destroy. session:0x7f6de40558f0,
connection:0x7f6ddc015aa0 conn:0x7f6de4055b20 nr:1


2015-07-15 09:54:07.787810 7f6de9ac4700 20 [trace] xio_nexus.c:2139
xio_nexus_close - nexus: [putref] ptr:0x7f6de4055b20, refcnt:1


2015-07-15 09:54:07.787812 7f6de9ac4700  2 [debug]
xio_session_client.c:808 xio_client_on_nexus_event - session:
[notification] - nexus closed. session:0x7f6de40558f0,
nexus:0x7f6de4055b20


2015-07-15 09:54:07.787814 7f6de9ac4700 20 [trace] xio_session.c:987
xio_on_nexus_closed - session:0x7f6de40558f0 - nexus:0x7f6de4055b20
close complete


2015-07-15 09:54:07.787816 7f6de9ac4700 20 [trace] xio_nexus.c:2111
xio_nexus_delayed_close - xio_nexus_deleyed close.
nexus:0x7f6de4055b20, state:4


2015-07-15 09:54:07.787817 7f6de9ac4700 20 [trace]
xio_connection.c:2122 xio_connection_post_destroy - lead connection is
closed


2015-07-15 09:54:07.790664 7f6de9ac4700  2 [debug]
xio_rdma_management.c:2386 xio_handle_cm_event - cm event:
[RDMA_CM_EVENT_ESTABLISHED], hndl:0x7f6ddc0162d0, status:0


2015-07-15 09:54:07.790672 7f6de9ac4700  2 [debug] xio_nexus.c:1632
xio_nexus_on_transport_event - nexus: [notification] - transport
established. nexus:0x7f6ddc0160b0, transport:0x7f6ddc0162d0


2015-07-15 09:54:07.790675 7f6de9ac4700  2 [debug]
xio_rdma_management.c:1274 xio_rdma_initial_pool_post_create -
post_recv conn_setup rx task:0x7f6ddc009400


2015-07-15 09:54:07.790680 7f6de9ac4700 20 [trace] xio_nexus.c:384
xio_nexus_send_setup_req - send setup request


2015-07-15 09:54:07.790682 7f6de9ac4700 20 [trace] xio_nexus.c:426
xio_nexus_send_setup_req - xio_nexus_send_setup_req:
nexus:0x7f6ddc0160b0, rdma_hndl:0x7f6ddc0162d0


2015-07-15 09:54:07.790683 7f6de9ac4700 20 [trace]
xio_rdma_datapath.c:4180 xio_rdma_send_setup_req - rdma send setup
request


2015-07-15 09:54:07.794359 7f6de9ac4700 20 [trace]
xio_rdma_datapath.c:4319 xio_rdma_on_setup_msg - setup complete.
send_buf_sz:17408


2015-07-15 09:54:07.794367 7f6de9ac4700 20 [trace] xio_nexus.c:661
xio_nexus_on_recv_setup_rsp - receiving setup response.
nexus:0x7f6ddc0160b0


2015-07-15 09:54:07.794369 7f6de9ac4700 20 [trace] xio_nexus.c:714
xio_nexus_on_recv_setup_rsp - xio_nexus_on_recv_setup_rsp:
nexus:0x7f6ddc0160b0, trans_hndl:0x7f6ddc0162d0


2015-07-15 09:54:07.795445 7f6de9ac4700 20 [trace]
xio_rdma_verbs.c:240 xio_reg_mr_ex_dev - before ibv_reg_mr


2015-07-15 09:54:07.798625 7f6de9ac4700 20 [trace]
xio_rdma_verbs.c:242 xio_reg_mr_ex_dev - after ibv_reg_mr


2015-07-15 09:54:07.798633 7f6de9ac4700 20 [trace]
xio_rdma_verbs.c:240 xio_reg_mr_ex_dev - before ibv_reg_mr


2015-07-15 09:54:07.798929 7f6de9ac4700 20 [trace]
xio_rdma_verbs.c:242 xio_reg_mr_ex_dev - after ibv_reg_mr


2015-07-15 09:54:07.798940 7f6de9ac4700  2 [debug]
xio_rdma_management.c:1572 xio_rdma_primary_pool_slab_pre_create -
pool buf:0x7f6de25a1000, mr:0x7f6ddc015d40


2015-07-15 09:54:07.799371 7f6de9ac4700  2 [debug]
xio_session_client.c:793 xio_client_on_nexus_event - session:
[notification] - nexus established. session:0x7f6de40558f0,
nexus:0x7f6ddc0160b0


2015-07-15 09:54:07.799376 7f6de9ac4700  2 [debug]
xio_connection.c:2030 xio_connection_send_hello_req - send hello
request. session:0x7f6de40558f0, connection:0x7f6de4056e20


2015-07-15 09:54:07.799522 7f6de9ac4700  2 [debug]
xio_connection.c:2643 xio_on_connection_hello_rsp_recv - recv hello
response. session:0x7f6de40558f0, connection:0x7f6de4056e20


2015-07-15 09:54:07.799530 7f6de9ac4700  2 [debug]
xio_connection.c:2647 xio_on_connection_hello_rsp_recv - got hello
response. session:0x7f6de40558f0, connection:0x7f6de4056e20


2015-07-15 09:54:07.799533 7f6de9ac4700  4 session event: connection
established. reason: Success

2015-07-15 09:54:07.799538 7f6de9ac4700  2 connection established
0x7f6de4056e20 session 0x7f6de40558f0 xcon 0x7f6de4055460

2015-07-15 09:54:07.799541 7f6de9ac4700  2 learned my addr
10.13.10.189:0/1003368

2015-07-15 09:54:07.799546 7f6de9ac4700  2 client: connected from
10.13.10.189:49134/0 to 10.13.10.189:6800/0

2015-07-15 09:54:07.799576 7f6de9ac4700 11 on_msg_delivered xcon:
0x7f6de4055460 session: 0x7f6de40558f0 msg: 0x7f6df014f160 sn: 0 type:
17 tid: 0 seq: 1

2015-07-15 09:54:07.804553 7f6de9ac4700 10 on_msg_req receive req treq
0x7f6de8162598 msg_cnt 1 iov_base 0x7f6de31f1060 iov_len 216 nents 1
conn 0x7f6de4056e20 sess 0x7f6de40558f0 sn 0

2015-07-15 09:54:07.804564 7f6de9ac4700  4 on_msg_req msg_seq.size()=1

2015-07-15 09:54:07.804590 7f6de9ac4700 10 on_msg_req receive req treq
0x7f6de8160178 msg_cnt 1 iov_base 0x7f6de31e7060 iov_len 216 nents 1
conn 0x7f6de4056e20 sess 0x7f6de40558f0 sn 1

2015-07-15 09:54:07.804594 7f6de9ac4700  4 on_msg_req msg_seq.size()=1

mon/MonMap.h: In function 'void MonMap::calc_ranks()' thread
7f6de92c3700 time 2015-07-15 09:54:07.804654

mon/MonMap.h: 47: FAILED assert(addr_name.count(p->second) == 0)

 ceph version 9.0.1-1494-g8fc0496 (8fc049664bc798432e1750da86b1f216f85a842d)

 1: (()+0x12637b) [0x7f6df585037b]

 2: (()+0x1bf86d) [0x7f6df58e986d]

 3: (()+0x1b6709) [0x7f6df58e0709]

 4: (()+0x1b7177) [0x7f6df58e1177]

 5: (()+0x2faa27) [0x7f6df5a24a27]

 6: (()+0x30fd2d) [0x7f6df5a39d2d]

 7: (()+0x3100b0) [0x7f6df5a3a0b0]

 8: (()+0x8182) [0x7f6dfa785182]

 9: (clone()+0x6d) [0x7f6dfa4b247d]

 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

terminate called after throwing an instance of 'ceph::FailedAssertion'

Aborted (core dumped) -> No Idea where this core is! looked at PWD, & /var/crash



Any help / pointers greatly appreciated (-:

-Neo



On Sun, Jul 12, 2015 at 1:25 AM, Joao Eduardo Luis <joao@suse.de> wrote:
> On 07/10/2015 11:31 PM, kernel neophyte wrote:
>> Hi,
>>
>> I am seeing the following error every time I am trying to manually
>> deploy ceph cluster and do a ceph -s :
>>
>> mon/MonMap.h: In function 'void MonMap::calc_ranks()' thread
>> 7fb3ccfb6700 time 2015-07-10 15:27:56.004148
>>
>> mon/MonMap.h: 47: FAILED assert(addr_name.count(p->second) == 0)
>
> Please send us a copy of your monmap and ceph.conf.
>
> You should also open a ticket on the tracker.
>
> Thanks!
>
>   -Joao
>
>>
>>  ceph version 9.0.1-1445-g4a179ee (4a179eea527f7cbcf45eed4a63ad0fa8f744fc4a)
>>
>>  1: (()+0x12716b) [0x7fb3d53ec16b]
>>
>>  2: (()+0x1c0a6d) [0x7fb3d5485a6d]
>>
>>  3: (()+0x1b7909) [0x7fb3d547c909]
>>
>>  4: (()+0x1b8377) [0x7fb3d547d377]
>>
>>  5: (()+0x2fbbe7) [0x7fb3d55c0be7]
>>
>>  6: (()+0x310f1d) [0x7fb3d55d5f1d]
>>
>>  7: (()+0x3112a0) [0x7fb3d55d62a0]
>>
>>  8: (()+0x8182) [0x7fb3d9e05182]
>>
>>  9: (clone()+0x6d) [0x7fb3d9b3247d]
>>
>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
>>
>> terminate called after throwing an instance of 'ceph::FailedAssertion'
>>
>> Aborted (core dumped)
>>
>> Any help greatly appreciated :-)
>>
>> -Neo
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
