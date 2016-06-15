From: Sage Weil <sage@newdream.net>
Subject: Re: AsyncMessenger maturity
Date: Wed, 15 Jun 2016 14:16:31 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606151412450.6221@cpach.fuggernut.com>
References: <DB5PR05MB160725A2A9228123780F67CFA9550@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35897 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933061AbcFOSQC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jun 2016 14:16:02 -0400
In-Reply-To: <DB5PR05MB160725A2A9228123780F67CFA9550@DB5PR05MB1607.eurprd05.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avner Ben Hanoch <avnerb@mellanox.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 15 Jun 2016, Avner Ben Hanoch wrote:
> Hi All,
> 
> I tried to evaluate AsyncMessenger (together with its sub classes) and I 
> found its code great in my eyes. Still, when using it at runtime, Ceph 
> will warn you that this module is dangerous.

In jewel we've removed the 'experimental' flag.  Upgrade!
 
> *I have two questions:*
> 1. Considering pros and cons, are there any cons when using 
> AsyncMessenger instead of SimpleMessenger (like stability, or cpu/memory 
> consumption, .)

Less CPU, fewer threads, nicer code.

> 2. I am considering a variant of AsyncMessenger that might require that 
> both sides will be same messenger, I wonder, is it possible to use 
> AsyncMessenger for private network between OSDs only and to remain with 
> SimpleMessenger for all other messengers (for example, by just changing 
> the lines that creates the 6 Messengers in ceph_osd.cc::main)

It's the same protocol as SimpleMessenger, so there is no need to run 
SimpleMessenger at all.  (You can't currently use two types in the same 
process, but I don't think there's any need to.)

sage
