From: David Zafman <david.zafman@inktank.com>
Subject: wip-libcephfs-emp-rb
Date: Mon, 7 Oct 2013 16:08:36 -0700
Message-ID: <E22D788C-3F58-460D-B455-47CFC2EE983B@inktank.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:64873 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab3JGXIk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Oct 2013 19:08:40 -0400
Received: by mail-oa0-f54.google.com with SMTP id n5so7184776oag.27
        for <ceph-devel@vger.kernel.org>; Mon, 07 Oct 2013 16:08:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <matt@linuxbox.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


I rebased wip-libcephfs and pushed as wip-libcephfs-emp-rb so that we can get this in to the Emperor release.  Sage mentioned that he had hit a fuse problem in the wip-libcephfs branch, so apparently the problem is still present.  Have you run into this bug in your testing?  Are you testing with these modification to Ceph?

2013-10-04T10:39:01.664 INFO:teuthology.task.workunit.client.0.out:[10.214.132.22]:   CC      kernel/softirq.o
2013-10-04T10:39:02.059 INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]: *** Caught signal (Segmentation fault) **
2013-10-04T10:39:02.059 INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]:  in thread 7f57fa316780
2013-10-04T10:39:02.073 INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]:  ceph version 0.69-500-g09f4df0 (09f4df02a866230b19539b03061f4abc5ab47ae2)
2013-10-04T10:39:02.073 INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]:  1: ceph-fuse() [0x5e0d1a]
2013-10-04T10:39:02.073 INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]:  2: (()+0xfcb0) [0x7f57f9cc5cb0]
2013-10-04T10:39:02.073 INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]:  3: (Client::_get_inodeno(Inode*)+0) [0x52dd10]
2013-10-04T10:39:02.073 INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]:  4: (Client::ll_forget(Inode*, int)+0x4a) [0x538d1a]
2013-10-04T10:39:02.074 INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]:  5: ceph-fuse() [0x52a1c5]
2013-10-04T10:39:02.074 INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]:  6: (fuse_session_loop()+0x75) [0x7f57f9ee3d65]
2013-10-04T10:39:02.074 INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]:  7: (main()+0x84c) [0x5266fc]
2013-10-04T10:39:02.074 INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]:  8: (__libc_start_main()+0xed) [0x7f57f83f576d]
2013-10-04T10:39:02.074 INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]:  9: ceph-fuse() [0x527c99]
2013-10-04T10:39:02.074 INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]: 2013-10-04 10:39:02.072487 7f57fa316780 -1 *** Caught signal (Segmentation fault) **
2013-10-04T10:39:02.074 INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]:  in thread 7f57fa316780

David Zafman
Senior Developer
http://www.inktank.com




