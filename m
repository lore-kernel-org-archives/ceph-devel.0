From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Thu, 7 Apr 2016 17:01:53 +0200
Message-ID: <57067661.9090407@digiware.nl>
References: <20160404150042.GA25465@onthe.net.au>
 <CY1PR0201MB18973631BB493B8DCE1A5C4AE89D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1604050828340.19675@cpach.fuggernut.com>
 <20160405151030.GA20891@onthe.net.au> <20160406063849.GA5139@onthe.net.au>
 <BLUPR0201MB18900E0ADCEA8C22D67DF444E89F0@BLUPR0201MB1890.namprd02.prod.outlook.com>
 <20160406171702.GA5847@onthe.net.au>
 <BLUPR0201MB18903C5D060F326FEC75F81FE89F0@BLUPR0201MB1890.namprd02.prod.outlook.com>
 <20160407004307.GA15754@onthe.net.au>
 <CY1PR0201MB18977F92B66A47AE41220AC7E8900@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160407025945.GA16081@onthe.net.au> <57062DBC.5080105@digiware.nl>
 <3E2B4A2A-04CA-45BB-9E45-C5A0EFA46A17@ornl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:23391 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752991AbcDGPC3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Apr 2016 11:02:29 -0400
In-Reply-To: <3E2B4A2A-04CA-45BB-9E45-C5A0EFA46A17@ornl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Atchley, Scott" <atchleyes@ornl.gov>
Cc: Chris Dunlop <chris@onthe.net.au>, Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 7-4-2016 14:21, Atchley, Scott wrote:
>> On Apr 7, 2016, at 2:51 AM, Willem Jan Withagen <wjw@digiware.nl> wr=
ote:
>>
>> On 7-4-2016 04:59, Chris Dunlop wrote:
>>> On Thu, Apr 07, 2016 at 12:52:48AM +0000, Allen Samuels wrote:
>>>> So, what started this entire thread was Sage's suggestion that for=
 HDD we
>>>> would want to increase the size of the block under management. So =
if we
>>>> assume something like a 32-bit checksum on a 128Kbyte block being =
read
>>>> from 5ZB Then the odds become:
>>>>
>>>> 1 - (2^-32 * (1-(10^-15))^(128 * 8 * 1024) - 2^-32 + 1) ^ ((5 * 8 =
* 10^21) / (4 * 8 * 1024))
>>>>
>>>> Which is
>>>>
>>>> 0.257715899051042299960931575773635333355380139960141052927
>>>>
>>>> Which is 25%. A big jump ---> That's my point :)
>>>
>>> Oops, you missed adjusting the second checksum term, it should be:
>>>
>>> 1 - (2^-32 * (1-(10^-15))^(128 * 8 * 1024) - 2^-32 + 1) ^ ((5 * 8 *=
 10^21) / (128 * 8 * 1024))
>>> =3D 0.009269991973796787500153031469968391191560327904558440721
>>>
>>> ...which is different to the 4K block case starting at the 12th dig=
it. I.e. not very different.
>>>
>>> Which is my point! :)
>>
>> Sorry for posting something this vague, but my memory (and Google) i=
s playing games with me.
>>
>> I have not so recently read some articles about this when I was stud=
ying ZFS which has a
>> similar problem. Since it also aims for ZettaByte storage, and what =
I took from that discussion
>> is that most of the CRC32 checksumtypes are susceptible to bit-error=
 clustering. Which means that
>> there is a bigger chance for a faulty block or set of error bits to =
go undetected.
>>
>> Like I said, sorry for not being able to be more specific atm.
>>
>> The ZFS preferred checksum is fletcher4, also because of its speed.
>> But others include: fletcher2 | fletcher4 | sha256 | sha512 | skein =
| edonr
>>
>> There is an article on Wikipedia that discusses Fletcher algorithms,=
 strength and weakness:
>> https://en.wikipedia.org/wiki/Fletcher's_checksum
>>
>> =E2=80=94WjW
>=20
> This ZFS blog has an interesting discussion of trusting (or not trust=
ing) fletcher4:
>=20
> https://blogs.oracle.com/bonwick/entry/zfs_dedup

Hi Scott,

Good find, but not the one I'm missing.

in this article you have to make the distinction between generating
hashes to be used in dedup. And collision avoidance there is very
important. So it is about generating a unique value for every block of
dedupped data.

Checksums don't really care about collisions. Just as long as they
detect errors. And exactly about the capabilities for error detection
have the different algorithms different properties.

Now you could argument that a not detected error is sort of a collision
in itself. That is a valid comment.

THe difference however in the 2 algorithms is that checksum as key
requirement need to be susceptible for combinations of bit-changes, and
debug requires unique hash values for all its input blocks.

And thus the difference in requirement will lead to different
mathematics, and in the end to different algorithms.

--WjW


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
