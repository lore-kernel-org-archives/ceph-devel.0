From: Travis Rhoden <trhoden@gmail.com>
Subject: Latest bobtail branch still crashing KVM VMs in bh_write_commit()
Date: Wed, 20 Mar 2013 15:49:23 -0400
Message-ID: <CACkq2mrSvLyy9j3HMAEiCHnuktnB_EQbnQ-JvAZcyLcjmjn3uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59112 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab3CTTtt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 15:49:49 -0400
Received: by mail-bk0-f46.google.com with SMTP id j5so1092457bkw.19
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 12:49:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hey folks,

We were hoping this one was fixed.  I upgraded all my nodes to the
latest bobtail branch, but still hit this today:

osdc/ObjectCacher.cc: In function 'void
ObjectCacher::bh_write_commit(int64_t, sobject_t, loff_t, uint64_t,
tid_t, int)' thread 7f650e62f700 time 2013-03-20 19:34:39.952616
osdc/ObjectCacher.cc: 834: FAILED assert(ob->last_commit_tid < tid)
 ceph version 0.56.3-42-ga30903c (a30903c6adaa023587d3147179d6038ad37ca520)
 1: (ObjectCacher::bh_write_commit(long, sobject_t, long, unsigned
long, unsigned long, int)+0xd68) [0x7f651d0ada48]
 2: (ObjectCacher::C_WriteCommit::finish(int)+0x6b) [0x7f651d0b460b]
 3: (Context::complete(int)+0xa) [0x7f651d06c9fa]
 4: (librbd::C_Request::finish(int)+0x85) [0x7f651d09c315]
 5: (Context::complete(int)+0xa) [0x7f651d06c9fa]
 6: (librbd::rados_req_cb(void*, void*)+0x47) [0x7f651d081387]
 7: (librados::C_AioSafe::finish(int)+0x1d) [0x7f651c43163d]
 8: (Finisher::finisher_thread_entry()+0x1c0) [0x7f651c49c920]
 9: (()+0x7e9a) [0x7f6519cffe9a]
 10: (clone()+0x6d) [0x7f6519a2bcbd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

Is this occuring in librbd caching?  If so, I could disable it for the
time being.

First saw this mentioned on-list here:
http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/13577

Will be happy to provide anything I can for this one -- definitely
critical for my use case.  It happens with about 10% of the VMs I
create.  Always within the first 60 seconds of the VM booting and
being network accessible.

 - Travis
