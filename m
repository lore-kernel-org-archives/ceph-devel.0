From: Guang Yang <yguang11@outlook.com>
Subject: Re: Radosgw - bucket index
Date: Mon, 2 Jun 2014 21:37:30 +0800
Message-ID: <BLU436-SMTP237CB8BBFC0921406960C55DF200@phx.gbl>
References: <alpine.DEB.2.00.1405061757540.28165@cobra.newdream.net> <BLU436-SMTP195A770E0A729DF4723DD28DF310@phx.gbl> <alpine.DEB.2.00.1405160600320.28306@cobra.newdream.net> <CABBk=J_p9dDQBhvhbXrDmUonsY_TW5ZFDWuQqw3DGukVSRJeKg@mail.gmail.com> <BLU436-SMTP15995ECEE2C5FA8E935D70EDF330@phx.gbl> <alpine.DEB.2.00.1405181601030.1689@cobra.newdream.net> <BLU436-SMTP1455EF599E16A12B539B498DF320@phx.gbl> <CABBk=J9E0rCXvAWtizqQgqizf8o247cPZrv2VE6GNwWFrNa=Tw@mail.gmail.com> <0F65B78C-DF9A-40E4-BAAF-7411443DA3B6@outlook.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s7.hotmail.com ([65.55.111.146]:55783 "EHLO
	BLU004-OMC4S7.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459AbaFBNh7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jun 2014 09:37:59 -0400
In-Reply-To: <0F65B78C-DF9A-40E4-BAAF-7411443DA3B6@outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

Hi Yehuda and Sage,
Can you help to comment on the ticket, I would like to send out a pull =
request some time this week for you to review, but before that, it woul=
d be nice to see your comments in terms of the interface and any other =
concerns you may have for this. Thanks.

Thanks,
Guang


On May 30, 2014, at 8:35 AM, Guang Yang <yguang11@outlook.com> wrote:

> Hi Yehuda,
> I opened an issue here: http://tracker.ceph.com/issues/8473, please h=
elp to review and comment.
>=20
> Thanks,
> Guang
>=20
> On May 19, 2014, at 2:47 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
>=20
>> On Sun, May 18, 2014 at 11:18 PM, Guang Yang <yguang11@outlook.com> =
wrote:
>>> On May 19, 2014, at 7:05 AM, Sage Weil <sage@inktank.com> wrote:
>>>=20
>>>> On Sun, 18 May 2014, Guang wrote:
>>>>>>> radosgw is using the omap key/value API for objects, which is m=
ore or less
>>>>>>> equivalent to what swift is doing with sqlite.  This data passe=
s straight
>>>>>>> into leveldb on the backend (or whatever other backend you are =
using).
>>>>>>> Using something like rocksdb in its place is pretty simple and =
ther are
>>>>>>> unmerged patches to do that; the user would just need to adjust=
 their
>>>>>>> crush map so that the rgw index pool is mapped to a different s=
et of OSDs
>>>>>>> with the better k/v backend.
>>>>> Not sure if I miss anything, but the key difference with SWIFT?s
>>>>> implementation is that they are using a table for bucket index an=
d it
>>>>> actually can be updated in parallel which makes more scalable for=
 write,
>>>>> though at certain point the sql table would result in performance
>>>>> degradation as well.
>>>>=20
>>>> As I understand it the same limitation is present there too: the i=
ndex is
>>>> in a single sqlite table.
>>>>=20
>>>>>> My more well-formed opinion is that we need to come up with a go=
od
>>>>>> design. It needs to be flexible enough to be able to grow (and m=
aybe
>>>>>> shrink), and I assume there would be some kind of background ope=
ration
>>>>>> that will enable that. I also believe that making it hash based =
is the
>>>>>> way to go. It looks like that the more complicated issue is here=
 is
>>>>>> how to handle the transition in which we shard buckets.
>>>>> Yeah I agree. I think the conflicting goals here are, we want a s=
orted
>>>>> list (so that it enable prefix scan for listing purpose) and we w=
ant to
>>>>> shard at the very beginning (the problem we are facing is paralle=
l
>>>>> writes updating the same bucket index object will need to be
>>>>> serialized).
>>>>=20
>>>> Given how infrequent container listings are, pre-sharding containe=
rs
>>>> across several objects makes some sense.  Paying the cost of doing
>>>> listings in parallel across N (where N is not too big) is not a bi=
g price
>>>> to pay. However, there will always need to be a way to re-shard fu=
rther
>>>> when containers/buckets get extremely big.  Perhaps a starting poi=
nt would
>>>> be support for static sharding where the number of shards is speci=
fied at
>>>> container/bucket creation time=85
>>> Considering the scope of the change, I also think this is a good st=
arting point to make the bucket index updating more scalable.
>>> Yehuda,
>>> How do you think?
>>=20
>> Sharding it will help with scaling it up to a certain point. As Sage
>> mentioned we can start with a static setting as a first simpler
>> approach, and move into a dynamic approach later on.
>>=20
>> Yehuda
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
