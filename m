From: RomanS <execooler@gmail.com>
Subject: Create BlueStore OSD by ceph-deploy
Date: Thu, 7 Jul 2016 17:50:54 +0300
Message-ID: <CALBCzHetvH7WzLifV6YOpCL3yhtChm2POsW+mK92zKB-OV-X9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35606 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbcGGOvH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jul 2016 10:51:07 -0400
Received: by mail-wm0-f48.google.com with SMTP id z126so151772187wme.0
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jul 2016 07:51:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi.

I'm trying to create a BlueStore OSD, but it seems something wrong somewhere.

My test environment is Ubuntu 16.04 + Ceph 10.2.2
(45107e21c568dd033c2f0a3107dec8f0b0e58374)

What i did:

I added the following section to my ceph.conf (i don't know how to
create BlueStore OSD on different devices):

[osd.0]
        host = ceph-node-1
        osd data = /var/lib/ceph/osd/ceph-0
        bluestore block path = /dev/sda2
        bluestore block db path = /dev/loop0

After that i did (this stage is OK):

ceph-deploy -v osd prepare --bluestore ceph-node-1:/dev/sda

After that i tried:

ceph-deploy -v osd activate ceph-node-1:/dev/sda1

On this stage i got several different errors:

1. EPERM: /dev/loop0 belongs root, need to chown it to ceph:ceph. I
think this is not a bug, but the documentation has to have a note
about this (big red font :-) )
2. EEXIST: 'prepare' stage creates a filesystem on the partition 1 and
creates required files on it. Also at this stage 'block' symlink is
created. Removing of this symlink helps me 'activate' the OSD. Bug?
3. EACCESS: before i had osd.0. I removed it, stopped the
corresponding daemon, removed the OSD from CRUSH map. But 'activate'
stage did not work. I googled the solution: "ceph auth del osd.0". Why
the removing of OSD does not clean CRUSH, Auth, etc. ?

Why it so complex?

The separate question:
ceph-deploy creates very simple config (without osd and mon sections).
How Ceph will start after reboot?

Thanks.
