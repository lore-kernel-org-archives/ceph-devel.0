From: Vero Estrada Galinanes <veg@ucsc.edu>
Subject: Re: Criteria behind disk scrubbing policy
Date: Wed, 9 Mar 2016 10:34:07 -0800
Message-ID: <CFA14F8E-3B3C-4594-BEB5-19C68983E377@ucsc.edu>
References: <CAKiXLjenBAB76AJ9qirL5Ff_GDz6E3sGXUie90xrsqydUqFVTw@mail.gmail.com> <alpine.DEB.2.11.1603090857080.14377@cpach.fuggernut.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34933 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932624AbcCISe1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2016 13:34:27 -0500
Received: by mail-pa0-f51.google.com with SMTP id td3so19532390pab.2
        for <ceph-devel@vger.kernel.org>; Wed, 09 Mar 2016 10:34:27 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1603090857080.14377@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,
Thanks for your answers
>=20
> In Ceph clusters disks are generally never powered down.  It sounds l=
ike=20
> Schwarz et al were studying a different type of storage system.  In o=
ur=20
> case, it's all about how quickly you discover a defect and repair aro=
und=20
> it.

Indeed, he was studying archival storage. I=E2=80=99m interested in bot=
h system types.
>=20
> We do let you change the scrub intervals on a per-pool basis as well =
(see=20
> pool_opts in osd/osd_types.h), so you can adjust the policy based on =
both=20
> the pool type (replicated vs erasure coded) or the importance of the =
data=20
> it contains.
>=20

That setting is exactly what I was expecting ceph should have. Do you h=
ave any study done about choosing scrub intervals policy on replicated/=
erasured pools?

Best,
Vero--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
