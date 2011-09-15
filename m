From: Atish Kathpal <atish.kathpal@gmail.com>
Subject: mkcephfs giving problems
Date: Thu, 15 Sep 2011 06:14:22 +0000 (UTC)
Message-ID: <loom.20110915T081127-706@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:48042 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754403Ab1IOGUH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Sep 2011 02:20:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1R45Ir-0004lN-JQ
	for ceph-devel@vger.kernel.org; Thu, 15 Sep 2011 08:20:05 +0200
Received: from 202.3.120.4 ([202.3.120.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 15 Sep 2011 08:20:05 +0200
Received: from atish.kathpal by 202.3.120.4 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 15 Sep 2011 08:20:05 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello 

What am I trying? -  To setup single node cluster for Ceph, OSD, MON and MDS on 
same node.
OS: Ubuntu 11.04 (natty)
I installed Ceph following these instructions: 
=================
wget -q -O- https://raw.github.com/NewDreamNetwork/ceph/master/keys/release.asc 
\
| sudo apt-key add -

sudo tee /etc/apt/sources.list.d/ceph.list <<EOF
deb http://ceph.newdream.net/debian/ DISTRO main
deb-src http://ceph.newdream.net/debian/ DISTRO main
EOF

sudo apt-get update
sudo apt-get install ceph
=================

Next I created /etc/ceph.conf file with following contents:
=========
[global]
        auth supported = cephx
       keyring = /etc/ceph/ceph.keyring

[mon]
        mon data = /ceph_data/mon.0

[mds]

[osd]
        osd data = /ceph_data/osd.0
        osd journal = /ceph_data/osd.0.journal
        osd journal size = 1000

[mon.0]
        host = atish-virtual-machine
        mon addr = 10.72.147.207:6789

[osd.0]
        host = atish-virtual-machine

[mds.0]
        host = atish-virtual-machine
===========

Now on running:  mkcephfs -a -c ceph.conf -k ceph.keyring

I get following output:
============
atish@atish-virtual-machine:/etc/ceph$ mkcephfs -a -c ceph.conf -k ceph.keyring
temp dir is /tmp/mkcephfs.dh5U7fAf0a
preparing monmap in /tmp/mkcephfs.dh5U7fAf0a/monmap
/usr/bin/monmaptool --create --clobber --add 0 10.72.147.207:6789 --print 
/tmp/mkcephfs.dh5U7fAf0a/monmap
/usr/bin/monmaptool: monmap file /tmp/mkcephfs.dh5U7fAf0a/monmap
/usr/bin/monmaptool: generated fsid 0fad0467-bfc6-5063-935b-5abd87dbebd5
epoch 1
fsid 0fad0467-bfc6-5063-935b-5abd87dbebd5
last_changed 2011-09-14 20:09:10.557121
created 2011-09-14 20:09:10.557121
0: 10.72.147.207:6789/0 mon.0
/usr/bin/monmaptool: writing epoch 1 to /tmp/mkcephfs.dh5U7fAf0a/monmap (1 
monitors)
=== osd.0 ===
failed to open log file '/var/log/ceph/osd.0.log': error 13: Permission denied
 ** WARNING: Ceph is still under development.  Any feedback can be directed  **
 **          at ceph-devel@vger.kernel.org or http://ceph.newdream.net/.     **
2011-09-14 20:09:10.944686 b77d86e0 AdminSocketConfigObs::init: failed: 
AdminSocket::bind_and_listen: failed to bind the UNIX domain socket to 
'/var/run/ceph/osd.0.asok': error 2: No such file or directory
2011-09-14 20:09:10.944701 b77d86e0 AdminSocketConfigObs: failed to start 
AdminSocket
2011-09-14 20:09:10.946025 b77d86e0 filestore(/ceph_data/osd.0) FileStore::mkfs: 
failed to open /ceph_data/osd.0/fsid: error 13: Permission denied
2011-09-14 20:09:10.946036 b77d86e0 OSD::mkfs: FileStore::mkfs failed with error 
-13
2011-09-14 20:09:10.946243 b77d86e0  ** ERROR: error creating empty object store 
in /ceph_data/osd.0: error 13: Permission denied
failed: '/sbin/mkcephfs -d /tmp/mkcephfs.dh5U7fAf0a --init-daemon osd.0'
atish@atish-virtual-machine:/etc/ceph$
================

Can you please guide me with setting Ceph up correctly? Where have I gone wrong?

Final aim: I intend to use just the Ceph Object Storage - RASOS - with S3/REST.

Waiting for reply.

Regards
Atish

