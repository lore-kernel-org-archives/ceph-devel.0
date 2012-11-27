From: Gregory Farnum <greg@inktank.com>
Subject: Re: Hadoop and Ceph client/mds view of modification time
Date: Tue, 27 Nov 2012 09:07:20 -0800
Message-ID: <8707A447F7754068A1D89D240265E1B7@inktank.com>
References: <CAPrxi5-pcHrxKsteGioaQ3haMOj0V3im1bXRL_TW28SD6R=qZw@mail.gmail.com>
 <50B4EE31.5020908@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:37565 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932122Ab2K0RHX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Nov 2012 12:07:23 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so4329277dak.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Nov 2012 09:07:22 -0800 (PST)
In-Reply-To: <50B4EE31.5020908@inktank.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On Tuesday, November 27, 2012 at 8:45 AM, Sam Lang wrote:
> =20
> Hi Noah,
> =20
> I was able to reproduce your issue with a similar test using the fuse=
 =20
> client and the clock_offset option for the mds. This is what I see =20
> happening:
> =20
> clientA's clock is a few seconds behind the mds clock
> =20
> clientA creates the file
> - the mds sets the mtime from its current time
> - clientA acquires the exclusive capability (cap) for the file
> =20
> clientA writes to the file
> - the mtime is updated locally (at clientA with its current time)
> =20
> clientA closes the file
> - the exclusive cap is flushed to the mds, but the mtime is less
> than the create mtime because of the clock skew, so the mds
> doesn't update it to the mtime from clientA's write
> =20
> clientA stats the file
> - the mtime from the write (still cached) gets returned. I saw a
> race in my tests, where sometimes the mtime was from the cache
> (if the flush hadn't completed I assume), and sometimes it was
> from the mds.
> =20
> clientB stats the file
> - the exclusive cap is revoked at clientA, but the mtime returned
> to clientB is from the mds

Hurray, I think we all agree about what's happening now! :)

Have you checked to see if the MDS ever sets mtime after create, or is =
it always dictated by the client following that?
 =20
> =20
> The goal of the current implementation is to provide an mtime that is=
 =20
> non-decreasing, but that conflicts with using mtime as a version in t=
his =20
> case. Using mtime as a version has its own set of problems, but I won=
't =20
> go into that here. I think there are a few alternatives if we want to=
 =20
> try to have a more consistent mtime value across clients.
> =20
> 1. Let the client set the create mtime. This avoids the issue that th=
e =20
> mds and client clocks are out of sync, but in other cases where the =20
> client has a clock a few seconds ahead of other clients, we run into =
a =20
> similar problem. This might be reasonable considering clients that =20
> share state will more likely have synchronized clocks than the client=
s =20
> and mds.
> =20
> 2. Provide a config option to always set the mtime on cap flush/revok=
e, =20
> even if its less than the current mtime. This breaks the non-decreasi=
ng =20
> behavior, and requires the user set a config option across the cluste=
r =20
> if they want this.
> =20
> 3. When a client acquires the cap for a file, have the mds provide it=
s =20
> current time as well. As the client updates the mtime, it uses the =20
> timestamp provided by the mds and the time since the cap was acquired=
=2E
> Except for the skew caused by the message latency, this approach allo=
ws =20
> the mtime to be based off the mds time, so it will be consistent acro=
ss =20
> clients and the mds. It does however, allow a client to set an mtime =
to =20
> the future (based off of its local time), which might be undesirable,=
 =20
> but that is more like how NFS behaves. Message latency probably won't=
 =20
> be much of an issue either, as the granularity of mtime is a second. =
=20
> Also, the client can set its cap acquired timestamp to the time at wh=
ich =20
> the cap was requested, ensuring that the relative increment includes =
the =20
> round trip latency so that the mtime will always be set further ahead=
=2E =20
> Of course, this approach would be a lot more intrusive to implement. =
:-)

I actually like this third approach of letting the MDS be authoritative=
 about time even if it's not directly involved. Given that, I wonder if=
 perhaps the client should just have time translation functions it uses=
 everywhere?
However, the problem with that is that the different MDS daemons might =
also disagree about time. Perhaps they could adopt the master MDS clock=
 or something skanky like that=E2=80=A6 :/

The fundamental issue of time resolution is why things are the way they=
 are now, of course =E2=80=94 you usually don't want things going "back=
wards" in time, but clock skews are a real problem in large clusters so=
 we just decided to not let things go back on the assumption it would b=
e a temporary and little-noticed disparity, with easy-to-understand beh=
avior. Obviously we were wrong about it being little-noticed.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
