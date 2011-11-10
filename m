From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: bug when using ceph and keyring does not exist
Date: Thu, 10 Nov 2011 16:32:30 +0100
Message-ID: <4EBBEE8E.5030808@smart-weblications.de>
References: <4EB78876.10406@smart-weblications.de> <CAORUGqC2cDWHi37G6g8R2Q03OrkhfR-EgfB_1h5Ca6WzZThP5A@mail.gmail.com>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx04.smart-weblications.de ([188.65.144.39]:49308 "EHLO
	mx04.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934192Ab1KJPch (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Nov 2011 10:32:37 -0500
In-Reply-To: <CAORUGqC2cDWHi37G6g8R2Q03OrkhfR-EgfB_1h5Ca6WzZThP5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Am 08.11.2011 18:57, schrieb Tommi Virtanen:
> On Sun, Nov 6, 2011 at 23:27, Smart Weblications GmbH - Florian
> Wiessner<f.wiessner@smart-weblications.de>  wrote:
>> i think i found a bug:
> ...

>
> So a missing keyring make ceph command crash. I see this commit, I
> think Sam found the bug independently and fixed it already. Please tr=
y
> again!
>
> commit d4ef9215fd00b08a198986fde4af5635833555ec
> Author: Samuel Just<samuel.just@dreamhost.com>
> Date:   2011-11-07 15:04:02 -0800
>
>      common: return null if mc.init() unsuccessful
>
>      Prevents ceph.cc from segfaulting on missing keyring.
>

yes, this fixes it - but a warning on stderr or so would be better imho=
=2E.


--=20

Mit freundlichen Gr=C3=BC=C3=9Fen,

=46lorian Wiessner

Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

--
Sitz der Gesellschaft: Naila
Gesch=C3=A4ftsf=C3=BChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
