From: Two Spirit <twospirit6905@gmail.com>
Subject: Re: which mds server is damaged?
Date: Thu, 14 Sep 2017 15:04:15 -0700
Message-ID: <CAKRxputojyrjjarPVwspCqhJQvOCgfhVrnGZJf+7Vq6VhbUnnw@mail.gmail.com>
References: <CAKRxpus_QKHx=Wi8UU-g50i8g3nkEKdg2mGVcu_uO5FbAoHHFA@mail.gmail.com>
 <CALe9h7fhfWQ1paK7TpCMVv+FA0Ta4_5X5FGWdWdgwyLjDmZxgA@mail.gmail.com>
 <CAKRxpuurKQp6vQmt2_mc5ckHZMjHajnivDob58eMpcUXodOupw@mail.gmail.com> <alpine.DEB.2.11.1709142134130.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:53931 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbdINWEQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Sep 2017 18:04:16 -0400
Received: by mail-io0-f169.google.com with SMTP id q11so4065291ioe.10
        for <ceph-devel@vger.kernel.org>; Thu, 14 Sep 2017 15:04:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1709142134130.16664@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

> Can you tell us more than "it went degraded"?  It's hard to know what
you're seeing.

Sorry, I only know of two states for the cephfs. Either it is not
complaining or it is spitting out a "     1 filesystem is degraded"
message.  When I saw that, I meant that based on what I read in 'ceph
-s'. Usually the symptom is I can't mount/access the files, but I've
also had that symptom without the degraded message, but usually traced
down to my fault.

ceph is still too new for me to debug much further.

I'd like to explain the testing scenario related to that in more
details if your interested.. I'm off to a meeting soon, can  email
more on this later.


On Thu, Sep 14, 2017 at 2:37 PM, Sage Weil <sweil@redhat.com> wrote:
> On Thu, 14 Sep 2017, Two Spirit wrote:
>> >The thing that's damaged is a logical mds rank (0), not a physical MDS
>> >daemon.  What this is telling you is that there is some serious
>> >corruption in your metadata pool that prevents that particular rank
>> >from starting.
>>
>> Zhang helped identify the bug and put it in tracker. I didn't fully
>> understand the problem but related to mds replay not happening and the
>> write_pos being off. He fixed it after a full scrub was done, the
>> degraded file system came back online. After a couple more hours of
>> stress testing, the file system went back to degraded(earlier today).
>
> Can you tell us more than "it went degraded"?  It's hard to know what
> you're seeing.
>
> More generally, can you share what you did with the system that originally
> triggered the unfound object?  It ordinarily requires a sequence of
> multiple not-quite-concurrent failures to induce that state, and we don't
> see it much.  I'm surprised you're hitting it right off the bat.
>
> Thanks!
> sage
