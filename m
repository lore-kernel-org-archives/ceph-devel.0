From: effie mouzeli <emouzeli@cern.ch>
Subject: Ceph and SL5.5
Date: Sat, 17 Jul 2010 05:12:38 +0100
Message-ID: <EE7C26DD-410B-4169-9EFD-98B6D682B216@cern.ch>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx30.cern.ch ([137.138.144.177]:16942 "EHLO
	CERNMX30.cern.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab0GQESD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Jul 2010 00:18:03 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello all, 

I am trying to check out how Ceph is doing under Scientific Linux 5.5 (unfortunately, academia loves SL). 

Currently I am running a cluster of 2 VMs, VM 1 is mon, mds and osd,  VM 2 is running osd only, and VM 3 is where I mount ceph.  All VMs  are running  SL5.5 x86_64 with the latest updates  and are on a gbit network. Additionally  I compiled ceph from source, (checked out  yesterday), with fuse support, since SL5.5 has a 2.6.18 kernel...

Using the fuse client, and a very simple configuration file, I am facing the following issues: 

- When adding files 120mb<  to the filesystem, the following messages appear, and the the writing speed slows   down (mon reports that all authenticated osds are up and running)

client4314.objecter  pg 0.aae5 on [1,0] is laggy: 157
client4314.objecter  pg 0.d2d0 on [0,1] is laggy: 175
client4314.objecter  pg 0.b7a6 on [1,0] is laggy: 171
client4314.objecter  pg 0.6031 on [0,1] is laggy: 173

- Additionally, when trying to delete a file, cfuse crashes:

./include/xlist.h: In function 'xlist<T>::~xlist() [with T = ObjectCacher::Object*]':
./include/xlist.h:63: FAILED assert(_size == 0)
 1: (xlist<ObjectCacher::Object*>::~xlist()+0x30) [0x658ed4]
 2: (ObjectCacher::ObjectSet::~ObjectSet()+0x2f) [0x658f51]
 3: (Inode::~Inode()+0x10e) [0x673b68]
 4: (Client::put_inode(Inode*, int)+0x10f) [0x6181d3]
 5: (Client::_ll_put(Inode*, int)+0x116) [0x61866a]
 6: (Client::ll_forget(vinodeno_t, int)+0x37a) [0x618a06]
 7: cfuse [0x605db1]
 8: (fuse_session_loop()+0x75) [0x2af02b790de5]
 9: (ceph_fuse_ll_main(Client*, int, char const**)+0x24a) [0x60431a]
 10: (main()+0x275) [0x5e1835]
 11: (__libc_start_main()+0xf4) [0x3d7361d994]
 12: (__gxx_personality_v0()+0x2a1) [0x5e1479]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
./include/xlist.h: In function 'xlist<T>::~xlist() [with T = ObjectCacher::Object*]':
./include/xlist.h:63: FAILED assert(_size == 0)
 1: (xlist<ObjectCacher::Object*>::~xlist()+0x30) [0x658ed4]
 2: (ObjectCacher::ObjectSet::~ObjectSet()+0x2f) [0x658f51]
 3: (Inode::~Inode()+0x10e) [0x673b68]
 4: (Client::put_inode(Inode*, int)+0x10f) [0x6181d3]
 5: (Client::_ll_put(Inode*, int)+0x116) [0x61866a]
 6: (Client::ll_forget(vinodeno_t, int)+0x37a) [0x618a06]
 7: cfuse [0x605db1]
 8: (fuse_session_loop()+0x75) [0x2af02b790de5]
 9: (ceph_fuse_ll_main(Client*, int, char const**)+0x24a) [0x60431a]
 10: (main()+0x275) [0x5e1835]
 11: (__libc_start_main()+0xf4) [0x3d7361d994]
 12: (__gxx_personality_v0()+0x2a1) [0x5e1479]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
terminate called after throwing an instance of 'ceph::FailedAssertion*'
Aborted
---
Ceph.conf
[global]
        auth supported = cephx
        keyring = /etc/ceph/keyring.bin
[mon]
        mon data = /opt/pragmata/monitor0
        debug ms = 1
[mon0]
        host = mpriki1
        mon addr = 10.0.0.10:6789
[mds]
        keyring = /etc/ceph/keyring.$name
[mds.mpriki1]
        host = mpriki1
[osd]
        osd data = /opt/pragmata/data/osd$id
        osd journal = /opt/pragmata/data/osd$id/journal
        keyring = /opt/ceph/keyring.$name
        debug osd = 1
        debug filestore = 1
[osd0]
        host =  mpriki1
        osd journal size = 100
[osd1] 
        host =  mpriki2
        osd journal size = 100  
----------

Under the same setup and ceph v0.20.2, client doesn't crash when I delete a file,  the file looks deleted, but even after a while, ceph has not freed any space. The problem with the laggy client, is present in v0.20.2 as well.

I reckon that installing a newer kernel is one solution, and getting rid of SL5.5 once and for all is possibly another one,  but any ideas on what's causing those issues in this setup, are welcomed. 

Cheers, 

-effie