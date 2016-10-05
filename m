From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: ceph-mgr is in master
Date: Wed, 5 Oct 2016 18:25:30 +0200
Message-ID: <af9675cf-521c-e852-ae5a-31f5c7106b4d@digiware.nl>
References: <CALe9h7ebyOdYcy1hjJ1pje28fuVro68o=_q=WscRuNX2dLebjw@mail.gmail.com>
 <CAJ4mKGb4BLwOs1sqmB=mD-_BUzUDrc0wL4NZ8wotp++kdkE9mQ@mail.gmail.com>
 <CALe9h7eZO2XCWqmMhM+hiJqSgmLPLqs5yBgyOD-6sRCYDD3jDQ@mail.gmail.com>
 <bf4c0368-09f1-0f6d-16c3-ed7a321cba51@digiware.nl>
 <CALe9h7dHVfTJgi-JBMiXtxAO9wLWJ5_N0TiE+hk0eg52DV420g@mail.gmail.com>
 <19f91716-7a06-ad47-0c9f-f4d1e7ea585b@digiware.nl>
 <CALe9h7eoX_Nuk0617eBY_5tuFWMw4_5CpvgHWJNVPhKiupKCvw@mail.gmail.com>
 <e0edf2d6-55ae-e8e1-9d83-662617c5729c@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:23397 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751968AbcJEQ0d (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 5 Oct 2016 12:26:33 -0400
In-Reply-To: <e0edf2d6-55ae-e8e1-9d83-662617c5729c@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 4-10-2016 16:42, Willem Jan Withagen wrote:
> On 4-10-2016 15:15, John Spray wrote:
>> On Tue, Oct 4, 2016 at 2:28 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> On 4-10-2016 14:16, John Spray wrote:
>>>> On Tue, Oct 4, 2016 at 1:03 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>>>> On 4-10-2016 08:07, John Spray wrote:
>>>>>> As Dan says, `ceph tell` is the new one, the one that sends commands
>>>>>> directly from the CLI to the named service (not via the mon).
>>>>>> However, this is a bit of a placeholder, as we'll eventually be
>>>>>> switching to some commands (especially PG stats ones) to silently go
>>>>>> to the mgr instead of the mon.  There are various ways of
>>>>>> accomplishing that, the simplest one is to have the CLI fetch both mgr
>>>>>> and mon command descriptions, and preferentially send commands to
>>>>>> matching entries from the mgr.
>>>>>
>>>>> ATM I had to disable building MGR, because Clang/Python/FreeBSD throw a
>>>>> fit when having to compile on of the python files...
>>>>> Something to do with function-signatures not matching.
>>>>> I'll look into it after I've completed most of my other blocking
>>>>> problems. Unless you'd really want to have the compiler errors now, I'll
>>>>> fireup a build with MGR on.
>>>>
>>>> Ah... yeah, I do seem to recall some places the compiler warned about
>>>> (perfectly safe) const char* casts.  I'll look into cleaning that up,
>>>> assuming it's what's making clang unhappy.
>>>
>>> Clang is a lot more picky at times... But usually I get away with a
>>> warning, this time it throws errors.
>>>
>>
>> Can you try this please?
>> https://github.com/ceph/ceph/pull/11307
> 
> Seems we are talking about the same errors.
> At least PyObject_CallMethod is what I remember giving the errors.
> 
> I'll put this in and give it a spinf for its money...

This is another Clang warning, I guess...
But as I read it, it sounds rather true...

/usr/srcs/Ceph/work/ceph/src/messages/MMgrReport.h:39:17: warning:
comparison of constant 256 with expression of type 'const enum
perfcounter_type_d' is always true
      [-Wtautological-constant-out-of-range-compare]
    assert(type < 256);
           ~~~~ ^ ~~~
atleast if enum perfcounter_type_d is a byte.

--WjW

