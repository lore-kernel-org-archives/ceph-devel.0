From: Tommi Virtanen <tv@inktank.com>
Subject: Re: OSD per disk.
Date: Tue, 5 Jun 2012 09:25:02 -0700
Message-ID: <CADvuQRFiEXzDzkRDj=_TpA9sLef=e93Shf1TvCTvTcpmj3rjtQ@mail.gmail.com>
References: <loom.20120528T080903-621@post.gmane.org> <1c048abb-0cbb-4d69-9922-419c16019887@mailpro>
 <loom.20120528T111434-469@post.gmane.org> <CADvuQREMRQtBv2NhM_QH0A_-mFE5wRGPVMHk0Wu7jhUvgXjcYQ@mail.gmail.com>
 <CA+7V1=Ey224p64Wo0172OrTTiA0sbg9x_13aJwRvBr7VRySHbQ@mail.gmail.com>
 <CADvuQRHzTy+Kvhah7sop6fdSvhYvA63ZNXBkntukmYLD_ejbVA@mail.gmail.com>
 <CA+4uBUY+qq0x81wg=Qom70ttAX4f-bwkDH=H5o6rPHdvpFgFuQ@mail.gmail.com> <loom.20120605T142846-305@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33674 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647Ab2FEQZX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jun 2012 12:25:23 -0400
Received: by dady13 with SMTP id y13so7507270dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jun 2012 09:25:23 -0700 (PDT)
In-Reply-To: <loom.20120605T142846-305@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chandrashekhar <chandubigc@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jun 5, 2012 at 5:34 AM, chandrashekhar <chandubigc@gmail.com> w=
rote:
>>>
> I built ceph from source ( f859f25d7eaec01fb6a82b88409d005c8177fea2 =C2=
=A0branch).
>
> mkcephfs -a -c /etc/ceph/ceph.conf =C2=A0-k /etc/ceph/keyring.admin -=
- is working
> fine, but when I tried to start ceph its showing following error.

I'm sorry, perhaps part of the email got cut or something, but all I
see is a snippet of strace where things succeed -- what's the error
you saw?

>>strace ceph -a start
>
> rt_sigprocmask(SIG_SETMASK, [PIPE], NULL, 8) =3D 0
> rt_sigprocmask(SIG_BLOCK, [PIPE], [PIPE], 8) =3D 0
> mmap(NULL, 8392704, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|M=
AP_STACK,
> -1, 0) =3D 0x7f1cc5a49000
> mprotect(0x7f1cc5a49000, 4096, PROT_NONE) =3D 0
> clone(child_stack=3D0x7f1cc6248f70,
> flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLON=
E_SYSVSEM
> |CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
> parent_tidptr=3D0x7f1cc62499d0, tls=3D0x7f1cc6249700,
> child_tidptr=3D0x7f1cc62499d0) =3D
> 21042
> rt_sigprocmask(SIG_SETMASK, [PIPE], NULL, 8) =3D 0
> rt_sigprocmask(SIG_BLOCK, [PIPE], [PIPE], 8) =3D 0
> mmap(NULL, 1052672, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK,
> -1, 0) =3D 0x7f1ccaa98000
> mprotect(0x7f1ccaa98000, 4096, PROT_NONE) =3D 0
> clone(child_stack=3D0x7f1ccab97f70,
> flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|
> CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
> parent_tidptr=3D0x7f1ccab989d0, tls=3D0x7f1ccab98700, child_tidptr=3D=
0x7f1ccab989d0) =3D
> 21043
> rt_sigprocmask(SIG_SETMASK, [PIPE], NULL, 8) =3D 0
> futex(0x201b904, FUTEX_WAIT_PRIVATE, 1, NULL
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
