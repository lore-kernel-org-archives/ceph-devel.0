From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: Add OSD and hard drives
Date: Wed, 29 Jun 2011 18:25:06 -0700
Message-ID: <4E0BD072.30109@dreamhost.com>
References: <ED302AD9DFBE5045BC354B53A8AD5FB10332831071@its-hcwnem05.ds.Vanderbilt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:60862 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661Ab1F3BZH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2011 21:25:07 -0400
In-Reply-To: <ED302AD9DFBE5045BC354B53A8AD5FB10332831071@its-hcwnem05.ds.Vanderbilt.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Hemingway, Graham Stuart" <graham.hemingway@Vanderbilt.Edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Graham,

On 06/29/2011 12:23 PM, Hemingway, Graham Stuart wrote:
> Hello,
>
> I have a simple ceph installation working.  My cluster has 7 hardware nodes.  5 OSDs (1 2TB drive each) and two MDSs.  I have one monitor which is on the same machine as one of the MDSs.  Running on Ubuntu 10.10 and v0.30 I have things working.  Yeah.
> So, my questions are:
>
> 1) Would you recommend adding a second monitor on the same machine as the other MDS?  Therefore two nodes each with MON and MDS.  Does ceph still want monitors in odd numbers?

Generally the monitors don't need much cpu or memory, and it's a good 
idea to run 3, so your cluster continues working if one fails. An even 
number doesn't improve reliability since a majority of monitors need to 
be active to make progress.

> 2) What is the procedure for adding an additional hard drive to each OSD?  I have a second 2TB drive physically on each OSD node that I would like to bring up and I did not find ready documentation on just adding drives.

The simplest way to add a drive is to start a new OSD for the new drive. 
Instructions for this are on the wiki:

http://ceph.newdream.net/wiki/OSD_cluster_expansion/contraction

Since your new drive is the same size as the others, you wouldn't need 
to adjust your crush map to get an even distribution of data.

The downside of running one OSD per disk is increased memory and cpu 
usage, but this shouldn't be a problem with a small cluster and few PGs.

Josh
