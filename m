From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Add OSD and hard drives
Date: Thu, 30 Jun 2011 14:45:50 +0200
Message-ID: <1309437950.3241.15.camel@wido-desktop>
References: <ED302AD9DFBE5045BC354B53A8AD5FB10332831071@its-hcwnem05.ds.Vanderbilt.edu>
	 <4E0BD072.30109@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:45150 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab1F3Mpp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jun 2011 08:45:45 -0400
In-Reply-To: <4E0BD072.30109@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: "Hemingway, Graham Stuart" <graham.hemingway@Vanderbilt.Edu>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Graham and Josh,

On Wed, 2011-06-29 at 18:25 -0700, Josh Durgin wrote:

> > 2) What is the procedure for adding an additional hard drive to each OSD?  I have a second 2TB drive physically on each OSD node that I would like to bring up and I did not find ready documentation on just adding drives.
> 
> The simplest way to add a drive is to start a new OSD for the new drive. 
> Instructions for this are on the wiki:
> 
> http://ceph.newdream.net/wiki/OSD_cluster_expansion/contraction
> 
> Since your new drive is the same size as the others, you wouldn't need 
> to adjust your crush map to get an even distribution of data.

You still need to add it to your crush map, but you don't need to fiddle
with the weight of the OSDs ;-)

Just to make it clear for Graham, you do need to add the new OSDs to
your crush map as new devices, but the weight isn't needed since they're
all of equal size.

> 
> The downside of running one OSD per disk is increased memory and cpu 
> usage, but this shouldn't be a problem with a small cluster and few PGs.

Yes, I can confirm that. I currently have 40 OSD's and +10k PG's, this
is hitting my machines pretty hard. The machines are Atoms with 4GB of
RAM each and 4 OSD's (2TB) per machine.

Wido

