From: Sage Weil <sage@newdream.net>
Subject: Re: Creating and deploying OSDs in parallel
Date: Mon, 30 Mar 2015 08:36:09 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503300835030.23387@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CB60C4@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60186 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbbC3PgK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Mar 2015 11:36:10 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CB60C4@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 30 Mar 2015, Somnath Roy wrote:
> Hi,
> I am planning to modify our deployment script so that it can create and deploy multiple OSDs in parallel to the same host as well as on different hosts.
> Just wanted to check if there is any problem to run say 'ceph-deploy osd create' etc. in parallel while deploying cluster.

I'm not aware of any, but I would not be surprised if you hit some 
problems.  IIRC ceph-disk is doing some simple locking while it is 
updating partition tables to prevent races between it and activation (via 
udev).  Hopefully what is there now is sufficient!

sage
