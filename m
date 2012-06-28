From: =?ISO-8859-1?Q?Daniel_God=E1s?= <dgodas@gmail.com>
Subject: POSIX file lock doesn't get release on process termination
Date: Thu, 28 Jun 2012 12:49:27 +0100
Message-ID: <CAA--FSVx08BMSBf5_mcJ0OpW455RWv8z9oL3ymE0H7L=M2LZUA@mail.gmail.com>
References: <CAA--FSU5cfvPNQ2d-veX3+DnRFO=eyWvDym8Etam_oY8N9WWXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48552 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab2F1Lt2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 07:49:28 -0400
Received: by dady13 with SMTP id y13so2773401dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jun 2012 04:49:28 -0700 (PDT)
In-Reply-To: <CAA--FSU5cfvPNQ2d-veX3+DnRFO=eyWvDym8Etam_oY8N9WWXw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I obtained a POSIX file lock with the following code:

--- snip ---

=2E..
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0std::string x =3D "/tmp/ceph_mount/lock_=
file";
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 std::ofstream lock_file(x);
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lock_file.close();

=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 // Lock automatically released by the O=
S when the process dies

=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (Sync::get_file_lock(x) =3D=3D -1) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }

=2E..

--- snip ---

The code should create the file if it doesnt exist or just open it and
close it if it does. Then the lock is taken. This is the code for
get_file_lock:

---snip---

=A0 =A0 =A0 =A0 static int get_file_lock(const std::string& path,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bool=
 block =3D false,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bool=
 exclusive =3D true)
=A0 =A0 =A0 =A0 {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int fd, flags;

=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((fd =3D open(path.c_str(), O_RDONLY=
)) =3D=3D -1)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 throw LockingException(=
path);

=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =3D (exclusive ? LOCK_EX : LOCK_S=
H);
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D (block ? 0 : LOCK_NB);

=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flock(fd, flags) =3D=3D 0)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return fd;

=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 close(fd);
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
=A0 =A0 =A0 =A0 }

---snip---

I never release the lock but I expect the operating system (and ceph)
to release it when the process terminates as this is normal POSIX
behaviour. The observed behaviour is that the lock never gets released
and after the process dies I can do the following:

---snip---

dev proc # cat locks
1: POSIX =A0ADVISORY =A0WRITE 4425 07:00:132 0 EOF
2: FLOCK =A0ADVISORY =A0WRITE 2906 fd:02:783456 0 EOF

---snip---

The lock taken by the process is the second one and the PID is correct
(it's the PID of the process that took the lock). However the process
doesn't exist any more, which I can verify with ps.

Is this a bug in CEPH, am I doing something stupid, is it the expected
behaviour?

Regards,
Dan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
