From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Understanding some of the Cmake logics
Date: Tue, 10 Oct 2017 17:13:47 +0200
Message-ID: <d9fcfa2d-bdb6-bc27-3f53-caacd864999e@digiware.nl>
References: <b06780c7-13ce-1274-735f-806a1f4f8062@digiware.nl>
 <CAJE9aONEKsSnh7De6-TcS_BwKsCnqav8MXkDR6aUFuMp2out6A@mail.gmail.com>
 <c8081893-bfbf-483f-01ed-1fd7a1c260d5@digiware.nl>
 <CAJE9aOMeOOM9sOdS10gk47R6hykYUQLST_+L7JkXr9Y-e+Si8A@mail.gmail.com>
 <ebf1e5c5-ff39-9026-25d8-c9216d1671b0@digiware.nl>
 <CAJE9aOOHonNsfFj8+umCOFEOtJM9u8o-WefAyVbfU3JGtp5j-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:17194 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932212AbdJJPOJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 10 Oct 2017 11:14:09 -0400
In-Reply-To: <CAJE9aOOHonNsfFj8+umCOFEOtJM9u8o-WefAyVbfU3JGtp5j-Q@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 10-10-2017 16:58, kefu chai wrote:
> On Tue, Oct 10, 2017 at 9:54 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> On 10-10-2017 15:31, kefu chai wrote:
>>> On Tue, Oct 10, 2017 at 8:06 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>>> On 10-10-2017 13:14, kefu chai wrote:
>>>>> + ceph-devel
>>>>>
>>>>> On Tue, Oct 10, 2017 at 4:49 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>>>>> Hi Kefu,
>>>>>>
>>>>>> Sort of wondering what in the current code below is the relation between
>>>>>> gpertools and tcmalloc?
>>>>>
>>>>> could you be more specific?
>>>>
>>>> While looking at the code of CMakeLists.txt:286, in the case that no
>>>> ALLOCATOR is defined.
>>>> There the current flow of code seems to suggest that gperf-tools is
>>>> always linked to tcmalloc. And once gperftools is found, the ALLOCATOR
>>>> is set to tcmalloc. This then breaks rocksdb building.
>>>>     `set(HAVE_LIBTCMALLOC ${GPERFTOOLS_FOUND})`
>>>> like:
>>>> ```
>>>>  CMake Error at cmake/modules/BuildRocksDB.cmake:63 (message):
>>>>    Incompatible tcmalloc v2.6.1 and rocksdb v5.8.0, please install
>>>>  gperf-tools
>>>>    2.5 (not 2.5.93) or >= 2.6.2, or switch to another allocator using
>>>> 'cmake -DALLOCATOR=libc'.
>>>>  Call Stack (most recent call first):
>>>>    src/CMakeLists.txt:825 (build_rocksdb)
>>>> ```
>>>>
>>>>>> Reason for the question is that once the gperf packages is installed,
>>>>>> as a bonus the code below declares the allocator to be tcmalloc.
>>>>>> But gperf under FreeBSD does not have tcmalloc.
>>>>>
>>>>> please note gperf here is not GNU perf [1] but google-perftools. and
>>>>> why do you claim the gperf under FreeBSD does not have tcmalloc? could
>>>>> you elaborate this a little bit?
>>>>
>>>> My bad, I mixed gperf and gperf-tools. We are talking about gperf-tools.
>>>> And yes, gperftools brings tcmalloc but not in the version mix that is
>>>> asked for. gperf-tools was at 2.5 one time, but has upgraded to 2.6.1_1
>>>> on FreeBSD[1]. Getting other versions will require manual work to get it
>>>> to work.
>>>>
>>>> But the question is:
>>>>     Do I really want my allocator to be tcmalloc when the native
>>>>     libc allocator is jemalloc?
>>>
>>> i think it's up to you.
>>
>> Oke, it is what the code now forces...
>> And I've tried avoiding tcmalloc uptil now, and would like to do so for
>> the time being..
>>
>>>> So is the test in CMakeLists.txt:286-324 what we want on FreeBSD?
>>>
>>> see http://tracker.ceph.com/issues/21422. so again, it's up to you.
>>
>> The tracker suggests that it is an error in 2.5.93, but
>> cmake/modules/BuildRocksDB.cmake suggests that it is only fixed in
>> 2.6.2...??
> 
> 2.6.2 is not yet released. so if you want to stick with tcmalloc, you
> need to build from the latest (or recent enough) source. actually, i
> am not sure what you question is..

The question: Do you know if 2.6.2 is the first gperf-tools-version >
2.5.93 where this bug from the tracker is solved?

>>
>>>> The workaround this (for the time being) is to call cmake with
>>>> -DALLOCATOR=libc as is suggested.
>>
>> I'll use this as workaround for the time being, since that is least
>> invasive. And when that works out, try and make a PR for the allocator
>> selector in CmakeLists.txt, and/or wait until gperf-tools 2.6.2 is
>> available on FreeBSD.
> 
> what is issue you want to address?

The issue I want to address is that I'm not able to build the intree
rocksdb ATM. Because tcmalloc is not => 2.6.2, and tcmalloc is required
because gperf-tools is detected.

Hardcoding the allocator during cmake-ing for now solves this catch-22.

--WjW

> 
>>
>> --WjW
>>
>>>> [1]
>>>> https://svnweb.freebsd.org/ports/head/devel/google-perftools/Makefile?revision=450353&view=markup
>>>>
>>>>>
>>>>> --
>>>>> [1] http://portsmon.freebsd.org/portoverview.py?category=devel&portname=gperf
>>>>> [2] http://portsmon.freebsd.org/portoverview.py?category=devel&portname=google-perftools
>>>>>
>>>>>>
>>>>>> So I guess I need to fix the code below the to prevent this implicit
>>>>>> relation
>>>>>> under FreeBSD.
>>>>>>
>>>>>> And the problem that arises from this all lies in compiling rocksdb,
>>>>>> because
>>>>>> under FreeBSD that also needs to be build with libc as allocator.
>>>>>> The introduction of the new rocksdb building makes this clear.
>>>>>>
>>>>>> CMake Error at cmake/modules/BuildRocksDB.cmake:63 (message):
>>>>>>   Incompatible tcmalloc v2.6.1 and rocksdb v5.8.0, please install
>>>>>> gperf-tools
>>>>>>   2.5 (not 2.5.93) or >= 2.6.2, or switch to another allocator using 'cmake
>>>>>>   -DALLOCATOR=libc'.
>>>>>> Call Stack (most recent call first):
>>>>>>   src/CMakeLists.txt:825 (build_rocksdb)
>>>>>>
>>>>>>
>>>>>> --WjW
>>>>>>
>>>>>>
>>>>>> a614c3b9c1e (Ali Maredia         2015-12-30 21:06:08 -0500 286)
>>>>>> if(ALLOCATOR)
>>>>>> ca9946d2b5a (Bassam Tabbara      2016-10-10 14:37:58 -0700 287)
>>>>>> if(${ALLOCATOR} MATCHES "tcmalloc(_minimal)?")
>>>>>> 6c12edbf9d2 (Kefu Chai           2016-08-11 00:12:05 +0800 288)
>>>>>> find_package(gperftools REQUIRED)
>>>>>> 6c12edbf9d2 (Kefu Chai           2016-08-11 00:12:05 +0800 289)
>>>>>> set(HAVE_LIBTCMALLOC ON)
>>>>>> a614c3b9c1e (Ali Maredia         2015-12-30 21:06:08 -0500 290)
>>>>>> elseif(${ALLOCATOR} STREQUAL "jemalloc")
>>>>>> a614c3b9c1e (Ali Maredia         2015-12-30 21:06:08 -0500 291)
>>>>>> find_package(JeMalloc REQUIRED)
>>>>>> 0ef09f32d46 (Ali Maredia         2016-05-02 18:21:32 -0400 292)
>>>>>> set(HAVE_LIBJEMALLOC ${JEMALLOC_FOUND})
>>>>>> 83b74f52501 (Matt Benjamin       2016-12-21 23:36:37 -0500 293)
>>>>>> set(HAVE_JEMALLOC 1)
>>>>>> a614c3b9c1e (Ali Maredia         2015-12-30 21:06:08 -0500 294)   endif()
>>>>>> a614c3b9c1e (Ali Maredia         2015-12-30 21:06:08 -0500 295)
>>>>>> else(ALLOCATOR)
>>>>>> 6c12edbf9d2 (Kefu Chai           2016-08-11 00:12:05 +0800 296)
>>>>>> find_package(gperftools)
>>>>>> 6c12edbf9d2 (Kefu Chai           2016-08-11 00:12:05 +0800 297)
>>>>>> set(HAVE_LIBTCMALLOC ${GPERFTOOLS_FOUND})
>>>>>> 6c12edbf9d2 (Kefu Chai           2016-08-11 00:12:05 +0800 298)   if(NOT
>>>>>> GPERFTOOLS_FOUND)
>>>>>> 0ef09f32d46 (Ali Maredia         2016-05-02 18:21:32 -0400 299)
>>>>>> find_package(JeMalloc)
>>>>>> 0ef09f32d46 (Ali Maredia         2016-05-02 18:21:32 -0400 300)
>>>>>> set(HAVE_LIBJEMALLOC ${JEMALLOC_FOUND})
>>>>>> 6c12edbf9d2 (Kefu Chai           2016-08-11 00:12:05 +0800 301)
>>>>>> endif(NOT GPERFTOOLS_FOUND)
>>>>>> 6c12edbf9d2 (Kefu Chai           2016-08-11 00:12:05 +0800 302)
>>>>>> if(GPERFTOOLS_FOUND)
>>>>>> 48a1f8eff5b (Kefu Chai           2016-06-08 11:34:44 +0800 303)
>>>>>> set(ALLOCATOR tcmalloc)
>>>>>> 48a1f8eff5b (Kefu Chai           2016-06-08 11:34:44 +0800 304)
>>>>>> elseif(JEMALLOC_FOUND)
>>>>>> 48a1f8eff5b (Kefu Chai           2016-06-08 11:34:44 +0800 305)
>>>>>> set(ALLOCATOR jemalloc)
>>>>>> 48a1f8eff5b (Kefu Chai           2016-06-08 11:34:44 +0800 306)   else()
>>>>>> ce3b71acd20 (Willem Jan Withagen 2017-02-12 15:03:56 +0100 307)
>>>>>> if(NOT FREEBSD)
>>>>>> ce3b71acd20 (Willem Jan Withagen 2017-02-12 15:03:56 +0100 308)       #
>>>>>> FreeBSD already has jemalloc as its default allocator
>>>>>> ce3b71acd20 (Willem Jan Withagen 2017-02-12 15:03:56 +0100 309)
>>>>>> message(WARNING "tcmalloc and jemalloc not found, falling back to libc")
>>>>>> ce3b71acd20 (Willem Jan Withagen 2017-02-12 15:03:56 +0100 310)     endif()
>>>>>> a614c3b9c1e (Ali Maredia         2015-12-30 21:06:08 -0500 311)
>>>>>> set(ALLOCATOR "libc")
>>>>>> 6c12edbf9d2 (Kefu Chai           2016-08-11 00:12:05 +0800 312)
>>>>>> endif(GPERFTOOLS_FOUND)
>>>>>> a614c3b9c1e (Ali Maredia         2015-12-30 21:06:08 -0500 313)
>>>>>> endif(ALLOCATOR)
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>>
>>
> 
> 
> 

