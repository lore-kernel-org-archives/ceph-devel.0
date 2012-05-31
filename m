From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: SIGSEGV in cephfs-java, but probably in Ceph
Date: Thu, 31 May 2012 09:01:26 -0700
Message-ID: <E86B4B74-502B-434B-9A20-072EE13C3878@cs.ucsc.edu>
References: <CAHwdYF3na4dHqpQmAth+gEKBLeqLKSHAd-6MChgKjRyBrO+Ttw@mail.gmail.com> <CAHwdYF2CF77XnyHG16gi_hPbZ8VNbEzn0XpikKMDdcGWcd2-CQ@mail.gmail.com> <DC393A32-288A-4BF2-B618-9D6E0A5C29B9@cs.ucsc.edu> <CAHwdYF0nUtS113oTQD8pMXr7Ue76MaE=94hwGTTeKgMR6CGWTA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:40277 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932634Ab2EaQB1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 12:01:27 -0400
In-Reply-To: <CAHwdYF0nUtS113oTQD8pMXr7Ue76MaE=94hwGTTeKgMR6CGWTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nam Dang <namd@de.cs.titech.ac.jp>
Cc: ceph-devel@vger.kernel.org


On May 31, 2012, at 8:48 AM, Nam Dang wrote:

> Hi Noah,
> 
> By the way, the test suite of cephfs-java has a bug. You should put
> the permission value in the form of 0777 instead of 777 since the
> number has to be octal. With 777 I got directories with weird
> permission settings.

Thanks Nam, I'll fix this up.

> 
> Best regards
> Nam Dang
> Tokyo Institute of Technology
> Tokyo, Japan
> 
> 
> On Thu, May 31, 2012 at 11:43 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>> 
>> On May 31, 2012, at 6:20 AM, Nam Dang wrote:
>> 
>>>> Stack: [0x00007ff6aa828000,0x00007ff6aa929000],
>>>> sp=0x00007ff6aa9274f0,  free space=1021k
>>>> Native frames: (J=compiled Java code, j=interpreted, Vv=VM code, C=native code)
>>>> C  [libcephfs.so.1+0x139d39]  Mutex::Lock(bool)+0x9
>>>> 
>>>> Java frames: (J=compiled Java code, j=interpreted, Vv=VM code)
>>>> j  com.ceph.fs.CephMount.native_ceph_mkdirs(JLjava/lang/String;I)I+0
>>>> j  com.ceph.fs.CephMount.mkdirs(Ljava/lang/String;I)V+6
>>>> j  Benchmark$CreateFileStats.executeOp(IILjava/lang/String;Lcom/ceph/fs/CephMount;)J+37
>>>> j  Benchmark$StatsDaemon.benchmarkOne()V+22
>>>> j  Benchmark$StatsDaemon.run()V+26
>>>> v  ~StubRoutines::call_stub
>> 
>> Nevermind to my last comment. Hmm, I've seen this, but very rarely.
>> 
>> - Noah
>> 

