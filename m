From: kefu chai <tchaikov@gmail.com>
Subject: Re: Understanding some of the Cmake logics
Date: Tue, 10 Oct 2017 23:35:02 +0800
Message-ID: <CAJE9aOOu96GRJOYW1mSUem=7JbyWK9mZ7tBGPyaOOyFUWFWnRQ@mail.gmail.com>
References: <b06780c7-13ce-1274-735f-806a1f4f8062@digiware.nl>
 <CAJE9aONEKsSnh7De6-TcS_BwKsCnqav8MXkDR6aUFuMp2out6A@mail.gmail.com>
 <c8081893-bfbf-483f-01ed-1fd7a1c260d5@digiware.nl> <CAJE9aOMeOOM9sOdS10gk47R6hykYUQLST_+L7JkXr9Y-e+Si8A@mail.gmail.com>
 <ebf1e5c5-ff39-9026-25d8-c9216d1671b0@digiware.nl> <CAJE9aOOHonNsfFj8+umCOFEOtJM9u8o-WefAyVbfU3JGtp5j-Q@mail.gmail.com>
 <d9fcfa2d-bdb6-bc27-3f53-caacd864999e@digiware.nl> <CAJE9aOO8Jfa+xRKUupSY_gBD6Fk7tnMHUZMasfM3aYX=g7uLfw@mail.gmail.com>
 <4e52a7ba-f0eb-5cc0-4bce-1bab78cbcad5@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:43995 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdJJPfD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Oct 2017 11:35:03 -0400
Received: by mail-oi0-f49.google.com with SMTP id c77so43808161oig.0
        for <ceph-devel@vger.kernel.org>; Tue, 10 Oct 2017 08:35:03 -0700 (PDT)
In-Reply-To: <4e52a7ba-f0eb-5cc0-4bce-1bab78cbcad5@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Oct 10, 2017 at 11:27 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 10-10-2017 17:19, kefu chai wrote:
>> On Tue, Oct 10, 2017 at 11:13 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> On 10-10-2017 16:58, kefu chai wrote:
>>>> On Tue, Oct 10, 2017 at 9:54 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>>>> On 10-10-2017 15:31, kefu chai wrote:
>>>>>> On Tue, Oct 10, 2017 at 8:06 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>>>>>> On 10-10-2017 13:14, kefu chai wrote:
>>>>>>>> + ceph-devel
>>>>>>>>
>>>>>>>> On Tue, Oct 10, 2017 at 4:49 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>>>>>>>> Hi Kefu,
>>>>>>>>>
>>>>>>>>> Sort of wondering what in the current code below is the relation between
>>>>>>>>> gpertools and tcmalloc?
>>>>>>>>
>>>>>>>> could you be more specific?
>>>>>>>
>>>>>>> While looking at the code of CMakeLists.txt:286, in the case that no
>>>>>>> ALLOCATOR is defined.
>>>>>>> There the current flow of code seems to suggest that gperf-tools is
>>>>>>> always linked to tcmalloc. And once gperftools is found, the ALLOCATOR
>>>>>>> is set to tcmalloc. This then breaks rocksdb building.
>>>>>>>     `set(HAVE_LIBTCMALLOC ${GPERFTOOLS_FOUND})`
>>>>>>> like:
>>>>>>> ```
>>>>>>>  CMake Error at cmake/modules/BuildRocksDB.cmake:63 (message):
>>>>>>>    Incompatible tcmalloc v2.6.1 and rocksdb v5.8.0, please install
>>>>>>>  gperf-tools
>>>>>>>    2.5 (not 2.5.93) or >= 2.6.2, or switch to another allocator using
>>>>>>> 'cmake -DALLOCATOR=libc'.
>>>>>>>  Call Stack (most recent call first):
>>>>>>>    src/CMakeLists.txt:825 (build_rocksdb)
>>>>>>> ```
>>>>>>>
>>>>>>>>> Reason for the question is that once the gperf packages is installed,
>>>>>>>>> as a bonus the code below declares the allocator to be tcmalloc.
>>>>>>>>> But gperf under FreeBSD does not have tcmalloc.
>>>>>>>>
>>>>>>>> please note gperf here is not GNU perf [1] but google-perftools. and
>>>>>>>> why do you claim the gperf under FreeBSD does not have tcmalloc? could
>>>>>>>> you elaborate this a little bit?
>>>>>>>
>>>>>>> My bad, I mixed gperf and gperf-tools. We are talking about gperf-tools.
>>>>>>> And yes, gperftools brings tcmalloc but not in the version mix that is
>>>>>>> asked for. gperf-tools was at 2.5 one time, but has upgraded to 2.6.1_1
>>>>>>> on FreeBSD[1]. Getting other versions will require manual work to get it
>>>>>>> to work.
>>>>>>>
>>>>>>> But the question is:
>>>>>>>     Do I really want my allocator to be tcmalloc when the native
>>>>>>>     libc allocator is jemalloc?
>>>>>>
>>>>>> i think it's up to you.
>>>>>
>>>>> Oke, it is what the code now forces...
>>>>> And I've tried avoiding tcmalloc uptil now, and would like to do so for
>>>>> the time being..
>>>>>
>>>>>>> So is the test in CMakeLists.txt:286-324 what we want on FreeBSD?
>>>>>>
>>>>>> see http://tracker.ceph.com/issues/21422. so again, it's up to you.
>>>>>
>>>>> The tracker suggests that it is an error in 2.5.93, but
>>>>> cmake/modules/BuildRocksDB.cmake suggests that it is only fixed in
>>>>> 2.6.2...??
>>>>
>>>> 2.6.2 is not yet released. so if you want to stick with tcmalloc, you
>>>> need to build from the latest (or recent enough) source. actually, i
>>>> am not sure what you question is..
>>>
>>> The question: Do you know if 2.6.2 is the first gperf-tools-version >
>>> 2.5.93 where this bug from the tracker is solved?
>>
>> https://github.com/ceph/ceph/pull/17788/commits/ff8d6a730bb774271b9eea6af338e2d3ce3c48a5
>
> fascinating reading...
> Shows that managing version can be a bitch.
>
>>>>>>> The workaround this (for the time being) is to call cmake with
>>>>>>> -DALLOCATOR=libc as is suggested.
>>>>>
>>>>> I'll use this as workaround for the time being, since that is least
>>>>> invasive. And when that works out, try and make a PR for the allocator
>>>>> selector in CmakeLists.txt, and/or wait until gperf-tools 2.6.2 is
>>>>> available on FreeBSD.
>>>>
>>>> what is issue you want to address?
>>>
>>> The issue I want to address is that I'm not able to build the intree
>>> rocksdb ATM. Because tcmalloc is not => 2.6.2, and tcmalloc is required
>>> because gperf-tools is detected.
>>
>> the error message offered two solutions. i think, what you need is
>> just to choose one of them.
>
> Right, so I'm going with libc for the moment...
>
> Thanx for your patient explanations,

i did send a mail with title of 'fix for "crash in rocksdb LRUCache
destructor with tcmalloc"' to this mailing list. if you have had read
it, it'd save both of us some time.

> --WjW
>
>



-- 
Regards
Kefu Chai
