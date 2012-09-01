From: Ryan Nicholson <Ryan.Nicholson@kcrg.com>
Subject: RE: Integration work
Date: Sat, 1 Sep 2012 06:02:22 +0000
Message-ID: <F5955DC568F9AF4DB00BE0F7E950BE0C26036BDA@BLUPRD0411MB438.namprd04.prod.outlook.com>
References: <503D0A00.2080905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:34114
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751279Ab2IAGC2 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 1 Sep 2012 02:02:28 -0400
In-Reply-To: <503D0A00.2080905@inktank.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ross Turk <ross@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Ross, All:

I've read through several recommendations, and I'd like to add 2 to that list for consideration.

First: For my local project, I'm using rbd with Oracle VM and VM manager, mainly because of the other engineers' familiarity with the Oracle platforms, and they're certified by MS to run Windows on Xen (using Oracle's stuff).

Now, due to necessity, I'll be working on a Storage plugin that allows the Orcale VM to understand RBD, to make pools, etc for our project. I would be interested to know if anyone else has actually started on their own version of the same.

Secondly: Through some trials, I've found that if one loses all of his Monitors in a way that they also lose their disks, one basically loses their cluster. I would like to recommend a lower priority shift in design that allows for "recovery of the entire monitor set from data/snapshots automatically stored at the osd's". 

For example, a monitor boots:
	-keyring file and ceph.conf are available
	-monitor sees that it is missing its local copy of maps, etc.
	-goes onto the first OSD's it sees and pulls down a snapshot of the same
	-checks for another running monitor, syncs with it, if not,
	-boots at quorum 0, verifying OSD states
	-life continues.

The big deal here, is that while the entire cluster is able to recover from failures using one storage philosophy, the monitors are using an entirely different, and more legacy storage philosophy - basically local RAID/power in numbers. Perhaps this has already been considered, and I would be interested in knowing what people think here, as well. Or perhaps I missed something and this is already done?

Thanks, for your time!

Ryan Nicholson

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Ross Turk
Sent: Tuesday, August 28, 2012 1:12 PM
To: ceph-devel@vger.kernel.org
Subject: Integration work


Hi, ceph-devel! It's me, your friendly community guy.

Inktank has an engineering team dedicated to Ceph, and we want to work on the right stuff. From time to time, I'd like to check in with you to make sure that we are.

Over the past several months, Inktank's engineers have focused on core stability, radosgw, and feature expansion for RBD. At the same time, they have been regularly allocating cycles to integration work. 
Recently, this has consisted of improvements to the way Ceph works within OpenStack (even though OpenStack isn't the only technology that we think Ceph should play nicely with).

What other sorts of integrations would you like to see Inktank engineers work on? For example, are you interested in seeing Inktank spend more of its resources improving interoperability with Apache CloudStack or Eucalyptus? How about Xen?

Please share your thoughts. We want to contribute in the best way possible with the resources we have, and your input can help.

Thx,
Ross

--
Ross Turk
Community, Ceph
@rossturk @inktank @ceph



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html


