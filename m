From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: BUG: scheduling while atomic
Date: Wed, 14 Dec 2011 15:59:16 -0800
Message-ID: <CACLRD_3TPWWKzCyhkRzdH3pPEgLZC6y96Tm_yDCfpZieHbkYDw@mail.gmail.com>
References: <201112091100.52460.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56728 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755595Ab1LNX7T convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Dec 2011 18:59:19 -0500
Received: by faar15 with SMTP id r15so1820743faa.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Dec 2011 15:59:18 -0800 (PST)
In-Reply-To: <201112091100.52460.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@dreamhost.com>

Anyone with some kernel client experience want to take a look at this?
-Sam

On Fri, Dec 9, 2011 at 2:00 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> Sorry folks for making so much trouble,
>
> but there is still another locking issue with the kernel client. iput=
 gets
> called with locks held, but iput can sleep and did in this occasion. =
It did
> not hang the system this time, but it can be quite nasty.
>
> Log attached as usual.
>
> Amon Ott
> --
> Dr. Amon Ott
> m-privacy GmbH =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tel: +49 30 2434233=
4
> Am K=C3=B6llnischen Park 1 =C2=A0 =C2=A0Fax: +49 30 24342336
> 10179 Berlin =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 http://www.m-p=
rivacy.de
>
> Amtsgericht Charlottenburg, HRB 84946
>
> Gesch=C3=A4ftsf=C3=BChrer:
> =C2=A0Dipl.-Kfm. Holger Maczkowsky,
> =C2=A0Roman Maczkowsky
>
> GnuPG-Key-ID: 0x2DD3A649
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
