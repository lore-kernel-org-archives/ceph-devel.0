From: "Holcombe, Christopher" <cholcomb@cscinfo.com>
Subject: New Project with Ceph
Date: Fri, 23 Nov 2012 17:31:23 +0000
Message-ID: <C4049E4484F13747B672D64B9C12C31328D93097@PWMAILM01.cscinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.cscinfo.com ([165.160.9.57]:45658 "EHLO mx1.cscinfo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752396Ab2KWRb0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 12:31:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx1.cscinfo.com (Postfix) with ESMTP id 9606D661173
	for <ceph-devel@vger.kernel.org>; Fri, 23 Nov 2012 12:31:25 -0500 (EST)
Received: from mx1.cscinfo.com ([127.0.0.1])
	by localhost (plmail01.wil.csc.local [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Is9-ThQ3KuRC for <ceph-devel@vger.kernel.org>;
	Fri, 23 Nov 2012 12:31:24 -0500 (EST)
Received: from casarray.cscinfo.com (pwmailch03.cscinfo.com [172.20.53.95])
	by mx1.cscinfo.com (Postfix) with ESMTPS id DA5BF661171
	for <ceph-devel@vger.kernel.org>; Fri, 23 Nov 2012 12:31:24 -0500 (EST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Everyone,

First email here to the developer Ceph mailing list.  Some of you may know me from the irc channel under the handle 'noob2' .  I hang out there every once in a while to ask questions and share knowledge. Last week I discussed a project I am working on in the irc channel.  Scuttlemonkey suggested I send an email off to this list with the possibility of a guest entry on the Ceph blog!  Let me describe what I am trying to accomplish:

Background : VMware Storage using Ceph.  After discovering Ceph I thought of several uses for it.  Storage is really expensive for enterprise customers and it doesn't need to be.  Going back to first principles results in the conclusion that storage hardware is very cheap now.  About 5% to 10% what enterprise customers are paying.  With that in mind I realized there is great room for improvement.  Most of the storage we use is carried over a brocade fibre network and I think Ceph is perfect for this task.  What is needed is a proxy to merge the rados back end to the fibre network.  I used LIO on a previous project and had a theory that I could use it to meet our storage needs with Ceph.  At some point in the future we will direct mount rbd over the network but we are not ready for that yet
 .

Design: Ceph already did most of the heavy lifting for me.  Triple replication, self-healing, interaction through the kernel as a block device and ability to scale easily with commodity servers.  My production Ceph cluster which I'm still in the process of getting quotes for will be HP DL180G6 servers.   Each of these will house 12 3TB data drives connected to a HP410 1GB flash backed write controller.  In building some previous clusters I learned that spending a little extra on the raid controller is usually worth it.  Our network contains 2 48 port gigabit switches in each rack for redundancy.  My plan is to use a 4 port gigabit network card and split the replication traffic off from the client traffic.  I plan on setting up 2 802.3ad aggregated links.  That should give the server about 
 2x 1.9Gb/s of bandwidth.  We are currently short on 10Gb network ports but from what I'm seeing in testing the HP raid cards can't handle enough data to make it worth it.  If that changes after tuning I can always upgrade.  We are an HP shop so my hands are a little tied.  Next is the proxy machines.  I'm going to reuse 2 older HP dl380 G5 servers that we took out of service.  One will be part of the A fabric for the fibre and the other will be on the B fabric.  This is needed for redundancy so the fibre initiator can fail back and forth should it need to.  I plan on creating rbd blocks of 1TB each on the Ceph cluster, mounting it on both of the proxy machines and exporting using LIO.  LIO has both block mode which can export any block device the kernel knows about or file mode which can
  export a file as a block device.  My testing has shown that VMware can mount this storage, vmotion vm's onto it and use it like any other SAN storage.  The only challenge I have at this point is getting the rbd devices to survive a reboot on the proxy machines.  I also will have to train the other admins on how to use it.  It is certainly more complicated than SAN storage we are used to but that shouldn't stop me.  I can build a web interface on top of this using django.  If I can achieve these without too much difficulty than Ceph is truly an enterprise storage replacement.
That's my project at a high level.  Ceph has many uses but I'm finding this use the most interesting at the moment.  When it is all finished it should save us over 90% on storage costs going forward.  If anyone knows how I could go about getting Ubuntu to save rbd mappings after a reboot that would be really helpful.  Thank you guys for your hard work!


Chris Holcombe
Unix Administrator
Corporation Service Company
cholcomb@cscinfo.com
302-636-8667


________________________________

NOTICE: This e-mail and any attachments is intended only for use by the addressee(s) named herein and may contain legally privileged, proprietary or confidential information. If you are not the intended recipient of this e-mail, you are hereby notified that any dissemination, distribution or copying of this email, and any attachments thereto, is strictly prohibited. If you receive this email in error please immediately notify me via reply email or at (800) 927-9800 and permanently delete the original copy and any copy of any e-mail, and any printout.
