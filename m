From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Simplified LRC in CEPH
Date: Fri, 1 Aug 2014 14:25:47 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE7535EB@CERNXCHG44.cern.ch>
References: <3472A07E6605974CBC9BC573F1BC02E4AE753328@CERNXCHG44.cern.ch>
 <3472A07E6605974CBC9BC573F1BC02E4AE75333D@CERNXCHG44.cern.ch>,<53DB88EC.4050209@dachary.org>
 <3472A07E6605974CBC9BC573F1BC02E4AE7534F1@CERNXCHG44.cern.ch>,<53DB92C9.5040302@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:55518 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624AbaHAOZv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Aug 2014 10:25:51 -0400
In-Reply-To: <53DB92C9.5040302@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic,=20
your initial scheme is more flexible. Nevertheless I think that a simpl=
ified description covers 99% of peoples use cases.=20

You can absorb the logic of implied parity into your generic LRC plug-i=
n if you find a good way to describe something like 'compute but don't'=
 store'. If you then offer additionally the poor man's description (k,m=
,l) one cover's the simple and complex use case!

Cheers Andreas.

________________________________________
=46rom: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.=
org] on behalf of Loic Dachary [loic@dachary.org]
Sent: 01 August 2014 15:14
To: Andreas Joachim Peters; ceph-devel@vger.kernel.org
Subject: Re: Simplified LRC in CEPH

Hi Andreas,

It probably is just what we need. Although https://github.com/ceph/ceph=
/pull/1921 is more flexible in terms of chunk placement, I can't think =
of a use case where it would actually be useful. Maybe it's just me bei=
ng back from hollidays but it smells like a solution to a non existent =
problem ;-) The other difference is that your proposal does not allow f=
or nested locality. I.e. datacenter locality and rack locality within a=
 datacenter, for instance. What do you think ?

Cheers

On 01/08/2014 18:29, Andreas Joachim Peters wrote:
> Hi Loic,
>
>> It would, definitely. How would you control where data / parity chun=
ks are located ?
>
> I ordered the chunks after encoding in this way:
>
> ( 1 2 3 4 LP1 ) ( 5 6 7 8 LP2 ) ( 9 10 11 12 LP3 ) ( 13 14 15 16 LP4 =
) ( R2 R3 R4 LP5 )
>
> Always (k/l)+1 consecutive chunks belong location-wise together ...  =
and I demand that (k/l) <=3D m
>
> That is probably straight forward to express in a crush rule.
>
> Cheers Andreas.
>
> PS: just one correction, I wrote 'degree' but it is called the 'dista=
nce' of the code
>
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 01 August 2014 14:32
> To: Andreas Joachim Peters; ceph-devel@vger.kernel.org
> Subject: Re: Simplified LRC in CEPH
>
> Hi Andreas,
>
> Enlightening explanation, thank you !
>
> On 01/08/2014 13:45, Andreas Joachim Peters wrote:
>> Hi Loic et. al.
>>
>> I managed to prototype (and understand) LRC encoding similiar to Xor=
bas in the ISA plug-in.
>>
>> As an example take a (16,4) code (which gives nice alignment for 4k =
blocks) :
>>
>> For 4 sub groups of the data chunks you build e.g. local parities LP=
1-LP4
>>
>> LP1 =3D 1 ^ 2 ^ 3 ^ 4
>>
>> LP2 =3D 5 ^ 6 ^ 7 ^ 8
>>
>> LP3 =3D 9 ^ 10 ^ 11 ^ 12
>>
>> LP4 =3D 13 ^ 14 ^ 15 ^ 16
>>
>> You do normal erasure encoding with 4 RS chunks:
>>
>> RS(1..16) =3D (R1, R2, R3, R4)
>>
>> You compute the local parity LP5 for the erasure chunks:
>>
>> LP5 =3D R1 ^ R2 ^ R3 ^ R4
>>
>> The relation which holds for Vandermonde matrices (because the first=
 matrix row contains only 1's)
>>
>> LP1 ^ LP2 ^ LP3 ^ LP4 =3D R1
>>
>> So you need to store only 24 chunks (not 25):
>>
>> (1 .. 16) (R2,R3,R4) (LP1,LP2,LP3,LP4,LP5)
>>
>> Side remark: in this simplified explanation I imply R1, not LP5 as d=
escribed in the Xorbas paper
>
> Does it make a difference or is it equivalent ?
>
>> The degree of the code is 5 e.g. you can construct a failure with 5 =
losses where you loose data, while if you are 'lucky' the code can even=
 repair up to 8 failures (one loss in each sub group + LP5,R2,R3,R4).
>>
>> The reconstruction traffic for single failures is:
>>
>> [(20 x 4) + (4 x 8)]/24 =3D~ 4.66 x [disk size] instead of 16 x [dis=
k size]
>>
>> There are three repair scenarios:
>>
>> 1) only single failures in any of the local groups using LRC repair =
(simple parities)
>> 2) multiple failures which can be reconstructed with RS parities wit=
hout LRC repair
>> 3) multiple failures which can be reconstructed with RS parities aft=
er LRC repair
>>
>> [ 4) reconstruction impossible  ]
>>
>> Having your proposed LRC layer (decoding) model in mind there is a c=
ertain contradiction here because there are cases where it is not requi=
red to use LRC since you can resolve all the failures with RS alone.
>>
>> In the end I think, it is sufficient if we introduce a parameter l i=
n the EC parameter list which defines the number of subgroups in the da=
ta chunks and imply to use always one local parity for all RS chunks. S=
o you can specify an LRC easily with three simple parameters:
>>
>> k=3D16 m=3D4 l=3D4
>>
>> The Xorbas configuration would be written as k=3D10 m=3D4 l=3D2
>>
>> Wouldn't that be much simpler and sufficient? What do you think?
>
> It would, definitely. How would you control where data / parity chunk=
s are located ?
>
> Cheers
>>
>> Cheers Andreas.
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
