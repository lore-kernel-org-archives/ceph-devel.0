From: Vincent Godin <vince.mlist@gmail.com>
Subject: OSD behaviour when an i/o error occurs
Date: Wed, 6 Sep 2017 18:01:54 +0200
Message-ID: <CAL2-6bKnuoT5Fj7+LXepwy8eDve+VXQmtEqrDX3Bn55J2ESKQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33115 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755103AbdIFQB4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Sep 2017 12:01:56 -0400
Received: by mail-qk0-f174.google.com with SMTP id o129so20586541qkd.0
        for <ceph-devel@vger.kernel.org>; Wed, 06 Sep 2017 09:01:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I'd like to understand the behaviour of an OSD daemon when an I/O
error occurs while reading and while writing.
We had some I/O errors while reading during deep-scrub on one OSD and
it's lead to hold all client's requests
Ceph version : Jewel 10.2.6
faulty OSD is a raid 0 on one SATA Disk on a HP SL4540 host

Is there a normal process of handling a I/O error by Ceph ? Is this
probleme linked to my hardware config. The corrupted sector seems not
take in account by the hardware so the error can re-occur a lot of
time on the same sector (maybe a problem with the raid0 between ceph
and the disk)

In the dmesg of the host, we can see the error :

sd 0:1:0:22: [sdw] tag#22 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
sd 0:1:0:22: [sdw] tag#22 Sense Key : Medium Error [current]
sd 0:1:0:22: [sdw] tag#22 Add. Sense: Unrecovered read error
sd 0:1:0:22: [sdw] tag#22 CDB: Read(16) 88 00 00 00 00 00 2e 15 24 e0
00 00 01 00 00 00
blk_update_request: critical medium error, dev sdw, sector 773137632
hpsa 0000:08:00.0: scsi 0:1:0:22: resetting logical Direct-Access HP
LOGICAL VOLUME RAID-0 SSDSmartPathCap- En- Exp=1
hpsa 0000:08:00.0: scsi 0:1:0:22: reset logical completed successfully
Direct-Access HP LOGICAL VOLUME RAID-0 SSDSmartPathCap- En- Exp=1
sd 0:1:0:22: [sdw] tag#10 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
sd 0:1:0:22: [sdw] tag#10 Sense Key : Medium Error [current]
sd 0:1:0:22: [sdw] tag#10 Add. Sense: Unrecovered read error
sd 0:1:0:22: [sdw] tag#10 CDB: Read(16) 88 00 00 00 00 01 e1 39 3c 00
00 00 01 00 00 00
blk_update_request: critical medium error, dev sdw, sector 8073591808

In the OSD log (with a standard level of logging), we can only see the
number of slow requests raising (before the system alarm) and a lot of
timeout of osd_op_tp thread then OSD is marked down by the others.
Nothing on the failed I/O
