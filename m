From: Gregory Farnum <greg@inktank.com>
Subject: Re: some questions about ceph
Date: Wed, 23 Jan 2013 16:01:57 -0800
Message-ID: <41D812A2765C43A1A6F2CAC5B9EA8DCE@inktank.com>
References: <CAFKnYyQbZcsCH_DwsQC-2eagU+A1a0g7PRS_L769_FC8QVJTxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:63302 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab3AXACB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 19:02:01 -0500
Received: by mail-pb0-f41.google.com with SMTP id xa7so5022225pbc.0
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 16:02:01 -0800 (PST)
In-Reply-To: <CAFKnYyQbZcsCH_DwsQC-2eagU+A1a0g7PRS_L769_FC8QVJTxg@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yue Li <xyly781@gmail.com>
Cc: ceph-devel@vger.kernel.org, Sheng Qiu <herbert1984106@gmail.com>

On Wednesday, January 23, 2013 at 3:35 PM, Yue Li wrote:
> Hi,
> =20
> i have some questions about ceph.
> =20
> ceph provide a POSIX client for users.
> for aio-read/write, it still use page cache on client side (seems to
> me). How long will the page cache expire (in case the data on server
> side has changed)?

The kernel client does this automatically; ceph-fuse currently doesn't =
do page cache invalidation (so, yes, you can get stale data), but fixin=
g this is in our queue and should be coming pretty soon: http://tracker=
=2Enewdream.net/issues/2215
 =20
> if we miss the page cache, we need to fetch data from server side for
> read accesses, what's the minimum transfer unit between client and
> OSDs?

There is no hard limit, although there will be a practical minimum base=
d on the read ahead and prefetch settings you specify.
 =20
> for write accesses, will the client batch the write request data into
> units of obj size then transferring to OSDs?

It will try to write out what it can, but no =E2=80=94 if you aren't do=
ing any syncs yourself, then the client will write out dirty data accor=
ding to an LRU (in ceph-fuse) or the regular page cache eviction algori=
thms (for the kernel), aggregating the dirty data it has available.
 =20
> generally what's the minimum transfer unit between client and OSDs?

No minimum.
 =20
> =20
> How to ensure the consistency for multi-write from clients on the sam=
e
> piece of data or parallel read and write on the same data?

If you have multiple clients accessing the same piece of data and at le=
ast one is a writer, they will go into a synchronous mode and data acce=
ss is coordinated and ordered by the MDS.
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
