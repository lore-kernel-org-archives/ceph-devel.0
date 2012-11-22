From: Sage Weil <sage@inktank.com>
Subject: Re: incremental rbd export / sparse files?
Date: Thu, 22 Nov 2012 13:59:12 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211221357480.9963@cobra.newdream.net>
References: <50AE062E.5020301@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45243 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab2KVV7N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 16:59:13 -0500
In-Reply-To: <50AE062E.5020301@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 22 Nov 2012, Stefan Priebe - Profihost AG wrote:
> Hello list,
> 
> right now a rbd export exports exactly the size of the disk even if there is
> KNOWN free space. Is this inteded to change?
> 
> Might it be possible to export just differences between snapshots and merge
> them later?

We were just talking about this the other day.

Step 1 is to create a mechanism to output a list of block ranges that 
have/have not changed between snapshots.

Step 2 is to export the incremental changes.  The hangup there is figuring 
out a generic and portable file format to represent those incremental 
changes; we'd rather not invent something ourselves that is ceph-specific.
Suggestions welcome!

sage

