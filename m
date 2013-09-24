From: =?UTF-8?Q?S=C3=A9bastien_Han?= <sebastien.han@enovance.com>
Subject: =?UTF-8?Q?Re=3A_Object_Write_Latency?=
Date: Tue, 24 Sep 2013 14:30:49 +0200
Message-ID: <etPan.524185f9.2cd89a32.f19a@leseb-mba.local>
References: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch>
 <CAPYLRziY9YVXp+zW8dS9+dN-r24AXXG84wx0ZgQFtpX2C1Pnfg@mail.gmail.com>
 <CABZ+qqnHf9NG5JirYNtT6LUEbzo52U43Arooo5-CNXR2SPPKaA@mail.gmail.com>
 <alpine.DEB.2.00.1309231115520.7394@cobra.newdream.net>
 <CABZ+qq=Pj0oQ3nUUh3T_mTnpXSUd93uLzX955bHx6MY+fek9YQ@mail.gmail.com>
 <CABZ+qqmzumXyncc3R6gOA4dzutto99eCUPOd7EG3TgNG9-=SyA@mail.gmail.com>
 <etPan.52417ad3.3804823e.f19a@leseb-mba.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:8665 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab3IXMam convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Sep 2013 08:30:42 -0400
In-Reply-To: <etPan.52417ad3.3804823e.f19a@leseb-mba.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, Dan van der Ster <dan@vanderster.com>
Cc: Andreas Joachim Peters <andreas.joachim.peters@cern.ch>, Gregory Farnum <greg@inktank.com>, "=?UTF-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

Ideally a partition using the first sectors of the disk.
I usually do a tiny partition at the beginning of the device and leave =
the rest for ods_data.

=E2=80=93=E2=80=93=E2=80=93=E2=80=93
S=C3=A9bastien Han
Cloud Engineer

"Always give 100%. Unless you're giving blood.=E2=80=9D

Phone:=C2=A0+33 (0)1 49 70 99 72
Mail:=C2=A0sebastien.han@enovance.com
Address :=C2=A010, rue de la Victoire - 75009 Paris
Web :=C2=A0www.enovance.com=C2=A0-=C2=A0Twitter :=C2=A0@enovance

On September 24, 2013 at 1:43:15 PM, S=C3=A9bastien Han (sebastien.han@=
enovance.com) wrote:

Ideally a partition using the first sectors of the disk.
I usually do a tiny partition at the beginning of the device and leave =
the rest for ods_data.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
