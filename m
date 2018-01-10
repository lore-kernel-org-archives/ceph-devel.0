From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Moving to 1.66 Boost
Date: Wed, 10 Jan 2018 10:06:09 +0100
Message-ID: <9d846490-4769-5b3a-5eb3-b741f6608382@digiware.nl>
References: <b4b3abf8-d7db-7037-a589-38c9563f078c@digiware.nl>
 <CAJE9aOMaKpOyy180hSV39eebnpWShWHE821qT00WmYXgnqbFxw@mail.gmail.com>
 <326bc270-7ccd-947d-a0e5-57bf44f93d37@digiware.nl>
 <210a83ee-b767-54fc-fea9-2ef3decaff1c@redhat.com>
 <3d5eb231-4688-fa9c-1daa-02a19e8de30c@digiware.nl>
 <a56a37c5-0137-a27a-980d-11b2e09437ef@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:60598 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755700AbeAJJGL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 10 Jan 2018 04:06:11 -0500
In-Reply-To: <a56a37c5-0137-a27a-980d-11b2e09437ef@redhat.com>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>, kefu chai <tchaikov@gmail.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 08/01/2018 23:15, Casey Bodley wrote:
> 
> 
> On 01/02/2018 12:11 PM, Willem Jan Withagen wrote:
>> On 2-1-2018 17:13, Casey Bodley wrote:
>>>
>>> On 01/01/2018 06:13 AM, Willem Jan Withagen wrote:
>>>> On 31/12/2017 06:30, kefu chai wrote:
>>>>> + ceph-devl
>>>>>
>>>>> On Wed, Dec 27, 2017 at 5:47 PM, Willem Jan Withagen
>>>>> <wjw@digiware.nl> wrote:
>>>>>> Hi Kefu,
>>>>>>
>>>>>> In FreeBSD the portmanager of Boost wants to move to 1.66, and so
>>>>>> normally
>>>>>> they do a test run on all 33.000 ports to see what breaks.
>>>>>>
>>>>>> Now one of the things that breaks is Ceph, but i a way I do not
>>>>>> understand...
>>>>>>
>>>>>> When linking ceph-common references to the 
>>>>>> /usr/local/lib/libboost_*.so
>>>>>> files on Boost 1.65 are now replaced by -lBoost::thread invocations
>>>>>> 1.66??
>>>>> could you pastebin the error message? Boost::thread is the library
>>>>> name. but I
>>>>> don't think it can be passed to the linker. if you see this in the
>>>>> command line,
>>>>> something is wrong.
>>>> It was the now traditional problem that a CMake upgrade does not run
>>>> in sync with Boost upgrades. Took quite some runs, but now FreeBSD
>>>> ports is at 12.2.2, and in preparation on the 1.66 Boost release it
>>>> builds without Beast by execluding WITH_RADOSGW_BEAST_FRONTEND.
>>>>
>>>> Which will be switched back on once the 1.66 Beast works with v12.2.2.
>>>>
>>> Okay, thanks. The rgw/beast changes for boost 1.66 are staged in
>>> https://github.com/ceph/ceph/pull/19054. If there are delays in merging
>>> that, I'm happy to pull them into a separate pr. And thanks for pointing
>>> out that we'll need to backport those pieces for luminous.
>> Right,
>>
>> If that/backporting is possible, then I can switch Beast back on for
>> Luminous. And everything comes back into sync...
>>
>> The WITH_RADOSGW_BEAST_FRONTEND switch made it very convenient to let
>> FreeBSD (prepare to) move to 1.66 without Ceph package building being
>> disabled. And now everybody can do "its thing(tm)" without blocking
>> dependencies.
>>
>> When I have a bit more time and #19054 is not merged by then, I'll take
>> a stab at it.

> The boost 1.66 changes merged into master. I've prepared a backport for 
> luminous at https://github.com/ceph/ceph/pull/19848 which pulls in all 
> the extra beast frontend stuff that targets v1.66.

I'll have to set up a seperate luminous tester, and will give this 
backport a testrun.
Is there any new release date planned for a new Luminous release?

--WjW


