From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Thu, 7 Apr 2016 03:17:02 +1000
Message-ID: <20160406171702.GA5847@onthe.net.au>
References: <20160401194912.GA18636@onthe.net.au>
 <CY1PR0201MB1897EE2E58FFF2FF3DFFFB55E89A0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160402040736.GA22721@onthe.net.au>
 <CY1PR0201MB1897416E6B245E1FC2B9CEBEE89B0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160404150042.GA25465@onthe.net.au>
 <CY1PR0201MB18973631BB493B8DCE1A5C4AE89D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1604050828340.19675@cpach.fuggernut.com>
 <20160405151030.GA20891@onthe.net.au>
 <20160406063849.GA5139@onthe.net.au>
 <BLUPR0201MB18900E0ADCEA8C22D67DF444E89F0@BLUPR0201MB1890.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:47015 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbcDFRRJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Apr 2016 13:17:09 -0400
Content-Disposition: inline
In-Reply-To: <BLUPR0201MB18900E0ADCEA8C22D67DF444E89F0@BLUPR0201MB1890.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Sage Weil <sage@newdream.net>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Apr 06, 2016 at 03:47:41PM +0000, Allen Samuels wrote:
>> From: Chris Dunlop [mailto:chris@onthe.net.au]
>> On Wed, Apr 06, 2016 at 01:10:30AM +1000, Chris Dunlop wrote:
>> OK, here's my (1st!, more below) working:

<snip>

> Well, that's correct if you have a "C" bit checksum for each bit. It'=
s not ok if the checksum is per-block.

Yeah, I realised that in the end.

>> OK, here's another attempt, looking at it a little differently: my 1=
st working
>> applies the P(bad check) at the bit level, the same as for P(bad bit=
). But the
>> checksum is actually done at the block level. So:
>>=20
>> P(bad bit)
>>   =3D probability bit is bad (BER)
>>   =3D U
>>=20
>> P(good bit)
>>   =3D probability bit is good
>>   =3D 1 - U
>>=20
>> P(good block)
>>   =3D probability D-bit block is all-bits-good
>>   =3D (1 - U) ^ D
>>=20
>> P(bad block)
>>   =3D probability block has at least one bad bit
>>   =3D 1 - P(good block)
>>   =3D 1 - ((1 - U) ^ D)
>>=20
>> P(bad check)
>>   =3D probability checksum fails (i.e. a false match)
>>   =3D 2^-C
>>=20
>> P(good check)
>>   =3D probability checksum succeeds (flags bad data)
>>   =3D 1 - P(bad check)
>>   =3D 1 - (2^-C)
>>=20
>> P(block ok)
>>   =3D probability block is all-good, or bad and flagged by checksum
>>   =3D P(good block) + (P(bad block) * P(good check))
>=20
> I don't think you can add these probabilities together. That only wor=
ks for uncorrelated events, which this isn't.=20

P(good block) and P(bad block) are mutually exclusive, so adding is wha=
t you
want to do. The sum of the two is 1: every block is either good (no bit
errors) or bad (bit errors). Multiplying P(bad block) by P(good check)=20
gives us the probability a bad block will be flagged by the checksum.

>>   =3D ((1 - U) ^ D) + ((1 - ((1 - U) ^ D)) * (1 - (2^-C)))
>>   =3D 2^-C * ((1-U)^D-1)+1
>>=20
>> N  =3D number of bits in data in which we're interested
>>=20
>> P(data ok)
>>   =3D probability data is ok (good, or flagged)
>>   =3D P(block ok) ^ (number_of_blocks)
>>   =3D P(block ok) ^ (N / D)
>>   =3D (((1 - U) ^ D) + ((1 - ((1 - U) ^ D)) * (1 - (2^-C)))) ^ (N / =
D)
>>   =3D (2^-C * (((1-U)^D) - 1) + 1) ^ (N / D)
>>=20
>> P(bad data)
>>   =3D probability of getting unflagged bad data
>>   =3D 1 - P(data ok)
>>   =3D 1 - ((2^-C * ((1-U)^D-1)+1) ^ (N / D))
>>=20
>> ...and this time the D term doesn't disappear. I.e. it supports Alle=
n's
>> contention that the block size matters.
>>=20
>> Let's plug some numbers into Wolfram Alpha to see if we get plausibl=
e
>> results:
>>=20
>> U =3D 10^-15
>> C =3D 32
>> D =3D 4 * 1024
>> N =3D 5PB =3D 5 * 8 * 10^15
>=20
> Not that it matters much, but shouldn't D be 4 * 8 * 1024 ?

Oops! Yup.

>> ---------
>> Chris #1
>> ---------
>> P(bad data)
>>   =3D 1 - ((1 - (U * 2^-C)) ^ N)
>>   =3D 1 - ((1 - ((10^-15) * (2^-32))) ^ (5 * 8 * (10^15)))
>>   =3D 9.3132257027866983914620845681582388414865913202250969 =C3=97 =
10^-9
>=20
> If I understood your terminology, doesn't this apply a 32-bit checksu=
m to each bit? If so, this result seems waaaaaay too high.

Yes, that's my first attempt which was incorrect for exactly that reaso=
n.

>> ---------
>> Chris #2
>> ---------
>> P(bad data)
>>   =3D 1 - ((2^-C * (((1-U)^D) - 1) + 1) ^ (N / D))
>>   =3D 1 - (((2^-32) * ((1-(10^-15))^(4 * 1024)-1)+1) ^ ((5 * 8 * (10=
^15)) / (4 * 1024)))
>>   =3D 9.3132257027676295619288907910277855094237197529999931 =C3=97 =
10^-9
>>   (differs from Chris #1 at 10^-20)
>>=20
>> If this formula is correct, it's still relatively immune to the data=
 block size, e.g.
>> at D =3D (1024 * 1024):
>>   =3D 1 - (((2^-32) * ((1-(10^-15))^(1024 * 1024)-1)+1) ^ ((5 * 8 * =
(10^15)) / (1024 * 1024)))
>>   =3D 9.3132256979038905963931781911807383342120258917664411 =C3=97 =
10^-9
>>   (differs from D=3D(4 * 1024) at 10^-17)

<snip>

>> ---------
>> Allen
>> ---------
>>> So the overall probability of a failure for this read is:
>>> (1 - (1-U)^D) / (2^C).
>>=20
>> P(bad data)
>>   =3D (1 - (1-U)^D) / (2^C)
>>   =3D (1 - (1-(10^-15))^(4 * 1024)) / (2^32)
>>   =3D 9.536743164042973518371608678388595553788002932094000 =C3=97 1=
0^-22
>>   (seems implausibly low?)
>=20
> I think my formula handles the odds of an individual (512B with 32bit
> checksum) read silently failing. I'm not exactly sure, but I think yo=
u're
> computing the odds of reading all 5PB once without a silent failure.
> Apples/oranges... That's why the numbers are so far different.

Doh! Sorry, yes, it should have been obvious to me that your formula di=
dn't
include the N term.

Let's say your formula is giving P(block not ok) (i.e. read silently fa=
iled).
To expand this to P(bad data), i.e. the odds of a failure when reading =
N bits:

P(block ok)
  =3D probability block is all-good, or bad and flagged by checksum
  =3D 1 - P(block not ok)
  =3D 1 - ((1 - (1-U)^D) / (2^C))

P(good data)
  =3D probability all data is ok (good, or flagged)
  =3D P(block ok) ^ (number_of_blocks)
  =3D P(block ok) ^ (N / D)
  =3D (1 - ((1 - (1-U)^D) / (2^C))) ^ (N / D)

P(bad data)
  =3D 1 - P(good data)
  =3D 1 - ((1 - ((1 - (1-U)^D) / (2^C))) ^ (N / D))

Compare that to my #2 from above:

P(bad data)
  =3D 1 - ((2^-C * (((1-U)^D) - 1) + 1) ^ (N / D))

With a little bit of manipulation (lazy way: use Wolfram Alpha's "simpl=
ify"
function on each formula), they can both be expressed as:

P(bad data)
  =3D 1 - (2^-C * (1-U)^D - 2^-C + 1) ^ (N / D)

I.e. we've independently arrived at the same place. Yay!

It just took me a lot longer... :-)

>> On the bright side, if the 10^-9 formula (Chris #1, Chris #2, Sage) =
are
>> anywhere near correct, they indicate with a block size of 4K and 32-=
bit
>> checksum, you'd need to read 5 * 10^21 bits, or 0.5 ZB, to get to a =
1% chance
>> of seeing unflagged bad data, e.g.:
>>=20
>> Chris #2 @ U=3D10^-15, C=3D32, D=3D(4 * 1024), N=3D(5 * 8 * 10^21)
>>   =3D 1 - (((2^-32) * ((1-(10^-15))^(4 * 1024)-1)+1) ^ ((5 * 8 * 10^=
21) / (4 * 1024)))
>>   =3D 0.009269991978615439689381062400448881380202158231615685460
>>   =3D 0.92%

Just for completeness, using the corrected D =3D (4 * 8 * 1024):

P(bad data) @ U=3D10^-15, C=3D32, D=3D(4 * 8 * 1024), N=3D(5 * 8 * 10^2=
1)
  =3D 1 - (2^-C * (1-U)^D - 2^-C + 1) ^ (N / D)
  =3D 1 - (2^-32 * (1-(10^-15))^(4 * 8 * 1024) - 2^-32 + 1) ^ ((5 * 8 *=
 10^21) / (4 * 8 * 1024))
  =3D 0.009269991978483162962573463579660791470065102520727107106
  =3D 0.92%

I.e. the same as before, up to 10^-12. Not surprising as the previous D=
 =3D
(1024 * 1024) example demonstrated it's relatively insensitive to the b=
lock
size.

Chris
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
