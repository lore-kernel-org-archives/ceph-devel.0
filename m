From: Wido den Hollander <wido@widodh.nl>
Subject: Re: handling fs errors
Date: Tue, 22 Jan 2013 14:12:23 +0100
Message-ID: <50FE9037.8040501@widodh.nl>
References: <alpine.DEB.2.00.1301212200031.29915@cobra.newdream.net> <CAC-hyiHnGXrr5hiZF__BP_uWZeSrhFk_psphAcRPwb5qGa69cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:34682 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab3AVNM2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 08:12:28 -0500
In-Reply-To: <CAC-hyiHnGXrr5hiZF__BP_uWZeSrhFk_psphAcRPwb5qGa69cw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org



On 01/22/2013 07:12 AM, Yehuda Sadeh wrote:
> On Mon, Jan 21, 2013 at 10:05 PM, Sage Weil <sage@inktank.com> wrote:
>> We observed an interesting situation over the weekend.  The XFS volume
>> ceph-osd locked up (hung in xfs_ilock) for somewhere between 2 and 4
>> minutes.  After 3 minutes (180s), ceph-osd gave up waiting and committed
>> suicide.  XFS seemed to unwedge itself a bit after that, as the daemon was
>> able to restart and continue.
>>
>> The problem is that during that 180s the OSD was claiming to be alive but
>> not able to do any IO.  That heartbeat check is meant as a sanity check
>> against a wedged kernel, but waiting so long meant that the ceph-osd
>> wasn't failed by the cluster quickly enough and client IO stalled.
>>
>> We could simply change that timeout to something close to the heartbeat
>> interval (currently default is 20s).  That will make ceph-osd much more
>> sensitive to fs stalls that may be transient (high load, whatever).
>>
>> Another option would be to make the osd heartbeat replies conditional on
>> whether the internal heartbeat is healthy.  Then the heartbeat warnings
>> could start at 10-20s, ping replies would pause, but the suicide could
>> still be 180s out.  If the stall is short-lived, pings will continue, the
>> osd will mark itself back up (if it was marked down) and continue.
>>
>> Having written that out, the last option sounds like the obvious choice.
>> Any other thoughts?
>>
>
> Another option would be to have the osd reply to the ping with some
> health description.
>

Looking to the future with more monitoring that might be a good idea.

If an OSD simply stops sending heartbeats if the internal conditions 
aren't met you don't know what's going on.

If the heartbeat would have metadata which tells: "I'm here, but not in 
such a good shape" that could be reported back to the monitors.

Monitoring tools could read this out and could sent out 
notifications/alerts to where they want.

Now we assume I/O completely stalls, but the metadata could also contain 
high latency? If the latency goes over threshold X you can still mark 
the OSD out temporarily since it will impact clients, but some 
information towards the monitor might be useful.

Wido

> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
