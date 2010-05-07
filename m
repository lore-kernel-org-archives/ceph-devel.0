From: Sage Weil <sage@newdream.net>
Subject: Re: RBD/OSD questions
Date: Fri, 7 May 2010 09:43:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005070942350.18563@cobra.newdream.net>
References: <784866.39317.qm@web36101.mail.mud.yahoo.com>
 <Pine.LNX.4.64.1005061517070.18563@cobra.newdream.net>
 <v2vcf40c6a91005070938y85d18ec2wa5a579944841511f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53436 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab0EGQk1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 May 2010 12:40:27 -0400
In-Reply-To: <v2vcf40c6a91005070938y85d18ec2wa5a579944841511f@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Grimm <agrimm61@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 7 May 2010, Andreas Grimm wrote:
> That sounds promising. I have another question about the OSDs.
> Following scenario:
> 
> I have a couple servers with each having six disks. My idea is to
> start an osd for every single disk on each server.
> Will Ceph place the replicas on different hosts by design, or can i
> solve this via a crush map?

You need to set up a crush map.  See this wiki page:
	http://ceph.newdream.net/wiki/Custom_data_placement_with_CRUSH

> Just a short question on terminus: what is a RBD (something about rados?)?

rbd = rados block device

sage
