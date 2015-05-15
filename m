From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: master vs. next
Date: Fri, 15 May 2015 13:45:06 +0300
Message-ID: <CAOi1vP_PPrMDE9o2Ai78sepPJf6ZH+99UVkiMAkiVMqemwEp3w@mail.gmail.com>
References: <5555B1E9.3010003@suse.cz>
	<CAOi1vP8tCszV-QJO+o-ab8i76qzw1b4sj6FWHgPk6KfVPuvZhQ@mail.gmail.com>
	<5555C495.8030804@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:32805 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678AbbEOKpH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 May 2015 06:45:07 -0400
Received: by wicmx19 with SMTP id mx19so35877985wic.0
        for <ceph-devel@vger.kernel.org>; Fri, 15 May 2015 03:45:06 -0700 (PDT)
In-Reply-To: <5555C495.8030804@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Nathan Cutler <ncutler@suse.cz>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, May 15, 2015 at 1:04 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 15/05/2015 11:48, Ilya Dryomov wrote:
>> On Fri, May 15, 2015 at 11:44 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>>> I'm a newcomer to the ceph project. SubmittingPatches says to target
>>> next for bugfixes and master for features. Beyond that I only have the
>>> vaguest notion of what the next branch is for and how patches get moved
>>> back and forth between master and next. Can anyone comment?
>>
>> next is development release branch (while firefly, hammer, etc are
>> stable release branches).  Bugfix PRs are submitted against next, next
>> is periodically merged into master.  In fact anybody can merge next
>> into master at any time to get the fix merged into next in master.
>> (Not the other way around - fixes are not supposed to go into master and
>> then be cherry-picked into next.)  After the development release is
>> cut, next is reset to master.
>>
>> I'm sure others will correct me if I missed something.
>
> I've always targeted commits to master (although I should have used next instead). The only downside of doing that is that my commit will only be in the +2 development version, or is there another inconvenience ?

For regular commits (features, enhancements, cleanups, etc) you should
target master, as you always have.  The fact that those commits don't
show up in any release right away is a pretty much a feature ;)

If you need to fix something that is broken in next, then you target
next.  I'm sure sometimes on an ad-hoc basis commits are cherry-picked
from master into next or even go directly into next to expedite things,
but that's rare and not something a newcomer should be concerned about.

That's my understanding - I suspect you, given your involvement into
backporting efforts, know more about this than I do.

Thanks,

                Ilya
