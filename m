From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: Suicide
Date: Tue, 19 Apr 2011 12:45:17 +0200
Message-ID: <4DAD67BD.1010901@provocation.net>
References: <4DA85AA6.8050707@provocation.net> <3704E18884CB47E081E09984151ACC7B@gmail.com> <4DA8C8FB.5050106@provocation.net> <161F0A2E50F1465996C6A9075A508C85@gmail.com> <4DA8D4EF.8090006@provocation.net> <25103BE141804650A169B6444F0D6D21@gmail.com> <4DAA2B38.1090706@provocation.net> <BANLkTi=rdcyUu_7PwFc0nRbYs-V=tr+V8Q@mail.gmail.com> <CB9E56C259C44656B7B9DD670A548B8A@gmail.com> <4DACBD77.9020600@provocation.net> <FF1D1635C657408E9A7F6275AB23DD61@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:50499 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423Ab1DSKpZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Apr 2011 06:45:25 -0400
In-Reply-To: <FF1D1635C657408E9A7F6275AB23DD61@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org



On 04/19/2011 01:02 AM, Gregory Farnum wrote:

> It's a bit more complicated than that. While we could probably do a better 
> job of controlling bandwidths, there are a lot of pieces devoted to handling 
> changes in disk performance and preventing the OSD from accepting more data 
> than it can handle -- much of this is tunable (it's not well-documented but 
> off the top of my head the ones to look at are osd_client_message_size_cap, 
> for how much client data to hold in-memory waiting on disk [defaults to 200MB], 
> and filestore_op_threads, which defaults to 2 but might be better at 1 or 0 
> for a very slow disk) . 

Indeed, I've seen cosd threads fighting each-other to write to disk. Do
I understand it correctly that OPTION(filestore_op_threads, 0, OPT_INT, 0)
in src/config.cc and recompile is the only way to change this?

> The specific crash that I saw here meant that the OSD called sync on its 
> underlying filesystem and 6 minutes later the sync hadn't completed! The 
> system can handle slow disks but it became basically unresponsive, at which 
> point the proper response in a replicated scenario is to kill itself (the 
> data should all exist elsewhere). 

It seems the right thing to do, provided that the data does exist elsewhere
in sufficient replicas. This touches something that Colin wrote in this same
thread, so I'll merge it in:

> If we let
> unresponsive OSDs linger forever, we could get in a situation where
> the upper layer (the Ceph filesystem) continues to wait forever for an
> unresponsive OSD, even though there are lots of other OSDs that could
> easily take up the slack.

The requirements and availability of OSDs at any given moment are known,
so the reaction to an unresponsive OSD can be calculated. Let's say,
given 20 OSDs and a CRUSH rule that says data {min_data 3; max_data 10},
ceph could acknowledge a write as long as committed to replicas =< 3 .
If, on the other hand, it can't commit the data to at least 3 OSDs (or
3 journals, as the case might be), it should throw an error back and tell
the application that it can't write to disk, so that the application can
react appropriately.

I have to admit though that I'm still rather confused as to how and in
which order data and metadata are passed around through memory and journal
to disk. The wiki says "The OSD does not acknowledge a write until it is
committed (stable) on disk" but does that mean "committed once" or "committed
on as many copies as data min_data"? I suspect the former, because that would
explain how the bottlenecks I'm seeing can build up. On the other hand, a
stricter flush-min_data-before-acknowledging strategy as I describe above
would automatically solve most network and disk bandwidth calculation problems
by blocking writes unless and until there is sufficient bandwidth to commit
all required copies to disk.

Of course these are design considerations that I'm sure you must have gone
through time and over again, so I could very well be missing some essential
point. I hope you bear with me.

> This is like starving to death at the
> all-you-can-eat buffet, just because they're out of jell-o.

:)) That's the funniest comparison I've seen in a long time, but I'm not
sure it fully applies. Yes, waiting forever for an unresponsive OSD when
there are others around would be exactly that, so ceph should (quickly)
time out and try elsewhere. But acknowledging a write before it knows
for sure whether it can meet its min_data requirements is another story;
that's stuffing data and hoping that some OSDs somewhere will accept it,
when in fact they might all have called it a day and gone fishing.

Z


