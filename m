From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: async messenger --debug-ms=1 too verbose?
Date: Thu, 22 Sep 2016 19:45:13 +0200
Message-ID: <0678ba93-30ee-d1d5-4c15-3547cd1b4a90@digiware.nl>
References: <CALe9h7cUtAL7Rw5r01=d=KXwmG_Fwc-ULjKBuY1NUsHyKSijcw@mail.gmail.com>
 <CAN=+7FXv2JMxO3Y1haFxZamL-hGAkpnafAi-KrXsEdbYL1Fadw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:25980 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966371AbcIVRpX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Sep 2016 13:45:23 -0400
In-Reply-To: <CAN=+7FXv2JMxO3Y1haFxZamL-hGAkpnafAi-KrXsEdbYL1Fadw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>, John Spray <jspray@redhat.com>, "Wang, Haomai" <haomaiwang@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 22-9-2016 19:40, Samuel Just wrote:
> I hadn't noticed, but I think the convention of having debug ms = 1
> print outgoing and incoming messages only is probably the right thing.
> -Sam
> 
> On Thu, Sep 22, 2016 at 10:31 AM, John Spray <jspray@redhat.com> wrote:
>> Hi all,
>>
>> Minor thing, I'm finding --debug-ms=1 harder to read with my squishy
>> mammal brain since we switched to async messenger (comparison here:
>> http://pastebin.com/LcG2Z91m).  There is just more noise in the screen
>> now and it's harder to read as a list of messages.
>>
>> Any thoughts?  Was it kind of accidental or is there a strong need for
>> the extra stuff?

Yes please,

it is swamping my screen with messages that events are executed without
much other info. I've put that at level 15 or 20, so as not te generate
lots of spam during testing of my async tests.

--WjW


