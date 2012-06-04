From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Re: SIGSEGV in cephfs-java, but probably in Ceph
Date: Sun, 3 Jun 2012 17:01:12 -0700
Message-ID: <CAPrxi599c-oSE-1MJN5dGSPib5wjc0TmQxiqYroHWF67JEJAVA@mail.gmail.com>
References: <CAHwdYF3na4dHqpQmAth+gEKBLeqLKSHAd-6MChgKjRyBrO+Ttw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52898 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270Ab2FDABN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Jun 2012 20:01:13 -0400
Received: by yenm10 with SMTP id m10so2679072yen.19
        for <ceph-devel@vger.kernel.org>; Sun, 03 Jun 2012 17:01:13 -0700 (PDT)
In-Reply-To: <CAHwdYF3na4dHqpQmAth+gEKBLeqLKSHAd-6MChgKjRyBrO+Ttw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nam Dang <namd@de.cs.titech.ac.jp>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Nam,

I pushed the following changes to my branch. It'd be great if you
could give it a shot:

  git://github.com/noahdesu/ceph.git wip-java-cephfs

- Throws CephNotMountedException when the client is not mounted
- Adds synchronization to the native code

Thanks,
Noah

On Thu, May 31, 2012 at 6:08 AM, Nam Dang <namd@de.cs.titech.ac.jp> wro=
te:
>
> Dear all,
>
> I am running a small benchmark for Ceph with multithreading and
> cephfs-java API.
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
as
> follows:
>
> #
> # A fatal error has been detected by the Java Runtime Environment:
> #
> # =C2=A0SIGSEGV (0xb) at pc=3D0x00007ff6af978d39, pid=3D14063, tid=3D=
140697400411904
> #
> # JRE version: 6.0_26-b03
> # Java VM: Java HotSpot(TM) 64-Bit Server VM (20.1-b02 mixed mode
> linux-amd64 compressed oops)
> # Problematic frame:
> # C =C2=A0[libcephfs.so.1+0x139d39] =C2=A0Mutex::Lock(bool)+0x9
> #
> # An error report file with more information is saved as:
> # /home/namd/cephBench/hs_err_pid14063.log
> #
> # If you would like to submit a bug report, please visit:
> # =C2=A0 http://java.sun.com/webapps/bugreport/crash.jsp
> # The crash happened outside the Java Virtual Machine in native code.
> # See problematic frame for where to report the bug.
>
> I have also attached the hs_err_pid14063.log for your reference.
> An excerpt from the file:
>
> Stack: [0x00007ff6aa828000,0x00007ff6aa929000],
> sp=3D0x00007ff6aa9274f0, =C2=A0free space=3D1021k
> Native frames: (J=3Dcompiled Java code, j=3Dinterpreted, Vv=3DVM code=
, C=3Dnative
> code)
> C =C2=A0[libcephfs.so.1+0x139d39] =C2=A0Mutex::Lock(bool)+0x9
>
> Java frames: (J=3Dcompiled Java code, j=3Dinterpreted, Vv=3DVM code)
> j =C2=A0com.ceph.fs.CephMount.native_ceph_mkdirs(JLjava/lang/String;I=
)I+0
> j =C2=A0com.ceph.fs.CephMount.mkdirs(Ljava/lang/String;I)V+6
> j
> =C2=A0Benchmark$CreateFileStats.executeOp(IILjava/lang/String;Lcom/ce=
ph/fs/CephMount;)J+37
> j =C2=A0Benchmark$StatsDaemon.benchmarkOne()V+22
> j =C2=A0Benchmark$StatsDaemon.run()V+26
> v =C2=A0~StubRoutines::call_stub
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
