From: Guang Yang <yguang11@outlook.com>
Subject: Re: Radosgw - bucket index
Date: Mon, 19 May 2014 14:18:06 +0800
Message-ID: <BLU436-SMTP1455EF599E16A12B539B498DF320@phx.gbl>
References: <alpine.DEB.2.00.1405061757540.28165@cobra.newdream.net> <BLU436-SMTP195A770E0A729DF4723DD28DF310@phx.gbl> <alpine.DEB.2.00.1405160600320.28306@cobra.newdream.net> <CABBk=J_p9dDQBhvhbXrDmUonsY_TW5ZFDWuQqw3DGukVSRJeKg@mail.gmail.com> <BLU436-SMTP15995ECEE2C5FA8E935D70EDF330@phx.gbl> <alpine.DEB.2.00.1405181601030.1689@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [65.55.111.140] ([65.55.111.140]:64150 "EHLO
	BLU004-OMC4S1.hotmail.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752910AbaESGSe convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 19 May 2014 02:18:34 -0400
In-Reply-To: <alpine.DEB.2.00.1405181601030.1689@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, Yehuda Sadeh <yehuda@inktank.com>
Cc: haomaiwang@gmail.com, Ceph-devel <ceph-devel@vger.kernel.org>

On May 19, 2014, at 7:05 AM, Sage Weil <sage@inktank.com> wrote:

> On Sun, 18 May 2014, Guang wrote:
>>>> radosgw is using the omap key/value API for objects, which is more=
 or less
>>>> equivalent to what swift is doing with sqlite.  This data passes s=
traight
>>>> into leveldb on the backend (or whatever other backend you are usi=
ng).
>>>> Using something like rocksdb in its place is pretty simple and the=
r are
>>>> unmerged patches to do that; the user would just need to adjust th=
eir
>>>> crush map so that the rgw index pool is mapped to a different set =
of OSDs
>>>> with the better k/v backend.
>> Not sure if I miss anything, but the key difference with SWIFT?s=20
>> implementation is that they are using a table for bucket index and i=
t=20
>> actually can be updated in parallel which makes more scalable for wr=
ite,=20
>> though at certain point the sql table would result in performance=20
>> degradation as well.
>=20
> As I understand it the same limitation is present there too: the inde=
x is=20
> in a single sqlite table.
>=20
>>> My more well-formed opinion is that we need to come up with a good
>>> design. It needs to be flexible enough to be able to grow (and mayb=
e
>>> shrink), and I assume there would be some kind of background operat=
ion
>>> that will enable that. I also believe that making it hash based is =
the
>>> way to go. It looks like that the more complicated issue is here is
>>> how to handle the transition in which we shard buckets.
>> Yeah I agree. I think the conflicting goals here are, we want a sort=
ed=20
>> list (so that it enable prefix scan for listing purpose) and we want=
 to=20
>> shard at the very beginning (the problem we are facing is parallel=20
>> writes updating the same bucket index object will need to be=20
>> serialized).
>=20
> Given how infrequent container listings are, pre-sharding containers=20
> across several objects makes some sense.  Paying the cost of doing=20
> listings in parallel across N (where N is not too big) is not a big p=
rice=20
> to pay. However, there will always need to be a way to re-shard furth=
er=20
> when containers/buckets get extremely big.  Perhaps a starting point =
would=20
> be support for static sharding where the number of shards is specifie=
d at=20
> container/bucket creation time=85
Considering the scope of the change, I also think this is a good starti=
ng point to make the bucket index updating more scalable.
Yehuda,
How do you think?
>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
