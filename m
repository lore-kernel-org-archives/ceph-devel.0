From: Greg Farnum <greg@inktank.com>
Subject: Re: SIGSEGV in cephfs-java, but probably in Ceph
Date: Thu, 31 May 2012 15:39:25 -0700
Message-ID: <05C460A496DC45689D6578B20D699425@inktank.com>
References: <CAHwdYF3na4dHqpQmAth+gEKBLeqLKSHAd-6MChgKjRyBrO+Ttw@mail.gmail.com>
 <CAHwdYF2CF77XnyHG16gi_hPbZ8VNbEzn0XpikKMDdcGWcd2-CQ@mail.gmail.com>
 <DC393A32-288A-4BF2-B618-9D6E0A5C29B9@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47918 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556Ab2EaWja (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 18:39:30 -0400
Received: by dady13 with SMTP id y13so1902278dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 15:39:29 -0700 (PDT)
In-Reply-To: <DC393A32-288A-4BF2-B618-9D6E0A5C29B9@cs.ucsc.edu>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Nam Dang <namd@de.cs.titech.ac.jp>, ceph-devel <ceph-devel@vger.kernel.org>

On Thursday, May 31, 2012 at 7:43 AM, Noah Watkins wrote:
> 
> On May 31, 2012, at 6:20 AM, Nam Dang wrote:
> 
> > > Stack: [0x00007ff6aa828000,0x00007ff6aa929000],
> > > sp=0x00007ff6aa9274f0, free space=1021k
> > > Native frames: (J=compiled Java code, j=interpreted, Vv=VM code, C=native code)
> > > C [libcephfs.so.1+0x139d39] Mutex::Lock(bool)+0x9
> > > 
> > > Java frames: (J=compiled Java code, j=interpreted, Vv=VM code)
> > > j com.ceph.fs.CephMount.native_ceph_mkdirs(JLjava/lang/String;I)I+0
> > > j com.ceph.fs.CephMount.mkdirs(Ljava/lang/String;I)V+6
> > > j Benchmark$CreateFileStats.executeOp(IILjava/lang/String;Lcom/ceph/fs/CephMount;)J+37
> > > j Benchmark$StatsDaemon.benchmarkOne()V+22
> > > j Benchmark$StatsDaemon.run()V+26
> > > v ~StubRoutines::call_stub
> > 
> 
> 
> 
> Nevermind to my last comment. Hmm, I've seen this, but very rarely.
Noah, do you have any leads on this? Do you think it's a bug in your Java code or in the C/++ libraries?
Nam: it definitely shouldn't be segfaulting just because a monitor went down. :)
-Greg

