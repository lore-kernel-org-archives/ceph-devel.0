From: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?=
        <bartlomiej.swiecki@corp.ovh.com>
Subject: Re: Breakage in Clang compile....
Date: Mon, 13 Feb 2017 10:26:32 +0100
Message-ID: <32db5fd3-a02a-1f4d-9e28-674280fa071c@corp.ovh.com>
References: <a5a35bfc-57b2-bf28-9788-04127654e23a@digiware.nl>
 <E5D4D9AF-0529-424A-9C75-759906A4C65D@quantum.com>
 <28691041-11fc-bd69-2d0b-1986fa798aca@digiware.nl>
 <CACKY0b_pZXyJO1fQn9hrqJw5JYT_x932YkCYZv3miFZOks9vJw@mail.gmail.com>
 <CAF-wwdFushwATp88GxKAJfZpiB+ZSf6Q7iQa5mAKjKeEetMO0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 2.mo301.mail-out.ovh.net ([137.74.110.65]:43694 "EHLO
        2.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbdBMJ0p (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2017 04:26:45 -0500
In-Reply-To: <CAF-wwdFushwATp88GxKAJfZpiB+ZSf6Q7iQa5mAKjKeEetMO0g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>, liuchang0812 <liuchang0812@gmail.com>
Cc: Willem Jan Withagen <wjw@digiware.nl>, Bassam Tabbara <Bassam.Tabbara@quantum.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

What I usually hear in gcc vs comparisons is that clang does not yet 
optimize the code as good gcc
(fun fact: sometimes that's because it's more standards conformant). 
Nevertheless, it's always
a good idea to compile the code with as many compilers as possible - 
that way more meaningful warnings
could be found. An example - when I was compiling the patch, clang has 
found this:

/builds/ceph-histograms/src/include/denc.h:1160:10: warning: binding 
dereferenced null pointer to reference has undefined behavior 
[-Wnull-dereference]
     denc(*(bool *)nullptr, p);
          ^~~~~~~~~~~~~~~~

And I strongly believe we should get rid of it - dereferencing null 
pointer in C++ is undefined
behavior so the compiler can do whatever he wants there. Even if it 
works with current gcc,
more aggressive optimizations added to compilers in the future could 
make this totally broken.

I've observed it's a common practice in many companies to develop using 
clang (to get
best diagnostic and tools) but do the final release using gcc (to get 
the best performance).
I also like clang for the number of tools built on top of clang - static 
analyzers, sanitizers,
code formatting etc. Chandler Carruth from Goggle has given some nice 
talks about this:
https://youtu.be/cX_GhJ6BuWI, https://youtu.be/E36BUcTWo50.

Regards,
Bartek


On 02/10/2017 10:31 AM, Brad Hubbard wrote:
> Whilst I agree clang has some advantages I also understand from
> watching recent videos that it has some disadvantages/shortcomings as
> well (can't remember the specifics atm). Whilst I don't agree we
> should be switching to clang I do suggest we should be compiling with
> it regularly since it can pick up problems that gcc may not.
>
> My 2c.
>
>
> On Fri, Feb 10, 2017 at 12:46 PM, liuchang0812 <liuchang0812@gmail.com> wrote:
>> clang's compile warn is clearer than gcc
>>
>> 2017-02-10 2:10 GMT+08:00 Willem Jan Withagen <wjw@digiware.nl>:
>>> On 9-2-2017 17:18, Bassam Tabbara wrote:
>>>> Hi,
>>>>
>>>> I’m curious are there specific advantages to compiling Ceph with
>>>> clang vs. gcc? I understand that clang uses less memory, compiles
>>>> faster, and has better errors/diagnostics, but as it relates to Ceph
>>>> is there any specific advantages?
>>>>
>>>> Is there a plan to switching to clang?
>>> There are a few reasons for also using Clang:
>>>   - Clang finds other types of issues in the code.
>>>          I think the speed, mem-footprint advantages you mention are not
>>>          (yet) the case.
>>>   - FreeBSD has Clang as native compiler, and I'm preparing a Ceph port
>>>     to FreeBSD.
>>>
>>> Thanx for fixing this, I saw the PR fly by.
>>>
>>> --WjW
>>>
>>>> Thanks! Bassam
>>>>
>>>>> On Feb 9, 2017, at 7:35 AM, Willem Jan Withagen <wjw@digiware.nl>
>>>>> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> I think this is a recent addition to the game? And Clang does not
>>>>> really like it.
>>>>>
>>>>> In file included from
>>>>> /home/jenkins/workspace/ceph-master/src/common/perf_counters.h:21:
>>>>> /home/jenkins/workspace/ceph-master/src/common/perf_histogram.h:80:9:
>>>>>
>>>>>
>>> error: array initializer must be an initializer list
>>>>> : m_axes_config(other.m_axes_config) { ^
>>>>> /home/jenkins/workspace/ceph-master/src/common/perf_counters.h:98:29:
>>>>>
>>>>>
>>> note: in instantiation of member function
>>>>> 'PerfHistogram<2>::PerfHistogram' requested here
>>>>> histogram.reset(new PerfHistogram<>(*other.histogram)); ^ 1 error
>>>>> generated.
>>>>>
>>>>> --WjW -- To unsubscribe from this list: send the line "unsubscribe
>>>>> ceph-devel" in the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at
>>>>> https://urldefense.proofpoint.com/v2/url?u=http-3A__vger.kernel.org_majordomo-2Dinfo.html&d=DwICaQ&c=8S5idjlO_n28Ko3lg6lskTMwneSC-WqZ5EBTEEvDlkg&r=BTMd2ANcDl5P_nTkEam5zzywWdGjHoaoXy4JMG_yHPA&m=PzCl2U7BH52mycDw3PiC7LaCbGCCTewMNBUqu8gGKIQ&s=gR4xXKHg4AFcwEccrIs-KoM7bjGw0aL9CnVF_PQE_fo&e=
>>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

