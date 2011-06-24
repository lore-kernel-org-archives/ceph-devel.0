From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [RFC] Don't use linux/version.h anymore to indicate a per-driver
 version - Was: Re: [PATCH 03/37] Remove unneeded version.h includes from
 include/
Date: Fri, 24 Jun 2011 18:52:58 -0300
Message-ID: <4E05073A.3030209@infradead.org>
References: <alpine.LNX.2.00.1106232344480.17688@swampdragon.chaosbits.net>	<4E04912A.4090305@infradead.org>	<BANLkTim9cBiiK_GsZaspxpPJQDBvAcKCWg@mail.gmail.com>	<201106241554.10751.hverkuil@xs4all.nl>	<4E04A122.2080002@infradead.org>	<20110624203404.7a3f6f6a@stein>	<BANLkTimj-oEDvWxMao6zJ_sudUntEVjO1w@mail.gmail.com> <20110624231028.7f03dcae@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:46798 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab1FXVx0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jun 2011 17:53:26 -0400
In-Reply-To: <20110624231028.7f03dcae@stein>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Devin Heitmueller <dheitmueller@kernellabs.com>, Hans Verkuil <hverkuil@xs4all.nl>, Jesper Juhl <jj@chaosbits.net>, LKML <linux-kernel@vger.kernel.org>, trivial@kernel.org, linux-media@vger.kernel.org, ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

Em 24-06-2011 18:10, Stefan Richter escreveu:
> On Jun 24 Devin Heitmueller wrote:
>> Really, this is all about applications being able to jam a hack into
>> their code that translates to "don't call this ioctl() with some
>> particular argument if it's driver W less than version X, because th=
e
>> driver had a bug that is likely to panic the guy's PC".  Sure, it's =
a
>> crummy solution, but at this point it's the best that we have got.
>=20
> The second best.  The best that we have got is that the user runs a f=
ixed
> kernel.
>=20
> Anyway; if this is the only purpose that this interface version=C2=B9=
 serves,
> then Mauro's subsystem-centralized solution has the benefit that it
> eliminates mistakes due to oversight by individual driver authors.
> Especially because the kind of implementation behavior changes that a=
re
> tracked by this type of version datum are sometimes just discovered o=
r
> documented in hindsight.  On the other hand, Mauro's solution is redu=
ndant
> to the uname(2) syscall.

Yes. That's why my initial proposal were to add some value to it by not=
 associating
it with the kernel version, but with a number that will be incremented =
only if
the V4L2 API changes.

>=20
> =C2=B9) Yes, it is still an ABI version, nothing less.  With all its =
backwards
> and forwards compatibility ramifications.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
