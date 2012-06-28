From: Gregory Farnum <greg@inktank.com>
Subject: Re: POSIX file lock doesn't get release on process termination
Date: Thu, 28 Jun 2012 08:05:29 -0700
Message-ID: <9F04F4F9E1BA42B291611579BFB11E54@inktank.com>
References: <CAA--FSU5cfvPNQ2d-veX3+DnRFO=eyWvDym8Etam_oY8N9WWXw@mail.gmail.com>
 <CAA--FSVx08BMSBf5_mcJ0OpW455RWv8z9oL3ymE0H7L=M2LZUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47111 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733Ab2F1PFc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 11:05:32 -0400
Received: by dady13 with SMTP id y13so2994089dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jun 2012 08:05:32 -0700 (PDT)
In-Reply-To: <CAA--FSVx08BMSBf5_mcJ0OpW455RWv8z9oL3ymE0H7L=M2LZUA@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?Daniel_God=C3=A1s?= <dgodas@gmail.com>
Cc: ceph-devel@vger.kernel.org

What versions are you using? This sound familiar, although I think we p=
reviously fixed it for fcntl locks, which are different than flock lock=
s in some annoying ways.
Anyway, I imagine this is a Ceph bug, but have you run this on a non-Ce=
ph mount on the same system and checked that the behavior is as you exp=
ect?


On Thursday, June 28, 2012 at 4:49 AM, Daniel God=C3=A1s wrote:

> Hi,
> =20
> I obtained a POSIX file lock with the following code:
> =20
> --- snip ---
> =20
> ...
> std::string x =3D "/tmp/ceph_mount/lock_file";
> std::ofstream lock_file(x);
> lock_file.close();
> =20
> // Lock automatically released by the OS when the process dies
> =20
> if (Sync::get_file_lock(x) =3D=3D -1) {
> return false;
> }
> =20
> ...
> =20
> --- snip ---
> =20
> The code should create the file if it doesnt exist or just open it an=
d
> close it if it does. Then the lock is taken. This is the code for
> get_file_lock:
> =20
> ---snip---
> =20
> static int get_file_lock(const std::string& path,
> bool block =3D false,
> bool exclusive =3D true)
> {
> int fd, flags;
> =20
> if ((fd =3D open(path.c_str(), O_RDONLY)) =3D=3D -1)
> throw LockingException(path);
> =20
> flags =3D (exclusive ? LOCK_EX : LOCK_SH);
> flags |=3D (block ? 0 : LOCK_NB);
> =20
> if (flock(fd, flags) =3D=3D 0)
> return fd;
> =20
> close(fd);
> return -1;
> }
> =20
> ---snip---
> =20
> I never release the lock but I expect the operating system (and ceph)
> to release it when the process terminates as this is normal POSIX
> behaviour. The observed behaviour is that the lock never gets release=
d
> and after the process dies I can do the following:
> =20
> ---snip---
> =20
> dev proc # cat locks
> 1: POSIX ADVISORY WRITE 4425 07:00:132 0 EOF
> 2: FLOCK ADVISORY WRITE 2906 fd:02:783456 0 EOF
> =20
> ---snip---
> =20
> The lock taken by the process is the second one and the PID is correc=
t
> (it's the PID of the process that took the lock). However the process
> doesn't exist any more, which I can verify with ps.
> =20
> Is this a bug in CEPH, am I doing something stupid, is it the expecte=
d
> behaviour?
> =20
> Regards,
> Dan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@=
vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
