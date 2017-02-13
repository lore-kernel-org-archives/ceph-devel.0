From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Breakage in Clang compile....
Date: Mon, 13 Feb 2017 11:20:41 +0100
Message-ID: <4cb44f22-9c7e-1266-df20-b53f11e377ec@digiware.nl>
References: <a5a35bfc-57b2-bf28-9788-04127654e23a@digiware.nl>
 <E5D4D9AF-0529-424A-9C75-759906A4C65D@quantum.com>
 <28691041-11fc-bd69-2d0b-1986fa798aca@digiware.nl>
 <CACKY0b_pZXyJO1fQn9hrqJw5JYT_x932YkCYZv3miFZOks9vJw@mail.gmail.com>
 <CAF-wwdFushwATp88GxKAJfZpiB+ZSf6Q7iQa5mAKjKeEetMO0g@mail.gmail.com>
 <32db5fd3-a02a-1f4d-9e28-674280fa071c@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:37658 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751480AbdBMKVG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 13 Feb 2017 05:21:06 -0500
In-Reply-To: <32db5fd3-a02a-1f4d-9e28-674280fa071c@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?= <bartlomiej.swiecki@corp.ovh.com>, Brad Hubbard <bhubbard@redhat.com>, liuchang0812 <liuchang0812@gmail.com>
Cc: Bassam Tabbara <Bassam.Tabbara@quantum.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 13-2-2017 10:26, Bartłomiej Święcki wrote:
> Hi,
> 
> What I usually hear in gcc vs comparisons is that clang does not yet
> optimize the code as good gcc
> (fun fact: sometimes that's because it's more standards conformant).
> Nevertheless, it's always
> a good idea to compile the code with as many compilers as possible -
> that way more meaningful warnings
> could be found. An example - when I was compiling the patch, clang has
> found this:
> 
> /builds/ceph-histograms/src/include/denc.h:1160:10: warning: binding
> dereferenced null pointer to reference has undefined behavior
> [-Wnull-dereference]
>     denc(*(bool *)nullptr, p);
>          ^~~~~~~~~~~~~~~~
> 
> And I strongly believe we should get rid of it - dereferencing null
> pointer in C++ is undefined
> behavior so the compiler can do whatever he wants there. Even if it
> works with current gcc,
> more aggressive optimizations added to compilers in the future could
> make this totally broken.
> 
> I've observed it's a common practice in many companies to develop using
> clang (to get
> best diagnostic and tools) but do the final release using gcc (to get
> the best performance).
> I also like clang for the number of tools built on top of clang - static
> analyzers, sanitizers,
> code formatting etc. Chandler Carruth from Goggle has given some nice
> talks about this:
> https://youtu.be/cX_GhJ6BuWI, https://youtu.be/E36BUcTWo50.

Hi Bartek,

What you found is also what I found. And I agree with the fact that it
needs fixing.... Am not even sure what a dereferenced null-pointer
should actually generate as value?

We have fixed similar issues at several places already where it
generated errors. Here it is a warning, so I can sort of live with it
because I can continue my porting/testing work.

So if you have suggestions, I very sure that they will get happily
accepted. And I can and will test and support getting these fixes in.

Using GCC on FreeBSD is no longer the preferred way of doing things.
Also are all packages compiled with Clang, so best to use those with the
Clang compiler.
And modern releases of GCC are all in ports and are not free of pesky
conflicts with the installed base.

Thanx,
--WjW

> 
> Regards,
> Bartek
> 
> 
> On 02/10/2017 10:31 AM, Brad Hubbard wrote:
>> Whilst I agree clang has some advantages I also understand from
>> watching recent videos that it has some disadvantages/shortcomings as
>> well (can't remember the specifics atm). Whilst I don't agree we
>> should be switching to clang I do suggest we should be compiling with
>> it regularly since it can pick up problems that gcc may not.
>>
>> My 2c.
>>
>>
>> On Fri, Feb 10, 2017 at 12:46 PM, liuchang0812
>> <liuchang0812@gmail.com> wrote:
>>> clang's compile warn is clearer than gcc
>>>
>>> 2017-02-10 2:10 GMT+08:00 Willem Jan Withagen <wjw@digiware.nl>:
>>>> On 9-2-2017 17:18, Bassam Tabbara wrote:
>>>>> Hi,
>>>>>
>>>>> I’m curious are there specific advantages to compiling Ceph with
>>>>> clang vs. gcc? I understand that clang uses less memory, compiles
>>>>> faster, and has better errors/diagnostics, but as it relates to Ceph
>>>>> is there any specific advantages?
>>>>>
>>>>> Is there a plan to switching to clang?
>>>> There are a few reasons for also using Clang:
>>>>   - Clang finds other types of issues in the code.
>>>>          I think the speed, mem-footprint advantages you mention are
>>>> not
>>>>          (yet) the case.
>>>>   - FreeBSD has Clang as native compiler, and I'm preparing a Ceph port
>>>>     to FreeBSD.
>>>>
>>>> Thanx for fixing this, I saw the PR fly by.
>>>>
>>>> --WjW
>>>>
>>>>> Thanks! Bassam
>>>>>
>>>>>> On Feb 9, 2017, at 7:35 AM, Willem Jan Withagen <wjw@digiware.nl>
>>>>>> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I think this is a recent addition to the game? And Clang does not
>>>>>> really like it.
>>>>>>
>>>>>> In file included from
>>>>>> /home/jenkins/workspace/ceph-master/src/common/perf_counters.h:21:
>>>>>> /home/jenkins/workspace/ceph-master/src/common/perf_histogram.h:80:9:
>>>>>>
>>>>>>
>>>> error: array initializer must be an initializer list
>>>>>> : m_axes_config(other.m_axes_config) { ^
>>>>>> /home/jenkins/workspace/ceph-master/src/common/perf_counters.h:98:29:
>>>>>>
>>>>>>
>>>> note: in instantiation of member function
>>>>>> 'PerfHistogram<2>::PerfHistogram' requested here
>>>>>> histogram.reset(new PerfHistogram<>(*other.histogram)); ^ 1 error
>>>>>> generated.
>>>>>>
>>>>>> --WjW -- To unsubscribe from this list: send the line "unsubscribe
>>>>>> ceph-devel" in the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at
>>>>>> https://urldefense.proofpoint.com/v2/url?u=http-3A__vger.kernel.org_majordomo-2Dinfo.html&d=DwICaQ&c=8S5idjlO_n28Ko3lg6lskTMwneSC-WqZ5EBTEEvDlkg&r=BTMd2ANcDl5P_nTkEam5zzywWdGjHoaoXy4JMG_yHPA&m=PzCl2U7BH52mycDw3PiC7LaCbGCCTewMNBUqu8gGKIQ&s=gR4xXKHg4AFcwEccrIs-KoM7bjGw0aL9CnVF_PQE_fo&e=
>>>>>>
>>>>>>
>>>> -- 
>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> 

