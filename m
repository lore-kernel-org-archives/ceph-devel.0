From: David Zafman <dzafman@redhat.com>
Subject: Re: deleting objects from a pool
Date: Fri, 26 Jun 2015 08:21:22 -0700
Message-ID: <558D6DF2.5070302@redhat.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91669AC8C2@SATLEXDAG01.amd.com> <90559C83A9C7FA45B5846C975DFA612DDB4C3F7250@ABGEX73E.FSC.NET> <BC97738F8E7C8742BABED7F06FB9DF91669ACA7B@SATLEXDAG01.amd.com> <66EBB02ADA308B4F8273E99FC000126C6BEA0BD5C8@ABGEX70E.FSC.NET> <558CAEC1.3050204@redhat.com> <66EBB02ADA308B4F8273E99FC000126C6BEA0BDEFE@ABGEX70E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37749 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274AbbFZPVY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 26 Jun 2015 11:21:24 -0400
In-Reply-To: <66EBB02ADA308B4F8273E99FC000126C6BEA0BDEFE@ABGEX70E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Podoski, Igor" <Igor.Podoski@ts.fujitsu.com>, "Deneau, Tom" <tom.deneau@amd.com>, =?ISO-8859-2?Q?=22Da=B3ek=2C_Piotr=22?= <Piotr.Dalek@ts.fujitsu.com>, ceph-devel <ceph-devel@vger.kernel.org>


This is a dangerous command because it can remove all your objects. At=20
least it can only do one namespace at a time.  It was intended to=20
cleanup rados bench runs, and is dangerous because it doesn't require=20
extra hoops like rados rmpool does.

I'm tempted to disallow a usage this way with empty --prefix/--run-name=
=20
arguments.

David

On 6/25/15 10:40 PM, Podoski, Igor wrote:
> Hi David,
>
> You're right, now I see adding --run-name "" will clean all benchmark=
 data from specified namespace, so you can run command only once.
>
> rados -p <poolname> -N <namespace> cleanup --prefix "" --run-name ""
>
> Regards,
> Igor.
>
>
> -----Original Message-----
> From: David Zafman [mailto:dzafman@redhat.com]
> Sent: Friday, June 26, 2015 3:46 AM
> To: Podoski, Igor; Deneau, Tom; Da=B3ek, Piotr; ceph-devel
> Subject: Re: deleting objects from a pool
>
>
> If you have rados bench data around, you'll need to run cleanup a sec=
ond time because the first time the "benchmark_last_metadata" object wi=
ll be consulted to find what objects to remove.
>
> Also, using cleanup this way will only remove objects from the defaul=
t namespace unless a namespace is specified with the -N option.
>
> rados -p <poolname> -N <namespace> cleanup --prefix ""
>
> David
>
> On 6/24/15 11:06 PM, Podoski, Igor wrote:
>> Hi,
>>
>> It appears, that cleanup can be used as a purge:
>>
>> rados -p <poolname> cleanup  --prefix ""
>>
>> Regards,
>> Igor.
>>
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Deneau, Tom
>> Sent: Wednesday, June 24, 2015 10:22 PM
>> To: Da=B3ek, Piotr; ceph-devel
>> Subject: RE: deleting objects from a pool
>>
>> I've noticed that deleting objects from a basic k=3D2 m=3D1 erasure =
pool is much much slower than deleting a similar number of objects from=
 a replicated size 3 pool (so the same number of files to be deleted). =
  It looked like the ec pool object deletion was almost 20x slower.  Is=
 there a lot more work to be done to delete an ec pool object?
>>
>> -- Tom
>>
>>
>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>> owner@vger.kernel.org] On Behalf Of Dalek, Piotr
>>> Sent: Wednesday, June 24, 2015 11:56 AM
>>> To: ceph-devel
>>> Subject: Re: deleting objects from a pool
>>>
>>>> -----Original Message-----
>>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>>> owner@vger.kernel.org] On Behalf Of Deneau, Tom
>>>> Sent: Wednesday, June 24, 2015 6:44 PM
>>>>
>>>> I have benchmarking situations where I want to leave a pool around
>>>> but delete a lot of objects from the pool.  Is there any really fa=
st
>>>> way to do
>>> that?
>>>> I noticed rados rmpool is fast but I don't want to remove the pool=
=2E
>>>>
>>>> I have been spawning multiple threads, each deleting a subset of t=
he
>>> objects
>>>> (which I believe is what rados bench write does) but even that can
>>>> be very slow.
>>> For now, apart from "rados -p <poolname> cleanup" (which doesn't
>>> purge the pool, but merely removes objects written during last
>>> benchmark run), the only option is by brute force:
>>>
>>> for i in $(rados -p <poolname> ls); do (rados -p <poolname> rm $i
>>> &>/dev/null &); done;
>>>
>>> There's no "purge pool" command in rados -- not yet, at least. I wa=
s
>>> thinking about one, but never really had time to implement one.
>>>
>>> With best regards / Pozdrawiam
>>> Piotr Da=B3ek
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
>>> in the body of a message to majordomo@vger.kernel.org More majordom=
o
>>> info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
