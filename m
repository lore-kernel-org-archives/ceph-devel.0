From: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Subject: How can I mount my Ceph cluster?
Date: Thu, 22 Mar 2012 10:39:04 +0800
Message-ID: <CALwGbPKR4M3khtKRCG_=UgOXFV5rVjrV6GdbQg5moLQiFU4vcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53600 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab2CVCjE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 22:39:04 -0400
Received: by iagz16 with SMTP id z16so2445388iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 19:39:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've written my config file at follow:

[global]
	auth supported = cephx
	keyring = /etc/ceph/$name.keyring

[mon]
	mon data = /srv/mon.$id

[mds]

[osd]
	osd data = /srv/osd.$id
	osd journal = /srv/osd.$id.journal
	osd journal size = 1000

[mon.a]
	host = deltamaster-ceph-1
	mon addr = 127.0.0.1:6789

[osd.0]
	host = deltamaster-ceph-1
	btrfs devs = /dev/sda6

...And start ceph

=== mon.a ===
mon.a: running...
=== osd.0 ===
osd.0: running...
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/sda7       15790076 4157688  10840172  28% /
udev              505100       4    505096   1% /dev
tmpfs             204960     828    204132   1% /run
none                5120       0      5120   0% /run/lock
none              512400     200    512200   1% /run/shm
/dev/sda1         192534   33580    149226  19% /boot
/dev/sda6        2928640    1256   2607104   1% /srv/osd.0
kernel/fs/ceph/ceph.ko
kernel/net/ceph/libceph.ko

Is it correct to type "mount -t ceph 127.0.0.1:/ /mnt/ceph"?
Why it tells me "source mount path was not specified"?
