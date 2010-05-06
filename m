From: Sage Weil <sage@newdream.net>
Subject: Re: RBD/OSD questions
Date: Thu, 6 May 2010 15:20:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005061517070.18563@cobra.newdream.net>
References: <784866.39317.qm@web36101.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51830 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab0EFWRh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 May 2010 18:17:37 -0400
In-Reply-To: <784866.39317.qm@web36101.mail.mud.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Fick <mogulguy@yahoo.com>
Cc: =?iso-8859-1?Q?Cl=E1udio_Martins?= <ctpm@ist.utl.pt>, ceph-devel@vger.kernel.org

> How can that be on a 2 OSD setup with double redundancy?
> In this case, if all of a replicas smaller objects are
> not on a single node, how will it recover from an OSD 
> failure?  
> 
> The only way I see this possible is if file foo is 
> split into small objects A1 A2 A3 A4 and replicas B1 
> B2 B3 B4 and you spread those across 2 OSDs like this:
> 
> replica 1 (A1 B2 A3 B4)
> replica 2 (B1 A2 B3 A4)

The image is striped over objects, _then_ the objects are replicated 
across OSDs.  Objects themselves aren't striped.

For example, if an image is striped over objects A B C D E F, each 4MB, 
you might end up with

osd0: A  B' C  D  E' F'
osd1: A' B  C' D' E  F

where A is the primary copy, A' is the replica, etc.

sage
