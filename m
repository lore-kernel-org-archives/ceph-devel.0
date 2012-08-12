From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: No lock on RBD allow several mount on different servers...
Date: Sun, 12 Aug 2012 11:37:29 +0200
Message-ID: <50277959.1080603@smart-weblications.de>
References: <CAOLwVUkWEOdo_HjKRZwU0rGi4S8rA33-o5gCMBJvhJahkrLXpQ@mail.gmail.com> <CALFpzo49Urnf8rnFCQ=wQ8eFMR0-8FWh2=9nKrCAxb+0Xm0rVQ@mail.gmail.com> <CAOLwVUnSUpAC69W48gbz-+7L7+p9z5tioODh_hPwVEt39GDvHw@mail.gmail.com> <CALFpzo4X7iL6aEUtqyEBp4AMDxKkK9wtwPx35WQVauYQbe8Hng@mail.gmail.com> <CALFpzo4up8oqKNESWDzm2AVpZ0Z5WyB5PQX-8Cu2+Sga7i=zbQ@mail.gmail.com> <CALFpzo7YicrNh8qCoTAe2hUU+onkci8PbggKWfUjn1TJ635HUw@mail.gmail.com> <06A44B2B-FA7F-418C-B9D2-D0602F4EB95B@gmail.com>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx03.smart-weblications.de ([188.65.144.38]:53661 "EHLO
	mx03.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751048Ab2HLJiE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sun, 12 Aug 2012 05:38:04 -0400
In-Reply-To: <06A44B2B-FA7F-418C-B9D2-D0602F4EB95B@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien HAN <han.sebastien@gmail.com>
Cc: Marcus Sorensen <shadowsor@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Am 12.08.2012 10:40, schrieb Sebastien HAN:

>>>>>>>
>>>>>>> With RBD images, the theory makes possible to mount them multip=
le
>>>>>>> times on different servers, of course **no one** wants that. If=
 you
>>>>>>> care about the consistency of your data :D
>>>>>>> I was wondering if ceph has any lock ability on the RBD device =
like
>>>>>>> DRBD does with secondary resource. Apparently not, I was able t=
o mount
>>>>>>> an image on multiple server and wrote data on both.
>>>>>>>
>>>>>>> Is this an incoming feature?
>>>>>>>
>>>>>>> I don't really know the difficulty level that this kind of feat=
ure
>>>>>>> implies, but it would be nice to have it.
>>>>>>>

I use ocfs2 ontop of mapped rbd images - works great.


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
