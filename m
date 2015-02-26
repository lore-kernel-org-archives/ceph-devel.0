From: Sage Weil <sage@newdream.net>
Subject: Re: Some usability question
Date: Thu, 26 Feb 2015 13:19:46 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502261310160.25838@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282BB873@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49022 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbbBZVTr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Feb 2015 16:19:47 -0500
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F282BB873@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 26 Feb 2015, Somnath Roy wrote:
> Hi,

> Is there any way to know which OSD to map to which drive of a host from 
> an Admin node ? We know from command like say 'ceph osd tree' to 
> identify till the host where an osd belongs to but not the disk. The 
> workaround I have is to login to the corresponding node and see the 
> mount points to identify. Is this the best one or am I missing any 
> command ? If we can depict a tree view (similar to 'ceph osd tree') from 
> pool to disk level (pool -> hosts ( and the crush buckets hierarchy) -> 
> osds -> disks), user can easily find out their crush map is working as 
> expected on a specific pool (say cache tier).

The closest is 'ceph osd metadata <id>' which gives you a bunch of random 
info about the OSD.  Right now it just gives you the path, which is always 
/var/lib/ceph/osd/ceph-NNN, but that could be expanded to try to map that 
back to a device, probably.  Search for 'metadata' in osd/OSD.cc.

> Second question, regarding Erasure coded pool a certain amount of 
> storage could be lost because of padding. I think it will be helpful if 
> we can show how much is lost because of the variant client workload with 
> the help of a command. This information can help user to choose the 
> erasure coded profile (as it is dependent on K value) accordingly. 
> Presently, rados object can't identify what is valid (and what not), so 
> it could be a lot of effort, but is it worth ?  Any thoughts ?

Hmm.  Not super trivial.  You could take the size of each object and 
calculate how much got padded to fill out the stripe, or probably do 
something that calculates what the average amount wasted would be for a 
uniform distribution of sizes.  Meh...  how important is this?

sage
