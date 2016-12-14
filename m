From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: Is Hammer end of life now?
Date: Tue, 13 Dec 2016 17:45:11 -0800
Message-ID: <CADRKj5TNf7uKq+de3arRP3iFOaenE6k5yrhZ4HnY8CH0OkZn8A@mail.gmail.com>
References: <CALqRxCxMvAZTgA5sO4cJzFhzVjL=0xYnXrLO2n57VZf21R3b9Q@mail.gmail.com>
 <71343bb5-fb1f-a389-3e8c-bbb38a42496e@suse.cz> <CADRKj5SJ4C57HSG4Ys3eC0LUWGXid=E7oCGRNjbsV0pKaaT3Eg@mail.gmail.com>
 <32f8de21-677f-812f-dfae-3dc4b4ebb42b@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35694 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbcLNBxt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2016 20:53:49 -0500
Received: by mail-vk0-f45.google.com with SMTP id w194so7623650vkw.2
        for <ceph-devel@vger.kernel.org>; Tue, 13 Dec 2016 17:53:48 -0800 (PST)
In-Reply-To: <32f8de21-677f-812f-dfae-3dc4b4ebb42b@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Dec 13, 2016 at 12:31 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hi Yehuda:
>
>> Need to have 18187 and 17985 backported.
>
>
> Both of those are already staged. I will schedule another round of tests
> today.
>
> I see you marked http://tracker.ceph.com/issues/16122 for backport to
> hammer. I gave it a try, but it is beyond my capabilities. Depending on if
> this backport is a "must-have" or a "nice-to-have", either someone other
> than me would have to do it or we could just omit it.
>

We'd still want to see it in, so maybe someone else can pick it up.

Thanks,
Yehuda
