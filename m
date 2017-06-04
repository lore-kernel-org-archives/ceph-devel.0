From: kefu chai <tchaikov@gmail.com>
Subject: Re: VLA detection ...
Date: Sun, 4 Jun 2017 18:58:13 +0800
Message-ID: <CAJE9aOPnYF6xbyzdM9ZNUpqw1rX3frQ_BXkF0-z6o=45Rq+COg@mail.gmail.com>
References: <174f417f-02f5-beb1-0f8b-96ff4a70349b@digiware.nl>
 <CAJE9aONhiWL+gHMKaeeg95mnSpua+DeDbArks+O=okKDh3k=YQ@mail.gmail.com> <5b4dd43f-5e9f-ca46-2448-8147a1615921@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:32976 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbdFDK6O (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Jun 2017 06:58:14 -0400
Received: by mail-vk0-f51.google.com with SMTP id p62so20949710vkp.0
        for <ceph-devel@vger.kernel.org>; Sun, 04 Jun 2017 03:58:14 -0700 (PDT)
In-Reply-To: <5b4dd43f-5e9f-ca46-2448-8147a1615921@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Jesse Williamson <jwilliamson@suse.de>, Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Jun 4, 2017 at 4:29 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 04/06/2017 05:28, kefu chai wrote:
>> On Sat, Jun 3, 2017 at 2:50 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> Hi,
>>>
>>> Now that we have -Wvla set:
>>> ===
>>>     Adds C++ warning flag for C Variable-Length Arrays.
>>>
>>>     C VLAs are not supported in C++. However, the GNU compiler allows
>>>     them as an extension, which it does not warn about when not in
>>>     pedantic mode. Unfortunately, it's easy to accidentally write
>>>     a VLA, even unintentionally-- adding this warning will help us
>>>     catch that.
>>> ===
>>>
>>> Are there going to be attempts to eradicate this usage?
>>> Note that Clang also supports VLAs:
>>> ===
>>> GCC and C99 allow an array's size to be determined at run time. This
>>> extension is not permitted in standard C++. However, Clang supports such
>>> variable length arrays for compatibility with GNU C and C99 programs.
>>> ===
>>>
>>
>> it's not in C++11 standard. but it's a handy feature in practice. i
>> still have trouble understanding we want to have -Wvla. i was trying
>> to silence this warning option last night but failed to move further
>> after several attempts. see https://github.com/ceph/ceph/pull/15441.
>>
>> probably, Jesse have more insights on this.
>
> It starts with old discussions from before 2009, and it would be hard
> for compiler makers to actually build it.

i am confused. as long as GCC and Clang claim to support a feature, we
should be able to it unless we have other concerns like portability or
performance. what we should be concerned is build-time and run-time
performance of ceph, not how hard this was implemented by GCC or Clang
folks, right?

>
> Both GCC and Clang support it.
>
> And next the major complaint I find about it, is that these structures
> are build on the stack, which might cause stackoverlows (and that mostly
> on embedded computers) That would be something for programmers to be
> aware of.

it does. but i think this is why i like it. it avoid the overhead of
heap allocation. agreed. but if it's a bug, then we need to fix it
instead of using a slower replacement. for example, if we allocate a
buffer of 25MB on stack, we should probably just crash. the existing
std::vector or boost::container::small_vector does not do this for us.

>
> And C++ has other stuctures to implement these.
> But as you tried, it is nog going to be easy.
>
> I would probably think there are beter things to do, than to chase after
> this. And IMHO the order should have been: Fix the VLAs and only then
> turn the warning on on the master repo. As to not have every body start

again, agreed.

> looking at these warning that have just started to pop up. But perhaps
> that is just me, because each and every warning is again a case where I
> need to look for possible incompatabilities.

these warnings trouble me also.

>
>
> --WjW



-- 
Regards
Kefu Chai
