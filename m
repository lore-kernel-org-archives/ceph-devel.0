From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: O_RDWR bug
Date: Fri, 24 Jun 2011 11:38:03 -0700
Message-ID: <BANLkTi=+5jy994smWa_Z_d5soOg2fU05yA@mail.gmail.com>
References: <BANLkTi=cFLrrAUhSjVduvt48HD2CO-MA_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53390 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab1FXSiG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jun 2011 14:38:06 -0400
Received: by bwd5 with SMTP id 5so14315bwd.19
        for <ceph-devel@vger.kernel.org>; Fri, 24 Jun 2011 11:38:04 -0700 (PDT)
In-Reply-To: <BANLkTi=cFLrrAUhSjVduvt48HD2CO-MA_g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mowang da <whooya.xxl@gmail.com>
Cc: ceph-devel@vger.kernel.org

2011/6/23 mowang da <whooya.xxl@gmail.com>:
> I am currently testing Ceph , l write some code like this:
>
> =A0 =A0 =A0 =A0 =A0 =A0 size_t fd =3D open("/mnt/aaa", O_CREAT | O_RD=
WR | O_APPEND , 0755);
>
> then l can not write buffer to the fd, 1 think there is something wro=
ng in :
>
> int ceph_flags_to_mode(int flags)
>
> {
>
> =A0 =A0 =A0 =A0 =A0...
>
> =A0 =A0 =A0 =A0 if ((flags & O_ACCMODE) =3D=3D O_RDWR)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode =3D CEPH_FILE_MODE_RDWR;
> =A0 =A0 =A0 =A0 else if ((flags & O_ACCMODE) =3D=3D O_WRONLY) //?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode =3D CEPH_FILE_MODE_WR;
> =A0 =A0 =A0 =A0 else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode =3D CEPH_FILE_MODE_RD;
>
> =A0 =A0 =A0 =A0 =A0...
>
> }
>
> if change the "(flags & O_ACCMODE) =3D=3D O_WRONLY" to "(flags &
> O_ACCMODE) =3D=3D O_ACCMODE", l can write success!
>
Can you verify that you're sending the right flags?

According to this:

#define O_ACCMODE          0003
#define O_RDONLY             00
#define O_WRONLY             01
#define O_RDWR               02

your check will only work if you pass  O_RDWR  | O_RDONLY, which is
obviously not what you meant to do.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
