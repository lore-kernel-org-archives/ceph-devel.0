From: Sage Weil <sweil@redhat.com>
Subject: who is using radosgw with civetweb?
Date: Wed, 25 Feb 2015 11:31:54 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46557 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753013AbbBYTb6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 25 Feb 2015 14:31:58 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, ceph-devel@vger.kernel.org

Hey,

We are considering switching to civetweb (the embedded/standalone rgw web 
server) as the primary supported RGW frontend instead of the current 
apache + mod-fastcgi or mod-proxy-fcgi approach.  "Supported" here means 
both the primary platform the upstream development focuses on and what the 
downstream Red Hat product will officially support.

How many people are using RGW standalone using the embedded civetweb 
server instead of apache?  In production?  At what scale?  What 
version(s) (civetweb first appeared in firefly and we've backported most 
fixes).

Have you seen any problems?  Any other feedback?  The hope is to (vastly) 
simplify deployment.

Thanks!
sage
