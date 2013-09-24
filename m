From: =?UTF-8?Q?S=C3=A9bastien_Han?= <sebastien.han@enovance.com>
Subject: =?UTF-8?Q?Re=3A_Object_Write_Latency?=
Date: Tue, 24 Sep 2013 14:39:52 +0200
Message-ID: <etPan.52418818.542289ec.f19a@leseb-mba.local>
References: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch>
 <CAPYLRziY9YVXp+zW8dS9+dN-r24AXXG84wx0ZgQFtpX2C1Pnfg@mail.gmail.com>
 <CABZ+qqnHf9NG5JirYNtT6LUEbzo52U43Arooo5-CNXR2SPPKaA@mail.gmail.com>
 <alpine.DEB.2.00.1309231115520.7394@cobra.newdream.net>
 <CABZ+qq=Pj0oQ3nUUh3T_mTnpXSUd93uLzX955bHx6MY+fek9YQ@mail.gmail.com>
 <CABZ+qqmzumXyncc3R6gOA4dzutto99eCUPOd7EG3TgNG9-=SyA@mail.gmail.com>
 <etPan.52417ad3.3804823e.f19a@leseb-mba.local>
 <etPan.524185f9.2cd89a32.f19a@leseb-mba.local>
 <CABZ+qqkHz0Qf+qYZTh5mnuTKWJ_-pDdG5tkqMFnX+AroPum_VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:49865 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab3IXMjq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Sep 2013 08:39:46 -0400
In-Reply-To: <CABZ+qqkHz0Qf+qYZTh5mnuTKWJ_-pDdG5tkqMFnX+AroPum_VA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: Andreas Joachim Peters <andreas.joachim.peters@cern.ch>, Gregory Farnum <greg@inktank.com>, "=?UTF-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Hi Dan,

Yes I noticed :), no we haven=E2=80=99t done anything on that side yet.
But I=E2=80=99ll be happy to see this happening, that way better than a=
 file of the fs.

Would be nice if you could push something then :)

Cheers.
=E2=80=93=E2=80=93=E2=80=93=E2=80=93
S=C3=A9bastien Han
Cloud Engineer

"Always give 100%. Unless you're giving blood.=E2=80=9D

Phone:=C2=A0+33 (0)1 49 70 99 72
Mail:=C2=A0sebastien.han@enovance.com
Address :=C2=A010, rue de la Victoire - 75009 Paris
Web :=C2=A0www.enovance.com=C2=A0-=C2=A0Twitter :=C2=A0@enovance

On September 24, 2013 at 2:33:57 PM, Dan van der Ster (dan@vanderster.c=
om) wrote:

Thanks Sebastien, we will try that. BTW, as you know we're using the =20
puppet modules of enovance, which set up a file-based journal. Did you =
=20
guys already puppetize a blockdev journal? I'll be doing that now if =20
not... =20
Cheers, Dan =20
CERN IT =20

On Tue, Sep 24, 2013 at 2:30 PM, S=C3=A9bastien Han =20
<sebastien.han@enovance.com> wrote: =20
> Ideally a partition using the first sectors of the disk. =20
> I usually do a tiny partition at the beginning of the device and leav=
e the rest for ods_data. =20
> =20
> =E2=80=93=E2=80=93=E2=80=93=E2=80=93 =20
> S=C3=A9bastien Han =20
> Cloud Engineer =20
> =20
> "Always give 100%. Unless you're giving blood.=E2=80=9D =20
> =20
> Phone: +33 (0)1 49 70 99 72 =20
> Mail: sebastien.han@enovance.com =20
> Address : 10, rue de la Victoire - 75009 Paris =20
> Web : www.enovance.com - Twitter : @enovance =20
> =20
> On September 24, 2013 at 1:43:15 PM, S=C3=A9bastien Han (sebastien.ha=
n@enovance.com) wrote: =20
> =20
> Ideally a partition using the first sectors of the disk. =20
> I usually do a tiny partition at the beginning of the device and leav=
e the rest for ods_data.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
