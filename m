From: Two Spirit <twospirit6905@gmail.com>
Subject: luminous filesystem is degraded
Date: Sun, 3 Sep 2017 06:14:56 -0700
Message-ID: <CAKRxpusdzy+k=v8nhvfW9Y_zciHYOZSo9U8HNvFovAAnH-eGzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:35285 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752907AbdICNO5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Sep 2017 09:14:57 -0400
Received: by mail-it0-f54.google.com with SMTP id c13so9227597itb.0
        for <ceph-devel@vger.kernel.org>; Sun, 03 Sep 2017 06:14:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Setup: luminous on
Ubuntu 14.04/16.04 mix. 5 OSD. all up. 3 or 4 mds, 3mon,cephx
rebooting all 6 ceph systems did not clear the problem. Failure
occurred within 6 hours of start of test.
similar stress test with 4OSD,1MDS,1MON,cephx worked fine.


stress test
# cp * /mnt/cephfs

# ceph -s
    health: HEALTH_WARN
            1 filesystem is degraded
            crush map has straw_calc_version=0
            1/731529 unfound (0.000%)
            Degraded data redundancy: 22519/1463058 objects degraded
(1.539%), 2 pgs unclean, 2 pgs degraded, 1 pg undersized

  services:
    mon: 3 daemons, quorum xxx233,xxx266,xxx272
    mgr: xxx266(active)
    mds: cephfs-1/1/1 up  {0=xxx233=up:replay}, 3 up:standby
    osd: 5 osds: 5 up, 5 in
    rgw: 1 daemon active


# ceph mds dump
dumped fsmap epoch 590
fs_name cephfs
epoch   589
flags   c
created 2017-08-24 14:35:33.735399
modified        2017-08-24 14:35:33.735400
tableserver     0
root    0
session_timeout 60
session_autoclose       300
max_file_size   1099511627776
last_failure    0
last_failure_osd_epoch  1573
compat  compat={},rocompat={},incompat={1=base v0.20,2=client
writeable ranges,3=default file layouts on dirs,4=dir inode in
separate object,5=mds uses versioned encoding,6=dirfrag is stored in
omap,8=file layout v2}
max_mds 1
in      0
up      {0=579217}
failed
damaged
stopped
data_pools      [5]
metadata_pool   6
inline_data     disabled
balancer
standby_count_wanted    1
579217: x.x.x.233:6804/1176521332 'xxx233' mds.0.589 up:replay seq 2
