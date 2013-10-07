From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: wip-libcephfs-emp-rb
Date: Mon, 7 Oct 2013 19:48:29 -0400 (EDT)
Message-ID: <567038737.154.1381189709014.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <0E0D6667-6E38-420E-8FF7-751350482313@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1884 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630Ab3JGXsd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 7 Oct 2013 19:48:33 -0400
In-Reply-To: <0E0D6667-6E38-420E-8FF7-751350482313@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi David,

I'll have a loot.

Matt

----- "David Zafman" <david.zafman@inktank.com> wrote:

> I rebased wip-libcephfs and pushed as wip-libcephfs-emp-rb so that we
> can get this in to the Emperor release. Sage mentioned that he had hit
> a fuse problem in the wip-libcephfs branch, so apparently the problem
> is still present. Have you run into this bug in your testing? Are you
> testing with these modification to Ceph?
> 
> 
> 
> 2013-10-04T10:39:01.664
> INFO:teuthology.task.workunit.client.0.out:[10.214.132.22]: CC
> kernel/softirq.o
> 2013-10-04T10:39:02.059
> INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]: ***
> Caught signal (Segmentation fault) **
> 2013-10-04T10:39:02.059
> INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]: in
> thread 7f57fa316780
> 2013-10-04T10:39:02.073
> INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]: ceph
> version 0.69-500-g09f4df0 (09f4df02a866230b19539b03061f4abc5ab47ae2)
> 2013-10-04T10:39:02.073
> INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]: 1:
> ceph-fuse() [0x5e0d1a]
> 2013-10-04T10:39:02.073
> INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]: 2:
> (()+0xfcb0) [0x7f57f9cc5cb0]
> 2013-10-04T10:39:02.073
> INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]: 3:
> (Client::_get_inodeno(Inode*)+0) [0x52dd10]
> 2013-10-04T10:39:02.073
> INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]: 4:
> (Client::ll_forget(Inode*, int)+0x4a) [0x538d1a]
> 2013-10-04T10:39:02.074
> INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]: 5:
> ceph-fuse() [0x52a1c5]
> 2013-10-04T10:39:02.074
> INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]: 6:
> (fuse_session_loop()+0x75) [0x7f57f9ee3d65]
> 2013-10-04T10:39:02.074
> INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]: 7:
> (main()+0x84c) [0x5266fc]
> 2013-10-04T10:39:02.074
> INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]: 8:
> (__libc_start_main()+0xed) [0x7f57f83f576d]
> 2013-10-04T10:39:02.074
> INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]: 9:
> ceph-fuse() [0x527c99]
> 2013-10-04T10:39:02.074
> INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]:
> 2013-10-04 10:39:02.072487 7f57fa316780 -1 *** Caught signal
> (Segmentation fault) **
> 2013-10-04T10:39:02.074
> INFO:teuthology.task.ceph-fuse.ceph-fuse.0.err:[10.214.132.22]: in
> thread 7f57fa316780
> 
> 
> 
> David Zafman
> Senior Developer
> http://www.inktank.com

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
