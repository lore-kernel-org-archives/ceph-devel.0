From: Nam Dang <namd@de.cs.titech.ac.jp>
Subject: Re: SIGSEGV in cephfs-java, but probably in Ceph
Date: Fri, 1 Jun 2012 00:48:00 +0900
Message-ID: <CAHwdYF0nUtS113oTQD8pMXr7Ue76MaE=94hwGTTeKgMR6CGWTA@mail.gmail.com>
References: <CAHwdYF3na4dHqpQmAth+gEKBLeqLKSHAd-6MChgKjRyBrO+Ttw@mail.gmail.com>
 <CAHwdYF2CF77XnyHG16gi_hPbZ8VNbEzn0XpikKMDdcGWcd2-CQ@mail.gmail.com> <DC393A32-288A-4BF2-B618-9D6E0A5C29B9@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.nap.gsic.titech.ac.jp ([131.112.222.52]:37488 "EHLO
	mail2.nap.gsic.titech.ac.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932470Ab2EaPsc convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 31 May 2012 11:48:32 -0400
Received: from 209.85.217.174 (209.85.217.174 [209.85.217.174])
	by mail2.nap.gsic.titech.ac.jp (deepsmtpd.so 3.5.54)
	with ESMTP id <CAHwdYF0nUtS113oTQD8pMXr7Ue76MaE=94hwGTTeKgMR6CGWTA@mail.gmail.com>
	for <ceph-devel@vger.kernel.org>; Fri, 1 Jun 2012 00:48:25 +0900
Received: by lbbgm6 with SMTP id gm6so949121lbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 08:48:21 -0700 (PDT)
In-Reply-To: <DC393A32-288A-4BF2-B618-9D6E0A5C29B9@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel@vger.kernel.org

Hi Noah,

By the way, the test suite of cephfs-java has a bug. You should put
the permission value in the form of 0777 instead of 777 since the
number has to be octal. With 777 I got directories with weird
permission settings.

Best regards
Nam Dang
Tokyo Institute of Technology
Tokyo, Japan


On Thu, May 31, 2012 at 11:43 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wr=
ote:
>
> On May 31, 2012, at 6:20 AM, Nam Dang wrote:
>
>>> Stack: [0x00007ff6aa828000,0x00007ff6aa929000],
>>> sp=3D0x00007ff6aa9274f0, =A0free space=3D1021k
>>> Native frames: (J=3Dcompiled Java code, j=3Dinterpreted, Vv=3DVM co=
de, C=3Dnative code)
>>> C =A0[libcephfs.so.1+0x139d39] =A0Mutex::Lock(bool)+0x9
>>>
>>> Java frames: (J=3Dcompiled Java code, j=3Dinterpreted, Vv=3DVM code=
)
>>> j =A0com.ceph.fs.CephMount.native_ceph_mkdirs(JLjava/lang/String;I)=
I+0
>>> j =A0com.ceph.fs.CephMount.mkdirs(Ljava/lang/String;I)V+6
>>> j =A0Benchmark$CreateFileStats.executeOp(IILjava/lang/String;Lcom/c=
eph/fs/CephMount;)J+37
>>> j =A0Benchmark$StatsDaemon.benchmarkOne()V+22
>>> j =A0Benchmark$StatsDaemon.run()V+26
>>> v =A0~StubRoutines::call_stub
>
> Nevermind to my last comment. Hmm, I've seen this, but very rarely.
>
> - Noah
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
