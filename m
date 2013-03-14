From: Sage Weil <sage@inktank.com>
Subject: Re: CephFS locality API RFC
Date: Thu, 14 Mar 2013 11:42:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303141142220.32317@cobra.newdream.net>
References: <2A330211-CC95-42FB-967C-6FAD4E1895DC@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53189 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab3CNSm4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Mar 2013 14:42:56 -0400
In-Reply-To: <2A330211-CC95-42FB-967C-6FAD4E1895DC@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 14 Mar 2013, Noah Watkins wrote:
> The current CephFS API is used to extract locality information as follows:
> 
> First we get a list of OSD IDs:
> 
>   ceph_get_file_extent_osds(offset) -> [OSD ID]*
> 
> Using the OSD IDs we can then query for the CRUSH bucket hierarchy:
> 
>   ceph_get_osd_crush_location(osd_id) -> path
> 
> The path includes hostname information, but we'd still like to get the IP. The current API for doing this is:
> 
>   ceph_get_file_stripe_address(offset) -> [sockaddr]*
> 
> that returns an IP for each OSD holds replicas. The order of the output list should be the same as the the OSD list, but It'd be nice to have a consistent API that deals with OSD id, making the correspondence explicit. For instance:
> 
>   ceph_get_file_stripe_address(osd_id) -> sockaddr

How about ceph_get_osd_addr(osd_id) -> sockaddr?

sage


> 
> Another option is to have `ceph_get_osd_crush_location` return both the path and a sockaddr.
> 
> Thoughts?
> 
> Thanks,
> Noah--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
