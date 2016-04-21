From: Chandan Kumar Singh <chandan.kr.singh@gmail.com>
Subject: Re: Mojette based Erasure Code is more performant than ISA-L or
 Jerasure (or not)
Date: Thu, 21 Apr 2016 14:39:04 +0530
Message-ID: <CAOu2ZZUAtFmKc9RkpwwMY9s7_2n-YptaoUhPJbkf+crhAXgd7A@mail.gmail.com>
References: <CAOu2ZZXx-no2EyDqd_D8SZp=qu-AALarxWd6=43qY-kTw7ZOow@mail.gmail.com>
	<57177CF7.1090600@dachary.org>
	<CAOu2ZZVWa7j2EmtfRjiTPvqJKckxRCOCjaHfeb+hAFZ=_a_JSg@mail.gmail.com>
	<5717AEDB.8050707@dachary.org>
	<CAOu2ZZWQrCAZ3Qg+KePQ-1By4BPpMcx1z2VR=m7vcNj1qFFdww@mail.gmail.com>
	<5717B8A6.90503@dachary.org>
	<CAOu2ZZVUg=SW_15f22tHD0XRwNftQ5+OHGgUza4-z1Y5=O=n2Q@mail.gmail.com>
	<5717BEF3.6020403@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34062 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbcDUJJG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2016 05:09:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id n3so19976081wmn.1
        for <ceph-devel@vger.kernel.org>; Thu, 21 Apr 2016 02:09:05 -0700 (PDT)
In-Reply-To: <5717BEF3.6020403@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

Well, there is no explicit explanation as to why "GF-Complete and
Jerasure version 2.0 have been removed from web sites at the
University of Tennessee and bitbucket.org." I might not even look for
implicit reasons but what I do notice is that Plank mentions
StreamScale's claims and expects users to be aware of it.

On Wed, Apr 20, 2016 at 11:10 PM, Loic Dachary <loic@dachary.org> wrote=
:
>
>
> On 21/04/2016 00:19, Chandan Kumar Singh wrote:
>> There is a warning on Jim Plank's website
>>
>> http://web.eecs.utk.edu/~plank/plank/www/software.html
>
> Where in this page is it explained why (I quote the page) "GF-Complet=
e and Jerasure version 2.0 have been removed from web sites at the Univ=
ersity of Tennessee and bitbucket.org." ?
>
>> and the following article
>>
>> https://www.techdirt.com/articles/20141115/07113529155/patent-troll-=
kills-open-source-project-speeding-up-computation-erasure-codes.shtml
>>
>>
>> On Wed, Apr 20, 2016 at 10:43 PM, Loic Dachary <loic@dachary.org> wr=
ote:
>>>
>>>
>>> On 20/04/2016 23:48, Chandan Kumar Singh wrote:
>>>> Hi
>>>>
>>>> As expected, Your observation in interesting. I had just glanced
>>>> through the paper initially but will go through it again. I starte=
d
>>>> looking at alternatives after reading about StreamScale Inc's clai=
ms
>>>> on jerasure. As of now, I suppose ISA is the best bet.
>>>
>>> Where did you read that StreamScale has claims on jerasure ? Again,=
 the devil is in the details ;-)
>>>
>>>> On Wed, Apr 20, 2016 at 10:01 PM, Loic Dachary <loic@dachary.org> =
wrote:
>>>>>
>>>>>
>>>>> On 20/04/2016 20:10, Chandan Kumar Singh wrote:
>>>>>> Hi
>>>>>>
>>>>>> Here is the link for the benchmark study :
>>>>>> http://arxiv.org/pdf/1504.07038.pdf. Initially, the mailing list=
 was
>>>>>> blocking it because of HTML subparts.
>>>>>
>>>>> I meant that the first step would be to repeat the benchmark as d=
escribed in the paper. Unless I missed something the details of how the=
 results were obtained have not been published. It is enough to get jus=
t one detail wrong and see significantly different results.
>>>>>
>>>>> Here is an example. From an implementor point of view, the perfor=
mance difference that matters is when reading data that has not been da=
maged (i.e. what happens 99.99% of the time). Mojette does not have sys=
tematic code. What it means is that reading data always requires decodi=
ng chunks. With systematic code, which is what jerasure / isa-l offer a=
nd what Ceph uses, reading erasure coded data does not require decoding=
=2E This is the Achilles' heel of this erasure code method. It is suppo=
sed to be measured by the graph in figure 3. For instance the bottom of=
 figure 3 states that ISA-L requires 640 cycles to read 8KB while Mojet=
te requires 1750 when there is no erasure (i.e. no chunk lost). That ma=
kes little sense to me as you don't need ISA-L at all to read the origi=
nal 8KB (that's what systematic codes are good for). This detail would =
need to be clarified before the experiment can be repeated.
>>>>>
>>>>> Mojette is definitely interesting and it would be nice to see Fre=
e Software minded people working on it. There is a long way to go befor=
e it's useable, but exploring new avenues is fascinating :-)
>>>>>
>>>>> Cheers
>>>>>
>>>>>> Regards
>>>>>> Chandan
>>>>>>
>>>>>> On Wed, Apr 20, 2016 at 6:28 PM, Loic Dachary <loic@dachary.org>=
 wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 20/04/2016 15:52, Chandan Kumar Singh wrote:
>>>>>>>> Hi
>>>>>>>>
>>>>>>>> The authors of  Mojette Erasure Encoding claim that this EC ha=
s higher
>>>>>>>> performance than ISA-L and Jerasure and can be used for hot st=
orage
>>>>>>>> use cases. Their EC is used in open source RozoFS. What is you=
r
>>>>>>>> evaluation of it? It will be nice if it is available as anothe=
r EC
>>>>>>>> plugin.
>>>>>>>
>>>>>>> RozoFS is no longer developped (last commit was july last year)=
=2E It would be nice to have an alternative implementation of the same =
algorithm, well maintained. It's sad to see Free Software being frozen.=
 But Free Software is never dead, all it needs is good will and a littl=
e work to be resurected ! I've never seen any benchmark regarding perfo=
rmances, that would be the first step.
>>>>>>>
>>>>>>> Cheers
>>>>>>>
>>>>>>> --
>>>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>>>
>>>>>>
>>>>>
>>>>> --
>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
