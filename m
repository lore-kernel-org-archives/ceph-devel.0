From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: increasingly large packages and longer build times
Date: Tue, 8 Aug 2017 09:29:07 +0200
Message-ID: <84ed9046-2bd8-d798-a7bc-0e5fe7009b1e@digiware.nl>
References: <CAC-Np1yg062K==JMEQhRTVKRe7orS3YoXz9hcgfKH+xfiZBiww@mail.gmail.com>
 <CALqRxCzmEN0UUD5iGcDw+iSp8+=cBmJpVa2Z=27fyVD_RWzRmw@mail.gmail.com>
 <1a1057ce-581f-8fe5-b474-d41e75c2f56a@digiware.nl>
 <20170808065906.luvs5b3xmlzfg7we@nora.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:22631 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750818AbdHHHt6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 8 Aug 2017 03:49:58 -0400
In-Reply-To: <20170808065906.luvs5b3xmlzfg7we@nora.maurer-it.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Fabian_Gr=c3=bcnbichler?= <f.gruenbichler@proxmox.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 8-8-2017 08:59, Fabian Grünbichler wrote:
> On Mon, Aug 07, 2017 at 05:30:06PM +0200, Willem Jan Withagen wrote:
>> On 7-8-2017 16:58, Ken Dreyer wrote:
>>> On Wed, Aug 2, 2017 at 7:39 AM, Alfredo Deza <adeza@redhat.com> wrote:
>>>> The ceph-debuginfo package has continued to increase in size on almost
>>>> every release, reaching 1.5GB for the latest luminous RC (12.1.2).
>>>>
>>>> To contrast that, the latest ceph-debuginfo in Hammer was about 0.73GB.
>>>>
>>>> Having packages that large is problematic on a few fronts:
>>>
>>> I agree Alfredo. Here's a similar issue I am experiencing with the source sizes:
>>>
>>> Jewel sizes:
>>>   14M ceph-10.2.7.tar.gz
>>>   82M ceph-10.2.7 uncompressed
>>>
>>> Luminous sizes:
>>>   142M ceph-12.1.2.tar.gz
>>>   709M ceph-12.1.2  uncompressed
>>
>> I'm on that same page.
>>
> 
> +1 (Proxmox VE, also building downstream packages)
> 
> Boost seems to be by far the biggest culprit - we initially built our
> packages using the system boost option to save some space, but this
> broke one time too often and we are now also shuffling tons of data
> around for every version bump.

I have not (yet) run into that problem.
Perhaps because the package-maintainer for FreeBSD does a good job.

Next question would be the install location for libboost stuff. Because
it needs to be out of the way for the regular boost stuff. But then
linking any Ceph code would again require extra TLC to start using the
correct libs.
Until now I did not really think of it, but rocksdb is statically linked
and that is the reason why it does not cause this kind to challenge.
But static linking only bloats codesize even more.

--WjW
