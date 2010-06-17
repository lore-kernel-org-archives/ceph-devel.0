From: Sage Weil <sage@newdream.net>
Subject: Re: ceph.conf sanity checks
Date: Thu, 17 Jun 2010 09:26:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006170926010.6914@cobra.newdream.net>
References: <hvdb65$5tm$4@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40099 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932992Ab0FQQZ2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jun 2010 12:25:28 -0400
In-Reply-To: <hvdb65$5tm$4@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Thu, 17 Jun 2010, Thomas Mueller wrote:
> 
> doing some testing I've made some mistakes and configured the same device 
> for "btrfs devs" and "osd journal". 
> 
> I then ran happily "mkcephfs -c /etc/ceph/ceph.conf --mkbtrfs", started 
> ceph, mounted it and wrote to it, umounted and stopped ceph.
> 
> no errors thrown.

mkcephfs now errors out of the osd journal device is part of btrfs devs.

thanks-
sage
