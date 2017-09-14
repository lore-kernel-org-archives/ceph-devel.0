From: Two Spirit <twospirit6905@gmail.com>
Subject: which mds server is damaged?
Date: Wed, 13 Sep 2017 18:49:34 -0700
Message-ID: <CAKRxpus_QKHx=Wi8UU-g50i8g3nkEKdg2mGVcu_uO5FbAoHHFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:44349 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbdINBtf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Sep 2017 21:49:35 -0400
Received: by mail-it0-f51.google.com with SMTP id r131so1181536itc.1
        for <ceph-devel@vger.kernel.org>; Wed, 13 Sep 2017 18:49:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I don't think there is a Troubleshooting MDS section. Nice to have one.

I'm not sure how to read "cephfs-0/1/1" as to what the 3 digits are.
It is unclear to me if I have 3 or 4 MDS. I thought i only setup 3,
but I think it telling me I actually have 4.
I can't figure out which server is the damaged MDS. The ceph mds dump
said "damaged 0".
Since "ceph -s' is saying I only have 1 damaged mds, I should be able
to remove it.

how do I go from mds.0 to a physical hostname?

$ ceph mds rmfailed 0 --yes-i-really-mean-it
removed failed mds.1:0

I thought I asked it to remove mds.0, but it looks like I'm removing mds.1

$ ceph health detail
MDS_DAMAGE 1 mds daemon damaged
    fs cephfs mds.0 is damaged

  services
    mds: cephfs-0/1/1 up , 3 up:standby, 1 damaged

$ ceph mds dump
dumped fsmap epoch 632
fs_name cephfs
epoch   632
flags   d
created 2017-08-24 14:35:33.735399
modified        2017-08-24 14:35:33.735400
tableserver     0
root    0
session_timeout 60
session_autoclose       300
max_file_size   1099511627776
last_failure    0
last_failure_osd_epoch  1828
compat  compat={},rocompat={},incompat={1=base v0.20,2=client
writeable ranges,3=default file layouts on dirs,4=dir inode in
separate object,5=mds uses versioned encoding,6=dirfrag is stored in
omap,8=file layout v2}
max_mds 1
in      0
up      {}
failed
damaged 0
stopped
data_pools      [5]
metadata_pool   6
inline_data     disabled
balancer
standby_count_wanted    1
