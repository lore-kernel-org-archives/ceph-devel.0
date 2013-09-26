From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: CEPH Erasure Encoding + OSD Scalability
Date: Thu, 26 Sep 2013 21:49:18 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4A52741F6@PLOXCHG03.cern.ch>
References: <3472A07E6605974CBC9BC573F1BC02E4A527352B@PLOXCHG03.cern.ch>
 <523FED54.8040208@dachary.org>
 <3472A07E6605974CBC9BC573F1BC02E4A52736D1@PLOXCHG03.cern.ch>
 <5242FDDC.3060504@dachary.org>
 <3472A07E6605974CBC9BC573F1BC02E4A5273DD6@PLOXCHG03.cern.ch>
 <52433014.3030109@dachary.org>
 <CAGhffvz1TYYLoqn0tps1HiLObSCv7H0ZNVgOd0raicGqgRuukA@mail.gmail.com>,<5244887A.80503@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx30.cern.ch ([137.138.144.177]:52179 "EHLO
	CERNMX30.cern.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458Ab3IZVtY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Sep 2013 17:49:24 -0400
In-Reply-To: <5244887A.80503@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Sure,=20
this text is clear, but it does not talk about the cost of reconstructi=
on e.g. not to select a data chunk but a parity chunk costs CPU and inc=
reases latency, but is not reflected by the external cost parameter e.g=
=2E if you have RS (3,2), 3 data and 2 parity chunks with chunks [0,1,2=
,3,4] with equal cost values,  I would select [0,1,2] since it avoids c=
omputation, however the retrieval cost for [2,3,4] would be the same bu=
t the computational cost is higher.

Now if [0] has for example the double cost compared to chunk [3], it is=
 not clear to me if [1,2,3] is a better set than [0,1,2] ... is the mea=
ning of a higher cost actually more a binary flag saying 'avoid to read=
 this chunk if possible' ?=20

Could you give a practical example when a chunk can have a higher cost =
in a CEPH setup and a rough range for the 'cost' parameter?

Thanks Andreas.




________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 26 September 2013 21:18
To: Andreas Joachim Peters
Cc: Ceph Development
Subject: Re: CEPH Erasure Encoding + OSD Scalability

[re-adding ceph-devel to the cc]

On 26/09/2013 20:36, Andreas-Joachim Peters wrote:> Hi Loic,
> today I forked he CEPH repository and will commit my changes to my Gi=
tHub fork asap ... (I am not familiar with GitHub in particular).
> I was finalizing the minimim_to_decode function today with test cases=
 (it is more sophisticated in this case ...) ... I didn't fully get wha=
t the 'with cost' function is supposed to do diffrent from the one with=
out cost?

I'd be happy to explain if
https://github.com/ceph/ceph/blob/master/src/osd/ErasureCodeInterface.h=
#L131
is unclear. Would you be so kind as to tell me what is confusing in the=
 description ?

>
>
> Cheers Andreas.
>
> On Wed, Sep 25, 2013 at 8:48 PM, Loic Dachary <loic@dachary.org <mail=
to:loic@dachary.org>> wrote:
>
>
>
>     On 25/09/2013 20:33, Andreas Joachim Peters wrote:> Yes, sure. I =
actually thought the same in the meanwhile ...  I have some questions:
>     >
>     > Q: Can/should it stay in the framework of google test's or you =
would prefer just a plain executable ?
>     >
>
>     A plain executable would make sense. An simple example from src/t=
est/Makefile.am :
>
>     ceph_test_trans_SOURCES =3D test/test_trans.cc
>     ceph_test_trans_LDADD =3D $(LIBOS) $(CEPH_GLOBAL)
>     bin_DEBUGPROGRAMS +=3D ceph_test_trans
>
>
>     > I have added local parity support to your erasure class adding =
a new argument: "erasure-code-lp" and
>     > two new methods:
>     >
>     > localparity_encode(...)
>     > localparity_decode(...)
>     >
>     > I made a more complex benchmark of (8,2) + 2 local parities (1^=
2^3^4, 5^6^7^8) which benchmarks performance of encoding/decoding as sp=
eed & effective write-latency for three cases (each for liberation & ca=
uchy_good codecs):
>     >
>     > 1 (8,2)
>     > 2 (8,2,lp=3D2)
>     > 3 (8,2,lp=3D2) + crc32c (blocks)
>     >
>     > and several failure scenarios ... single, double, triple disk f=
ailures. Probably the best is if I make all this parameters configurabl=
e.
>
>     Great :-) Do you have a public git repository where I could clone=
 this & give it a try ?
>
>     > Q: For the local parity implementation .... shall I inherit fro=
m your erasure plugin and overwrite the encode/decode method or you wou=
ld consider a patch to the original class?
>
>     It is a perfect timing for a patch to the original class.
>
>     > I have also a 128-bit XOR implementation for the local parities=
=2E This will work with new gcc's & clang compilers ...
>     >
>     > Q: Which compilers/platforms are supported by CEPH? Is there a =
minimal GCC version?
>
>     You can see all supported platforms here:
>
>     http://ceph.com/gitbuilder.cgi
>
>     I don't think the GCC version shows in the logs but you can proba=
bly figure it out from the corresponding distribution.
>
>     > Q: is there some policy restricting comments within code? In ge=
neral I see very few or no comments within the code ..
>
>     :-) The mon code tends to be more heavily commented than the osd =
code (IMO) but I'm not aware of any policy. When I feel the need to com=
ment, I write a unit test. If the unit test is difficult, I tend to com=
ment to clarify its purpose. The problem with comments is that they qui=
ckly become obsolete and/or misleading. That being said, I don't think =
anyone will object if you heavily comment your code.
>
>     Cheers
>
>     > Cheers Andreas.
>     >
>     >
>     >
>     >
>
>     --
>     Lo=EFc Dachary, Artisan Logiciel Libre
>     All that is necessary for the triumph of evil is that good people=
 do nothing.
>
>

--
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do no=
thing.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
