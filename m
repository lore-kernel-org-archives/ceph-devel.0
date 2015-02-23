From: Sage Weil <sweil@redhat.com>
Subject: Re: -fno-omit-frame-pointer
Date: Mon, 23 Feb 2015 10:28:39 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502231021400.23553@cobra.newdream.net>
References: <alpine.DEB.2.00.1502211252520.27009@cobra.newdream.net> <54E91449.4090000@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59526 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbbBWS2l (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 Feb 2015 13:28:41 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1NISfcI005091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Mon, 23 Feb 2015 13:28:41 -0500
In-Reply-To: <54E91449.4090000@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel@vger.kernel.org

I got Brendan's flamegraphs to work without any changes on the rex fedora 
dev nodes.  See

	http://ceph.com/sage/foo.svg


This is about 10 seconds of a rados bench on a vstart cluster, so nothing 
fancy.  It's a pretty easy way to visualize where the time is spent, 
though.

A few things I noticed:

 - lots of time in DBObjectMap::set_keys (2%).  a surprising amount (>1%) 
in setxattr (kernel), too.  Hopefully NewStore can do better here.

 - the ReplicatedPG::do_request view is interesting, too.. not 
surprisingly a fair bit of time spent with the PG logs.

 - 1% spend on writing pg info and log (PG::write_if_dirty).  most of that 
in encode

sage

