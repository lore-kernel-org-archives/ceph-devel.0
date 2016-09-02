From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Switching cephfs suites from btrfs to xfs
Date: Fri, 2 Sep 2016 11:57:44 +0200
Message-ID: <763a5969-16b6-dc99-b2ee-0bc2c11aa85e@digiware.nl>
References: <CALe9h7e7ePnRe+cmFO4DZTwCbJJErVbwpHH4YzGur9LtgxXHdg@mail.gmail.com>
 <CA+2bHPZi87JdOVRUDgXjJQE6836zp16us2a+DVU-upWt6B0FLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:24719 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752856AbcIBJ57 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Sep 2016 05:57:59 -0400
In-Reply-To: <CA+2bHPZi87JdOVRUDgXjJQE6836zp16us2a+DVU-upWt6B0FLA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>, John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 2-9-2016 02:51, Patrick Donnelly wrote:
> On Thu, Sep 1, 2016 at 6:33 AM, John Spray <jspray@redhat.com> wrote:
>> Given our current push toward bluestore as the long term plan, I'm
>> wondering if anyone would object to me switching off the use of btrfs
>> in the CephFS test suites?
>>
>> I think the motivation for this historically was to maximise coverage
>> of the FileStore pieces that XFS doesn't exercise, but that probably
>> matters less these days, and the (much larger) rados suite covers
>> btrfs.
>>
>> My motivation is to get rid of the intermittent assert(0 ==
>> "unexpected error") OSD crashes that crop up in our testing every once
>> in a while and are attributed to btrfs.
> 
> I like the idea. +1

It his means that a lot of the shell code I excluded for FreeBSD, then
I'm all for it. :)

--WjW


