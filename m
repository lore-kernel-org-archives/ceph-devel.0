From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Failed OSDs not getting marked down or out
Date: Wed, 18 Mar 2015 13:11:39 -0700
Message-ID: <CAC6JEv9SMnuXE80Y8jtMv_Qsf7MpcCAmsYjV3r5ju1B7838+kg@mail.gmail.com>
References: <CAKeiORT21fyG0WcdgJC6Gbnpe90y_SM+VuOJDML8NXR9dG2sZA@mail.gmail.com>
	<alpine.DEB.2.00.1503181256160.3716@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36137 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754906AbbCRULl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Mar 2015 16:11:41 -0400
Received: by iegc3 with SMTP id c3so48933137ieg.3
        for <ceph-devel@vger.kernel.org>; Wed, 18 Mar 2015 13:11:40 -0700 (PDT)
Received: from mail-ig0-f178.google.com (mail-ig0-f178.google.com. [209.85.213.178])
        by mx.google.com with ESMTPSA id 17sm11600501iol.39.2015.03.18.13.11.40
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 13:11:40 -0700 (PDT)
Received: by igbud6 with SMTP id ud6so4139325igb.1
        for <ceph-devel@vger.kernel.org>; Wed, 18 Mar 2015 13:11:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1503181256160.3716@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Matt Conner <matt.conner@keepertech.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Mar 18, 2015 at 12:59 PM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 18 Mar 2015, Matt Conner wrote:
>> I'm working with a 6 rack, 18 server (3 racks of 2 servers , 3 racks
>> of 4 servers), 640 OSD cluster and have run into an issue when failing
>> a storage server or rack where the OSDs are not getting marked down
>> until the monitor timeout is reached - typically resulting in all
>> writes being blocked until the timeout.
>>
>> Each of our storage servers contains 36 OSDs, so in order to prevent a
>> server from marking a OSD out (in case of network issues), we have set
>> our "mon_osd_min_down_reporters" value to 37. This value is working
>> great for a smaller cluster, but unfortunately seems to not work so
>> well in this large cluster. Tailing the monitor logs I can see that
>> the monitor is only receiving failed reports from 9-10 unique OSDs per
>> failed OSD.
>>
>> I've played around with "osd_heartbeat_min_peers", and it seems to
>> help, but I still run into issues where an OSD is not marked down. Can
>> anyone explain how the number of heartbeat peers is determined and
>> how, if necessary, I can can use "osd_heartbeat_min_peers" to ensure I
>> have enough peering to detect failures in large clusters?
>
> The peers are normally determined why which other OSDs we share a PG with.
> Increasing pg_num for your pools will tend to increase this.  It looks
> like osd_heartbeat_min_peers will do the same (to be honest I don't think
> I've ever had to use it for this), so I'm not sure why that isn't
> resolving the problem.  Maybe make sure it is set significantly higher
> than 36?  It may simply be that several of the random choices were within
> the same host so that when it goes down there still aren't enough peers
> to mark things down.
>
> Alternatively, you can give up on the mon_osd_min_down_reporters tweak.
> It sounds like it creates more problems than it solves...

This normally works out okay; in particular I'd expect a lot more than
10 peer OSDs in a cluster of this size. What's your CRUSH map and
ruleset look like? How many pools and PGs?
-Greg
