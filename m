From: Martin Maurer <martin@proxmox.com>
Subject: RE: ceph-standalone
Date: Mon, 24 Feb 2014 10:33:51 +0000
Message-ID: <258F4EBF32A18F48AEBD81186101F3145B1AD6F1@lisa.maurer-it.com>
References: <alpine.DEB.2.00.1402231225090.17508@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.maurer-it.com ([94.136.31.133]:33424 "EHLO
	proxmox.maurer-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbaBXKo0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Feb 2014 05:44:26 -0500
In-Reply-To: <alpine.DEB.2.00.1402231225090.17508@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

 > and have a usable mini-cluster.  That makes it really easy for users to play
> with the basics, like:

[Martin Maurer] 
Hello Sage,

Not the same, but another fast way to get a full OS and Ceph installed for testing (and more): Proxmox VE Ceph Server

For playing with Ceph, you can  install Proxmox VE on bare-metal, inside your favorite virtualization system (e.g. inside KVM or any other)

Here is a short video tutorial:
http://youtu.be/ImyRUyMBrwo

Wiki: 
http://pve.proxmox.com/wiki/Ceph_Server
(Note, CephFS is not yet implemented)

Martin

 


