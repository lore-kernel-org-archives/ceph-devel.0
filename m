From: Thomas Mueller <thomas@chaschperli.ch>
Subject: cfuse abort on file delete (0.20.2)
Date: Fri, 28 May 2010 09:44:20 +0000 (UTC)
Message-ID: <hto39j$l6k$4@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:55004 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755261Ab0E1Jo2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 28 May 2010 05:44:28 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OHw79-0000ZH-Jj
	for ceph-devel@vger.kernel.org; Fri, 28 May 2010 11:44:27 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 28 May 2010 11:44:27 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 28 May 2010 11:44:27 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi 

saw the new version 0.20.2 and compiled it. now i'm able to create more than 3 10mb files. :)

i created 10mb files for testing with 

# for i in $(seq 1 100); do  dd if=/dev/zero of=test${i} bs=1M count=10; done

then tried to delete the files:

# rm -f test*

result (many):
rm: cannot remove `test84': Transport endpoint is not connected

see below for output of cfuse.

with the following command i can reproduce the behavoiur:

for i in $(seq 200 300); do  dd if=/dev/zero of=test${i} bs=1M count=10; done; rm -f test*;

after restarting the cfuse mount I can successfully delete the files.

- Thomas

output of cfuse:

# cfuse /mnt
mounting ceph
10.05.28 11:31:35.633016 4193a940 monclient(hunting): found mon0
starting fuse
ceph_fuse_ll_main starting fuse on pid 18223

./include/xlist.h: In function 'xlist<T>::~xlist() [with T = ObjectCacher::Object*]':
./include/xlist.h:63: FAILED assert(_size == 0)
 1: (Client::put_inode(Inode*, int)+0x180) [0x48bec0]
 2: (Client::_ll_put(Inode*, int)+0x69) [0x48c059]
 3: (Client::ll_forget(vinodeno_t, int)+0x447) [0x48c5b7]
 4: cfuse [0x46af40]
 5: (fuse_session_loop()+0x75) [0x35bdc0ede5]
 6: (ceph_fuse_ll_main(Client*, int, char const**)+0x18c) [0x46979c]
 7: (main()+0x187) [0x44e3e7]
 8: (__libc_start_main()+0xf4) [0x3888c1d994]
 9: (__gxx_personality_v0()+0x1c1) [0x44e149]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
./include/xlist.h: In function 'xlist<T>::~xlist() [with T = ObjectCacher::Object*]':
./include/xlist.h:63: FAILED assert(_size == 0)
 1: (Client::put_inode(Inode*, int)+0x180) [0x48bec0]
 2: (Client::_ll_put(Inode*, int)+0x69) [0x48c059]
 3: (Client::ll_forget(vinodeno_t, int)+0x447) [0x48c5b7]
 4: cfuse [0x46af40]
 5: (fuse_session_loop()+0x75) [0x35bdc0ede5]
 6: (ceph_fuse_ll_main(Client*, int, char const**)+0x18c) [0x46979c]
 7: (main()+0x187) [0x44e3e7]
 8: (__libc_start_main()+0xf4) [0x3888c1d994]
 9: (__gxx_personality_v0()+0x1c1) [0x44e149]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
terminate called after throwing an instance of 'ceph::FailedAssertion*'
Aborted


