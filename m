From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Multiple OSDs suicide because of client issues?
Date: Mon, 23 Nov 2015 11:17:56 -0600
Message-ID: <CAJ4mKGbYrDOpiEJiMKZwHaEHGrZT=b58GjzYg4x35U1XtDbDWg@mail.gmail.com>
References: <CAANLjFqL82wLfrYDD-LNgctWR=MpHWJ=PxfQJ8g2Ntbv8fgu2g@mail.gmail.com>
	<CAJ4mKGb5F+cuUKdU6PHs47sed9ZCb+qEnNDvxfuxB=vFyDx96A@mail.gmail.com>
	<CAANLjFo=vCsny5=JW1wYiQk5S=oXdtVd0OzXEC=uTGgmDO9ydA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37265 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbbKWRR5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Nov 2015 12:17:57 -0500
Received: by wmww144 with SMTP id w144so114088070wmw.0
        for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2015 09:17:56 -0800 (PST)
In-Reply-To: <CAANLjFo=vCsny5=JW1wYiQk5S=oXdtVd0OzXEC=uTGgmDO9ydA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 23, 2015 at 11:03 AM, Robert LeBlanc <robert@leblancnet.us>=
 wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> The backtrace is:
>
> 2015-11-20 20:59:48.856679 7f7012ff7700 -1 common/HeartbeatMap.cc: In
> function 'bool ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*,
> const char*, time_t)' thread 7f7012ff7700 time 2015-11-20
> 20:59:48.833166
> common/HeartbeatMap.cc: 79: FAILED assert(0 =3D=3D "hit suicide timeo=
ut")
>
>  ceph version 0.94.5 (9764da52395923e0b32908d83a9f7304401fee43)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x85) [0xbc9d85]
>  2: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char
> const*, long)+0x2d9) [0xaff1f9]
>  3: (ceph::HeartbeatMap::is_healthy()+0xde) [0xaffaee]
>  4: (OSD::handle_osd_ping(MOSDPing*)+0x733) [0x696c43]
>  5: (OSD::heartbeat_dispatch(Message*)+0x2fb) [0x697ebb]
>  6: (DispatchQueue::entry()+0x62a) [0xc84c9a]
>  7: (DispatchQueue::DispatchThread::entry()+0xd) [0xba81cd]
>  8: (()+0x7df5) [0x7f702d85ddf5]
>  9: (clone()+0x6d) [0x7f702c3401ad]
>  NOTE: a copy of the executable, or `objdump -rdS ` is needed to inte=
rpret this.
>
> - --- begin dump of recent events ---
>
> We have had problems with Large Receive Offloads and KVM VMs before. =
I
> think this host just got missed, or maybe it is something different.
> I'm ok with a host having a hard time accessing the Ceph cluster. I'm
> a bit concerned if a misbehaving client can cause multiple OSDs to
> fault. It would be good if the OSD is resistant to things like this b=
y
> compartmentalizing them to only those cilents/connections.

Just this backtrace doesn't help much (something was slow, and it
timed out!), but there should be a log line including "had suicide
timed out after" just ahead of it (in that thread).
I guess it's vaguely possible the LRO got busted since the network
card on your client was dead? Not really anything we can do about that
though...

>I'm attaching the entire OSD log in case it is useful.

Uh, that doesn't have the backtrace in it.
-Greg

>
> Thanks for taking a look at this.
>
> - ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>
>
> On Mon, Nov 23, 2015 at 9:03 AM, Gregory Farnum  wrote:
>> No, it shouldn't be able to just by having clock issues or whatever.
>> There *are* still some ways a malformed request can cause the OSDs t=
o
>> crash, though =E2=80=94 it looks like maybe this is a network card i=
ssue? That
>> could have maybe flipped some bits that broke stuff. What's the
>> backtrace on the OSDs?
>> -Greg
>
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.2.3
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJWU0bgCRDmVDuy+mK58QAAcysP/1xI6paI89WDozrmE2sY
> ehaF4sZsyy6y6mizsp+g7dXErNXtCIRQIg+LDjtS+SOnni+Z/XAhmLlCb5xM
> tid3xqQhQPLD66QhFQsxEGQxvWI5urqHnGWRhpbjpz8Xa0ReAHYCLj8K6hh0
> f7FHyqEjsEDtcqrk3+EI6bklBW7xgJy4zHQG+0MiZarzh5gSXvEpxrXo2KIr
> qBUcEE585jddVhvEv+VQVuBagQlBEMLo4RTz+5mdwneijIGAIQlOUCXVTogp
> d6aLaVQyCNMiAblJoFzr/UeV7E5ajQzd4QZ5i9H7ZD1sCwWMdV/pQNyYoDWk
> 3dBQXeYrkU2KlH14iKOJa1jxAPWg9mnnsguesir1aWunR+LamL2tbBlgXcXG
> 0NjIfl7q0yMm89jb7/JVAr8nyp3gOHdNaPRfd8FTilYoLGJFEB1j25q2qlBP
> 8IBSZbldXlXi9HB78cU3/I2o44CsrPPzZgN0iJ0fT7mbRPujkZbsdk3SbFtu
> eG1dXsZLNdSOgll5gSj11U8Kt4HvkF9dhatmqYeyZGFeBHOJqKhi0dw6yZ2T
> sSFPsHRNt6vbc8ckF4NqyFyPTK5PTSqB8TdLiZXW8vHvWooxNOtdCFgjQtNY
> kdb1kLsNW/z5dgE218kvwUnAObXaB9RkEJ47xi9o2FbVya+eHMYdM0JaEYxt
> I48o
> =3DUufa
> -----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
