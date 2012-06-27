From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: OSD Hardware questions
Date: Wed, 27 Jun 2012 11:23:05 -0600
Message-ID: <4FEB4179.8050104@sandia.gov>
References: <4FEB04CC.4050008@profihost.ag>
 <4FEB10DA.7010206@inktank.com> <4FEB1EF8.4050307@sandia.gov>
 <4FEB2480.3080404@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:47004 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756047Ab2F0RX3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jun 2012 13:23:29 -0400
In-Reply-To: <4FEB2480.3080404@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/27/2012 09:19 AM, Stefan Priebe wrote:
> Am 27.06.2012 16:55, schrieb Jim Schutt:
>> This is my current best tuning for my hardware, which uses
>> 24 SAS drives/server, and 1 OSD/drive with a journal partition
>> on the outer tracks and btrfs for the data store.
>
> Which raid level do you use?

No RAID.  Each OSD directly accesses a single
disk, via a partition for the journal and a partition
for the btrfs file store for that OSD.

I've got my 24 drives spread across three 6 Gb/s SAS HBAs,
so I can sustain ~90 MB/s per drive with all drives active,
when writing to the outer tracks using dd.

I want to rely on Ceph for data protection via replication.
At some point I expect to play around with the RAID0
support in btrfs to explore the performance relationship
between number of OSDs and size of each OSD, but haven't yet.

>
>> I'd be very curious to hear how these work for you.
>> My current testing load is streaming writes from
>> 166 linux clients, and the above tunings let me
>> sustain ~2 GB/s on each server (2x replication,
>> so 500 MB/s per server aggregate client bandwidth).
> 10GBe max speed shoudl be around 1Gbit/s. Do i miss something?

Hmmm, not sure.  My servers are limited by the bandwidth
of the SAS drives and HBAs.  So 2 GB/s aggregate disk
bandwidth is 1 GB/s for journals and 1 GB/s for data.
At 2x replication, that's 500 MB/s client data bandwidth.

>
>> I have dual-port 10 GbE NICs, and use one port
>> for the cluster and one for the clients. I use
>> jumbo frames because it freed up ~10% CPU cycles over
>> the default config of 1500-byte frames + GRO/GSO/etc
>> on the load I'm currently testing with.
> Do you have ntuple and lro on or off? Which kernel version do you use and which driver version? Intel cards?

# ethtool -k eth2
Offload parameters for eth2:
rx-checksumming: on
tx-checksumming: on
scatter-gather: on
tcp-segmentation-offload: on
udp-fragmentation-offload: off
generic-segmentation-offload: on
generic-receive-offload: on
large-receive-offload: off

The NICs are Chelsio T4, but I'm not using any of the
TCP stateful offload features for this testing.
I don't know if they have ntuple support, but the
ethtool version I'm using (2.6.33) doesn't mention it.

For kernels I switch back and forth between latest development
kernel from Linus's tree, or latest stable kernel, depending
on where the kernel development cycle is.  I usually switch
to the development kernel around -rc4 or so.

-- Jim

>
> Stefan
>
>


