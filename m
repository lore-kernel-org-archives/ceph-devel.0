From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: use ceph-ci.git to get repositories out of dev branches
Date: Mon, 12 Dec 2016 21:06:07 +0100
Message-ID: <e8bc131d-4df5-fb33-6295-14406a6263c4@digiware.nl>
References: <CAC-Np1y=2DY7Rve+ao73i7EtKrFY1K_jnDR86Yhhgt9XF7gsQw@mail.gmail.com>
 <CAC-Np1wgRYptDTeF7=MSmWMW1B1tP_=RNp8EtTGkSy+ZqrP-rA@mail.gmail.com>
 <fb0b5283-d482-629d-31ee-ddf1ef651455@digiware.nl>
 <CALe9h7eXcGtFNtCZT8ZG-v3hKgAVYS5mQGnUAjVLejtXMt1d1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:60217 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752165AbcLLUGN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Dec 2016 15:06:13 -0500
In-Reply-To: <CALe9h7eXcGtFNtCZT8ZG-v3hKgAVYS5mQGnUAjVLejtXMt1d1Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Andrew Schoen <aschoen@redhat.com>

On 12-12-2016 20:54, John Spray wrote:
> On Mon, Dec 12, 2016 at 7:44 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> On 12-12-2016 13:48, Alfredo Deza wrote:
>>> **REMINDER**
>>>
>>> Please, push development branches to ceph-ci.git to get
>>> repositories/binaries built.
>>>
>>> We are scheduled to restrict permissions to ceph.git in a few days.
>>>
>>> Thanks!
>>>
>>> On Wed, Dec 7, 2016 at 7:34 AM, Alfredo Deza <adeza@redhat.com> wrote:
>>>> As announced on November 23rd, please start pushing development
>>>> branches to ceph-ci.git (https://github.com/ceph/ceph-ci) to get
>>>> repositories.
>>>>
>>>> This doesn't change reporting in https://shaman.ceph.com and it
>>>> shouldn't affect testing via teuthology.
>>>>
>>>> The ceph.git repository will continue to build binaries and
>>>> repositories for another week to help transitioning.
>>>>
>>>> If you have any issues, please mention them in the #sepia or
>>>> #ceph-devel channels to me (alfredodeza) or Andrew Schoen
>>>> (andrewschoen).
>>
>> Hi Alfredo,
>>
>> Not being a native git-citizen, this is perhaps a bit to cryptic for me.
>>
>> So instead of makeing PRs in my ceph-fork, I should
>>         fork ceph-ci
>>         new PRs should be submitted from this fork against ceph-ci.
>> ??
>>
>> Any suggestions on how to migrate my current ceph-fork to a
>> ceph-ci-fork? Or am I going to "lose" all my changes in the log of the
>> current, and transfer the changes thru diff/patch..
> 
> Don't worry, if you are just opening pull requests then none of this
> affects you.
> 
> The change is that when we wanted to build branches for testing, we
> pushed them to ceph.git.  Now we push things that we want to build to
> ceph-ci.git.  Pull requests are still opened against ceph.git.

Ah, oke,

I'm going back into relaxed hacking mode.

Thnx,
--WjW


