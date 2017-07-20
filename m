From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: unset_dumpable
Date: Fri, 21 Jul 2017 08:39:32 +1000
Message-ID: <CAF-wwdGNs7Zqd9y3hE6PP=T2aDrESZmkR0KGRbkNVsbCTAYdiQ@mail.gmail.com>
References: <a7cd6c1f-93f7-e652-68ff-bdfc89ff20c1@digiware.nl>
 <CA+2bHPb-=nhakBXwfhxjMpBmRJJmUqUgEPnCO44Z_3RcVwUM4Q@mail.gmail.com>
 <b6e4fd6e-d38a-219b-df89-b500ec63692d@digiware.nl>
 <24961618-3abf-08c5-e134-1f58b85f0b96@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35958 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965282AbdGTWjj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jul 2017 18:39:39 -0400
Received: by mail-pf0-f177.google.com with SMTP id o88so16985702pfk.3
        for <ceph-devel@vger.kernel.org>; Thu, 20 Jul 2017 15:39:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <24961618-3abf-08c5-e134-1f58b85f0b96@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

When implemented it was generally though to be OK by reviewers, including yourself.

https://github.com/ceph/ceph/pull/14821

Can I asked what changed to make it an issue now? Has there been some recent
change in compilers on FreeBSD to make this an issue? It's a valid use of RAII
in my humble opinion although it *appears* to be an unused variable. Odd this
warning is not present on Linux and I wonder whether sanity prevailed in that
regard?

On Fri, Jul 21, 2017 at 7:04 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Op 20-7-2017 om 22:06 schreef Willem Jan Withagen:
>>
>>
>>
>> Op 20-7-2017 om 21:20 schreef Patrick Donnelly:
>>>
>>> On Thu, Jul 20, 2017 at 7:02 AM, Willem Jan Withagen <wjw@digiware.nl>
>>> wrote:
>>>>
>>>> Hi,
>>>>
>>>> I'm running in too many:
>>>> /home/jenkins/workspace/ceph-master/src/test/bufferlist.cc:490:11:
>>>> warning: unused variable 'unset_dumpable' [-Wunused-variable]
>>>>      PrCtl unset_dumpable;
>>>>            ^
>>>>
>>>> for it to be by accident??
>>>> But why is this variable created in about a dozen functions?
>>>
>>> AFAICT, the intent by Brad in aef2a7b6ac5d0dafdac16d0d4cef42056c07b5a6
>>> is to prevent core dumps during the lifetime of certain objects. The
>>> object is actually used indirectly via syscalls in its
>>> constructo/destructor.
>>>
>>> Is there a nice way of silencing this warning for this code?
>>
>> I suspected as much as that.
>>
>> Likely there is a pragma that can be wrapped around the declaration.
>> And then stick it in a macro, but I'm not sure that pragma will survice a
>> macro.
>
>
> Pragmas could work, but sticking them in a macro for both GCC and Clang is a
> real mess.
> Doing a (void) trick seems a lot easier.
>
>     https://github.com/ceph/ceph/pull/16462
>
> --WjW



-- 
Cheers,
Brad
