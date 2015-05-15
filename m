From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: master vs. next
Date: Fri, 15 May 2015 14:40:32 +0300
Message-ID: <CAOi1vP8qab5_4t8gqMpME6XCKEC6NNMCnt_XG2XH+SUSbbDv-w@mail.gmail.com>
References: <5555B1E9.3010003@suse.cz>
	<CAOi1vP8tCszV-QJO+o-ab8i76qzw1b4sj6FWHgPk6KfVPuvZhQ@mail.gmail.com>
	<5555C495.8030804@dachary.org>
	<CAOi1vP_PPrMDE9o2Ai78sepPJf6ZH+99UVkiMAkiVMqemwEp3w@mail.gmail.com>
	<5555D53D.7070400@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38307 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933874AbbEOLke (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 May 2015 07:40:34 -0400
Received: by wicnf17 with SMTP id nf17so133552658wic.1
        for <ceph-devel@vger.kernel.org>; Fri, 15 May 2015 04:40:32 -0700 (PDT)
In-Reply-To: <5555D53D.7070400@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, May 15, 2015 at 2:15 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> On 2015-05-15 12:45, Ilya Dryomov wrote:
>> If you need to fix something that is broken in next, then you target
>> next.  I'm sure sometimes on an ad-hoc basis commits are cherry-picked
>> from master into next or even go directly into next to expedite things,
>> but that's rare and not something a newcomer should be concerned about.
>
> SubmittingPatches says to target next for bugfixes. So far I have only
> been pushing bugfixes, so I have been targeting that branch. And when
> the patch is merged, it goes directly into next. So I don't understand

That's what the first sentence in the paragraph you quoted says.

> why you say that's rare and not something I should be concerned about?

Here I was referring to when something that isn't strictly a bugfix
goes to next or when something goes to master intentionally or by
mistake and then cherry-picked into next by Sage or others after
discussion.  The point I was trying to make is that *that* is something
out of the ordinary and hence something that newcomers don't have to
worry about so much.

Thanks,

                Ilya
