From: Sage Weil <sage@newdream.net>
Subject: Re: remove PG
Date: Wed, 23 Feb 2011 08:50:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102230848330.2601@cobra.newdream.net>
References: <AANLkTimGyBpOPWKDV6iOHUqkDWvcQ_biSJzvsLuE+=JJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38713 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755076Ab1BWQs1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Feb 2011 11:48:27 -0500
In-Reply-To: <AANLkTimGyBpOPWKDV6iOHUqkDWvcQ_biSJzvsLuE+=JJ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: H Chang <heracles@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 23 Feb 2011, H Chang wrote:
> Hi,
> 
> I was browsing PG management code in Ceph, and have one question.
> 
> It appears that an OSD could send a PG removal request to another OSD.
> The recipient OSD would then remove that particular PG from its pg_map.
> 
> I'd like to know under what circumstances an OSD would want to remove PGs.

If a PG moves from one OSD to another (due to, say, cluster expansion), 
there will be a copy of the PG data at the old location.  Once the new 
primary OSD has completed recovery (i.e. has the requisite number of 
copies of data in the correct locations) it will tell the OSDs with 
"stray" copies to remove the data.

Currently this code is very conservative; we only remove the PG once it is 
completely migrated/rereplicated to the new location.

sage
