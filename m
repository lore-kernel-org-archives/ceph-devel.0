From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Pyramid Erasure Code plugin (draft)
Date: Fri, 17 Jan 2014 14:10:59 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE6B2587@PLOXCHG03.cern.ch>
References: <52D8FC5A.5090905@dachary.org>
 <CAGhffvwLtm1rJ68ORiASxDzfsOuo0y2YQvU3uLMUvxQOAA_d7g@mail.gmail.com>,<52D90D50.8080501@dachary.org>
 <3472A07E6605974CBC9BC573F1BC02E4AE6B2508@PLOXCHG03.cern.ch>,<52D93689.7010705@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:16942 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920AbaAQOLE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jan 2014 09:11:04 -0500
In-Reply-To: <52D93689.7010705@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,=20
this is what I mentioned in the other thread ....
depending on the global parameters, it is more efficient to include the=
 global stripes into the local parity computation because also a disk w=
ith global parity breaks with the same probability like the disk with d=
ata stripes and you can repair them with the local parity if you includ=
e them in the computation.

If I understand your scheme in the given example K:4 means, that local =
parity is computed over d4 ata stripes only while K:6 means, it is comp=
uted over 4 data + 2 global parity stripes, so this should work ?!?!?

Cheers Andreas.


________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 17 January 2014 14:56
To: Andreas Joachim Peters
Cc: Ceph Development
Subject: Re: Pyramid Erasure Code plugin (draft)

On 17/01/2014 12:18, Andreas Joachim Peters wrote:
> Is k:4 not wrong? I want to build the local parity using 4 data + 2 R=
S stripes ?!?!?
>

I misunderstood and did not consider the case where you would want to d=
o this. I'm glad you raise this now :-) Reading http://home.ie.cuhk.edu=
=2Ehk/~mhchen/papers/pyramid.ToS.13.pdf my understanding is that local =
parity is not calculated for chunks created by the lower level. Am I re=
ading it incorrectly ?

In the context of Ceph I think you're right anyway : local parity needs=
 to apply to chunks generated at the global level.

>
> { "plugin": "xor",
>       "k": 4,
>       "m": 1,
>       "item": "datacenter",
>       "mapping": "0000--^1111--^2222--^",
>     },
>
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 17 January 2014 12:00
> To: Andreas Joachim Peters
> Cc: Ceph Development
> Subject: Re: Pyramid Erasure Code plugin (draft)
>
> On 17/01/2014 11:34, Andreas-Joachim Peters wrote:
>> Hi Loic,
>>
>> i think I don't understand if this works really for all cases and pr=
obably sysadmins will be lost without ready to use templates.
>
> I agree, providing a sensible default is important. I'll draft someth=
ing.
>
>> Can you write down with this syntax a rule like this:
>>
>> =3D> build 12 data chunks (d1...d12)
>> =3D> build 6 RS chunks, distribute  (p1..p6)
>> =3D> arrange them as : lp1=3D(d1,d2,d3,d4,p1,p2) lp2=3D(d5,d6,d7,d8,=
p3,p4) lp3=3D(d9,d10,d11,d12,p5,p6)
>> =3D> map 21 stripes to 3 data center as: D1=3D(d1,d2,d3,d4,p1,p2,lp1=
) D2=3D(d5,d6,d7,d8,p3,p4,lp2) D3=3D(d9,d10,d11,d12,p5,p6,lp3)
>> e.g. chunk(0...21) =3D (d1,d2,d3...lp1,d5,d6,d7...lp2,d9,d10,d11...l=
p3)
>
> Here is how it translates : http://tracker.ceph.com/issues/7146#note-=
2 ( replacing | with - ... maybe more readable ).
>
> Does that make sense ?
>>
>> Thanks, Andreas.
>>
>>
>>
>>
>>
>>
>>
>>
>> On Fri, Jan 17, 2014 at 10:48 AM, Loic Dachary <loic@dachary.org <ma=
ilto:loic@dachary.org>> wrote:
>>
>>     Hi Andreas,
>>
>>     I spent some time this week trying to figure out something that =
would be reasonably generic, readable from the sysadmin point of view a=
nd simple to implement. The input of the plugin is here:
>>
>>     http://tracker.ceph.com/issues/7146#note-1
>>
>>     The json structure describes the pyramid and associates an erasu=
re code method with each layer, including parameters. The mapping descr=
ibes how chunks relate to the list of OSDs obtained from crush. For ins=
tance in |^000111^| the | are ignored ( whitespace is confusing because=
 it's not easy to figure out visually how many of them there are ), ^ m=
arks a coding chunk, any other character is a data chunk. The pyramid e=
ncoding function reads this and encode the first three data chunks with=
 one coding chunk. The re-ordering of the chunks is done by the pyramid=
 code and the underlying erasure code method does not need to know anyt=
hing about it. There is no copy involved, it re-orders pointers ( buffe=
rptr ).
>>
>>     Here is a draft (not compiling not working but the logic looks r=
ight to me) implementation:
>>
>>     encode :
>>     https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/Erasure=
CodePluginPyramid/ErasureCodePyramid.cc#L250
>>
>>     decode :
>>     https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/Erasure=
CodePluginPyramid/ErasureCodePyramid.cc#L367
>>
>>     The plugins for each layer would be loaded at init time :
>>
>>     https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/Erasure=
CodePluginPyramid/ErasureCodePyramid.cc#L83
>>
>>     with as much consistency checks as possible, for instance:
>>
>>     https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/Erasure=
CodePluginPyramid/ErasureCodePyramid.cc#L102
>>
>>     so that runtime can assume constraints are enforced. Please let =
me know if you see something that does not look right, this is a draft,=
 it can be reworked 100% ;-)
>>
>>     Cheers
>>
>>     --
>>     Lo=EFc Dachary, Artisan Logiciel Libre
>>
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
