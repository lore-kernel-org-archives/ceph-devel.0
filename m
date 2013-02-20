From: Gregory Farnum <greg@inktank.com>
Subject: Re: Hadoop DNS/topology details
Date: Tue, 19 Feb 2013 16:44:26 -0800
Message-ID: <CAPYLRzjmW+RrYuaDOFkHi3CAtLw0H4FHe2vCWGshwy55tFPdhw@mail.gmail.com>
References: <13BF7821-647C-4234-B696-5AA41ECCD6E5@cs.ucsc.edu>
	<CAPYLRzjy-TCTobh1mi1=d9omx0ZWvEce6ZB9vvf3ON5MVaC-MA@mail.gmail.com>
	<16038FC6-8930-46AE-A5C5-1169230CDDA8@cs.ucsc.edu>
	<alpine.DEB.2.00.1302191637520.18860@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:33133 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932691Ab3BTAo1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 19:44:27 -0500
Received: by mail-qc0-f174.google.com with SMTP id z24so2876105qcq.33
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 16:44:26 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302191637520.18860@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Joe Buck <jbbuck@gmail.com>

On Tue, Feb 19, 2013 at 4:39 PM, Sage Weil <sage@inktank.com> wrote:
> On Tue, 19 Feb 2013, Noah Watkins wrote:
>> On Feb 19, 2013, at 2:22 PM, Gregory Farnum <greg@inktank.com> wrote:
>> > On Tue, Feb 19, 2013 at 2:10 PM, Noah Watkins <jayhawk@cs.ucsc.edu>
>> > wrote:
>> >
>> > That is just truly annoying. Is this described anywhere in their docs?
>>
>> Not really. It's just there in the code--I can figure out the metric if
>> you're interested. I suspect it is local node, local rack, off rack
>> ordering, with no special tie breakers.
>>
>> > I don't think it would be hard to sort, if we had some mechanism for
>> > doing so (crush map nearness, presumably?),
>>
>> Topology information from the bucket hierarchy? I think it's always some
>> sort of heuristic.
>>
>> >> 1. Expand CephFS interface to return IP and hostname
>> >
>> > Ceph doesn't store hostnames anywhere ? it really can't do this. All
>> > it has is IPs associated with OSD ID numbers. :) Adding hostnames
>> > would be a monitor and map change, which we could do, but given the
>> > issues we've had with hostnames in other contexts I'd really rather
>> > not.
>>
>> What is the fate of hostnames used in ceph.conf? Could that information
>> be leveraged, when specified by the cluster admin?
>
> Those went hte way of the Dodo.

More specifically, those hostnames are used by mkcephfs (and
ceph-deploy?) for ssh'ing into the remote nodes, and they might sit in
a lot of ceph.conf's somewhere. But it's not data aggregated by the
monitors, or even used in-memory.

> However, we do have host and rack information in the crush map, at least
> for non-customized installations.  How about something like
>
>   string ceph_get_osd_crush_location(int osd, string type);
>
> or similar.  We could call that with "host" and "rack" and get exactly
> what we need, without making any changes to the data structures.

That's a good workaround, but it does rely on those fields being set
up in the CRUSH map (and makes handling cases like SSD-primary setups
a lot more challenging).
-Greg
