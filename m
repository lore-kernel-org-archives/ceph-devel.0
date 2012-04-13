From: Sage Weil <sage@newdream.net>
Subject: Re: Questions about hash functions of CRUSH
Date: Fri, 13 Apr 2012 10:06:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204131003440.5676@cobra.newdream.net>
References: <CALwGbPJPxT+q0ThYQ0H+Th4j=J0PE=q+byCf4YTw=THtCdkqpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1658469050-1334336713=:5676"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55529 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab2DMRGk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Apr 2012 13:06:40 -0400
In-Reply-To: <CALwGbPJPxT+q0ThYQ0H+Th4j=J0PE=q+byCf4YTw=THtCdkqpQ@mail.gmail.com>
Content-ID: <Pine.LNX.4.64.1204131005441.5676@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1658469050-1334336713=:5676
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.1204131005442.5676@cobra.newdream.net>

On Fri, 13 Apr 2012,  wrote:
> Hi everyone.
>=20
> I'm still reading CRUSH source code.
>=20
> When reading src/crush/hash.c, I've got some questions about the hash fun=
ction.
>=20
> 1. There are several magic numbers there, like=A01315423911, 231232,
> 1232. Are they arbitrary or do they really mean something in theory?

You'll notice there are lots of 1's, 2's, and 3's... that was me mashing=20
the keyboard.  :)

> 2.=A0crush_hashmix macro is a part of Jenkins hash function. In the
> series of crush_hash_rjenkins1_* functions, why input parameters are
> mixed this way instead of something else?=A0Are they arbitrary or do
> they really mean something in theory?
>=20
> > For example
> >=A0 crush_hashmix(a, b, hash);
> >=A0 crush_hashmix(c, d, hash);
> >=A0 crush_hashmix(e, x, hash);
> >=A0 crush_hashmix(y, a, hash);
> >=A0 crush_hashmix(b, x, hash);
> >=A0 crush_hashmix(y, c, hash);
> >=A0 crush_hashmix(d, x, hash);
> >=A0 crush_hashmix(y, e, hash);
> >=A0Do the order and combinations matter something?

I did some experimentation and that seemed to get all of the bits mixed in=
=20
well.  It was not particularly methodical, so it is something we'll want=20
to revisit and properly measure for the next CRUSH revision to see if a=20
change is warranted.

sage
--557981400-1658469050-1334336713=:5676--
