From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Simplified LRC in CEPH
Date: Fri, 1 Aug 2014 12:44:59 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE7534F1@CERNXCHG44.cern.ch>
References: <3472A07E6605974CBC9BC573F1BC02E4AE753328@CERNXCHG44.cern.ch>
 <3472A07E6605974CBC9BC573F1BC02E4AE75333D@CERNXCHG44.cern.ch>,<53DB88EC.4050209@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:56921 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754874AbaHAMpE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Aug 2014 08:45:04 -0400
In-Reply-To: <53DB88EC.4050209@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic,=20

> It would, definitely. How would you control where data / parity chunk=
s are located ?

I ordered the chunks after encoding in this way:

( 1 2 3 4 LP1 ) ( 5 6 7 8 LP2 ) ( 9 10 11 12 LP3 ) ( 13 14 15 16 LP4 ) =
( R2 R3 R4 LP5 )

Always (k/l)+1 consecutive chunks belong location-wise together ...  an=
d I demand that (k/l) <=3D m

That is probably straight forward to express in a crush rule.

Cheers Andreas.

PS: just one correction, I wrote 'degree' but it is called the 'distanc=
e' of the code=20
=20
________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 01 August 2014 14:32
To: Andreas Joachim Peters; ceph-devel@vger.kernel.org
Subject: Re: Simplified LRC in CEPH

Hi Andreas,

Enlightening explanation, thank you !

On 01/08/2014 13:45, Andreas Joachim Peters wrote:
> Hi Loic et. al.
>
> I managed to prototype (and understand) LRC encoding similiar to Xorb=
as in the ISA plug-in.
>
> As an example take a (16,4) code (which gives nice alignment for 4k b=
locks) :
>
> For 4 sub groups of the data chunks you build e.g. local parities LP1=
-LP4
>
> LP1 =3D 1 ^ 2 ^ 3 ^ 4
>
> LP2 =3D 5 ^ 6 ^ 7 ^ 8
>
> LP3 =3D 9 ^ 10 ^ 11 ^ 12
>
> LP4 =3D 13 ^ 14 ^ 15 ^ 16
>
> You do normal erasure encoding with 4 RS chunks:
>
> RS(1..16) =3D (R1, R2, R3, R4)
>
> You compute the local parity LP5 for the erasure chunks:
>
> LP5 =3D R1 ^ R2 ^ R3 ^ R4
>
> The relation which holds for Vandermonde matrices (because the first =
matrix row contains only 1's)
>
> LP1 ^ LP2 ^ LP3 ^ LP4 =3D R1
>
> So you need to store only 24 chunks (not 25):
>
> (1 .. 16) (R2,R3,R4) (LP1,LP2,LP3,LP4,LP5)
>
> Side remark: in this simplified explanation I imply R1, not LP5 as de=
scribed in the Xorbas paper

Does it make a difference or is it equivalent ?

> The degree of the code is 5 e.g. you can construct a failure with 5 l=
osses where you loose data, while if you are 'lucky' the code can even =
repair up to 8 failures (one loss in each sub group + LP5,R2,R3,R4).
>
> The reconstruction traffic for single failures is:
>
> [(20 x 4) + (4 x 8)]/24 =3D~ 4.66 x [disk size] instead of 16 x [disk=
 size]
>
> There are three repair scenarios:
>
> 1) only single failures in any of the local groups using LRC repair (=
simple parities)
> 2) multiple failures which can be reconstructed with RS parities with=
out LRC repair
> 3) multiple failures which can be reconstructed with RS parities afte=
r LRC repair
>
> [ 4) reconstruction impossible  ]
>
> Having your proposed LRC layer (decoding) model in mind there is a ce=
rtain contradiction here because there are cases where it is not requir=
ed to use LRC since you can resolve all the failures with RS alone.
>
> In the end I think, it is sufficient if we introduce a parameter l in=
 the EC parameter list which defines the number of subgroups in the dat=
a chunks and imply to use always one local parity for all RS chunks. So=
 you can specify an LRC easily with three simple parameters:
>
> k=3D16 m=3D4 l=3D4
>
> The Xorbas configuration would be written as k=3D10 m=3D4 l=3D2
>
> Wouldn't that be much simpler and sufficient? What do you think?

It would, definitely. How would you control where data / parity chunks =
are located ?

Cheers
>
> Cheers Andreas.
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
