From: Gregory Farnum <greg@inktank.com>
Subject: Re: POSIX file lock doesn't get release on process termination
Date: Thu, 28 Jun 2012 17:06:35 -0700
Message-ID: <CAPYLRzgsHFrUkYA0gjvKkL4=zaKxS62xZDCo-4iaifDQv9oNHw@mail.gmail.com>
References: <CAA--FSU5cfvPNQ2d-veX3+DnRFO=eyWvDym8Etam_oY8N9WWXw@mail.gmail.com>
	<CAA--FSVx08BMSBf5_mcJ0OpW455RWv8z9oL3ymE0H7L=M2LZUA@mail.gmail.com>
	<9F04F4F9E1BA42B291611579BFB11E54@inktank.com>
	<CAA--FSU8idAbdM0-D++5pjELFFiFqj0D2ai8+mktL7G=ECmV2A@mail.gmail.com>
	<CAA--FSWL3MDsGnEH1x22KB_HNDzJe5Ezjc=b6t7CHr9ys_BmPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61218 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab2F2AGh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 20:06:37 -0400
Received: by lbbgm6 with SMTP id gm6so3831853lbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jun 2012 17:06:35 -0700 (PDT)
In-Reply-To: <CAA--FSWL3MDsGnEH1x22KB_HNDzJe5Ezjc=b6t7CHr9ys_BmPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Daniel_God=E1s?= <dgodas@gmail.com>
Cc: ceph-devel@vger.kernel.org

Yep, I think you're right. I looked at this very briefly and didn't
see anything obviously broken; could you create a bug in our tracker
(tracker.newdream.net) with your findings?
Unfortunately we're not focusing much on the filesystem right now, but
with the record we won't lose track of the bug, and somebody might
pick it up on an ambitious weekend. :)
-Greg

On Thu, Jun 28, 2012 at 9:16 AM, Daniel God=E1s <dgodas@gmail.com> wrot=
e:
> fcntl locks work as expected, the following code proves it:
>
> --- snip ---
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct flock s;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s.l_type =3D (exclusive ? F_WRLCK : F_=
RDLCK);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s.l_whence =3D SEEK_SET;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s.l_start =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s.l_len =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s.l_pid =3D getpid();
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (block) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (fcntl(fd, F_SETLKW=
, &s) !=3D -1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return=
 fd;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (fcntl(fd, F_SETLK,=
 &s) !=3D -1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return=
 fd;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> --- snip ---
>
> However, imho the behaviour with flock locks is bogus and should be l=
ooked into.
>
>
> 2012/6/28 Daniel God=E1s <dgodas@gmail.com>:
>>> What versions are you using?
>>
>> Ceph 0.41, kernel 3.2.2 (kernel client)
>>
>>> =A0Anyway, I imagine this is a Ceph bug, but have you run this on a=
 non-Ceph mount on the same system and checked that the behavior is as =
you expect?
>>
>> Yes, I ran it on an ext4 mount and works as expected
>>
>>
>> 2012/6/28 Gregory Farnum <greg@inktank.com>:
>>> What versions are you using? This sound familiar, although I think =
we previously fixed it for fcntl locks, which are different than flock =
locks in some annoying ways.
>>> Anyway, I imagine this is a Ceph bug, but have you run this on a no=
n-Ceph mount on the same system and checked that the behavior is as you=
 expect?
>>>
>>>
>>> On Thursday, June 28, 2012 at 4:49 AM, Daniel God=E1s wrote:
>>>
>>>> Hi,
>>>>
>>>> I obtained a POSIX file lock with the following code:
>>>>
>>>> --- snip ---
>>>>
>>>> ...
>>>> std::string x =3D "/tmp/ceph_mount/lock_file";
>>>> std::ofstream lock_file(x);
>>>> lock_file.close();
>>>>
>>>> // Lock automatically released by the OS when the process dies
>>>>
>>>> if (Sync::get_file_lock(x) =3D=3D -1) {
>>>> return false;
>>>> }
>>>>
>>>> ...
>>>>
>>>> --- snip ---
>>>>
>>>> The code should create the file if it doesnt exist or just open it=
 and
>>>> close it if it does. Then the lock is taken. This is the code for
>>>> get_file_lock:
>>>>
>>>> ---snip---
>>>>
>>>> static int get_file_lock(const std::string& path,
>>>> bool block =3D false,
>>>> bool exclusive =3D true)
>>>> {
>>>> int fd, flags;
>>>>
>>>> if ((fd =3D open(path.c_str(), O_RDONLY)) =3D=3D -1)
>>>> throw LockingException(path);
>>>>
>>>> flags =3D (exclusive ? LOCK_EX : LOCK_SH);
>>>> flags |=3D (block ? 0 : LOCK_NB);
>>>>
>>>> if (flock(fd, flags) =3D=3D 0)
>>>> return fd;
>>>>
>>>> close(fd);
>>>> return -1;
>>>> }
>>>>
>>>> ---snip---
>>>>
>>>> I never release the lock but I expect the operating system (and ce=
ph)
>>>> to release it when the process terminates as this is normal POSIX
>>>> behaviour. The observed behaviour is that the lock never gets rele=
ased
>>>> and after the process dies I can do the following:
>>>>
>>>> ---snip---
>>>>
>>>> dev proc # cat locks
>>>> 1: POSIX ADVISORY WRITE 4425 07:00:132 0 EOF
>>>> 2: FLOCK ADVISORY WRITE 2906 fd:02:783456 0 EOF
>>>>
>>>> ---snip---
>>>>
>>>> The lock taken by the process is the second one and the PID is cor=
rect
>>>> (it's the PID of the process that took the lock). However the proc=
ess
>>>> doesn't exist any more, which I can verify with ps.
>>>>
>>>> Is this a bug in CEPH, am I doing something stupid, is it the expe=
cted
>>>> behaviour?
>>>>
>>>> Regards,
>>>> Dan
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org (mailto:majordo=
mo@vger.kernel.org)
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
