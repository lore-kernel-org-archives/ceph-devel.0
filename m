From: Wido den Hollander <wido@widodh.nl>
Subject: RE: A Few Questions about Ceph
Date: Mon, 21 Feb 2011 13:28:06 +0100
Message-ID: <1298291286.20766.50.camel@wido-desktop>
References: <loom.20110218T053907-813@post.gmane.org>
	 <1298039091.2366.65.camel@wido-desktop>
	 <B828A4C02BE12543ACDFCF7EB0C693C6788420D549@NC-SVR-09.netelligent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:59877 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865Ab1BUM21 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Feb 2011 07:28:27 -0500
In-Reply-To: <B828A4C02BE12543ACDFCF7EB0C693C6788420D549@NC-SVR-09.netelligent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nigh <mnigh@netelligent.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Mark,

On Sat, 2011-02-19 at 22:52 -0600, Mark Nigh wrote:
> Wido,
> 
> Thanks for the great information. I do have a follow up question. When I create my 3rd and 4th OSD nodes, how do I go about mounting that data? So for example, I am on a client and want to mount the data on the 3 and 4th nodes (different placement groups) and not the data on the 1st and 2nd OSDs.
> 

First, you can't mount data which is on a specific OSD. You have to add
the OSD's to the cluster:
http://ceph.newdream.net/wiki/OSD_cluster_expansion/contraction

When you did that, you can create a new CRUSH rule and assign a specific
pool/CRUSH rule to a directory.

You can mount every directy you want, so on your new client you can
mount the directory which has that CRUSH rule (cephfs tool).

> Am I looking at this incorrectly? To do what I am looking for, I would probably have to create a new FS with a msd and mon, etc?

Like I explained, not fully. Ceph places data on OSD's like to tell it
to (CRUSH map).

> 
> I was able to mount the subdirectory as you suggested on a Fedora 14 box (mount -t ceph x.x.x.x:/subdir1 /mnt/ceph), but when I do a ls I get permission denied.

I'm not sure what that could be? Are you sure you are root? If not, do
you have the right permissions to do a ls there? No AppArmor or SELinux
which is in your way?

Wido

> 
> Thank you,
> 
> Mark Nigh
> 
> 
> 
> -----Original Message-----
> From: Wido den Hollander [mailto:wido@widodh.nl]
> Sent: Friday, February 18, 2011 8:25 AM
> To: Mark Nigh
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: A Few Questions about Ceph
> 
> Hi Mark,
> 
> On Fri, 2011-02-18 at 04:39 +0000, Mark Nigh wrote:
> > I have been doing significant research and testing of Ceph as a long-term
> > solution for our Cloud Storage Solution.
> >
> 
> While every new user is welcome to Ceph, please do understand that is
> still under heavy development and is NOT production ready.
> 
> > 1. I have a 3 node cluster. the first cluster is running the mon, msd and osd0
> > daemons. The second node is running the osd1 daemon only. I am able to mount the
> > x.x.x.x:/ /mnt/ceph just fine. I have added a 3 node and am running the osd
> > daemon only. I don't want to add this node to the placement group of the 1st 2
> > nodes, but rather add a 4th and have the 3rd and 4th in a placement group. This
> > would be helpful for different customers or different applications that may or
> > may not need replication to a second data center.
> 
> Yes, that is possible. You can create a CRUSH-map
> ( http://ceph.newdream.net/wiki/Custom_data_placement_with_CRUSH ).
> Every RADOS pool has a cruhsrule attribute, here you can device which
> rule to use.
> 
> When using the Ceph filesystem you can also specify a CRUSH rule per
> directory, this can be done with the "cephfs" command:
> 
> I haven't used the tool myself yet, but I think something like this
> should be possible:
> 
> $ cephfs -p data-on-ssd /mnt/ceph/dir1/sub2
> 
> The "data-on-ssd" pool then has a CRUSH rule which only uses OSD's with
> SSD's in t hem.
> 
> >
> > 2. Is there anyway to create sub-directories in the client mount for example,
> > mount -t ceph x.x.x.x:/subdirectory /mnt/ceph
> 
> Yes, you can mount every subdirectory you want. Simply mount the root
> first, create the directories you want and then start mounting those new
> subdirectories.
> 
> >
> > I am looking forward to placing ceph into our production network as our backup
> > target.
> 
> I'm just going to repeat myself. Ceph is great, but it is still under
> heavy development. Testing and feedback is needed and very welcome, but
> right now it's not suitable for production.
> 
> Regards,
> 
> Wido
> 
> >
> > Thank you,
> >
> > Mark Nigh
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> This transmission and any attached files are privileged, confidential or otherwise the exclusive property of the intended recipient or Netelligent Corporation. If you are not the intended recipient, any disclosure, copying, distribution or use of any of the information contained in or attached to this transmission is strictly prohibited. If you have received this transmission in error, please contact us immediately by responding to this message or by telephone (314-392-6900) and promptly destroy the original transmission and its attachments.

