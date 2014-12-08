From: Sage Weil <sweil@redhat.com>
Subject: Re: CEPH & Shared RBD Volumes
Date: Mon, 8 Dec 2014 10:26:03 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412081024260.4440@cobra.newdream.net>
References: <88C3E003BB3649489ED4ECA6C80410476B9D8E@ORSMSX102.amr.corp.intel.com> <5485EBC8.2010407@smart-weblications.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35718 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbaLHS0O (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 8 Dec 2014 13:26:14 -0500
In-Reply-To: <5485EBC8.2010407@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Smart Weblications GmbH - Florian Wiessner <f.wiessner@smart-weblications.de>
Cc: "Cook, Nigel" <nigel.cook@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 8 Dec 2014, Smart Weblications GmbH - Florian Wiessner wrote:
> Hi Nigel,
> 
> Am 08.12.2014 15:30, schrieb Cook, Nigel:
> > Folks,
> > 
> > Can CEPH support 2 clients simultaneously accessing a single volume - for example a database cluster - and honor read and write order of blocks across the multiple clients?
> > 
> 
> Yes, we use ocfs2 ontop of rbd, gfs2 should also work...

You do need to disable client-side rbd caching, though (on librbd).  The 
librbd cache is crash-safe but not coherent across clients, and clustered 
file systems expect coherency (caches in a SAN are at the disk or shared 
controller, not the client).

sage

