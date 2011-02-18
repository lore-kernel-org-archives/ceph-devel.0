From: Wido den Hollander <wido@widodh.nl>
Subject: Re: A Few Questions about Ceph
Date: Fri, 18 Feb 2011 15:24:51 +0100
Message-ID: <1298039091.2366.65.camel@wido-desktop>
References: <loom.20110218T053907-813@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:49978 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757333Ab1BROY5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Feb 2011 09:24:57 -0500
In-Reply-To: <loom.20110218T053907-813@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nigh <mnigh@netelligent.com>
Cc: ceph-devel@vger.kernel.org

Hi Mark,

On Fri, 2011-02-18 at 04:39 +0000, Mark Nigh wrote:
> I have been doing significant research and testing of Ceph as a long-term
> solution for our Cloud Storage Solution. 
> 

While every new user is welcome to Ceph, please do understand that is
still under heavy development and is NOT production ready.

> 1. I have a 3 node cluster. the first cluster is running the mon, msd and osd0
> daemons. The second node is running the osd1 daemon only. I am able to mount the
> x.x.x.x:/ /mnt/ceph just fine. I have added a 3 node and am running the osd
> daemon only. I don't want to add this node to the placement group of the 1st 2
> nodes, but rather add a 4th and have the 3rd and 4th in a placement group. This
> would be helpful for different customers or different applications that may or
> may not need replication to a second data center. 

Yes, that is possible. You can create a CRUSH-map
( http://ceph.newdream.net/wiki/Custom_data_placement_with_CRUSH ).
Every RADOS pool has a cruhsrule attribute, here you can device which
rule to use.

When using the Ceph filesystem you can also specify a CRUSH rule per
directory, this can be done with the "cephfs" command:

I haven't used the tool myself yet, but I think something like this
should be possible:

$ cephfs -p data-on-ssd /mnt/ceph/dir1/sub2

The "data-on-ssd" pool then has a CRUSH rule which only uses OSD's with
SSD's in t hem.

> 
> 2. Is there anyway to create sub-directories in the client mount for example,
> mount -t ceph x.x.x.x:/subdirectory /mnt/ceph

Yes, you can mount every subdirectory you want. Simply mount the root
first, create the directories you want and then start mounting those new
subdirectories.

> 
> I am looking forward to placing ceph into our production network as our backup
> target. 

I'm just going to repeat myself. Ceph is great, but it is still under
heavy development. Testing and feedback is needed and very welcome, but
right now it's not suitable for production.

Regards,

Wido

> 
> Thank you, 
> 
> Mark Nigh 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

