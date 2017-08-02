From: Oleg Kolosov <olekol@gmail.com>
Subject: Re: Rados bench with a failed node
Date: Wed, 2 Aug 2017 11:54:13 +0300
Message-ID: <CAODUPsGuq4o7PtH4JuHBPPLk70NkzHRNGpvEQwZYraZwmPT3Cg@mail.gmail.com>
References: <CAODUPsHkC153vq5O7TKjt+ZTgMofsyR7m7hdKdi2ASbKTMWpRg@mail.gmail.com>
 <alpine.DEB.2.11.1708011319590.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34748 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752754AbdHBIyO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Aug 2017 04:54:14 -0400
Received: by mail-oi0-f54.google.com with SMTP id x3so38604574oia.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Aug 2017 01:54:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1708011319590.20435@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,
You are correct! The problem is indeed only for my erasure code,
however I'm not sure what it is.
I've reproduced the issue in the virtual cluster created by vstart.sh
 (logging enabled)
I've compared the logs of all OSDs with my erasure code versus a
similar implementation of lrc - however there were no visible
differences.
Any tips on what should I look for?
What might affect this in erasure code source code?

Another iteresting thing I'm seeing is that even cleanup fails:

>  bin/rados -p optlrcpool cleanup
error during cleanup: -5
error 5: (5) Input/output error

This only occurs when I set 'noout' & stop and osd and then write and
read with the benchmark.


I should mentioned that my erasure code works properly besides this
experiment. It manages to recover from a failed node during normal
mode of operation.

Thanks,
Oleg

On Tue, Aug 1, 2017 at 4:21 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 1 Aug 2017, Oleg Kolosov wrote:
>> Hi
>> I'm developing my own erasure code and I'm trying to run rados
>> benchmark on it. My experiment consists of writing objects, then while
>> reading them I stop an OSD and see how it affects latency.
>> While running this experiment with 'rados bench' I get an error after
>> stopping the osd:
>>
>> benchmark_data_adm-1_3806_object8 is not correct!
>> read got -5
>> error during benchmark: -5
>> error 5: (5) Input/output error
>>
>> Is it expected to fail like this?
>
> It's hard to say what's happening without logs, but my guess would be that
> your erasure code isn't correctly reconstructing the stripe when a
> shard is missing.
>
>> Is there a way to bypass it or somehow perform my experiment?
>
> If it's what I'm guessing, not really... nor would you want to.  I would
> enable osd logging to see where the EIO is coming from.
>
> sage
