From: Sage Weil <sage@newdream.net>
Subject: autobuilt debian/ubuntu packages
Date: Thu, 16 Jun 2011 12:09:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1106161207250.29922@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47308 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab1FPTHc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jun 2011 15:07:32 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 67840BC887
	for <ceph-devel@vger.kernel.org>; Thu, 16 Jun 2011 12:09:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 4090DBC887
	for <ceph-devel@vger.kernel.org>; Thu, 16 Jun 2011 12:09:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hey,

The URLs for the autobuilt debian/ubuntu packages have changed up a bit, 
and we're now building Ubuntu packages for natty instead of maverick.  
The new info is

	http://ceph.newdream.net/wiki/Debian#Autobuilt_unstable_packages

Basically,
 deb http://ceph.newdream.net/debian-snapshot-amd64/BRANCH/ DISTRIBUTION main

So, for example, to get the latest 'stable' branch for squeeze,
 deb http://ceph.newdream.net/debian-snapshot-amd64/stable/ squeeze main

The latest development packages for natty would be
 deb http://ceph.newdream.net/debian-snapshot-amd64/master/ natty main

If anyone wants different distributions or architectures, let me know!

sage

