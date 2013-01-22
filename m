From: Wido den Hollander <wido@widodh.nl>
Subject: Re: questions on networks and hardware
Date: Tue, 22 Jan 2013 14:20:29 +0100
Message-ID: <50FE921D.2050204@widodh.nl>
References: <EFFE82E1-B74B-4DAB-8801-5311FA903618@jnielsen.net> <50FC2682.3020601@widodh.nl> <86F63F32-4C61-4F12-9EB0-925AD4FF1864@jnielsen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:34911 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab3AVNUc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 08:20:32 -0500
In-Reply-To: <86F63F32-4C61-4F12-9EB0-925AD4FF1864@jnielsen.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Nielsen <lists@jnielsen.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 01/22/2013 12:15 AM, John Nielsen wrote:
> Thanks all for your responses! Some comments inline.
>
> On Jan 20, 2013, at 10:16 AM, Wido den Hollander <wido@widodh.nl> wrote:
>
>> On 01/19/2013 12:34 AM, John Nielsen wrote:
>>> I'm planning a Ceph deployment which will include:
>>> 	10Gbit/s public/client network
>>> 	10Gbit/s cluster network
>>> 	dedicated mon hosts (3 to start)
>>> 	dedicated storage hosts (multiple disks, one XFS and OSD per disk, 3-5 to start)
>>> 	dedicated RADOS gateway host (1 to start)
>>>
>>> I've done some initial testing and read through most of the docs but I still have a few questions. Please respond even if you just have a suggestion or response for one of them.
>>>
>>> If I have "cluster network" and "public network" entries under [global] or [osd], do I still need to specify "public addr" and "cluster addr" for each OSD individually?
>>
>> Already answered, but no. You don't need to. The OSDs will bind to the available IP in that network.
>
> Nice. That's how I hoped/assumed it would work but I have seen some configurations on the web that include both so I wanted to make sure.
>
>>> Which network(s) should the monitor hosts be on? If both, is it valid to have more than one "mon addr" entry per mon host or is there a different way to do it?
>>
>> They should be on the "public" network since the clients also need to be able to reach the monitors.
>
> It sounds (from other followups) like there is work on adding some awareness of the cluster network to the monitor but it's not there yet. I'll stay tuned. It would be nice if the monitors and OSD's together could form a reachability map for the cluster and give the option of using the public network for the affected subset of OSD traffic in the event of a problem on the cluster network. Having the monitor(s) connected to the cluster network might be useful for that...
>
> Then again, a human should be involved if there is a network failure anyway; manually changing the network settings in the Ceph config as a temporary workaround is already an option I suppose.
>
>>> I'd like to have 2x 10Gbit/s NIC's on the gateway host and maximize throughput. Any suggestions on how to best do that? I'm assuming it will talk to the OSD's on the Ceph public/client network, so does that imply a third even-more-public network for the gateway's clients?
>>
>> No, there is no third network. You could trunk the 2 NICs with LACP or something. Since the client will open TCP connections to all the OSDs you will get a pretty good balancing over the available bandwith.
>
> Good suggestion, thanks. I actually just started using LACP to pair up 1Gb NIC's on a small test cluster and it's proven beneficial, even with less-than-ideal hashing from the switch.
>
> To put my question here a different way: suppose I really really want to segregate the Ceph traffic from the HTTP traffic and I set up the IP's and routing necessary to do so (3rd network idea). Is there any reason NOT to do that?
>

No, no problem! The RGW gateways simply have 10G to the internet and 10G 
to the Ceph cluster.

The OSDs on their part have a "cluster network" which they use for 
internal communication.

Ceph doesn't need to know about your 3rd network.

>>> Is it worthwhile to have 10G NIC's on the monitor hosts? (The storage hosts will each have 2x 10Gbit/s NIC's.)
>>
>> No, not really. 1Gbit should be more then enough for your monitors. 3 monitors should also be good. No need to go for 5 or 7.
>
> Maybe I'll have the monitors just be on the public network but use LACP with dual 1Gbit NIC's for fault tolerance (since I'll have the NIC's onboard anyway).
>
>>> I think this has come up before, but has anyone written up something with more details on setting up gateways? Hardware recommendations, strategies to improve caching and performance, multiple gateway setups with and without a load balancer, etc.
>>
>> Not that I know. I'm still trying to play with RGW and Varnish in front of it, but haven't really taken the time yet. The goal is to offload a lot of the caching to Varnish and have Varnish 'ban' objects when they change.
>>
>> You could also use Varnish as a loadbalancer. But in this case you could also use RR-DNS or LVS with Direct Routing, that way only incoming traffic goes through the loadbalancer and return traffic goes directly to your network's gateway.
>
> I definitely plan to look in to Varnish at some point, I'll be sure to follow up here if I learn anything interesting.
>

One thing is still having multiple Varnish caches and object banning. I 
proposed something for this some time ago, some "hook" in RGW you could 
use to inform a upstream cache to "purge" something from it's cache.

That isn't there yet though.

Wido

> Thanks again,
>
> JN
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
