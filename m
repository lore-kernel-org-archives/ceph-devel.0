From: Sage Weil <sage@newdream.net>
Subject: Re: projects
Date: Sat, 3 Sep 2011 15:33:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109031532190.12865@cobra.newdream.net>
References: <Pine.LNX.4.64.1108291206370.14548@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46056 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab1ICW20 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Sep 2011 18:28:26 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 9E5F6BC749
	for <ceph-devel@vger.kernel.org>; Sat,  3 Sep 2011 15:33:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 78CF7BC749
	for <ceph-devel@vger.kernel.org>; Sat,  3 Sep 2011 15:33:52 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1108291206370.14548@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've added several more items to the projects wiki page:

	http://ceph.newdream.net/wiki/Projects

A few worth mentioning:

* Clean java libceph bindings. There are some basic libceph Java bindings 
in src/client/hadoopclient that are used by the current hadoop shim. These 
should be cleaned up a bit, moved, and packaged properly to provide 
generic libceph java bindings (of which the hadoop shim would be just one 
user). See http://tracker.newdream.net/issues/814.

* libvirt storage pool. libvirt already has basic support for describing 
individual RBD images and launching KVM/qemu with them. It would be great 
to add support for a libvirt storage pool that uses librbd to view/manage 
all images in a single rados pool. See 
http://ceph.newdream.net/gitbuilder-deb-amd64/.

* Wireshark dissector. We wrote a wireshark plugin a while back that 
understands the basic ceph on-wire protocol. It also parses some of the 
more common message types. It needs to be dusted off and updated, and 
ideally even pushed upstream. See http://tracker.newdream.net/issues/131/.

sage
