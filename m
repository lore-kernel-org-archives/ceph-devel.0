From: Sage Weil <sage@newdream.net>
Subject: Re: RBD/OSD questions
Date: Tue, 11 May 2010 09:26:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005110925450.32173@cobra.newdream.net>
References: <784866.39317.qm@web36101.mail.mud.yahoo.com>
 <v2vcf40c6a91005070938y85d18ec2wa5a579944841511f@mail.gmail.com>
 <Pine.LNX.4.64.1005070942350.18563@cobra.newdream.net>
 <201005111339.06101.anton.vazir@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53646 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051Ab0EKQXY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 May 2010 12:23:24 -0400
In-Reply-To: <201005111339.06101.anton.vazir@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anton <anton.vazir@gmail.com>
Cc: Andreas Grimm <agrimm61@gmail.com>, ceph-devel@vger.kernel.org

On Tue, 11 May 2010, Anton wrote:
> Sage, what about rebalancing of already existing replicas, 
> on crush-map change? 

The cluster will do this transparently, as soon as the map changes.

sage


> 
> On Friday 07 May 2010, Sage Weil wrote:
> > You need to set up a crush map.  See this wiki page:
> >         http://ceph.newdream.net/wiki/Custom_data_placeme
> > nt_with_CRUSH
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
