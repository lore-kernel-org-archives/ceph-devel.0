From: Samuel Just <sjust@redhat.com>
Subject: Re: async messenger --debug-ms=1 too verbose?
Date: Thu, 22 Sep 2016 10:55:07 -0700
Message-ID: <CAN=+7FVsPTKUfLTcmkGS2HDdFfk+jNmF1yTyp4PDdedaqfuoDA@mail.gmail.com>
References: <CALe9h7cUtAL7Rw5r01=d=KXwmG_Fwc-ULjKBuY1NUsHyKSijcw@mail.gmail.com>
 <CAN=+7FXv2JMxO3Y1haFxZamL-hGAkpnafAi-KrXsEdbYL1Fadw@mail.gmail.com> <0678ba93-30ee-d1d5-4c15-3547cd1b4a90@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:36233 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034193AbcIVRzJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Sep 2016 13:55:09 -0400
Received: by mail-qt0-f177.google.com with SMTP id l91so41375150qte.3
        for <ceph-devel@vger.kernel.org>; Thu, 22 Sep 2016 10:55:08 -0700 (PDT)
In-Reply-To: <0678ba93-30ee-d1d5-4c15-3547cd1b4a90@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: John Spray <jspray@redhat.com>, "Wang, Haomai" <haomaiwang@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

I'm confused, debug ms = 15 or 20 would increase the amount of output...
-Sam

On Thu, Sep 22, 2016 at 10:45 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 22-9-2016 19:40, Samuel Just wrote:
>> I hadn't noticed, but I think the convention of having debug ms = 1
>> print outgoing and incoming messages only is probably the right thing.
>> -Sam
>>
>> On Thu, Sep 22, 2016 at 10:31 AM, John Spray <jspray@redhat.com> wrote:
>>> Hi all,
>>>
>>> Minor thing, I'm finding --debug-ms=1 harder to read with my squishy
>>> mammal brain since we switched to async messenger (comparison here:
>>> http://pastebin.com/LcG2Z91m).  There is just more noise in the screen
>>> now and it's harder to read as a list of messages.
>>>
>>> Any thoughts?  Was it kind of accidental or is there a strong need for
>>> the extra stuff?
>
> Yes please,
>
> it is swamping my screen with messages that events are executed without
> much other info. I've put that at level 15 or 20, so as not te generate
> lots of spam during testing of my async tests.
>
> --WjW
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
