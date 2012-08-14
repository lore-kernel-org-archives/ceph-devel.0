From: hemant surale <hemant.surale@gmail.com>
Subject: Ceph setup on single node : prob with "
Date: Tue, 14 Aug 2012 15:43:17 +0530
Message-ID: <CAGfy=6mCWNY4mn2_H3b=8FENmY=2SGXUB78RObprSdvzye_h1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37967 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755614Ab2HNKNS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Aug 2012 06:13:18 -0400
Received: by yhmm54 with SMTP id m54so206948yhm.19
        for <ceph-devel@vger.kernel.org>; Tue, 14 Aug 2012 03:13:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all ,
 i have prob while executing "sudo mkcephfs -a -c /etc/ceph/ceph.conf
-k ceph.keyring"  ERROR :
*****************************************************************************************************************
root@hemant-virtual-machine:/etc/ceph# mkcephfs -a -c ceph.conf -k ceph.keyring
temp dir is /tmp/mkcephfs.n6zx4y4y33
preparing monmap in /tmp/mkcephfs.n6zx4y4y33/monmap
/usr/bin/monmaptool --create --clobber --add alpha 10.72.147.249:6789
--print /tmp/mkcephfs.n6zx4y4y33/monmap
/usr/bin/monmaptool: monmap file /tmp/mkcephfs.n6zx4y4y33/monmap
/usr/bin/monmaptool: generated fsid d4173bb9-61c9-4339-a5fa-e1edfe143d2e
epoch 0
fsid d4173bb9-61c9-4339-a5fa-e1edfe143d2e
last_changed 2012-08-14 14:31:29.350163
created 2012-08-14 14:31:29.350163
0: 10.72.147.249:6789/0 mon.alpha
/usr/bin/monmaptool: writing epoch 0 to
/tmp/mkcephfs.n6zx4y4y33/monmap (1 monitors)
=== osd.0 ===
2012-08-14 14:31:29.390410 7fe3b920e780  ** ERROR: error creating
empty object store in /ceph_data/osd.0: (2) No such file or directory
failed: '/sbin/mkcephfs -d /tmp/mkcephfs.n6zx4y4y33 --init-daemon osd.0'
***********************************************************************************************************************************


i have followed following cmds to install ceph

wget -q -O- https://raw.github.com/ceph/ceph/master/keys/release.asc |
sudo apt-key add -

echo deb http://ceph.com/debian/ $(lsb_release -sc) main | sudo tee
/etc/apt/sources.list.d/ceph.list

wget -q -O- https://raw.github.com/ceph/ceph/master/keys/autobuild.asc
\ | sudo apt-key add -

echo deb http://gitbuilder.ceph.com/ceph-deb-$(lsb_release
-sc)-x86_64-basic/ref/{BRANCH} $(lsb_release -sc) main | sudo tee
/etc/apt/sources.list.d/ceph.list

sudo apt-get update && sudo apt-get install ceph

then i hv created ceph.conf file

after that i tried to deploy it with mkcephfs
and "sudo mkcephfs -a -c /etc/ceph/ceph.conf -k ceph.keyring" gives an
error as discussed .

Please help me out..

-Hemant Surale
