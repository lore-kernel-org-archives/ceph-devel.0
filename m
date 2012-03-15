From: madhusudhana <madhusudhana.u.acharya@gmail.com>
Subject: ceph -w command output in newly setup cluster
Date: Thu, 15 Mar 2012 17:43:34 +0000 (UTC)
Message-ID: <loom.20120315T183916-860@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48273 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032051Ab2CORnz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Mar 2012 13:43:55 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S8EiM-0003VD-7A
	for ceph-devel@vger.kernel.org; Thu, 15 Mar 2012 18:43:50 +0100
Received: from Static-180.119.99.14.tataidc.co.in ([Static-180.119.99.14.tataidc.co.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 15 Mar 2012 18:43:50 +0100
Received: from madhusudhana.u.acharya by Static-180.119.99.14.tataidc.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 15 Mar 2012 18:43:50 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
I have created a fresh ceph cluster using ver 0.43 and kernel 3.2.11. After 
setting up the clutser and running mkcephfs and init-ceph, i am seeing below
output for ceph -w output. I am sure, something is wrong. can you help me to 
find what can be the error.


[root@ceph-node-8 ~]# ceph -w
2012-03-15 23:07:27.849695 7f4743849760 -- :/0 messenger.start
2012-03-15 23:07:27.850704 7f4743849760 -- :/2957 --> 10.25.12.125:6789/0 -- 
auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x1652990 con 0x1652600
2012-03-15 23:07:30.850719 7f4741b78700 -- :/2957 mark_down 0x1652600 -- 
0x1652390
2012-03-15 23:07:30.851147 7f4741b78700 -- :/2957 --> 10.25.12.124:6789/0 -- 
auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x7f473c000ec0 con 0x7f473c000b30
2012-03-15 23:07:33.851588 7f4741b78700 -- :/2957 mark_down 0x7f473c000b30 -- 
0x7f473c0008c0
2012-03-15 23:07:33.851730 7f4741b78700 -- :/2957 --> 10.25.12.126:6789/0 -- 
auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x7f473c0017e0 con 0x7f473c001670


Below is my ceph.conf file


[global]
        ;auth supported = cephx
        keyring = /etc/ceph/admin.keyring
        debug ms = 1
        debug mds = 10

[mon]
        mon data = /data/mon.$id

[mon.a]
        host = ceph-node-4
        mon addr = xx.xx.xx.xxx:6789

[mon.b]
        host = ceph-node-5
        mon addr = xx.xx.xx.xxx:6789

[mon.c]
        host = ceph-node-6
        mon addr = xx.xx.xx.xxx:6789
[mds]
        keyring = /etc/ceph/keyring.$name

[mds.ceph-node-7]
        host = ceph-node-7

[mds.ceph-node-8]
        host = ceph-node-8

[osd]
        osd data = /data/osd.$id
        keyring = /etc/ceph/keyring.$name
        osd journal = /data/osd.$id.journal
        osd journal size = 10000
        debug ms = 1
        debug osd = 20
        debug filestore = 20
        debug journal = 20



[osd.0]
        host = ceph-node-1
        btrfs devs = /dev/sda4

[osd.1]
        host = ceph-node-2
        btrfs devs = /dev/sda4

[osd.2]
        host = ceph-node-3
        btrfs devs = /dev/sda4


