From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: PG statechart
Date: Fri, 26 Apr 2013 09:07:40 -0700
Message-ID: <281AE624-F6F6-4376-8130-77608D174646@inktank.com>
References: <517A9B3A.3080806@dachary.org>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:54338 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966Ab3DZQHj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 12:07:39 -0400
Received: by mail-pa0-f42.google.com with SMTP id kl13so2579186pab.29
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 09:07:39 -0700 (PDT)
In-Reply-To: <517A9B3A.3080806@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Boost Statechart Viewer generates GraphViz:

  http://rtime.felk.cvut.cz/statechart-viewer/

Having trouble with my LLVM environment on 12.04, so I haven't tested i=
t.

-Noah

On Apr 26, 2013, at 8:20 AM, Loic Dachary <loic@dachary.org> wrote:

> Hi,
>=20
> I was considering drawing a statechart ( http://www.math-cs.gordon.ed=
u/courses/cs211/ATMExample/SessionStatechart.gif ) to better understand=
 the transitions of PG
>=20
> https://github.com/ceph/ceph/blob/master/src/osd/PG.h#L1341
>=20
> and realized that it probably already exists somewhere. Does it ?=20
>=20
> /me hopefull ;-)
>=20
> --=20
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
