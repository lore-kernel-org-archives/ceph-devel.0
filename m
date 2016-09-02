From: John Spray <jspray@redhat.com>
Subject: Re: Switching cephfs suites from btrfs to xfs
Date: Fri, 2 Sep 2016 12:10:55 +0100
Message-ID: <CALe9h7eZ_iqc-VkQSi0_s+Tw7FfyG6XT+N6S4VT1wJUacStnwA@mail.gmail.com>
References: <CALe9h7e7ePnRe+cmFO4DZTwCbJJErVbwpHH4YzGur9LtgxXHdg@mail.gmail.com>
 <alpine.DEB.2.11.1609011415390.19032@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:35706 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbcIBLLR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Sep 2016 07:11:17 -0400
Received: by mail-qt0-f176.google.com with SMTP id 93so56237020qtg.2
        for <ceph-devel@vger.kernel.org>; Fri, 02 Sep 2016 04:11:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1609011415390.19032@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Sep 1, 2016 at 3:16 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 1 Sep 2016, John Spray wrote:
>> Given our current push toward bluestore as the long term plan, I'm
>> wondering if anyone would object to me switching off the use of btrfs
>> in the CephFS test suites?
>
> Sounds good to me!

OK, just testing this now https://github.com/ceph/ceph-qa-suite/pull/1160

John

> sage
>
>> I think the motivation for this historically was to maximise coverage
>> of the FileStore pieces that XFS doesn't exercise, but that probably
>> matters less these days, and the (much larger) rados suite covers
>> btrfs.
>>
>> My motivation is to get rid of the intermittent assert(0 ==
>> "unexpected error") OSD crashes that crop up in our testing every once
>> in a while and are attributed to btrfs.
>>
>> Thoughts?
>>
>> John
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
