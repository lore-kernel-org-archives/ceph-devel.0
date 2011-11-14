From: Kelly Kane <kelly@hawknetworks.com>
Subject: Re: crushmap errors
Date: Mon, 14 Nov 2011 07:45:31 -0800
Message-ID: <CAKfXD0xj7dAGPpv48-X4kO9ek7QjPtEzYGP5Uvf+Qi3+8bDiTg@mail.gmail.com>
References: <4EBD9F62.20709@tuxadero.com>
	<Pine.LNX.4.64.1111111444490.30348@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48314 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582Ab1KNPpc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2011 10:45:32 -0500
Received: by fagn18 with SMTP id n18so3130020fag.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2011 07:45:31 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1111111444490.30348@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Martin Mailand <martin@tuxadero.com>, ceph-devel@vger.kernel.org

On Fri, Nov 11, 2011 at 14:51, Sage Weil <sage@newdream.net> wrote:
>> 2. Why are 2 racks are not enough for 2 failure domains?
>> From the commit:
>> If there are >2 racks, separate across racks.
>
> Well, technically they are. =C2=A0My worry is that it's more likely t=
hat racks
> will have significantly vary capacity (i.e. crush weight) due to, say=
, 1
> full rack and a second 1/2 rack. =C2=A0If the policy forces replicas =
be placed
> across racks things won't balance well.
>
> I suppose there should be an argument like --min-racks that controls =
that
> threshold?

In theory the operator can shoot themselves in the foot if they so
please. It seems like a Ceph management console could warn about
"imbalanced crush weight" across racks. This would also allow the
cluster operator to check on their balance over time assuming hardware
gets replaced over time. This could introduce larger rotational hdds,
or smaller ssds, across the cluster.

Kelly
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
