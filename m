From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Radosgw - bucket index
Date: Sun, 18 May 2014 23:47:17 -0700
Message-ID: <CABBk=J9E0rCXvAWtizqQgqizf8o247cPZrv2VE6GNwWFrNa=Tw@mail.gmail.com>
References: <alpine.DEB.2.00.1405061757540.28165@cobra.newdream.net>
	<BLU436-SMTP195A770E0A729DF4723DD28DF310@phx.gbl>
	<alpine.DEB.2.00.1405160600320.28306@cobra.newdream.net>
	<CABBk=J_p9dDQBhvhbXrDmUonsY_TW5ZFDWuQqw3DGukVSRJeKg@mail.gmail.com>
	<BLU436-SMTP15995ECEE2C5FA8E935D70EDF330@phx.gbl>
	<alpine.DEB.2.00.1405181601030.1689@cobra.newdream.net>
	<BLU436-SMTP1455EF599E16A12B539B498DF320@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:63979 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaESGrS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 May 2014 02:47:18 -0400
Received: by mail-ve0-f181.google.com with SMTP id pa12so5886653veb.40
        for <ceph-devel@vger.kernel.org>; Sun, 18 May 2014 23:47:17 -0700 (PDT)
In-Reply-To: <BLU436-SMTP1455EF599E16A12B539B498DF320@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang Yang <yguang11@outlook.com>
Cc: Sage Weil <sage@inktank.com>, Haomai Wang <haomaiwang@gmail.com>, Ceph-devel <ceph-devel@vger.kernel.org>

On Sun, May 18, 2014 at 11:18 PM, Guang Yang <yguang11@outlook.com> wro=
te:
> On May 19, 2014, at 7:05 AM, Sage Weil <sage@inktank.com> wrote:
>
>> On Sun, 18 May 2014, Guang wrote:
>>>>> radosgw is using the omap key/value API for objects, which is mor=
e or less
>>>>> equivalent to what swift is doing with sqlite.  This data passes =
straight
>>>>> into leveldb on the backend (or whatever other backend you are us=
ing).
>>>>> Using something like rocksdb in its place is pretty simple and th=
er are
>>>>> unmerged patches to do that; the user would just need to adjust t=
heir
>>>>> crush map so that the rgw index pool is mapped to a different set=
 of OSDs
>>>>> with the better k/v backend.
>>> Not sure if I miss anything, but the key difference with SWIFT?s
>>> implementation is that they are using a table for bucket index and =
it
>>> actually can be updated in parallel which makes more scalable for w=
rite,
>>> though at certain point the sql table would result in performance
>>> degradation as well.
>>
>> As I understand it the same limitation is present there too: the ind=
ex is
>> in a single sqlite table.
>>
>>>> My more well-formed opinion is that we need to come up with a good
>>>> design. It needs to be flexible enough to be able to grow (and may=
be
>>>> shrink), and I assume there would be some kind of background opera=
tion
>>>> that will enable that. I also believe that making it hash based is=
 the
>>>> way to go. It looks like that the more complicated issue is here i=
s
>>>> how to handle the transition in which we shard buckets.
>>> Yeah I agree. I think the conflicting goals here are, we want a sor=
ted
>>> list (so that it enable prefix scan for listing purpose) and we wan=
t to
>>> shard at the very beginning (the problem we are facing is parallel
>>> writes updating the same bucket index object will need to be
>>> serialized).
>>
>> Given how infrequent container listings are, pre-sharding containers
>> across several objects makes some sense.  Paying the cost of doing
>> listings in parallel across N (where N is not too big) is not a big =
price
>> to pay. However, there will always need to be a way to re-shard furt=
her
>> when containers/buckets get extremely big.  Perhaps a starting point=
 would
>> be support for static sharding where the number of shards is specifi=
ed at
>> container/bucket creation time=E2=80=A6
> Considering the scope of the change, I also think this is a good star=
ting point to make the bucket index updating more scalable.
> Yehuda,
> How do you think?

Sharding it will help with scaling it up to a certain point. As Sage
mentioned we can start with a static setting as a first simpler
approach, and move into a dynamic approach later on.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
