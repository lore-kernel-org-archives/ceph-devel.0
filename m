From: Sage Weil <sage@newdream.net>
Subject: Re: Luminous - replace old target-weight tree from osdmap with mgr
 balancer
Date: Wed, 10 Jan 2018 21:23:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801102123260.8186@piezo.novalocal>
References: <602f839b-6927-2c53-dbb5-baee02569105@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:40618 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeAJVXs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jan 2018 16:23:48 -0500
In-Reply-To: <602f839b-6927-2c53-dbb5-baee02569105@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 10 Jan 2018, Stefan Priebe - Profihost AG wrote:
> k,
> 
> in the past we used the python crush optimize tool to reweight the osd
> usage - it inserted a 2nd tree with $hostname-target-weight as hostnames.

Can you attach a 'ceph osd crush tree' (or partial output) so I can see 
what you mean?

Thanks!
sage

> 
> Now the quesions are:
> 1.) can we remove the tree? How?
> 2.) Can we do this now or only after all clients are running Luminous?
> 3.) is it enought to enable the mgr balancer module?
> 
> Thanks!
> 
> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
