From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: ISA erasure code plugin and cache
Date: Mon, 4 Aug 2014 13:19:49 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE7581DE@CERNXCHG43.cern.ch>
References: <53DF750B.6080107@dachary.org>
 <3472A07E6605974CBC9BC573F1BC02E4AE75711F@CERNXCHG43.cern.ch>
 <53DF7E7A.5040509@dachary.org>
 <6AA21C22F0A5DA478922644AD2EC308C8A60B8@SHSMSX101.ccr.corp.intel.com>,<53DF8304.5040100@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:36137 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581AbaHDNTx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Aug 2014 09:19:53 -0400
In-Reply-To: <53DF8304.5040100@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Yes,=20
you are both right, it would have only the current failure situation in=
 each cache and it stores the encoding table in each plug-in instance.
Probably the sharing of cache and encoding table would add more (unwant=
ed) thread synchronization points.=20

If this is the final design, I might remove also the lock? Nevertheless=
, it has no measurable performance impact ...

Cheers Andreas.


________________________________________
=46rom: Loic Dachary [loic@dachary.org]
Sent: 04 August 2014 14:56
To: Ma, Jianpeng; Andreas Joachim Peters
Cc: Ceph Development
Subject: Re: ISA erasure code plugin and cache

On 04/08/2014 14:50, Ma, Jianpeng wrote:
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic Dachary
>> Sent: Monday, August 4, 2014 8:37 PM
>> To: Andreas Joachim Peters
>> Cc: Ma, Jianpeng; Ceph Development
>> Subject: Re: ISA erasure code plugin and cache
>>
>>
>>
>> On 04/08/2014 14:15, Andreas Joachim Peters wrote:> Hi Loic,
>>>
>>> the background relevant to your comments have (unfortunately) never=
 been
>> answered on the mailing list.
>>>
>>> The cache is written in a way, that it is useful for a fixed (k,m) =
combination
>> and thread-safe.
>>>
>>> So, if there is one instance of the plugin per pool, it is the righ=
t
>> implementation. If there is (as you write) one instance for each PG =
in any pool,
>> it is sort of 'stupid' because the same encoding table is stored for=
 each PG
>> seperatly.
>>
>> I would not called it stupid ;-) Just not as efficient as if the cac=
he was by all PGs.
>> Without cache the decode table has to be calculated for each object =
in the
>> placement group and there are a lot of objects. The table may be dup=
licated
>> hundreds of time so it has an impact on the memory footprint, but it=
 should not
>> have a visible impact on the decode performances. An optimisation of=
 your
>> implementation to save memory would be nice, but it is not critical.
>>
> AFAIK, for a recovery pg, all the objects of pg have the same lost ch=
unks. So only the first object miss the cache.
> But the later won't.  It only need a entry to cache.
> Or am I missing something?

It also is my understanding and that's what makes the cache so useful. =
Now, in the long run the cache stays and grows. Since it is a few mega =
bytes per PG, it will eventually has a non negligible impact on a long =
running OSD. But again, it's nothing critical to performances.

Cheers

>
> Jianpeng Ma
>
>> How large are the decode tables ?
>>
>>> So if the final statement is to create one plugin instance per PG, =
I will change
>> it accordingly and shared encoding & decoding tables for a fixed (k,=
m), if not it
>> can stay.
>>>
>>> Just need to know that ... this boils down to the fact, that encodi=
ng &
>> decoding should not be considered 'stateless'.
>>>
>>> Cheers Andreas.
>>>
>>>
>>> ________________________________________
>>> From: Loic Dachary [loic@dachary.org]
>>> Sent: 04 August 2014 13:56
>>> To: Andreas Joachim Peters
>>> Cc: Ma, Jianpeng; Ceph Development
>>> Subject: ISA erasure code plugin and cache
>>>
>>> Hi,
>>>
>>> Here is how I understand the current code:
>>>
>>> When an OSD is missing, recovery is required and the primary OSD wi=
ll collect
>> the available chunks to do so. It will then call the decode method v=
ia
>> ECUtil::decode which is a small wrapper around the corresponding
>> ErasureCodeInterface::decode method.
>>>
>>>    https://github.com/ceph/ceph/blob/master/src/osd/ECBackend.cc#L3=
61
>>>
>>> The ISA plugin will then use the isa_decode method to perform the w=
ork
>>>
>>>
>> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasur=
eCode
>> Isa.cc#L212
>>>
>>> and will be repeatedly called until all objects in the PGs that wer=
e relying on
>> the missing OSD are recovered. To avoid computing the decoding table=
 for each
>> object, it is stored in a LRU cache
>>>
>>>
>> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasur=
eCode
>> Isa.cc#L480
>>>
>>> and copied in the stack if already there:
>>>
>>>
>> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasur=
eCode
>> Isa.cc#L433
>>>
>>> Each PG has a separate instance of ErasureCodeIsa, obtained when it=
 is
>> created:
>>>
>>>    https://github.com/ceph/ceph/blob/master/src/osd/PGBackend.cc#L2=
92
>>>
>>> It means that data members of each ErasureCodeIsa are copied as man=
y
>> times as there are PGs. If an OSD handles participates in 200 PG tha=
t belong to
>> an erasure coded pool configured to use ErasureCodeIsa, the data mem=
bers
>> will be duplicated 200 times.
>>>
>>> It is good practice to make it so that the encode/decode methods of
>> ErasureCodeIsa are thread safe. In the jerasure plugin these methods=
 have no
>> side effect on the object. In the isa plugin the LRU cache storing t=
he decode
>> tables is modified by the decode method and guarded by a mutex:
>>>
>>>    get
>> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasur=
eCode
>> Isa.cc#L281
>>>    put
>> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasur=
eCode
>> Isa.cc#L310
>>>
>>> Please correct me if I'm mistaken ;-) I've not reviewed the code ye=
t and try to
>> find problems, I just wanted to make sure I get the intention before=
 doing so.
>>>
>>> Cheers
>>> --
>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
