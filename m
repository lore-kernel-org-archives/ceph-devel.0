From: Chandan Kumar Singh <chandan.kr.singh@gmail.com>
Subject: Re: Mojette based Erasure Code is more performant than ISA-L or
 Jerasure (or not)
Date: Wed, 20 Apr 2016 22:18:25 +0530
Message-ID: <CAOu2ZZWQrCAZ3Qg+KePQ-1By4BPpMcx1z2VR=m7vcNj1qFFdww@mail.gmail.com>
References: <CAOu2ZZXx-no2EyDqd_D8SZp=qu-AALarxWd6=43qY-kTw7ZOow@mail.gmail.com>
	<57177CF7.1090600@dachary.org>
	<CAOu2ZZVWa7j2EmtfRjiTPvqJKckxRCOCjaHfeb+hAFZ=_a_JSg@mail.gmail.com>
	<5717AEDB.8050707@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36079 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbcDTQs0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Apr 2016 12:48:26 -0400
Received: by mail-wm0-f46.google.com with SMTP id v188so211463102wme.1
        for <ceph-devel@vger.kernel.org>; Wed, 20 Apr 2016 09:48:26 -0700 (PDT)
In-Reply-To: <5717AEDB.8050707@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

Hi

As expected, Your observation in interesting. I had just glanced
through the paper initially but will go through it again. I started
looking at alternatives after reading about StreamScale Inc's claims
on jerasure. As of now, I suppose ISA is the best bet.

Regards
Chandan


On Wed, Apr 20, 2016 at 10:01 PM, Loic Dachary <loic@dachary.org> wrote=
:
>
>
> On 20/04/2016 20:10, Chandan Kumar Singh wrote:
>> Hi
>>
>> Here is the link for the benchmark study :
>> http://arxiv.org/pdf/1504.07038.pdf. Initially, the mailing list was
>> blocking it because of HTML subparts.
>
> I meant that the first step would be to repeat the benchmark as descr=
ibed in the paper. Unless I missed something the details of how the res=
ults were obtained have not been published. It is enough to get just on=
e detail wrong and see significantly different results.
>
> Here is an example. From an implementor point of view, the performanc=
e difference that matters is when reading data that has not been damage=
d (i.e. what happens 99.99% of the time). Mojette does not have systema=
tic code. What it means is that reading data always requires decoding c=
hunks. With systematic code, which is what jerasure / isa-l offer and w=
hat Ceph uses, reading erasure coded data does not require decoding. Th=
is is the Achilles' heel of this erasure code method. It is supposed to=
 be measured by the graph in figure 3. For instance the bottom of figur=
e 3 states that ISA-L requires 640 cycles to read 8KB while Mojette req=
uires 1750 when there is no erasure (i.e. no chunk lost). That makes li=
ttle sense to me as you don't need ISA-L at all to read the original 8K=
B (that's what systematic codes are good for). This detail would need t=
o be clarified before the experiment can be repeated.
>
> Mojette is definitely interesting and it would be nice to see Free So=
ftware minded people working on it. There is a long way to go before it=
's useable, but exploring new avenues is fascinating :-)
>
> Cheers
>
>> Regards
>> Chandan
>>
>> On Wed, Apr 20, 2016 at 6:28 PM, Loic Dachary <loic@dachary.org> wro=
te:
>>> Hi,
>>>
>>> On 20/04/2016 15:52, Chandan Kumar Singh wrote:
>>>> Hi
>>>>
>>>> The authors of  Mojette Erasure Encoding claim that this EC has hi=
gher
>>>> performance than ISA-L and Jerasure and can be used for hot storag=
e
>>>> use cases. Their EC is used in open source RozoFS. What is your
>>>> evaluation of it? It will be nice if it is available as another EC
>>>> plugin.
>>>
>>> RozoFS is no longer developped (last commit was july last year). It=
 would be nice to have an alternative implementation of the same algori=
thm, well maintained. It's sad to see Free Software being frozen. But F=
ree Software is never dead, all it needs is good will and a little work=
 to be resurected ! I've never seen any benchmark regarding performance=
s, that would be the first step.
>>>
>>> Cheers
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
