From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: OSD public / cluster network isolation using VRF:s
Date: Mon, 7 Dec 2015 10:01:17 -0700
Message-ID: <CAANLjFrs=Nrr5No0QOaUEH5aDLdpt9T393iiokap-gHLiN27WA@mail.gmail.com>
References: <1449173601.2291.84.camel@millnert.se>
	<422901884.211767.1449176599032.JavaMail.open-xchange@ox03.mail.pcextreme.nl>
	<alpine.DEB.2.00.1512031326331.19170@cobra.newdream.net>
	<1449495663.29564.118.camel@millnert.se>
	<alpine.DEB.2.00.1512070608030.25269@cobra.newdream.net>
	<1449503414.29564.163.camel@millnert.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34702 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755691AbbLGRBS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Dec 2015 12:01:18 -0500
Received: by lbbcs9 with SMTP id cs9so69559439lbb.1
        for <ceph-devel@vger.kernel.org>; Mon, 07 Dec 2015 09:01:17 -0800 (PST)
In-Reply-To: <1449503414.29564.163.camel@millnert.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Millnert <martin@millnert.se>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

We did some work on prioritizing Ceph traffic and this is what I came up with.

#!/bin/sh

#set -x

if [ $1 == "bond0" ]; then

        INTERFACES="enp7s0f0 enp7s0f1"

        for i in $INTERFACES; do
                # Clear what might be there
                tc qdisc del dev $i root

                # Add priority queue at the root of the interface
                tc qdisc add dev $i root handle 1: prio

                # Add sfq to each priority band to give each destination
                # a chance to get traffic
                tc qdisc add dev $i parent 1:1 handle 10: sfq
                tc qdisc add dev $i parent 1:2 handle 20: sfq
                tc qdisc add dev $i parent 1:3 handle 30: sfq
        done

        # Flush the POSTROUTING chain
        iptables -t mangle -F POSTROUTING

        # Don't mess with the loopback device
        iptables -t mangle -A POSTROUTING -o lo -j ACCEPT

        # Remark the Ceph heartbeat packets
        iptables -t mangle -A POSTROUTING -m dscp --dscp 0x30 -j DSCP
--set-dscp 0x2e

        # Traffic destined for the monitors should get priority
        iptables -t mangle -A POSTROUTING -p tcp --dport 6789 -j DSCP
--set-dscp 0x2e

        # All traffic going out the management interface is high priority
        iptables -t mangle -A POSTROUTING -o bond0.202 -j DSCP --set-dscp 0x2e

        # Send the high priority traffic to the tc 1:1 queue of the adapter
        iptables -t mangle -A POSTROUTING -m dscp --dscp 0x2e -j
CLASSIFY --set-class 0001:0001

        # Stop processing high priority traffic so it doesn't get messed up
        iptables -t mangle -A POSTROUTING -m dscp --dscp 0x2e -j ACCEPT

        # Set the replication traffic to low priority, it will only be on the
        # cluster network VLAN 401. Heartbeats were taken care of already
        iptables -t mangle -A POSTROUTING -o bond0.401 -j DSCP --set-dscp 0x08

        # Send the replication traffic to the tc 1:3 queue of the adapter
        iptables -t mangle -A POSTROUTING -m dscp --dscp 0x08 -j
CLASSIFY --set-class 0001:0003

        # Stop processing low priority traffic
        iptables -t mangle -A POSTROUTING -m dscp --dscp 0x08 -j ACCEPT

        # Whatever is left is best effort or storage traffic. We don't need
        # to mark it because it will get the default DSCP of 0. Just send it
        # to the middle tc class 1:2
        iptables -t mangle -A POSTROUTING -j CLASSIFY --set-class 0001:0002
fi

In the switches, we mark CoS based on the DSCP tag since we are not
able to easily mark the L2 CoS in Linux. Even though we are using the
scavenger class here on the Linux box for replication, I believe we
are marking DSCP 0x08 to the same class as DSCP 0x0. All Ceph traffic
has CoS priority higher than the VM traffic (different VLANs but same
physical switches). We didn't have much luck with replication traffic
lower than client traffic and it works well enough for what we wanted
with client/replication at the same priority. We have created
saturation tests and even though the cluster performance degrades a
lot, we did not have the flapping of OSD nodes that others have
mentioned in similar situations. We also have configured 12 reporters
for 10 OSDs per host so I'm sure that helps as well.

Newer versions of Ceph will automatically set the DSCP of heartbeat
packets, but we wanted a different DSCP value so we just remark them.
I was going to test setting client traffic lower than replication, but
we didn't have a pressing need to after our testing, the cluster would
have degraded about the same either way. We just wanted to prevent the
OSD flapping and this got us there.
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.0
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWZbtZCRDmVDuy+mK58QAAO2EP/ROKlPERu9CkMX7WldOh
PvrF/Xc1QenWmqgB9SDjjbpcA/xuyrzUXhlYL7iOjnx4yc+Y4M7KHDSjz2M9
7WZ3UDIOqXJ5LiMmzfwlD+k0+iZ8yYdMpeWrMG/bK4em/DUpa4g1IBz5iasE
CXti9dUPBN8fNnsDYY4svCP55QWCnVMV1m4Fsqp4Pa1VNSPwfdgBpzDgbnNR
qLKXaA2MbRP82li1ywlz3GFVnwPFLvkcbHnaOgO/WnfIM/LsftXLTk5bOqdV
wmXNc2ApbY6ZRKzYRUZYuuj6VMfGnU+qYpuTFrGiUESfRYNgc6vK3d3Uzeln
FmV4IXchfwFvtLH05PX2aOGN5MsL+iN9pjHOuqdrWoHlEclxfQBP7HTQJbPZ
hQgaCqoyRPaTwAX26OMj8oGNn1z/TtwYvDCZsNj40LHMjzOzDeAGauAG0b5e
GusSFAjw4REVzk1DvuuMUOE5yEpchqqoTSwsA7cBYKIr/HpnsQN1YwKHfFWQ
Ztx2dZSYrVU99dU1DEGATW8S92oyNC+He+eyz8YoMjdhLV7cm4O2QY0D4uQF
po31utoWi67WpTr1LCnzwdsAC4gHi/dJ6LGRqn/zyXfk+WQ+8h3I29Xoh6DE
MQyVKaAVHUE6xYy1RAoRT5WJTg1ZvQwLk7p3V1twOtjrOCzjwFQ8hUyMOqSx
1IT8
=ihTl
-----END PGP SIGNATURE-----
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Mon, Dec 7, 2015 at 8:50 AM, Martin Millnert <martin@millnert.se> wrote:
> On Mon, 2015-12-07 at 06:10 -0800, Sage Weil wrote:
>> On Mon, 7 Dec 2015, Martin Millnert wrote:
>> > > Note that on a largish cluster the public/client traffic is all
>> > > north-south, while the backend traffic is also mostly north-south to the
>> > > top-of-rack and then east-west.  I.e., within the rack, almost everything
>> > > is north-south, and client and replication traffic don't look that
>> > > different.
>> >
>> > This problem domain is one of the larger challenges. I worry about
>> > network timeouts for critical cluster traffic in one of the clusters due
>> > to hosts having 2x1GbE. I.e. in our case I want to
>> > prioritize/guarantee/reserve a minimum amount of bandwidth for cluster
>> > health traffic primarily, and secondarily cluster replication. Client
>> > write replication should then be least prioritized.
>>
>> One word of caution here: the health traffic should really be the
>> same path and class of service as the inter-osd traffic, or else it
>> will not identify failures.
>
> Indeed - complete starvation is never good. We're considering reserving
> parts of the bandwidth (Where the class of service implementation in the
> networking gear does the job of spending unallocated bandwidth, etc, as
> per the whole packet scheduling logic.
> TX time slots never go idle if there are non-empty queues.)
>
> Something like:
>  1) "Reserve 5% bandwith to 'osd-mon'
>  2) "Reserve 40% bandwidth to 'osd-osd' (repairs when unhealthy)"
>  3) "Reserve 30% bandwidth to 'osd-osd' (other)"
>  4) "Reserve 25% bandwidth to 'client-osd' traffic"
>
> Our goal is that client traffic *should* lose some packets here and
> there when there is more load towards a host than it has bandwidth for,
> a little bit more often than it happens to more critical traffic. Health
> takes precedence over function, but not on an "all or nothing" basis. I
> suppose 2 and 3 may be impossible to distinguish.
>
> But most important of all is, the way I understand Ceph-under-stress,
> that we want to actively avoid start flipping OSD's up/down and ending
> up with an oscillating/unstable cluster, that starts to move data
> around, simply because a host is under pressure (i.e. 100 nodes writing
> to 1, and similar scenarios).
>
>> e.g., if the health traffic is prioritized,
>> and lower-priority traffic is starved/dropped, we won't notice.
>
> To truly notice drops - we need information from the network layer,
> either host stack side (where we can have it per-socket) or from the
> network side, i.e. the switches etc, right?
> We'll monitor the different hardware queues in our network devices.
> Socket statistics can be received at a host-wide scale from the Linux
> network stack, and well, per socket given some modifications to Ceph I
> suppose (I push netstat's statistics into influxdb).
> (I'm rusty on how/what per-socket metrics can be logged today in vanilla
> kernel and assume we need application support.)
>
> The bigger overarching issue for us is what happens under stress in
> different situations and how to maximize time spent in state "normal" of
> the cluster.
>
>> > To support this I need our network equipment to perform the CoS job, and
>> > in order to do that at some level in the stack I need to be able to
>> > classify traffic. And furthermore, I'd like to do this with as little
>> > added state as possible.
>>
>> I seem to recall a conversation a year or so ago about tagging
>> stream/sockets so that the network layer could do this.  I don't think
>> we got anywhere, though...
>
> It'd be interesting to look into what were the ideas back then - I'll
> take a look over the archives.
>
> Thanks,
> Martin
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
