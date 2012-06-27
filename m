From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: OSD Hardware questions
Date: Wed, 27 Jun 2012 17:19:28 +0200
Message-ID: <4FEB2480.3080404@profihost.ag>
References: <4FEB04CC.4050008@profihost.ag> <4FEB10DA.7010206@inktank.com> <4FEB1EF8.4050307@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:54672 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757669Ab2F0PT3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jun 2012 11:19:29 -0400
In-Reply-To: <4FEB1EF8.4050307@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 27.06.2012 16:55, schrieb Jim Schutt:
> This is my current best tuning for my hardware, which uses
> 24 SAS drives/server, and 1 OSD/drive with a journal partition
> on the outer tracks and btrfs for the data store.

Which raid level do you use?

> I'd be very curious to hear how these work for you.
> My current testing load is streaming writes from
> 166 linux clients, and the above tunings let me
> sustain ~2 GB/s on each server (2x replication,
> so 500 MB/s per server aggregate client bandwidth).
10GBe max speed shoudl be around 1Gbit/s. Do i miss something?

> I have dual-port 10 GbE NICs, and use one port
> for the cluster and one for the clients.  I use
> jumbo frames because it freed up ~10% CPU cycles over
> the default config of 1500-byte frames + GRO/GSO/etc
> on the load I'm currently testing with.
Do you have ntuple and lro on or off? Which kernel version do you use 
and which driver version? Intel cards?

Stefan
