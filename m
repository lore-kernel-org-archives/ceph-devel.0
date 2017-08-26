From: Oleg Kolosov <olekol@gmail.com>
Subject: Re: Matching shard to crush bucket in erasure coding
Date: Sat, 26 Aug 2017 20:16:30 +0300
Message-ID: <CAODUPsFoqad6x20bVFjEOuPdhkvOQLCmK64hOYochOjboMCqDg@mail.gmail.com>
References: <CAODUPsG=wnHdROuNvvCcxeDtahG2V2C24ttEETJtebCGnx6C8Q@mail.gmail.com>
 <alpine.DEB.2.11.1708231400590.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:32856 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbdHZRQc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Aug 2017 13:16:32 -0400
Received: by mail-oi0-f54.google.com with SMTP id r203so16271579oih.0
        for <ceph-devel@vger.kernel.org>; Sat, 26 Aug 2017 10:16:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1708231400590.20435@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,
Thanks for the answer, it has helped me a lot.

Regards,
Oleg

On Wed, Aug 23, 2017 at 5:04 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 22 Aug 2017, Oleg Kolosov wrote:
>> Hi
>> I'm working on a new erasure code, different than the one implemented
>> in ceph lrc plugin. I'm trying to understand how ceph lrc plugin
>> allocates shards in a layer, but it's not clear from the code.
>>
>> For example, say I have a local group containing shards 0,1,2,5
>> While 0,1,2 are data and 5 is parity. I'd like to place all of these
>> shards in the same rack.
>>
>> Where in lrc .cc code  these shards, which are composing a single
>> layer, are allocated to the same rack?
>
> The EC code has to be carefully matched with a CRUSH rule that lays things
> out properly.  This is the reason that the EC crush rules are tied
> to the erasure code profiles and the plugin handles rule creation.
>
> In the LRC case, you have a rule like
>
>  take root
>  choose 3 rack
>  choose 5 osd
>
> to get a set of 15 shards, in groups of 5.  The LRC plugin has some logic
> to put the original data shards in the first 3 or 4 shards of each of
> those sets of 5, and the parity blocks in the remaing slots.  You'll want
> to do something similar.  Bonus points if you can reuse the scheme that
> LRC uses...
>
> sage
