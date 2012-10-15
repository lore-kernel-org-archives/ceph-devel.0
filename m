From: Sage Weil <sage@inktank.com>
Subject: Re: rbd command to display free space in a cluster ?
Date: Mon, 15 Oct 2012 08:46:36 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210150846030.3424@cobra.newdream.net>
References: <ec165b12-5d49-49d0-b5c9-cdb51bc2b442@mailpro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48575 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab2JOPqh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Oct 2012 11:46:37 -0400
In-Reply-To: <ec165b12-5d49-49d0-b5c9-cdb51bc2b442@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 15 Oct 2012, Alexandre DERUMIER wrote:
> Hi,
> 
> I'm looking for a way to retrieve the free space from a rbd cluster with rbd command.
> 
> Any hint ?
> 
> (something like ceph -w status, but without need to parse the result)

 rados df

is the closest.

sage



> 
> Regards,
> 
> Alexandre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
