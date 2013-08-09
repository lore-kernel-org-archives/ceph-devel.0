From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [PATCH 0/2] Cleanup invalidate page
Date: Fri, 9 Aug 2013 15:51:52 -0400
Message-ID: <CANP1eJFRh-Y+G8JDA25d0DW+Cuwu0TAM3YJZ6eKOtTn7nXL-UA@mail.gmail.com>
References: <cover.1375686804.git.milosz@adfin.com>
	<alpine.DEB.2.00.1308091044000.12830@cobra.newdream.net>
	<CANP1eJEfZuO7cY25Rep+rv-mv89W61=cT=9y7xvhXLsL_h9=8A@mail.gmail.com>
	<alpine.DEB.2.00.1308091243200.14125@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:56255 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030920Ab3HITvx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Aug 2013 15:51:53 -0400
Received: by mail-wi0-f171.google.com with SMTP id hr7so82616wib.16
        for <ceph-devel@vger.kernel.org>; Fri, 09 Aug 2013 12:51:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1308091243200.14125@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Yan, Zheng" <zheng.z.yan@intel.com>

On Fri, Aug 9, 2013 at 3:44 PM, Sage Weil <sage@inktank.com> wrote:
> On Fri, 9 Aug 2013, Milosz Tanski wrote:
>> Sage,
>>
>> Great. Is there some automated testing system that looks for
>> regressions in cephfs that I can be watching for?
>
> Yep, you can join the ceph-qa@ceph.com email list and watch for the
> kcephfs suite results (see http://ceph.com/resources/mailing-list-irc/).

I'll brace my self for the spam.

>
> BTW I made a few tweaks to the second patch due to a conflict (added
> handling for the length arg to invalidatepage).

Thanks and sorry for the oversight.

Best,
 -Milosz

>
> Thanks!
> sage
>
>>
>> - Milosz
>>
>> On Fri, Aug 9, 2013 at 1:44 PM, Sage Weil <sage@inktank.com> wrote:
>> > Hi Milosz,
>> >
>> > I pulled both these into the testing branch.  Thanks!
>> >
>> > sage
>> >
>> > On Fri, 9 Aug 2013, Milosz Tanski wrote:
>> >
>> >> Currently ceph_invalidatepage has is overly eger with it's checks which are
>> >> moot. The second change cleans up the case where offset is non zero.
>> >>
>> >> Please pull the from:
>> >>   https://bitbucket.org/adfin/linux-fs.git wip-invalidatepage
>> >>
>> >> This simple patchset came from the changes I made while working on fscache
>> >> support for cephfs. Per Sage's request I split this up into smaller bites for
>> >> testing and review.
>> >>
>> >> Milosz Tanski (2):
>> >>   ceph: Remove bogus check in invalidatepage
>> >>   ceph: cleanup the logic in ceph_invalidatepage
>> >>
>> >>  fs/ceph/addr.c | 33 +++++++++++++++------------------
>> >>  1 file changed, 15 insertions(+), 18 deletions(-)
>> >>
>> >> --
>> >> 1.8.1.2
>> >>
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>
>> >>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
