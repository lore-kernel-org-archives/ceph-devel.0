From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Object Write Latency
Date: Tue, 24 Sep 2013 14:33:11 +0200
Message-ID: <CABZ+qqkHz0Qf+qYZTh5mnuTKWJ_-pDdG5tkqMFnX+AroPum_VA@mail.gmail.com>
References: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch>
 <CAPYLRziY9YVXp+zW8dS9+dN-r24AXXG84wx0ZgQFtpX2C1Pnfg@mail.gmail.com>
 <CABZ+qqnHf9NG5JirYNtT6LUEbzo52U43Arooo5-CNXR2SPPKaA@mail.gmail.com>
 <alpine.DEB.2.00.1309231115520.7394@cobra.newdream.net> <CABZ+qq=Pj0oQ3nUUh3T_mTnpXSUd93uLzX955bHx6MY+fek9YQ@mail.gmail.com>
 <CABZ+qqmzumXyncc3R6gOA4dzutto99eCUPOd7EG3TgNG9-=SyA@mail.gmail.com>
 <etPan.52417ad3.3804823e.f19a@leseb-mba.local> <etPan.524185f9.2cd89a32.f19a@leseb-mba.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:64695 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab3IXMdy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Sep 2013 08:33:54 -0400
Received: by mail-bk0-f48.google.com with SMTP id my13so1655970bkb.7
        for <ceph-devel@vger.kernel.org>; Tue, 24 Sep 2013 05:33:52 -0700 (PDT)
Received: by mail-lb0-f174.google.com with SMTP id w6so3694758lbh.19
        for <ceph-devel@vger.kernel.org>; Tue, 24 Sep 2013 05:33:51 -0700 (PDT)
In-Reply-To: <etPan.524185f9.2cd89a32.f19a@leseb-mba.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <sebastien.han@enovance.com>
Cc: Sage Weil <sage@inktank.com>, Andreas Joachim Peters <andreas.joachim.peters@cern.ch>, Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks Sebastien, we will try that. BTW, as you know we're using the
puppet modules of enovance, which set up a file-based journal. Did you
guys already puppetize a blockdev journal? I'll be doing that now if
not...
Cheers, Dan
CERN IT

On Tue, Sep 24, 2013 at 2:30 PM, S=E9bastien Han
<sebastien.han@enovance.com> wrote:
> Ideally a partition using the first sectors of the disk.
> I usually do a tiny partition at the beginning of the device and leav=
e the rest for ods_data.
>
> =96=96=96=96
> S=E9bastien Han
> Cloud Engineer
>
> "Always give 100%. Unless you're giving blood.=94
>
> Phone: +33 (0)1 49 70 99 72
> Mail: sebastien.han@enovance.com
> Address : 10, rue de la Victoire - 75009 Paris
> Web : www.enovance.com - Twitter : @enovance
>
> On September 24, 2013 at 1:43:15 PM, S=E9bastien Han (sebastien.han@e=
novance.com) wrote:
>
> Ideally a partition using the first sectors of the disk.
> I usually do a tiny partition at the beginning of the device and leav=
e the rest for ods_data.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
