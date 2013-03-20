From: "Campbell, Bill" <bcampbell@axcess-financial.com>
Subject: Re: Latest bobtail branch still crashing KVM VMs in
 bh_write_commit()
Date: Wed, 20 Mar 2013 15:51:31 -0400
Message-ID: <1756476932.1405953.1363809091028.JavaMail.root@axcess-financial.com>
References: <CACkq2mrSvLyy9j3HMAEiCHnuktnB_EQbnQ-JvAZcyLcjmjn3uQ@mail.gmail.com>
Reply-To: "Campbell, Bill" <bcampbell@axcess-financial.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.axcess-financial.com ([74.115.185.13]:52351 "EHLO
	chqexc08.cngfinancial.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752466Ab3CTT4l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 Mar 2013 15:56:41 -0400
In-Reply-To: <CACkq2mrSvLyy9j3HMAEiCHnuktnB_EQbnQ-JvAZcyLcjmjn3uQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Travis, are you using format 1 or 2 images?  I've seen the same behavior on format 2 images using cloned snapshots, but haven't run into this issue on any normal format 2 images.

----- Original Message -----
From: "Travis Rhoden" <trhoden@gmail.com>
To: "ceph-devel" <ceph-devel@vger.kernel.org>
Sent: Wednesday, March 20, 2013 3:49:23 PM
Subject: Latest bobtail branch still crashing KVM VMs in bh_write_commit()

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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
NOTICE: Protect the information in this message in accordance with the company's security policies. If you received this message in error, immediately notify the sender and destroy all copies.
