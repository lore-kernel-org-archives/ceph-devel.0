From: Aaron Ten Clay <aarontc@aarontc.com>
Subject: Re: [ceph-users] Extremely high OSD memory utilization on Kraken
 11.2.0 (with XFS -or- bluestore)
Date: Wed, 19 Apr 2017 16:22:30 -0700
Message-ID: <CAFFcurr3MDM=xoAAzibgJ-SVQoUDX0GNxxywc0PYqrOdTHxN9g@mail.gmail.com>
References: <CAFFcurqEctQ2fHHDcGYfy3YCuaq9DxZr0VU4e8dNVACNVLDmqA@mail.gmail.com>
 <alpine.DEB.2.11.1704171457320.10661@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:34624 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964890AbdDSXWc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Apr 2017 19:22:32 -0400
Received: by mail-io0-f193.google.com with SMTP id h41so8747996ioi.1
        for <ceph-devel@vger.kernel.org>; Wed, 19 Apr 2017 16:22:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1704171457320.10661@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: ceph-devel@vger.kernel.org

(Re-sending this as plaintext to satisfy vger.kernel.org!)

I'm new to doing this all via systemd and systemd-coredump, but I
appear to have gotten cores from two OSD processes. When xzipped they
are < 2MIB each, but I threw them on my webserver to avoid polluting
the mailing list. This seems oddly small, so if I've botched the
process somehow let me know :)

https://aarontc.com/ceph/dumps/core.ceph-osd.150.082e9ca887c34cfbab183366a214a84c.6742.1492634493000000000000.xz
https://aarontc.com/ceph/dumps/core.ceph-osd.150.082e9ca887c34cfbab183366a214a84c.7202.1492634508000000000000.xz

And for reference:
root@osd001:/var/lib/systemd/coredump# ceph -v
ceph version 11.2.0 (f223e27eeb35991352ebc1f67423d4ebc252adb7)


I am also investigating sysdig as recommended.

Thanks!

On Mon, Apr 17, 2017 at 8:15 AM, Sage Weil <sage@newdream.net> wrote:
> On Sat, 15 Apr 2017, Aaron Ten Clay wrote:
>> Hi all,
>>
>> Our cluster is experiencing a very odd issue and I'm hoping for some
>> guidance on troubleshooting steps and/or suggestions to mitigate the issue.
>> tl;dr: Individual ceph-osd processes try to allocate > 90GiB of RAM and are
>> eventually nuked by oom_killer.
>
> My guess is that there there is a bug in a decoding path and it's
> trying to allocate some huge amount of memory.  Can you try setting a
> memory ulimit to something like 40gb and then enabling core dumps so you
> can get a core?  Something like
>
> ulimit -c unlimited
> ulimit -m 20000000
>
> or whatever the corresponding systemd unit file options are...
>
> Once we have a core file it will hopefully be clear who is
> doing the bad allocation...
>
> sage
>
>
>
>>
>> I'll try to explain the situation in detail:
>>
>> We have 24-4TB bluestore HDD OSDs, and 4-600GB SSD OSDs. The SSD OSDs are in
>> a different CRUSH "root", used as a cache tier for the main storage pools,
>> which are erasure coded and used for cephfs. The OSDs are spread across two
>> identical machines with 128GiB of RAM each, and there are three monitor
>> nodes on different hardware.
>>
>> Several times we've encountered crippling bugs with previous Ceph releases
>> when we were on RC or betas, or using non-recommended configurations, so in
>> January we abandoned all previous Ceph usage, deployed LTS Ubuntu 16.04, and
>> went with stable Kraken 11.2.0 with the configuration mentioned above.
>> Everything was fine until the end of March, when one day we find all but a
>> couple of OSDs are "down" inexplicably. Investigation reveals oom_killer
>> came along and nuked almost all the ceph-osd processes.
>>
>> We've gone through a bunch of iterations of restarting the OSDs, trying to
>> bring them up one at a time gradually, all at once, various configuration
>> settings to reduce cache size as suggested in this ticket:
>> http://tracker.ceph.com/issues/18924...
>>
>> I don't know if that ticket really pertains to our situation or not, I have
>> no experience with memory allocation debugging. I'd be willing to try if
>> someone can point me to a guide or walk me through the process.
>>
>> I've even tried, just to see if the situation was  transitory, adding over
>> 300GiB of swap to both OSD machines. The OSD procs managed to allocate, in a
>> matter of 5-10 minutes, more than 300GiB of RAM pressure and became
>> oom_killer victims once again.
>>
>> No software or hardware changes took place around the time this problem
>> started, and no significant data changes occurred either. We added about
>> 40GiB of ~1GiB files a week or so before the problem started and that's the
>> last time data was written.
>>
>> I can only assume we've found another crippling bug of some kind, this level
>> of memory usage is entirely unprecedented. What can we do?
>>
>> Thanks in advance for any suggestions.
>> -Aaron
>>
>>



-- 
Aaron Ten Clay
https://aarontc.com
