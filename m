From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Some usability question
Date: Thu, 26 Feb 2015 21:44:04 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F282BB8C5@SACMBXIP02.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282BB873@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1502261310160.25838@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0077.outbound.protection.outlook.com ([65.55.169.77]:36192
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754130AbbBZVoQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Feb 2015 16:44:16 -0500
In-Reply-To: <alpine.DEB.2.00.1502261310160.25838@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Thanks !
<<inline

-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net]
Sent: Thursday, February 26, 2015 1:20 PM
To: Somnath Roy
Cc: Ceph Development
Subject: Re: Some usability question

On Thu, 26 Feb 2015, Somnath Roy wrote:
> Hi,

> Is there any way to know which OSD to map to which drive of a host
> from an Admin node ? We know from command like say 'ceph osd tree' to
> identify till the host where an osd belongs to but not the disk. The
> workaround I have is to login to the corresponding node and see the
> mount points to identify. Is this the best one or am I missing any
> command ? If we can depict a tree view (similar to 'ceph osd tree')
> from pool to disk level (pool -> hosts ( and the crush buckets
> hierarchy) -> osds -> disks), user can easily find out their crush map
> is working as expected on a specific pool (say cache tier).

The closest is 'ceph osd metadata <id>' which gives you a bunch of random info about the OSD.  Right now it just gives you the path, which is always /var/lib/ceph/osd/ceph-NNN, but that could be expanded to try to map that back to a device, probably.  Search for 'metadata' in osd/OSD.cc.
[Somnath] Sure, I will see if I can add this.

> Second question, regarding Erasure coded pool a certain amount of
> storage could be lost because of padding. I think it will be helpful
> if we can show how much is lost because of the variant client workload
> with the help of a command. This information can help user to choose
> the erasure coded profile (as it is dependent on K value) accordingly.
> Presently, rados object can't identify what is valid (and what not),
> so it could be a lot of effort, but is it worth ?  Any thoughts ?

Hmm.  Not super trivial.  You could take the size of each object and calculate how much got padded to fill out the stripe, or probably do something that calculates what the average amount wasted would be for a uniform distribution of sizes.  Meh...  how important is this?

[Somnath] This is one of the concern came up during our qualification with erasure coding pool. We need to quantify the actual storage gain for different workload in case of erasure coding vs replicated. I was thinking if it is trivial to do , but, if not,  not a high priority.

sage

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

