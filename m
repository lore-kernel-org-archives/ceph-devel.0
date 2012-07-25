From: Sage Weil <sage@inktank.com>
Subject: Re: monitor start up question
Date: Wed, 25 Jul 2012 16:29:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1207251628480.20649@cobra.newdream.net>
References: <CA+jddaNP94kr8=K175Qk7PkMY=NEM_a+67XxNMZ1TAFUn4etaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47506 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428Ab2GYX3y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jul 2012 19:29:54 -0400
In-Reply-To: <CA+jddaNP94kr8=K175Qk7PkMY=NEM_a+67XxNMZ1TAFUn4etaQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 25 Jul 2012, Mandell Degerness wrote:
> When a cluster has been shut down and then re-started, how do the
> monitors know what the cluster fsid is?  Is it stored somewhere?

It's embedded in the monmap, currently found at $mon_data/monmap/<largest 
integer file>.  Not terribly convenient, sorry!

> I would like to be able to verify, before starting a monitor on a
> given server, if an existing monitor directory belongs to the current
> cluster or to a previous cluster incarnation.  With the OSDs, I can
> just check the cluster_fsid file.

We can add a similar file in the $mon_data directory in future version.

sage
