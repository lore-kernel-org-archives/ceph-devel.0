From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: rbd create error with 0.26
Date: Tue, 10 May 2011 07:42:22 -0700
Message-ID: <BANLkTikRzuukqpwkEceMB9ZiRY-SUPFxuA@mail.gmail.com>
References: <BANLkTim4GDuiVLaX2khWqRF310VJnSEG4Q@mail.gmail.com>
	<BANLkTik7eFyp_7X=U5dZ=O5KdCQvyWQ+Sw@mail.gmail.com>
	<BANLkTing1pYepM0F9nrewq9vyfF77Z8yJg@mail.gmail.com>
	<BANLkTinNS5Zhnccwgxt2SBwjS+c18cr4jg@mail.gmail.com>
	<BANLkTinO=rYk8wOvO50EKyzbHTjrjk_dvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56681 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681Ab1EJOmY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2011 10:42:24 -0400
Received: by bwz15 with SMTP id 15so4893655bwz.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2011 07:42:23 -0700 (PDT)
In-Reply-To: <BANLkTinO=rYk8wOvO50EKyzbHTjrjk_dvQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, May 10, 2011 at 7:15 AM, Simon Tian <aixt2006@gmail.com> wrote:
> Hi,
>
> =A0 =A0As you said, one of the osds crashed:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D log =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 2011-05-10 21:46:38.990311 4bc90940 osd2 8 pg[3.13a( v 8'1 (0'0,8'1]
> n=3D1 ec=3D2 les=3D6 5/5/4) [2,3] r=3D0 mlcod 0'0 active+clean]
> oi.user_version=3D8'2 is_modify=3D0
> 2011-05-10 21:46:38.990386 4bc90940 osd2 8 pg[3.13a( v 8'1 (0'0,8'1]
> n=3D1 ec=3D2 les=3D6 5/5/4) [2,3] r=3D0 mlcod 0'0 active+clean]
> oi.user_version=3D8'2 is_modify=3D1
> *** Caught signal (Segmentation fault) **
> =A0in thread 0x45382940
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I tried again, this time, i done "rbd create foo --size 1024"
> successfully, but when I run the code of testlibrbd.c, one of the osd=
s
> crash again:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D log =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 2011-05-10 22:08:20.008871 4c115940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
> n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean
> snaptrimq=3D[1~1]] dump_watchers testimg.rbd/head testimg.rbd/head(9'=
4
> client4107.0:14 wrlock_by=3Dunknown0.0:0)
> 2011-05-10 22:08:20.008903 4c115940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
> n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean
> snaptrimq=3D[1~1]] =A0* obc->watcher: client4107 session=3D0xc80990
> 2011-05-10 22:08:20.008925 4c115940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
> n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean
> snaptrimq=3D[1~1]] =A0* oi->watcher: client4107 cookie=3D2
> 2011-05-10 22:08:20.009232 4b914940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
> n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean]
> oi.user_version=3D10'5 is_modify=3D1
> 2011-05-10 22:08:20.009267 4b914940 expires 2011-05-10 23:08:19.89003=
2
> now 2011-05-10 22:08:20.009260
> 2011-05-10 22:08:20.009284 napshots_list
> 2011-05-10 22:08:20.009307 4b914940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
> n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean]
> oi.user_version=3D10'5 is_modify=3D0
> 2011-05-10 22:08:20.009375 4b914940 osd3 10 pg[4.1( v 9'4 (9'2,9'4]
> n=3D1 ec=3D9 les=3D9 9/9/9) [3,0] r=3D0 mlcod 9'3 active+clean]
> oi.user_version=3D10'5 is_modify=3D1
> *** Caught signal (Segmentation fault) **
> =A0in thread 0x4eb1c940
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
Can you by any chance get backtrace for that crash (gdb cosd core;
bt)? You might need to have the debug packages installed.
Also, note that you're not running the latest version so you might be
hitting something that was already fixed (not that I remember anything
specific, but it might be worth a try).

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
