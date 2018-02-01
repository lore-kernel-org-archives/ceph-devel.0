From: Ugis <ugis22@gmail.com>
Subject: rbd + btrfs freezes
Date: Thu, 1 Feb 2018 13:26:51 +0200
Message-ID: <CAE63xUPO8SrDCGBrmRsJi-KE--PbKRxP1yPcuz0LfQCfcK9DLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:51616 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbeBAL0w (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Feb 2018 06:26:52 -0500
Received: by mail-it0-f44.google.com with SMTP id p139so3781958itb.1
        for <ceph-devel@vger.kernel.org>; Thu, 01 Feb 2018 03:26:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
when btrfs on rbd is mounted it randomly freezes on reading and
definitely freezes on writes with messages in dmesg as below.


Ceph cluster side all osds 12.2.2
#rbd feature disable pool/rbdX object-map fast-diff deep-flatten
(other way kernel refuses to perform rbd map)

#rbd info pool/rbdX
rbd image 'rbdX':
        size 102400 MB in 25600 objects
        order 22 (4096 kB objects)
        block_name_prefix: rbd_data.ce75cb2ae8944a
        format: 2
        features: layering, exclusive-lock
        flags:
        create_timestamp: Wed Jan 31 22:27:05 2018


client side:
#mkfs.btrfs -L some /dev/rbd0
this detected rbd0 as SSD disk(which it is not) and performed trim
copied ~30GB data into new btrfs filesystem
reboot was done

afterwards freezing of io in btrfs mount happened with the following in dmesg:
# dmesg -T | tail -n 20
[Thu Feb  1 13:01:00 2018] rbd: rbd0: client30307895 seems dead, breaking lock
[Thu Feb  1 13:01:00 2018] rbd: rbd0: blacklist of client30307895 failed: -13
[Thu Feb  1 13:01:00 2018] rbd: rbd0: failed to acquire lock: -13
[Thu Feb  1 13:01:00 2018] rbd: rbd0: no lock owners detected
[Thu Feb  1 13:01:01 2018] rbd: rbd0: client30307895 seems dead, breaking lock
[Thu Feb  1 13:01:01 2018] rbd: rbd0: blacklist of client30307895 failed: -13
[Thu Feb  1 13:01:01 2018] rbd: rbd0: failed to acquire lock: -13
[Thu Feb  1 13:01:01 2018] rbd: rbd0: no lock owners detected
[Thu Feb  1 13:01:01 2018] rbd: rbd0: client30307895 seems dead, breaking lock
[Thu Feb  1 13:01:01 2018] rbd: rbd0: blacklist of client30307895 failed: -13
[Thu Feb  1 13:01:01 2018] rbd: rbd0: failed to acquire lock: -13
[Thu Feb  1 13:01:01 2018] rbd: rbd0: no lock owners detected
[Thu Feb  1 13:01:01 2018] rbd: rbd0: client30307895 seems dead, breaking lock
[Thu Feb  1 13:01:01 2018] rbd: rbd0: blacklist of client30307895 failed: -13
[Thu Feb  1 13:01:01 2018] rbd: rbd0: failed to acquire lock: -13
[Thu Feb  1 13:01:01 2018] rbd: rbd0: no lock owners detected
[Thu Feb  1 13:01:01 2018] rbd: rbd0: client30307895 seems dead, breaking lock
[Thu Feb  1 13:01:01 2018] rbd: rbd0: blacklist of client30307895 failed: -13
[Thu Feb  1 13:01:01 2018] rbd: rbd0: failed to acquire lock: -13
[Thu Feb  1 13:01:01 2018] rbd: rbd0: no lock owners detected

# uname -a
Linux name 4.15.0-041500-generic #201801282230 SMP Sun Jan 28 22:31:30
UTC 2018 x86_64 x86_64 x86_64 GNU/Linux

# modinfo rbd
filename:       /lib/modules/4.15.0-041500-generic/kernel/drivers/block/rbd.ko
license:        GPL
description:    RADOS Block Device (RBD) driver
author:         Jeff Garzik <jeff@garzik.org>
author:         Yehuda Sadeh <yehuda@hq.newdream.net>
author:         Sage Weil <sage@newdream.net>
author:         Alex Elder <elder@inktank.com>
srcversion:     CF9C498AB3890D4BD4377D5
depends:        libceph
intree:         Y
name:           rbd
vermagic:       4.15.0-041500-generic SMP mod_unload
parm:           single_major:Use a single major number for all rbd
devices (default: true) (bool)

Here is the full output for new btrfs formatting on rbd as I did not
save first one:
-------------------
# mkfs.btrfs -L some /dev/rbd2
btrfs-progs v4.4
See http://btrfs.wiki.kernel.org for more information.

Detected a SSD, turning off metadata duplication.  Mkfs with -m dup if
you want to force metadata duplication.
Performing full device TRIM (5.00GiB) ...
Label:              some
UUID:               325fb099-1082-4a26-b509-b74ae68e960a
Node size:          16384
Sector size:        4096
Filesystem size:    5.00GiB
Block group profiles:
  Data:             single            8.00MiB
  Metadata:         single            8.00MiB
  System:           single            4.00MiB
SSD detected:       yes
Incompat features:  extref, skinny-metadata
Number of devices:  1
Devices:
   ID        SIZE  PATH
    1     5.00GiB  /dev/rbd2
---------------

This rather seems to be rbd problem. Is it a bug? Any suggestions for
the workaround?


Best regards
Ugis
