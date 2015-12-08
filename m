From: Rongze Zhu <zrzhit@gmail.com>
Subject: Long time between waiting_for_osdmap event and reached_pg event in dump_historic_ops
Date: Wed, 9 Dec 2015 01:56:36 +0800
Message-ID: <CAMXgYGbc8Z2XOpaB-b_-0VyoM+XAy5pFQk2EazMeA=VXd-0g6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:36168 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbbLHR4h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Dec 2015 12:56:37 -0500
Received: by iofh3 with SMTP id h3so32301603iof.3
        for <ceph-devel@vger.kernel.org>; Tue, 08 Dec 2015 09:56:36 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi guys,

I found out a strange issue in a  ceph cluster. This ceph cluster is used
for OpenStack cluster, there are 70 VMs in the cluster.  There are many
slow request(osd_op_complaint_time = 3) in the ceph cache tier with high
load( more than 3000 ops, 90% write).

After the investigation, I found that sometimes the interval time between
waiting_for_osdmap event and reached_pg event in the op will be very
long(may be 10 ~ 100 seconds). This means that some ops will stay op_wq
queue very long, until the osd op threads process it.

What reasons can cause this issue? Before anyone encountered this
situation?  I think that osdmap,pg lock,object lock can't block osd op
thread so long(10s ~ 100 seconds).


hardware(total 11 nodes):
    - 6 x nodes(compute & storage):
        - 3 x nodes: HUAWEI RH2288H V2 server, 2xE5-2658, 256GB,
            - 1 x HUAWEI SSD disk 800GB, used for ceph osd
            - 12 x 1.2TB SAS disk(each raid0 has 4 sas disk), used for ceph
        - 3 x nodes: HP DL380 Gen9 server,  2xE5-2640, 128GB,
            - 2 x OCZ SSD disk 800GB, used for ceph
            - 12 x 1.2TB SAS disk(each raid0 has 4 sas disk), used for ceph
    - 5 x nodes (compute)

os:
    - HUAWEI server: RHEL 6.4, 2.6.32-358.123.2.openstack
    - HP DL380 Gen9 server: RHEL 6.5, 2.6.32-431.el6.x86_64

ceph:
    - ceph 0.80.10
    - 9 ssd osd for cache tier
    - 18 raid0 osd for storage tier
    - replication size = 2
    - pg num = 1024
    - osd op thread = 20
    - filestore op thread = 20

dump_historic_ops(osd.4  ssd):

        { "description": "osd_op(client.983894.0:8044023
rbd_data.468d085e74d0.00000000000031b9 [] 4.5605c210 ack+ondisk+write
e11409)",
          "received_at": "2015-12-08 13:31:49.645295",
          "age": "100.252129",
          "duration": "25.419458",
          "type_data": [
                "commit sent; apply or cleanup",
                { "client": "client.983894",
                  "tid": 8044023},
                [
                    { "time": "2015-12-08 13:31:49.645616",
                      "event": "waiting_for_osdmap"},
                    { "time": "2015-12-08 13:32:01.529474",
                      "event": "reached_pg"},
                    { "time": "2015-12-08 13:32:01.529557",
                      "event": "started"},
                    { "time": "2015-12-08 13:32:01.529575",
                      "event": "started"},
                    { "time": "2015-12-08 13:32:01.529642",
                      "event": "waiting for subops from 25"},
                    { "time": "2015-12-08 13:32:01.530340",
                      "event": "commit_queued_for_journal_write"},
                    { "time": "2015-12-08 13:32:01.531270",
                      "event": "write_thread_in_journal_buffer"},
                    { "time": "2015-12-08 13:32:01.533131",
                      "event": "journaled_completion_queued"},
                    { "time": "2015-12-08 13:32:01.533412",
                      "event": "sub_op_commit_rec"},
                    { "time": "2015-12-08 13:32:05.813736",
                      "event": "op_commit"},
                    { "time": "2015-12-08 13:32:05.814035",
                      "event": "commit_sent"},
                    { "time": "2015-12-08 13:32:15.064722",
                      "event": "op_applied"},
                    { "time": "2015-12-08 13:32:15.064753",
                      "event": "done"}]]}]}


--
Rongze Zhu
