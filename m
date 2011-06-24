From: Devin Heitmueller <dheitmueller@kernellabs.com>
Subject: Re: [RFC] Don't use linux/version.h anymore to indicate a per-driver
 version - Was: Re: [PATCH 03/37] Remove unneeded version.h includes from include/
Date: Fri, 24 Jun 2011 17:22:50 -0400
Message-ID: <BANLkTinZoax2fcSxvyQgfsT-bmsF+BofyQ@mail.gmail.com>
References: <alpine.LNX.2.00.1106232344480.17688@swampdragon.chaosbits.net>
	<4E04912A.4090305@infradead.org>
	<BANLkTim9cBiiK_GsZaspxpPJQDBvAcKCWg@mail.gmail.com>
	<201106241554.10751.hverkuil@xs4all.nl>
	<4E04A122.2080002@infradead.org>
	<20110624203404.7a3f6f6a@stein>
	<BANLkTimj-oEDvWxMao6zJ_sudUntEVjO1w@mail.gmail.com>
	<1308949448.2093.20.camel@morgan.silverblock.net>
	<20110624232048.66f1f98c@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39321 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887Ab1FXVWx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jun 2011 17:22:53 -0400
In-Reply-To: <20110624232048.66f1f98c@stein>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Andy Walls <awalls@md.metrocast.net>, Mauro Carvalho Chehab <mchehab@infradead.org>, Hans Verkuil <hverkuil@xs4all.nl>, Jesper Juhl <jj@chaosbits.net>, LKML <linux-kernel@vger.kernel.org>, trivial@kernel.org, linux-media@vger.kernel.org, ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

On Fri, Jun 24, 2011 at 5:20 PM, Stefan Richter
<stefanr@s5r6.in-berlin.de> wrote:
> Easier:
> =A0"I run Ubuntu 10.4".
> =A0"I run kernel 2.6.32."
> One of these is usually already included in the first post or IRC mes=
sage
> from the user.
>
> Separate driver versions are only needed on platforms where drivers a=
re
> not distributed by the operating system distributor, or driver source=
 code
> is not released within kernel source code.

Unfortunately, this doesn't work as all too often the user has "Ubuntu
10.1 but I installed the latest media_build tree a few months ago".
Hence they are not necessarily on a particular binary release from a
distro but rather have a mix of a distro's binary release and a
v4l-dvb tree compiled from source.

Devin

--=20
Devin J. Heitmueller - Kernel Labs
http://www.kernellabs.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
