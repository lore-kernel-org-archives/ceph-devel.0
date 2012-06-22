From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Rolling upgrades possible?
Date: Fri, 22 Jun 2012 13:34:06 +0400
Message-ID: <CABYiri_QWjWEZxDU-M7CH9nWRhZa1zb9D+jVtvkHv2DNOP-U0g@mail.gmail.com>
References: <CAMmJxt+2YZBCTZ_W7xuk8HHnqfTUUuxFGtT_AoaJYqsvjB0niw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:57162 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761909Ab2FVJe1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 05:34:27 -0400
Received: by wibhn6 with SMTP id hn6so469848wib.1
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jun 2012 02:34:26 -0700 (PDT)
In-Reply-To: <CAMmJxt+2YZBCTZ_W7xuk8HHnqfTUUuxFGtT_AoaJYqsvjB0niw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Axel Eriksson <john@insane.se>
Cc: ceph-devel@vger.kernel.org

On Fri, Jun 22, 2012 at 1:23 PM, John Axel Eriksson <john@insane.se> wr=
ote:
> I guess this has been asked before, I'm just new to the list and
> wondered whether it's possible to do
> rolling upgrades of mons, osds and radosgw? We will soon be in the
> process of migrating from our current
> storage solution to Ceph/RGW. We will only use the object storage,
> actually mainly the S3-interface radosgw
> supplies.
>
> Right now we have a very small test-installation - 1 mon, 2 osds wher=
e
> the mon also runs rgw. Next week I've
> heard that 0.48 might be released, if we upgrade to that, do we have
> to shut down the cluster during the upgrade
> or can we do a rolling upgrade while still responding to PUTs and
> GETs? If not possible yet, is this in the pipeline?
>
> Best,
> John

Should not be possible with only one mon, you need at least three for
continuous operation, so you can add them right now and then try to
upgrade cluster nodes one by one.

By the way, does recent upgrade of osd` on-disk content means near
stabilization of data format(which means theoretically flawless
per-node upgrade)? If so, is there any approximate times? About one
and half months ago some in-list discussion mentioned such
stabilization as very soon(tm), so I`ll be happy on more exact
timeline before pushing ceph-based infrastructure into production.

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
