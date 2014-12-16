From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: tcp tuning
Date: Wed, 17 Dec 2014 10:55:35 +1300
Message-ID: <CA+z5Dsxt5rizoiDWgKQBQ5FV4PL8+SkwsnxHKDODd6v1Q8y0UQ@mail.gmail.com>
References: <alpine.DEB.2.00.1412161334200.20966@cobra.newdream.net> <5490A736.4090902@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:37078 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbaLPVz6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Dec 2014 16:55:58 -0500
Received: by mail-la0-f47.google.com with SMTP id hz20so12266072lab.34
        for <ceph-devel@vger.kernel.org>; Tue, 16 Dec 2014 13:55:57 -0800 (PST)
In-Reply-To: <5490A736.4090902@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mnelson@redhat.com
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Buffers settings are very particular to the actual network config, so
not that easy to give generic advice on. However given the huge number
of TCP connections Ceph uses it would make sense to have some standard
guidance around things like backlog, conntrack, timewait etc. I'm sure
this is something we all end up doing in various non-standard ways.

On 17 December 2014 at 10:42, Mark Nelson <mark.nelson@inktank.com> wrote:
> On 12/16/2014 03:36 PM, Sage Weil wrote:
>>
>> I stumbled across this comment in the bug tracker from Jake Young:
>>
>>         http://tracker.ceph.com/issues/9844
>>
>> It's unrelated to the original bug, but wanted to post it here for comment
>> as a quick glance at this makes me think some of these tunings would be
>> good for users in general.
>>
>> sage
>>
>> "My cluster originally had 4 nodes, with 7 osds on each node, 28 osds
>> total, running Gian. I did not have any problems at this time.
>>
>> My problems started after adding two new nodes, so I had 6 nodes and 42
>> total osds. It would run fine on low load, but when the request load
>> increased, osds started to fall over.
>>
>> I was able to set the debug_ms to 10 and capture the logs from a failed
>> OSD. There were a few different reasons the osds were going down. This
>> example shows it terminating normally for an unspecified reason a minute
>> after it notices it is marked down in the map.
>>
>> Osd 25 actually marks this osd (osd 35) down. For some reason many osds
>> cannot communicate with each other.
>>
>> [...]
>>
>> The recurring theme here is that there is a communication issue between
>> the osds.
>>
>> I looked carefully at my network hardware configuration (UCS C240s with
>> 40Gbps Cisco VICs connected to a pair of Nexus 5672 using A-FEX Port
>> Profile configuration) and couldn't find any dropped packets or errors.
>>
>> I ran "ss -s" for the first time on my osds and was a bit suprised to see
>> how many open TCP connections they all have.
>>
>> ceph@osd6:/var/log/ceph$ ss -s
>> Total: 1492 (kernel 0)
>> TCP: 1411 (estab 1334, closed 40, orphaned 0, synrecv 0, timewait 0/0),
>> ports 0
>>
>> Transport Total IP IPv6
>> 0 - -
>> RAW 0 0 0
>> UDP 10 4 6
>> TCP 1371 1369 2
>> INET 1381 1373 8
>> FRAG 0 0 0
>> While researching if additional kernel tuning would be required to handle
>> so many connections, I eventually realized that I forgot to copy my
>> customized /etc/sysctl.conf file on the two new nodes. I'm not sure if the
>> large amount of TCP connections is part of the performance enhancements
>> between Giant and Firefly, or if Firefly uses a similar number of
>> connections.
>>
>> ceph@osd6:/var/log/ceph$ cat /etc/sysctl.conf
>> # /etc/sysctl.conf - Configuration file for setting system variables
>> See /etc/sysctl.d/ for additional system variables
>> See sysctl.conf (5) for information. #
>>
>> Increase Linux autotuning TCP buffer limits
>> Set max to 16MB for 1GE and 32M (33554432) or 54M (56623104) for 10GE
>>
>> Don't set tcp_mem itself! Let the kernel scale it based on RAM.
>> net.core.rmem_max = 56623104
>> net.core.wmem_max = 56623104
>> net.core.rmem_default = 56623104
>> net.core.wmem_default = 56623104
>> net.core.optmem_max = 40960
>> net.ipv4.tcp_rmem = 4096 87380 56623104
>> net.ipv4.tcp_wmem = 4096 65536 56623104
>>
>> Make room for more TIME_WAIT sockets due to more clients,
>> and allow them to be reused if we run out of sockets
>>
>> Also increase the max packet backlog
>> net.core.somaxconn = 1024
>> net.core.netdev_max_backlog = 50000
>> net.ipv4.tcp_max_syn_backlog = 30000
>> net.ipv4.tcp_max_tw_buckets = 2000000
>> net.ipv4.tcp_tw_reuse = 1
>> net.ipv4.tcp_fin_timeout = 10
>>
>> Disable TCP slow start on idle connections
>> net.ipv4.tcp_slow_start_after_idle = 0
>>
>> If your servers talk UDP, also up these limits
>> net.ipv4.udp_rmem_min = 8192
>> net.ipv4.udp_wmem_min = 8192
>>
>> Disable source routing and redirects
>> net.ipv4.conf.all.send_redirects = 0
>> net.ipv4.conf.all.accept_redirects = 0
>> net.ipv4.conf.all.accept_source_route = 0
>>
>> I added the net.core.somaxconn after this experience, since the default is
>> 128. This represents the allowed socket backlog in the kernel; which
>> should help when I reboot an osd node and 1300 connections need to be made
>> quickly.
>>
>> I found that I needed to restart my osds after applying the kernel tuning
>> above for my cluster to stabilize.
>>
>> My system is now stable again and performs very well.
>
>
>
> FWIW, this is the tuning I ended up with for RGW last fall when doing swift
> comparison testing that yielded the best performance for both solutions.  At
> the time this wasn't needed (and made little difference) on the OSDs, but it
> appears that maybe TCP tuning in general is something we need to look more
> closely.
>
> echo 33554432 | sudo tee /proc/sys/net/core/rmem_default
> echo 33554432 | sudo tee /proc/sys/net/core/wmem_default
> echo 33554432 | sudo tee /proc/sys/net/core/rmem_max
> echo 33554432 | sudo tee /proc/sys/net/core/wmem_max
> echo "10240 87380 33554432" | sudo tee /proc/sys/net/ipv4/tcp_rmem
> echo "10240 87380 33554432" | sudo tee /proc/sys/net/ipv4/tcp_wmem
> echo 250000 | sudo tee /proc/sys/net/core/netdev_max_backlog
> echo 524288 | sudo tee /proc/sys/net/nf_conntrack_max
> echo 1 | sudo tee /proc/sys/net/ipv4/tcp_tw_recycle
> echo 1 | sudo tee /proc/sys/net/ipv4/tcp_tw_reuse
>
>
>
>>
>> "
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
~Blairo
