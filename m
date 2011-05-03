From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: How to reduce active mds number
Date: Tue, 3 May 2011 10:34:45 -0700
Message-ID: <20110503173445.GE20739@dreamer>
References: <BANLkTikGYbYnWQfPPMFo3spsuzOq315m=Q@mail.gmail.com>
 <Pine.LNX.4.64.1104220845110.15351@cobra.newdream.net>
 <BANLkTi=BR6tDMjm_cZD6beBQ_VB4Ojj1gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:57441 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab1ECRep (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2011 13:34:45 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=BR6tDMjm_cZD6beBQ_VB4Ojj1gw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "doki74216@gmail.com" <doki74216@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, May 03, 2011 at 10:07:01AM +0800, doki74216@gmail.com wrote:
> 2) I want to set the active one to standby. I excute"ceph mds
> set_max_mds 1" and "ceph mds stop 0".
>     But here is why I confuse:
>     mds0 becomes stopping not standby.??
>     It shows:
> 192.138.200.185:6800/14465 =E2=80=981=E2=80=99mds0.6 up:stopping seq =
14
> 192.138.200.184:6800/15442 =E2=80=980=E2=80=99mds1.1 up:active seq 21=
0

I think the confusion here is that "ceph mds stop 0" really tells it
to stop, not to go to standby. Once it finishes stopping (=3D has safel=
y
exported all its data to the other mds), you can start it again, and
then it'll get to be standby.

This ASCII art from the source might explain. Ignore the extra detail:

 boot  --> standby, creating, or starting.


 dne  ---->   creating  ----->   active*
 ^ ^___________/                /  ^ ^
 |                             /  /  |
 destroying                   /  /   |
   ^                         /  /    |
   |                        /  /     |
 stopped <---- stopping* <-/  /      |
      \                      /       |
        ----- starting* ----/        |
                                     |
 failed                              |
    \                                |
     \--> replay*  --> reconnect* --> rejoin*

     * =3D can fail


Your mds is still in the state "stopping". To get to standby, it needs
to finish that, then get to "boot" again (by being restarted), and
then it can enter standby.

On the other hand, I can reproduce the problem of an MDS just being in
state "stopping" for along time. I'll see what others have to say
about that.


> 3) When I excute"ceph mds set_max_mds 2", mds0 doesn't become active,
>     I type"ceph mds dump -o -"
>     But it shows:
> 192.138.200.185:6800/14465 =E2=80=981=E2=80=99mds0.6 up:stopping seq =
14 export_targets=3D1
> 192.138.200.184:6800/15442 =E2=80=980=E2=80=99mds1.1 up:active seq 21=
0
>    There is no two active MDSes, why?

Your mds is still in the state "stopping". It needs to finish that
first. If you've set max_mds=3D=3D2, it should get to active once it's
done.


> 4) Therefore, I still hope that there are one active mds and one
> standby mds(by default).
>     I restart the system. I execute" /etc/init.d/ceph -a stop" and "
> /etc/init.d/ceph -a start"
>     I type"ceph -s"
>     But it shows:
> mds e52:  2/2/1 up {0=3Dup:rejoin, 1=3Dup:resolve}
>                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  what mean=
s?
>     After awhile I execue=E2=80=9Dceph mds stat=E2=80=9D , it shows:
> =E2=80=98e61: 2/2/1 up {o=3Dup:relay, 1=3Dup:relay}=E2=80=99 (0)
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ what means?

The word "relay" is never mentioned in the source tree. And seeing
that "o" in there makes me think you're typing these lines in. If
you're copying log lines to email, please use copy-paste and don't
type them in manually; variation from the exact message makes helping
you harder.

"replay" is when an MDS is starting up and reading its journal,
replaying the operations stored there against the final data storage.

"resolve" is when the MDSes go through their journals and figure out
how to handle operations that can cross MDS boundaries, such as
renames across directories.


> 5) I set the man active number to one because I still want the system
> by default value(one active and one standby).
>     I execute"ceph mds set_max_mds 1"
>     It shows:
> mds e80: 2/2/1 up {0=3Dup:rejoin, 1=3Dup:rejoin}, 1:up:standby
> mds e80: 2/2/1 up {0=3Dup:active, 1=3Dup:rejoin}, 1:up:standby
> mds e80: 2/2/1 up {0=3Dup:active, 1=3Dup:active}, 1:up:standby
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     I don't know what it means.
>     Why there are three statuses? Aren't there just 2 MDSes in my sys=
tem?
>     I execue"ceph -s"
>     It shows:
> mds e94: 2/2/1 up {0=3Dup:active,1=3Dup:active}, 1 up:standby
>=20
> Please help me to solve these questions..
> And teach me how to set the MDS by the default(1 active & 1 standby)?
> Thank you very much  ^^

I don't have a good answer to this one. The /1 in the 2/2/1 means your
max_mds really is 1. It might be a question of there being no
automatic transition from active to standby.

I can reproduce this problem locally, and will try to figure it out.

--=20
:(){ :|:&};:
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
