From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Hadoop DNS/topology details
Date: Tue, 19 Feb 2013 16:36:05 -0800
Message-ID: <16038FC6-8930-46AE-A5C5-1169230CDDA8@cs.ucsc.edu>
References: <13BF7821-647C-4234-B696-5AA41ECCD6E5@cs.ucsc.edu> <CAPYLRzjy-TCTobh1mi1=d9omx0ZWvEce6ZB9vvf3ON5MVaC-MA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:45158 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933049Ab3BTAgH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 19:36:07 -0500
Received: by mail-pa0-f41.google.com with SMTP id fb11so3685461pad.14
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 16:36:06 -0800 (PST)
In-Reply-To: <CAPYLRzjy-TCTobh1mi1=d9omx0ZWvEce6ZB9vvf3ON5MVaC-MA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Joe Buck <jbbuck@gmail.com>


On Feb 19, 2013, at 2:22 PM, Gregory Farnum <greg@inktank.com> wrote:

> On Tue, Feb 19, 2013 at 2:10 PM, Noah Watkins <jayhawk@cs.ucsc.edu> w=
rote:
>=20
> That is just truly annoying. Is this described anywhere in their docs=
?

Not really. It's just there in the code--I can figure out the metric if=
 you're interested. I suspect it is local node, local rack, off rack or=
dering, with no special tie breakers.

> I don't think it would be hard to sort, if we had some mechanism for
> doing so (crush map nearness, presumably?),

Topology information from the bucket hierarchy? I think it's always som=
e sort of heuristic.

>> 1. Expand CephFS interface to return IP and hostname
>=20
> Ceph doesn't store hostnames anywhere =97 it really can't do this. Al=
l
> it has is IPs associated with OSD ID numbers. :) Adding hostnames
> would be a monitor and map change, which we could do, but given the
> issues we've had with hostnames in other contexts I'd really rather
> not.

What is the fate of hostnames used in ceph.conf? Could that information=
 be leveraged, when specified by the cluster admin?

-Noah--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
