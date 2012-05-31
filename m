From: Nam Dang <namd@de.cs.titech.ac.jp>
Subject: Re: SIGSEGV in cephfs-java, but probably in Ceph
Date: Thu, 31 May 2012 22:20:28 +0900
Message-ID: <CAHwdYF2CF77XnyHG16gi_hPbZ8VNbEzn0XpikKMDdcGWcd2-CQ@mail.gmail.com>
References: <CAHwdYF3na4dHqpQmAth+gEKBLeqLKSHAd-6MChgKjRyBrO+Ttw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.nap.gsic.titech.ac.jp ([131.112.222.52]:50494 "EHLO
	mail2.nap.gsic.titech.ac.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757956Ab2EaNVA convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 31 May 2012 09:21:00 -0400
Received: from 209.85.215.46 (209.85.215.46 [209.85.215.46])
	by mail2.nap.gsic.titech.ac.jp (deepsmtpd.so 3.5.54)
	with ESMTP id <CAHwdYF2CF77XnyHG16gi_hPbZ8VNbEzn0XpikKMDdcGWcd2-CQ@mail.gmail.com>
	for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 22:20:52 +0900
Received: by lahd3 with SMTP id d3so691974lah.19
        for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 06:20:49 -0700 (PDT)
In-Reply-To: <CAHwdYF3na4dHqpQmAth+gEKBLeqLKSHAd-6MChgKjRyBrO+Ttw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

It turned out my monitor went down without my knowing.
So my bad, it wasn't because of Ceph.

Best regards,

Nam Dang
Tokyo Institute of Technology
Tokyo, Japan


On Thu, May 31, 2012 at 10:08 PM, Nam Dang <namd@de.cs.titech.ac.jp> wr=
ote:
> Dear all,
>
> I am running a small benchmark for Ceph with multithreading and cephf=
s-java API.
> I encountered this issue even when I use only two threads, and I used
> only open file and creating directory operations.
>
> The piece of code is simply:
> String parent =3D filePath.substring(0, filePath.lastIndexOf('/'));
> mount.mkdirs(parent, 0755); // create parents if the path does not ex=
ist
> int fileID =3D mount.open(filePath, CephConstants.O_CREAT, 0666); //
> open the file
>
> Each thread mounts its own ceph mounting point (using
> mount.mount(null)) and I don't have any interlocking mechanism across
> the threads at all.
> It appears the error is SIGSEGV sent off by libcepfs. The message is =
as follows:
>
> #
> # A fatal error has been detected by the Java Runtime Environment:
> #
> # =A0SIGSEGV (0xb) at pc=3D0x00007ff6af978d39, pid=3D14063, tid=3D140=
697400411904
> #
> # JRE version: 6.0_26-b03
> # Java VM: Java HotSpot(TM) 64-Bit Server VM (20.1-b02 mixed mode
> linux-amd64 compressed oops)
> # Problematic frame:
> # C =A0[libcephfs.so.1+0x139d39] =A0Mutex::Lock(bool)+0x9
> #
> # An error report file with more information is saved as:
> # /home/namd/cephBench/hs_err_pid14063.log
> #
> # If you would like to submit a bug report, please visit:
> # =A0 http://java.sun.com/webapps/bugreport/crash.jsp
> # The crash happened outside the Java Virtual Machine in native code.
> # See problematic frame for where to report the bug.
>
> I have also attached the hs_err_pid14063.log for your reference.
> An excerpt from the file:
>
> Stack: [0x00007ff6aa828000,0x00007ff6aa929000],
> sp=3D0x00007ff6aa9274f0, =A0free space=3D1021k
> Native frames: (J=3Dcompiled Java code, j=3Dinterpreted, Vv=3DVM code=
, C=3Dnative code)
> C =A0[libcephfs.so.1+0x139d39] =A0Mutex::Lock(bool)+0x9
>
> Java frames: (J=3Dcompiled Java code, j=3Dinterpreted, Vv=3DVM code)
> j =A0com.ceph.fs.CephMount.native_ceph_mkdirs(JLjava/lang/String;I)I+=
0
> j =A0com.ceph.fs.CephMount.mkdirs(Ljava/lang/String;I)V+6
> j =A0Benchmark$CreateFileStats.executeOp(IILjava/lang/String;Lcom/cep=
h/fs/CephMount;)J+37
> j =A0Benchmark$StatsDaemon.benchmarkOne()V+22
> j =A0Benchmark$StatsDaemon.run()V+26
> v =A0~StubRoutines::call_stub
>
> So I think the probably may be due to the locking mechanism of ceph
> internally. But Dr. Weil previously answered my email stating that th=
e
> mounting is done independently so multithreading should not lead to
> this problem. If there is anyway to work around this, please let me
> know.
>
> Best regards,
>
> Nam Dang
> Email: namd@de.cs.titech.ac.jp
> HP: (+81) 080-4465-1587
> Yokota Lab, Dept. of Computer Science
> Tokyo Institute of Technology
> Tokyo, Japan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
