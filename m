From: Kostis Fardelas <dante1234@gmail.com>
Subject: Suiciding and corrupted OSDs zero out Ceph cluster IO
Date: Fri, 16 Sep 2016 12:11:39 +0300
Message-ID: <CAN3wisVcObOWrSey3xXNwuLMNidncc+NSTOFvSNKiAJ9P-oCDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:34762 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754476AbcIPJTH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Sep 2016 05:19:07 -0400
Received: by mail-qt0-f176.google.com with SMTP id 38so40255124qte.1
        for <ceph-devel@vger.kernel.org>; Fri, 16 Sep 2016 02:19:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

(sent this email to ceph-users too, but there was no feedback due to
to its complex issues I guess, so I am sending this in ceph-devel too.
Thanks)

Hello cephers,
last week we survived a 3-day outage on our ceph cluster (Hammer
0.94.7, 162 OSDs, 27 "fat" nodes, 1000s of clients) due to 6 out of
162 OSDs crash in the SAME node. The outage was caused in the
following timeline:
time 0:  OSDs living in the same node (rd0-19) start heavily flapping
(in the logs: failed, wrongly marked me down, RESETSESSION etc). Some
more OSDs on other nodes are also flapping but the OSDs of this single
node seem to have played the major part in this problem

time +6h: rd0-19 OSDs assert. Two of them suicide on OSD::osd_op_tp
thread timeout and the other ones assert with EPERM and corrupted
leveldb related errors. Something like this:

2016-09-10 02:40:47.155718 7f699b724700  0 filestore(/rados/rd0-19-01)
 error (1) Operation not permitted not handled on operation 0x46db2d00
(1731767079.0.0, or op 0, counting from 0)
2016-09-10 02:40:47.155731 7f699b724700  0 filestore(/rados/rd0-19-01)
unexpected error code
2016-09-10 02:40:47.155732 7f699b724700  0 filestore(/rados/rd0-19-01)
 transaction dump:
{
    "ops": [
        {
            "op_num": 0,
            "op_name": "omap_setkeys",
            "collection": "3.b30_head",
            "oid": "3\/b30\/\/head",
            "attr_lens": {
                "_epoch": 4,
                "_info": 734
            }
        }
    ]
}


2016-09-10 02:40:47.155778 7f699671a700 -1 os/FileStore.cc: In
function 'unsigned int
FileStore::_do_transaction(ObjectStore::Transaction&, uint64_t, int,
ThreadPool::TPH
andle*)' thread 7f699671a700 time 2016-09-10 02:40:47.153544
os/FileStore.cc: 2761: FAILED assert(0 == "unexpected error")

This leaves the cluster in a state like below:
2016-09-10 03:04:31.927635 mon.0 62.217.119.14:6789/0 948003 : cluster
[INF] osdmap e281474: 162 osds: 156 up, 156 in
2016-09-10 03:04:32.145074 mon.0 62.217.119.14:6789/0 948004 : cluster
[INF] pgmap v105867219: 28672 pgs: 1
active+recovering+undersized+degraded, 26684 active+clean, 1889
active+undersized+degraded, 98 down+peering; 95983 GB data, 179 TB
used, 101379 GB / 278 TB avail; 12106 B/s rd, 11 op/s;
2408539/69641962 objects degraded (3.458%); 1/34820981 unfound
(0.000%)

From this time we have almost no IO propably due to 98 down+peering
PGs, 1 unfound object and 1000s of librados clients stuck.
As of now, we have not managed to pinpoint what caused the crashes (no
disk errors, no network errors, no general hardware errors, nothing in
dmesg) but things are still under investigation. Finally we managed to
bring up enough crashed OSDs for IO to continue (using gdb, leveldb
repairs, ceph-objectstore-tool), but our main questions exists:

A. the 6 OSDs were on the same node. What is so special about
suiciding + EPERMs that leave the cluster with down+peering and zero
IO? Is this a normal behaviour after a crash like this? Notice that
the cluster has marked the crashed OSDs down+out, so it seems that the
cluster somehow "fenced" these OSDs but in a manner that leaves the
cluster unusable. Our crushmap is the default one with the host as a
failure domain
B. would replication=3 help? Would we need replication=3 and min=2 to
avoid such a problem in the future? Right now we are on size=2 &
min_size=1
C. would an increase in suicide timeouts help for future incidents like this?
D. are there any known related bugs on 0.94.7? Haven't found anything so far...

Regards,
Kostis
