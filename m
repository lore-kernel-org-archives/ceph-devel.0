From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Assertion failed while buildign manpages
Date: Tue, 5 Dec 2017 13:48:10 +0100
Message-ID: <206aa921-d233-652a-1cf8-717ddf51add9@digiware.nl>
References: <6899bf17-d2cd-8088-97fe-0a23d001b6dc@digiware.nl>
 <CAC-Np1ynKuTVNqKncyPDHctSK88=7wXadSDb=wtaDRrbqNrPSw@mail.gmail.com>
 <e5fcda3e-b57a-e7d0-b94e-e3c81c89e799@digiware.nl>
 <CAC-Np1zj8s0pDFYb1CUm_S4JEnsZ6fWuysYotZPJfMXgTgdNJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:20176 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752149AbdLEMsO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 5 Dec 2017 07:48:14 -0500
In-Reply-To: <CAC-Np1zj8s0pDFYb1CUm_S4JEnsZ6fWuysYotZPJfMXgTgdNJw@mail.gmail.com>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 5-12-2017 13:32, Alfredo Deza wrote:
> On Tue, Dec 5, 2017 at 4:14 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> On 04/12/2017 21:31, Alfredo Deza wrote:
>>>
>>> On Mon, Dec 4, 2017 at 3:22 PM, Willem Jan Withagen <wjw@digiware.nl>
>>> wrote:
>>>>
>>>> Hi
>>>>
>>>> My FreeBSD-Jenkins complains about a failed assertion, but I'm blissfully
>>>> ignorant in this matter.
>>>> So perhaps somebody has hints to fix this.
>>>
>>>
>>> This looks pretty obscure, but the one thing I see different is that
>>> you are using a version of Sphinx that we don't
>>>
>>> We are pinned to 1.6.3 currently.
>>>
>>> The ceph-syn man page hasn't changed in a while, so maybe try bumping
>>> Sphinx?
>>
>>
>> I pinged the port-owner, and he is working on an update. But since lots of
>> packages depend on sphinx for the man-pages, other things need to be fixed
>> as well since it breaks building lots of other stuff.
>>
>> But it is the works, so for now I'll run Jenkins without building the
>> manpages.
> 
> This turned out to be a problem introduced by my change updating the
> title on ceph-disk's man page:
> 
> https://github.com/ceph/ceph/pull/19241/commits/bd00560c20caeeb1ded211cb81533280338014d1
> 
> This has since been reverted with
> https://github.com/ceph/ceph/pull/19325 and all builds are now passing
> 
> Plain asserts in Python aren't a good way to report errors, so it was
> very difficult to identify what made this break.

Hi Alfredo,

Right, I'll enable manapages again. And we'll see in the next build.

Thanx for the update,
--WjW
