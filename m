From: Devin Heitmueller <dheitmueller@kernellabs.com>
Subject: Re: [RFC] Don't use linux/version.h anymore to indicate a per-driver
 version - Was: Re: [PATCH 03/37] Remove unneeded version.h includes from include/
Date: Fri, 24 Jun 2011 08:20:28 -0400
Message-ID: <BANLkTinXymR_2A2Mr+UbhK63s2xjtK=B=g@mail.gmail.com>
References: <alpine.LNX.2.00.1106232344480.17688@swampdragon.chaosbits.net>
	<alpine.LNX.2.00.1106232356530.17688@swampdragon.chaosbits.net>
	<4E04732A.3060305@infradead.org>
	<201106241326.27593.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35607 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641Ab1FXMUa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jun 2011 08:20:30 -0400
In-Reply-To: <201106241326.27593.hverkuil@xs4all.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, Jesper Juhl <jj@chaosbits.net>, LKML <linux-kernel@vger.kernel.org>, trivial@kernel.org, linux-media@vger.kernel.org, ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

> Applications are certainly using it. I know this for a fact for the i=
vtv driver where
> feature improvements are marked that way.
>
> Without more research on how this is used I am not comfortable with t=
his.
>
> Regards,
>
> =A0 =A0 =A0 =A0Hans

MythTV has a bunch of these too (mainly so the code can adapt to
driver bugs that are fixed in later revisions).  Putting Mauro's patch
upstream will definitely cause breakage.

Also, it screws up the ability for users to get fixes through the
media_build tree (unless you are increasing the revision constantly
with every merge you do).

Devin

--=20
Devin J. Heitmueller - Kernel Labs
http://www.kernellabs.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
