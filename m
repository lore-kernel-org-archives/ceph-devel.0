From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: unset_dumpable
Date: Fri, 21 Jul 2017 01:34:39 +0200
Message-ID: <7b17556a-6959-4f0f-8fd9-40de86b76500@digiware.nl>
References: <a7cd6c1f-93f7-e652-68ff-bdfc89ff20c1@digiware.nl>
 <CA+2bHPb-=nhakBXwfhxjMpBmRJJmUqUgEPnCO44Z_3RcVwUM4Q@mail.gmail.com>
 <b6e4fd6e-d38a-219b-df89-b500ec63692d@digiware.nl>
 <24961618-3abf-08c5-e134-1f58b85f0b96@digiware.nl>
 <CAF-wwdGNs7Zqd9y3hE6PP=T2aDrESZmkR0KGRbkNVsbCTAYdiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:65432 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936260AbdGTXel (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 20 Jul 2017 19:34:41 -0400
In-Reply-To: <CAF-wwdGNs7Zqd9y3hE6PP=T2aDrESZmkR0KGRbkNVsbCTAYdiQ@mail.gmail.com>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>



Op 21-7-2017 om 00:39 schreef Brad Hubbard:
> When implemented it was generally though to be OK by reviewers, including yourself.
>
> https://github.com/ceph/ceph/pull/14821
>
> Can I asked what changed to make it an issue now? Has there been some recent
> change in compilers on FreeBSD to make this an issue? It's a valid use of RAII
> in my humble opinion although it *appears* to be an unused variable. Odd this
> warning is not present on Linux and I wonder whether sanity prevailed in that
> regard?

At that time I only looked at the functionality of your code, and was 
happy with what it did.
Which is still the case.

But I'm also trying to get as little warnings as possible, since that 
will new ones more outstanding.
And unused variables usually trigger my eye, because that is mostly 
caused by conditionals.
And I;ve already put in a large amount  FreeBSD depends, quite a few 
caused warnings and needed
some TLC.

I have no opinion as to the sanity of hte compiler makers, and 
where//what warnings they assert.

--WjW

>
> On Fri, Jul 21, 2017 at 7:04 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Op 20-7-2017 om 22:06 schreef Willem Jan Withagen:
>>>
>>>
>>> Op 20-7-2017 om 21:20 schreef Patrick Donnelly:
>>>> On Thu, Jul 20, 2017 at 7:02 AM, Willem Jan Withagen <wjw@digiware.nl>
>>>> wrote:
>>>>> Hi,
>>>>>
>>>>> I'm running in too many:
>>>>> /home/jenkins/workspace/ceph-master/src/test/bufferlist.cc:490:11:
>>>>> warning: unused variable 'unset_dumpable' [-Wunused-variable]
>>>>>       PrCtl unset_dumpable;
>>>>>             ^
>>>>>
>>>>> for it to be by accident??
>>>>> But why is this variable created in about a dozen functions?
>>>> AFAICT, the intent by Brad in aef2a7b6ac5d0dafdac16d0d4cef42056c07b5a6
>>>> is to prevent core dumps during the lifetime of certain objects. The
>>>> object is actually used indirectly via syscalls in its
>>>> constructo/destructor.
>>>>
>>>> Is there a nice way of silencing this warning for this code?
>>> I suspected as much as that.
>>>
>>> Likely there is a pragma that can be wrapped around the declaration.
>>> And then stick it in a macro, but I'm not sure that pragma will survice a
>>> macro.
>>
>> Pragmas could work, but sticking them in a macro for both GCC and Clang is a
>> real mess.
>> Doing a (void) trick seems a lot easier.
>>
>>      https://github.com/ceph/ceph/pull/16462
>>
>> --WjW
>
>

