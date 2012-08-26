From: Smart Weblications GmbH <info@smart-weblications.de>
Subject: Re: About sparse images
Date: Sun, 26 Aug 2012 20:38:02 +0200
Message-ID: <503A6D0A.8050207@smart-weblications.de>
References: <CAOLwVUnGz4ZvWdNo6JKHuS06YZYCeT7WjaDdGiDipRv8UZVLhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx04.smart-weblications.de ([188.65.144.39]:57913 "EHLO
	mx04.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753686Ab2HZSjD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sun, 26 Aug 2012 14:39:03 -0400
In-Reply-To: <CAOLwVUnGz4ZvWdNo6JKHuS06YZYCeT7WjaDdGiDipRv8UZVLhA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Am 26.08.2012 20:11, schrieb S=E9bastien Han:
> Hi all!
>=20
> I know that ceph images (rbd) are sparse. It's good but I have some
> interrogations about the ceph -s (-w) output. Let's say your create a
> 10G image, map it, format it and mount it. Finally you filled up the
> entire space available. You notice that the 'data' and 'used' space
> had grown. Now delete the content of your image but **not** this
> image, not now. You notice that nothing changed from the ceph output,
> it's not surprising because of the sparse capability. At this point o=
f
> time  the output from the command ceph is neither right nor wrong. It
> only shows the space used by the sparse image, but it doesn't mean
> that you have 'real' data in it, just a simple object allocation. It'=
s
> not so relevant, the only solution is to remove the image (obviously)=
=2E
> My feeling is that we should be careful about the ceph's output, it's
> not a good indicator for 'real' data. Ok Ceph won't replace a
> monitoring system but I'll be happy to trust the ceph output at 100%
> :)
>=20
> I would appreciate some reactions about that :)
>=20


why not gather real image size with rbd info <imagename>, sum up used s=
pace,
then look at ceph -s to get total avail space?



--=20

Mit freundlichen Gr=FC=DFen,


Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

--
Sitz der Gesellschaft: Naila
Gesch=E4ftsf=FChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
