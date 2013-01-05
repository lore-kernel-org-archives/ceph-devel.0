From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: ceph stays degraded after crushmap rearrangement
Date: Sat, 05 Jan 2013 18:03:05 +0100
Message-ID: <50E85CC9.9080503@profihost.ag>
References: <50E85799.4060607@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:42394 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755768Ab3AERDA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jan 2013 12:03:00 -0500
In-Reply-To: <50E85799.4060607@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

now i cannot even access an rbd image anymore.

Hanging status is now:
2013-01-05 18:01:21.736298 mon.0 [INF] pgmap v2212193: 7632 pgs: 1 
stale, 10 peering, 14 stale+peering, 1 stale+remapped, 1807 
stale+active+remapped, 1 stale+active+degraded, 2587 remapped+peering, 
1767 stale+remapped+peering, 1341 stale+active+degraded+remapped, 103 
stale+active+replay+degraded+remapped; 152 GB data, 313 GB used, 5022 GB 
/ 5336 GB avail; 7647/79122 degraded (9.665%)


Stefan
Am 05.01.2013 17:40, schrieb Stefan Priebe:
> Hi list,
>
> i've rearranged my crushmap. Ceph was degraded about 18% and was
> recovering / rearranging fine.
>
> But now it stays still and degraded status is rising??
>
> 2013-01-05 17:35:40.906587 mon.0 [INF] pgmap v2211269: 7632 pgs: 7632
> active+remapped; 152 GB data, 312 GB used, 5023 GB / 5336 GB avail;
> 22/79086 degraded (0.028%)
>
> ...
>
> 2013-01-05 17:37:50.142106 mon.0 [INF] pgmap v2211386: 7632 pgs: 7632
> active+remapped; 152 GB data, 312 GB used, 5023 GB / 5336 GB avail;
> 24/79090 degraded (0.030%)
>
> ..
>
> 2013-01-05 17:40:35.292054 mon.0 [INF] pgmap v2211526: 7632 pgs: 7632
> active+remapped; 152 GB data, 313 GB used, 5023 GB / 5336 GB avail;
> 32/79106 degraded (0.040%)
>
> I'm on currect testing branch.
>
> Greets,
> Stefan
