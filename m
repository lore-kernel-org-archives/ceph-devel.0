From: Sage Weil <sage@redhat.com>
Subject: Re: ARM benchmarks for the erasure code plugin
Date: Fri, 27 Jun 2014 10:16:50 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406271016080.12946@cobra.newdream.net>
References: <53ADA5EC.5030302@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42034 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbaF0RQu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jun 2014 13:16:50 -0400
In-Reply-To: <53ADA5EC.5030302@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sandon Van Ness <sandon@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

The machine types are tala and saya; you should be able to grab one with 
teuthology-lock.  Hopefully they are up...

sage

On Fri, 27 Jun 2014, Loic Dachary wrote:

> Hi Sandon,
> 
> Would it be possible to get access to an ARM based machine to run erasure code plugins benchmarks ? The idea is to get a baseline similar to what https://github.com/ceph/ceph/pull/1875 shows and figure out where we stand. At this point any ARM processor will do. Eventually we will want to give NEON[1] enabled processors a try but right now we have nothing take advantage of that ;-)
> 
> Cheers
> 
> [1] http://en.wikipedia.org/wiki/NEON_%28instruction_set%29#NEON
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> 
> 
