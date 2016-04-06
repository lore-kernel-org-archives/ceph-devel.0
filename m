From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Wed, 6 Apr 2016 16:38:49 +1000
Message-ID: <20160406063849.GA5139@onthe.net.au>
References: <20160401052838.GA8044@onthe.net.au>
 <alpine.DEB.2.11.1604011051480.22014@cpach.fuggernut.com>
 <20160401194912.GA18636@onthe.net.au>
 <CY1PR0201MB1897EE2E58FFF2FF3DFFFB55E89A0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160402040736.GA22721@onthe.net.au>
 <CY1PR0201MB1897416E6B245E1FC2B9CEBEE89B0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160404150042.GA25465@onthe.net.au>
 <CY1PR0201MB18973631BB493B8DCE1A5C4AE89D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1604050828340.19675@cpach.fuggernut.com>
 <20160405151030.GA20891@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:49648 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbcDFGiz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Apr 2016 02:38:55 -0400
Content-Disposition: inline
In-Reply-To: <20160405151030.GA20891@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Apr 06, 2016 at 01:10:30AM +1000, Chris Dunlop wrote:
> On Tue, Apr 05, 2016 at 08:35:43AM -0400, Sage Weil wrote:
>> D =3D block size, U =3D hw UBER, C =3D checksum.  Let's add N =3D nu=
mber of bits=20
>> you actually want to read.  In that case, we have to read (N / D) bl=
ocks=20
>> of D bits, and we get
>>=20
>> P(reading N bits and getting some bad data and not knowing it)
>> 	=3D (D * U) / (2^C) * (N / D)
>> 	=3D U * N / 2^C
>>=20
>> and the D term (block size) disappears.  IIUC this is what Chris was=
=20
>> originally getting at.  The block size affects the probability I get=
 an=20
>> error on one block, but if I am a user reading something, you don't =
care=20
>> about block size--you care about how much data you want to read.  I =
think=20
>> in that case it doesn't really matter (modulo rounding error, minimu=
m read=20
>> size, how precisely we can locate the error, etc.).
>>
>> Is that right?
>=20
> Yep, that's pretty much what I was thinking. My probability algebra i=
s more
> than a little rusty but that looks like the formula I was starting to=
 put
> together.

OK, here's my (1st!, more below) working:

P(bad bit)
  =3D probability bit is bad (BER)
  =3D U

P(bad check)
  =3D probability checksum fails (i.e. a false match)
  =3D 2^-C

P(bit fail)
  =3D probability bit is bad, and subsequent checksum fail
  =3D P(bad bit) * P(bad check)

P(bit ok)
  =3D probability bit is good, or flagged by checksum
  =3D 1 - P(bit fail)
  =3D 1 - (P(bad bit) * P(bad check))

P(block ok)
  =3D probability D-bit block is all-bits-good, or flagged by checksum
  =3D P(bit ok) ^ D
  =3D (1 - (P(bad bit) * P(bad check))) ^ D
  =3D (1 - (U * 2^-C)) ^ D

N  =3D number of bits in data in which we're interested

P(data ok)
  =3D probability data is ok (good, or flagged)
  =3D P(block ok) ^ (number_of_blocks)
  =3D P(block ok) ^ (N / D)
  =3D ((1 - (P(bad bit) * P(bad check))) ^ D) ^ (N / D)
  =3D (1 - (P(bad bit) * P(bad check))) ^ N
  =3D (1 - (U * 2^-C)) ^ N

P(bad data)
  =3D probability of getting unflagged bad data
  =3D 1 - P(data ok)
  =3D 1 - ((1 - (U * 2^-C)) ^ N)

Like Sage's working, the size of the individual data blocks disappears.=
 But
unfortunately it doesn't match Sage's formula. :-(

OK, here's another attempt, looking at it a little differently: my 1st
working applies the P(bad check) at the bit level, the same as for P(ba=
d
bit). But the checksum is actually done at the block level. So:

P(bad bit)
  =3D probability bit is bad (BER)
  =3D U

P(good bit)
  =3D probability bit is good
  =3D 1 - U

P(good block)
  =3D probability D-bit block is all-bits-good
  =3D (1 - U) ^ D

P(bad block)
  =3D probability block has at least one bad bit
  =3D 1 - P(good block)
  =3D 1 - ((1 - U) ^ D)

P(bad check)
  =3D probability checksum fails (i.e. a false match)
  =3D 2^-C

P(good check)
  =3D probability checksum succeeds (flags bad data)
  =3D 1 - P(bad check)
  =3D 1 - (2^-C)

P(block ok)
  =3D probability block is all-good, or bad and flagged by checksum
  =3D P(good block) + (P(bad block) * P(good check))
  =3D ((1 - U) ^ D) + ((1 - ((1 - U) ^ D)) * (1 - (2^-C)))=20
  =3D 2^-C * ((1-U)^D-1)+1

N  =3D number of bits in data in which we're interested

P(data ok)
  =3D probability data is ok (good, or flagged)
  =3D P(block ok) ^ (number_of_blocks)
  =3D P(block ok) ^ (N / D)
  =3D (((1 - U) ^ D) + ((1 - ((1 - U) ^ D)) * (1 - (2^-C)))) ^ (N / D)
  =3D (2^-C * (((1-U)^D) - 1) + 1) ^ (N / D)

P(bad data)
  =3D probability of getting unflagged bad data
  =3D 1 - P(data ok)
  =3D 1 - ((2^-C * ((1-U)^D-1)+1) ^ (N / D))

=2E..and this time the D term doesn't disappear. I.e. it supports Allen=
's
contention that the block size matters.

Let's plug some numbers into Wolfram Alpha to see if we get plausible r=
esults:

U =3D 10^-15
C =3D 32
D =3D 4 * 1024
N =3D 5PB =3D 5 * 8 * 10^15

---------
Chris #1
---------
P(bad data)
  =3D 1 - ((1 - (U * 2^-C)) ^ N)
  =3D 1 - ((1 - ((10^-15) * (2^-32))) ^ (5 * 8 * (10^15)))
  =3D 9.3132257027866983914620845681582388414865913202250969 =C3=97 10^=
-9

---------
Chris #2
---------
P(bad data)
  =3D 1 - ((2^-C * (((1-U)^D) - 1) + 1) ^ (N / D))
  =3D 1 - (((2^-32) * ((1-(10^-15))^(4 * 1024)-1)+1) ^ ((5 * 8 * (10^15=
)) / (4 * 1024)))
  =3D 9.3132257027676295619288907910277855094237197529999931 =C3=97 10^=
-9
  (differs from Chris #1 at 10^-20)

If this formula is correct, it's still relatively immune to the data bl=
ock
size, e.g. at D =3D (1024 * 1024):
  =3D 1 - (((2^-32) * ((1-(10^-15))^(1024 * 1024)-1)+1) ^ ((5 * 8 * (10=
^15)) / (1024 * 1024)))
  =3D 9.3132256979038905963931781911807383342120258917664411 =C3=97 10^=
-9
  (differs from D=3D(4 * 1024) at 10^-17)

---------
Sage
---------
> P(reading N bits and getting some bad data and not knowing it)
> 	=3D U * N / 2^C

P(bad data)
  =3D (10^-15 * 5 * 8 * 10^15) / (2^32)
  =3D 9.31322574615478515625 =C3=97 10^-9
  (differs from Chris #2 at 10^-17)

---------
Allen
---------
> So the overall probability of a failure for this read is:
> (1 - (1-U)^D) / (2^C).

P(bad data)
  =3D (1 - (1-U)^D) / (2^C)
  =3D (1 - (1-(10^-15))^(4 * 1024)) / (2^32)
  =3D 9.536743164042973518371608678388595553788002932094000 =C3=97 10^-=
22
  (seems implausibly low?)


Now what?

Anyone want to check the assumptions and calcs, and/or come up with you=
r own?

On the bright side, if the 10^-9 formula (Chris #1, Chris #2, Sage) are
anywhere near correct, they indicate with a block size of 4K and 32-bit
checksum, you'd need to read 5 * 10^21 bits, or 0.5 ZB, to get to a 1%
chance of seeing unflagged bad data, e.g.:

Chris #2 @ U=3D10^-15, C=3D32, D=3D(4 * 1024), N=3D(5 * 8 * 10^21)
  =3D 1 - (((2^-32) * ((1-(10^-15))^(4 * 1024)-1)+1) ^ ((5 * 8 * 10^21)=
 / (4 * 1024)))
  =3D 0.009269991978615439689381062400448881380202158231615685460
  =3D 0.92%


Chris
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
