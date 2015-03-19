From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Failed OSDs not getting marked down or out
Date: Thu, 19 Mar 2015 06:58:11 -0700
Message-ID: <CAC6JEv8TJaybJhYpq067Bhrz86f9CHtY8Lz9haKXtqED34e+Hw@mail.gmail.com>
References: <CAKeiORT21fyG0WcdgJC6Gbnpe90y_SM+VuOJDML8NXR9dG2sZA@mail.gmail.com>
	<alpine.DEB.2.00.1503181256160.3716@cobra.newdream.net>
	<CAC6JEv9SMnuXE80Y8jtMv_Qsf7MpcCAmsYjV3r5ju1B7838+kg@mail.gmail.com>
	<CAKeiORShxjnSVO9cRJC9ucrq-UWgRXLgqkt_Q8WO+2T7rHn2dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36069 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbbCSN6M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Mar 2015 09:58:12 -0400
Received: by igbud6 with SMTP id ud6so24555015igb.1
        for <ceph-devel@vger.kernel.org>; Thu, 19 Mar 2015 06:58:12 -0700 (PDT)
Received: from mail-ig0-f172.google.com (mail-ig0-f172.google.com. [209.85.213.172])
        by mx.google.com with ESMTPSA id k9sm1395742ige.6.2015.03.19.06.58.11
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2015 06:58:11 -0700 (PDT)
Received: by igbqf9 with SMTP id qf9so23581438igb.1
        for <ceph-devel@vger.kernel.org>; Thu, 19 Mar 2015 06:58:11 -0700 (PDT)
In-Reply-To: <CAKeiORShxjnSVO9cRJC9ucrq-UWgRXLgqkt_Q8WO+2T7rHn2dg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Conner <matt.conner@keepertech.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Can you share the actual map? I'm not sure exactly what "rack rules"
means here but from your description so far I'm guessing/hoping that
you've accidentally restricted OSD choices in a way that limits the
number of peers each OSD is getting.
-Greg

On Thu, Mar 19, 2015 at 5:41 AM, Matt Conner <matt.conner@keepertech.com> wrote:
> In this case we are using rack rules with the firefly tunables. The testing
> was being done with a single, 3 copy, pool with placement group number 4096.
> This was calculated based on 10% data and 200 PGs per OSD using the
> calculator at http://ceph.com/pgcalc/.
>
> Thanks,
> Matt
>
> Matt Conner
> keepertechnology
> matt.conner@keepertech.com
> (240) 461-2657
>
> On Wed, Mar 18, 2015 at 4:11 PM, Gregory Farnum <greg@gregs42.com> wrote:
>>
>> On Wed, Mar 18, 2015 at 12:59 PM, Sage Weil <sage@newdream.net> wrote:
>> > On Wed, 18 Mar 2015, Matt Conner wrote:
>> >> I'm working with a 6 rack, 18 server (3 racks of 2 servers , 3 racks
>> >> of 4 servers), 640 OSD cluster and have run into an issue when failing
>> >> a storage server or rack where the OSDs are not getting marked down
>> >> until the monitor timeout is reached - typically resulting in all
>> >> writes being blocked until the timeout.
>> >>
>> >> Each of our storage servers contains 36 OSDs, so in order to prevent a
>> >> server from marking a OSD out (in case of network issues), we have set
>> >> our "mon_osd_min_down_reporters" value to 37. This value is working
>> >> great for a smaller cluster, but unfortunately seems to not work so
>> >> well in this large cluster. Tailing the monitor logs I can see that
>> >> the monitor is only receiving failed reports from 9-10 unique OSDs per
>> >> failed OSD.
>> >>
>> >> I've played around with "osd_heartbeat_min_peers", and it seems to
>> >> help, but I still run into issues where an OSD is not marked down. Can
>> >> anyone explain how the number of heartbeat peers is determined and
>> >> how, if necessary, I can can use "osd_heartbeat_min_peers" to ensure I
>> >> have enough peering to detect failures in large clusters?
>> >
>> > The peers are normally determined why which other OSDs we share a PG
>> > with.
>> > Increasing pg_num for your pools will tend to increase this.  It looks
>> > like osd_heartbeat_min_peers will do the same (to be honest I don't
>> > think
>> > I've ever had to use it for this), so I'm not sure why that isn't
>> > resolving the problem.  Maybe make sure it is set significantly higher
>> > than 36?  It may simply be that several of the random choices were
>> > within
>> > the same host so that when it goes down there still aren't enough peers
>> > to mark things down.
>> >
>> > Alternatively, you can give up on the mon_osd_min_down_reporters tweak.
>> > It sounds like it creates more problems than it solves...
>>
>> This normally works out okay; in particular I'd expect a lot more than
>> 10 peer OSDs in a cluster of this size. What's your CRUSH map and
>> ruleset look like? How many pools and PGs?
>> -Greg
>
>
