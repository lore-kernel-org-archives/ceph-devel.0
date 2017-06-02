From: Aaron Ten Clay <aarontc@aarontc.com>
Subject: Re: [ceph-users] Extremely high OSD memory utilization on Kraken
 11.2.0 (with XFS -or- bluestore)
Date: Fri, 2 Jun 2017 14:56:55 -0700
Message-ID: <CAFFcurpFgvo4em=a4D27xtcszeib4Zsw6VM3oq3_0H8Xis8-Pw@mail.gmail.com>
References: <CAFFcurqEctQ2fHHDcGYfy3YCuaq9DxZr0VU4e8dNVACNVLDmqA@mail.gmail.com>
 <alpine.DEB.2.11.1704171457320.10661@piezo.novalocal> <CAFFcurrA8BKF0a+9gdGAsTDbE78ci9X8dwEaWEycoF4DNQN8uw@mail.gmail.com>
 <CAFFcuroumvWGZA+KC4V7wOiF9T0y7k9v+Ms=GgOh+bGm8gP__g@mail.gmail.com>
 <alpine.DEB.2.11.1705042124210.3646@piezo.novalocal> <CAFFcuroCpM7GGdsfcpNEvLQAsWEWqUbnPfP1FmZxq_-DyjgQeA@mail.gmail.com>
 <alpine.DEB.2.11.1705160133070.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35754 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbdFBV5B (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jun 2017 17:57:01 -0400
Received: by mail-oi0-f51.google.com with SMTP id l18so107435813oig.2
        for <ceph-devel@vger.kernel.org>; Fri, 02 Jun 2017 14:57:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1705160133070.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mon, May 15, 2017 at 6:35 PM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 15 May 2017, Aaron Ten Clay wrote:
>> Hi Sage,
>>
>> No problem. I thought this would take a lot longer to resolve so I
>> waited to find a good chunk of time, then it only took a few minutes!
>>
>> Here are the respective backtrace outputs from gdb:
>>
>> https://aarontc.com/ceph/dumps/core.ceph-osd.150.082e9ca887c34cfbab183366a214a84c.6742.1492634493000000000000.backtrace.txt
>> https://aarontc.com/ceph/dumps/core.ceph-osd.150.082e9ca887c34cfbab183366a214a84c.7202.1492634508000000000000.backtrace.txt
>
> Looks like it's in BlueFS replay.  Can you reproduce with 'log max recent
> = 1' and 'debug bluefs = 20'?
>
> It's weird... the symptom is eating RAM, but it's hitting an assert during
> relay on mount...
>
> Thanks!
> sage
>

Sage:

Here's the log from osd.1: https://aarontc.com/ceph/ceph-osd.1.log.bz2

I'm not entirely sure the issue was reproduced. The symptom of running
away with all the RAM still happens, but there is so much in this log
I'm not sure if it has what you're looking for.

-Aaron
