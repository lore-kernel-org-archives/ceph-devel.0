From: Alyona Kiselyova <akiselyova@mirantis.com>
Subject: Re: data-at-rest compression
Date: Fri, 27 Nov 2015 17:40:04 +0300
Message-ID: <CAONhiy53c4+=dD2fnwgxan4Sz7FQ7i4Q1g=GtbF4FjCDC7VzvA@mail.gmail.com>
References: <5642115E.407@mirantis.com>
	<CAONhiy67Yd-7h6Ew9W+X3n3u6198A5Q58xZYRZ62-divm-78bA@mail.gmail.com>
	<alpine.DEB.2.00.1511130518160.7964@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36845 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbbK0OkH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Nov 2015 09:40:07 -0500
Received: by oiww189 with SMTP id w189so62713044oiw.3
        for <ceph-devel@vger.kernel.org>; Fri, 27 Nov 2015 06:40:05 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1511130518160.7964@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, kariraja@yahoo.com
Cc: Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi All,
I created a separate PR for common plugin interface, corresponding to
2 Sage's commits and one my bug fix commit:
https://github.com/ceph/ceph/pull/6696
Also I updated compression plugins commit with this patch:
https://github.com/ceph/ceph/pull/6361
Igor will wait to update his PR
(https://github.com/ceph/ceph/pull/6524) before we decide, how common
plugin mechanism will be merged, to avoid multiple refactoring.
So, please, take a look to my work, when you have some time.

Also I would like to propose erasure code refactoring via new plugin
mechanism. Please, let me know, if it's possible, if nobody work on it
and I can do it.
Thanks for reply.
-------------------------------
Best regards,
Alyona Kiseleva


On Fri, Nov 13, 2015 at 4:18 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 13 Nov 2015, Alyona Kiselyova wrote:
>> Hi,
>> I was working on pluggable compression interface in this work
>> (https://github.com/ceph/ceph/pull/6361). In Igor's pull request was
>> suggested to reuse  common plugin infrastructure from unmerged
>> wip-plugin branch. Now I'm working on adaptation of it, and as I see,
>> I need only this two commits from it
>> (https://github.com/ceph/ceph/commit/294bef3d12ec04d9febf1f850184be7653a4322cand
>> https://github.com/ceph/ceph/commit/18ad8df1094db52c839dc6b2dc689fc882230acb).
>> Sage, is it possible to make standalone pull request with them, or I
>> must just to cherry pick them in my branch?
>
> Let's do a separate PR.
>
> Thanks!
> sage
>
>
>> Thanks for answer.
>> -------------------------------
>> Best regards,
>> Alyona Kiseleva
>>
>>
>> On Tue, Nov 10, 2015 at 6:46 PM, Igor Fedotov <ifedotov@mirantis.com> wrote:
>> > Hi All,
>> >
>> > a while ago we had some conversations here about adding compression support
>> > for EC pools.
>> > Here is corresponding pull request implementing this feature:
>> >
>> > https://github.com/ceph/ceph/pull/6524/commits
>> >
>> > Appropriate blueprint is at:
>> > http://tracker.ceph.com/projects/ceph/wiki/Rados_-_at-rest_compression
>> >
>> > All comments and reviews are highly appreciated.
>> >
>> > Thanks,
>> > Igor.
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
