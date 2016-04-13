From: Francois Lafont <flafdivers@free.fr>
Subject: Re: [ceph-users] Deprecating ext4 support
Date: Wed, 13 Apr 2016 16:19:05 +0200
Message-ID: <570E5559.7030307@free.fr>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36598 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031045AbcDMOTI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 10:19:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id l6so14398151wml.3
        for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 07:19:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

Hello,

On 11/04/2016 23:39, Sage Weil wrote:

> [...] Is this reasonable?  [...]

Warning: I'm just a ceph user and definitively non-expert user.

1. Personally, if you see the documentation, read a little the maling l=
ist
and/or IRC, it seems to me _clear_ that ext4 is not recommended even if=
 the
opposite if mentioned sometimes (personally I don't use ext4 in my ceph
cluster, I use xfs as the doc says).

2. I'm not a ceph expert but I can imagine the monstrous work that repr=
esents
the development of a software such as ceph and I think it can be reason=
able
sometimes to limit the work when it's possible.

So make ext4 deprecated seems to me reasonable. I think the comfort of =
the
users is important but, in a _long_ term, it seems to me important that=
 the
developers can concentrate their work to important things.

--=20
=46ran=C3=A7ois Lafont
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
