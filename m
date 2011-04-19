From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Suicide
Date: Tue, 19 Apr 2011 09:29:06 -0700
Message-ID: <BANLkTimwUNDi6s1QLWrH4JxDrRzeazW2Fw@mail.gmail.com>
References: <4DA85AA6.8050707@provocation.net>
	<3704E18884CB47E081E09984151ACC7B@gmail.com>
	<4DA8C8FB.5050106@provocation.net>
	<161F0A2E50F1465996C6A9075A508C85@gmail.com>
	<4DA8D4EF.8090006@provocation.net>
	<25103BE141804650A169B6444F0D6D21@gmail.com>
	<4DAA2B38.1090706@provocation.net>
	<BANLkTi=rdcyUu_7PwFc0nRbYs-V=tr+V8Q@mail.gmail.com>
	<CB9E56C259C44656B7B9DD670A548B8A@gmail.com>
	<4DACBD77.9020600@provocation.net>
	<FF1D1635C657408E9A7F6275AB23DD61@gmail.com>
	<4DAD67BD.1010901@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43055 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060Ab1DSQ3K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Apr 2011 12:29:10 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id BAFEEC064
	for <ceph-devel@vger.kernel.org>; Tue, 19 Apr 2011 09:29:08 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 46E0FC062
	for <ceph-devel@vger.kernel.org>; Tue, 19 Apr 2011 09:29:08 -0700 (PDT)
Received: by eyx24 with SMTP id 24so1747984eyx.19
        for <ceph-devel@vger.kernel.org>; Tue, 19 Apr 2011 09:29:06 -0700 (PDT)
In-Reply-To: <4DAD67BD.1010901@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

On Tue, Apr 19, 2011 at 3:45 AM, Zenon Panoussis <oracle@provocation.net> wrote:
>> It's a bit more complicated than that. While we could probably do a better
>> job of controlling bandwidths, there are a lot of pieces devoted to handling
>> changes in disk performance and preventing the OSD from accepting more data
>> than it can handle -- much of this is tunable (it's not well-documented but
>> off the top of my head the ones to look at are osd_client_message_size_cap,
>> for how much client data to hold in-memory waiting on disk [defaults to 200MB],
>> and filestore_op_threads, which defaults to 2 but might be better at 1 or 0
>> for a very slow disk) .
>
> Indeed, I've seen cosd threads fighting each-other to write to disk. Do
> I understand it correctly that OPTION(filestore_op_threads, 0, OPT_INT, 0)
> in src/config.cc and recompile is the only way to change this?
Heavens no! You can set any of those options in your config file:
filestore op threads = 0
or on the command line when starting the osd:
cosd -i osd.a -c ceph.conf --filestore_op_threads 0


>> The specific crash that I saw here meant that the OSD called sync on its
>> underlying filesystem and 6 minutes later the sync hadn't completed! The
>> system can handle slow disks but it became basically unresponsive, at which
>> point the proper response in a replicated scenario is to kill itself (the
>> data should all exist elsewhere).
>
> It seems the right thing to do, provided that the data does exist elsewhere
> in sufficient replicas. This touches something that Colin wrote in this same
> thread, so I'll merge it in:
>
>> If we let
>> unresponsive OSDs linger forever, we could get in a situation where
>> the upper layer (the Ceph filesystem) continues to wait forever for an
>> unresponsive OSD, even though there are lots of other OSDs that could
>> easily take up the slack.
>
> The requirements and availability of OSDs at any given moment are known,
> so the reaction to an unresponsive OSD can be calculated. Let's say,
> given 20 OSDs and a CRUSH rule that says data {min_data 3; max_data 10},
> ceph could acknowledge a write as long as committed to replicas =< 3 .
> If, on the other hand, it can't commit the data to at least 3 OSDs (or
> 3 journals, as the case might be), it should throw an error back and tell
> the application that it can't write to disk, so that the application can
> react appropriately.
Mmm. There are problems with that too: applications often don't deal
well with the filesystem spitting back errors; you don't want errors
to propagate back to the application based on which OSD they're trying
to access, etc.
In general Ceph behaves about like a RAID array in recovery under
these kinds of situations. It counts on the replication for safety and
we could maybe add more smarts to prevent kicking out the last copy of
data but that would be complex and error-prone without a big gain (ie,
not appropriate at this stage of development). If at any point it
can't commit the data to disk then after a timeout the mapping of data
to OSDs will change and the write will get redirected to an active
OSD.

> I have to admit though that I'm still rather confused as to how and in
> which order data and metadata are passed around through memory and journal
> to disk. The wiki says "The OSD does not acknowledge a write until it is
> committed (stable) on disk" but does that mean "committed once" or "committed
> on as many copies as data min_data"? I suspect the former, because that would
> explain how the bottlenecks I'm seeing can build up. On the other hand, a
> stricter flush-min_data-before-acknowledging strategy as I describe above
> would automatically solve most network and disk bandwidth calculation problems
> by blocking writes unless and until there is sufficient bandwidth to commit
> all required copies to disk.
Actually it's neither. All data is mapped to a placement group for
reading and writing. The placement group is made up of a certain
number of OSDs which is set by the pool/CRUSH rules (by default, 2).
The data is sent to the first OSD and that then replicates it to the
other OSDs in its placement group and a write is considered safe when
it's on-disk on each OSD. However, there are complications. Because we
don't want to start moving data around when an OSD gets rebooted,
there's a distinction between an OSD being up or down (ie, accessible
or not accessible) and an OSD being in or out (ie, included in the
placement group). So the placement group might temporarily have only
one up OSD in which case the data is considered safe after that OSD
gets it.
In the typical case though then all the OSDs are up, and all of them
need to have the data before it's acked in any way.

I believe you're experiencing difficulty because (IIRC) you have an
OSD and a monitor both using the same (very slow) disk. Both of these
daemons call fsync et al *very frequently* for safety purposes and
that all on its own can really kill performance on a slow disk. It's
just a compounding cycle in your case which I suspect would be helped
a lot by putting your OSD and your monitor on separate disks.
-Greg
