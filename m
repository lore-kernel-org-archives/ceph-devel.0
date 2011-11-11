From: Sage Weil <sage@newdream.net>
Subject: Re: crushmap errors
Date: Fri, 11 Nov 2011 14:51:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111111444490.30348@cobra.newdream.net>
References: <4EBD9F62.20709@tuxadero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55214 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848Ab1KKWvH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Nov 2011 17:51:07 -0500
In-Reply-To: <4EBD9F62.20709@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 11 Nov 2011, Martin Mailand wrote:
> Hi,
> I used in ceph v0.38 the host and rack feature in the conf during an mkcephfs.
> Now I have to problems with the crushmap
> 
> 1. I cannot compile a ceph genearated crushmap.
> crushtool -c file.txt -o file
> file.txt:4 error: parse error at '.0'

Whoops, will push a patch to stable shortly.  The grammer wasn't 
recognizing '.' as a legal character.

> 2. Why are 2 racks are not enough for 2 failure domains?
> From the commit:
> If there are >2 racks, separate across racks.

Well, technically they are.  My worry is that it's more likely that racks 
will have significantly vary capacity (i.e. crush weight) due to, say, 1 
full rack and a second 1/2 rack.  If the policy forces replicas be placed 
across racks things won't balance well.

I suppose there should be an argument like --min-racks that controls that 
threshold?

sage
