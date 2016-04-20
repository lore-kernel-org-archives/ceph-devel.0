From: Loic Dachary <loic@dachary.org>
Subject: Re: Mojette based Erasure Code is more performant than ISA-L or
 Jerasure (or not)
Date: Wed, 20 Apr 2016 23:31:23 +0700
Message-ID: <5717AEDB.8050707@dachary.org>
References: <CAOu2ZZXx-no2EyDqd_D8SZp=qu-AALarxWd6=43qY-kTw7ZOow@mail.gmail.com>
	<57177CF7.1090600@dachary.org>
	<CAOu2ZZVWa7j2EmtfRjiTPvqJKckxRCOCjaHfeb+hAFZ=_a_JSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp26.services.sfr.fr ([93.17.128.1]:36213 "EHLO
	smtp26.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbcDTQbj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Apr 2016 12:31:39 -0400
In-Reply-To: <CAOu2ZZVWa7j2EmtfRjiTPvqJKckxRCOCjaHfeb+hAFZ=_a_JSg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chandan Kumar Singh <chandan.kr.singh@gmail.com>
Cc: ceph-devel@vger.kernel.org



On 20/04/2016 20:10, Chandan Kumar Singh wrote:
> Hi
>=20
> Here is the link for the benchmark study :
> http://arxiv.org/pdf/1504.07038.pdf. Initially, the mailing list was
> blocking it because of HTML subparts.

I meant that the first step would be to repeat the benchmark as describ=
ed in the paper. Unless I missed something the details of how the resul=
ts were obtained have not been published. It is enough to get just one =
detail wrong and see significantly different results.=20

Here is an example. From an implementor point of view, the performance =
difference that matters is when reading data that has not been damaged =
(i.e. what happens 99.99% of the time). Mojette does not have systemati=
c code. What it means is that reading data always requires decoding chu=
nks. With systematic code, which is what jerasure / isa-l offer and wha=
t Ceph uses, reading erasure coded data does not require decoding. This=
 is the Achilles' heel of this erasure code method. It is supposed to b=
e measured by the graph in figure 3. For instance the bottom of figure =
3 states that ISA-L requires 640 cycles to read 8KB while Mojette requi=
res 1750 when there is no erasure (i.e. no chunk lost). That makes litt=
le sense to me as you don't need ISA-L at all to read the original 8KB =
(that's what systematic codes are good for). This detail would need to =
be clarified before the experiment can be repeated.

Mojette is definitely interesting and it would be nice to see Free Soft=
ware minded people working on it. There is a long way to go before it's=
 useable, but exploring new avenues is fascinating :-)

Cheers
=20
> Regards
> Chandan
>=20
> On Wed, Apr 20, 2016 at 6:28 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>> Hi,
>>
>> On 20/04/2016 15:52, Chandan Kumar Singh wrote:
>>> Hi
>>>
>>> The authors of  Mojette Erasure Encoding claim that this EC has hig=
her
>>> performance than ISA-L and Jerasure and can be used for hot storage
>>> use cases. Their EC is used in open source RozoFS. What is your
>>> evaluation of it? It will be nice if it is available as another EC
>>> plugin.
>>
>> RozoFS is no longer developped (last commit was july last year). It =
would be nice to have an alternative implementation of the same algorit=
hm, well maintained. It's sad to see Free Software being frozen. But Fr=
ee Software is never dead, all it needs is good will and a little work =
to be resurected ! I've never seen any benchmark regarding performances=
, that would be the first step.
>>
>> Cheers
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
