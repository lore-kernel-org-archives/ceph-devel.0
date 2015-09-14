From: Sage Weil <sweil@redhat.com>
Subject: radosgw socket dir
Date: Mon, 14 Sep 2015 08:05:51 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509140801270.7530@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32900 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789AbbINPFx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 Sep 2015 11:05:53 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: osynge@suse.com
Cc: ceph-devel@vger.kernel.org

radosgw now runs as ceph:ceph under systemd.  /run/ceph-rgw is 755 owned 
as the web user.  I think this will break anybody using apache and 
fastcgi.  That's not the default, but I don't think that combo 
makes any sense anyway.

Should we...

 - make /run/ceph-rgw ceph:ceph 0755, make the sockets 770, and then make 
the user add the web user to the ceph group?

 - make /run/ceph-rgw ceph:www 0755 + group sticky bit and then make the 
sockets 770 so that the web user can open them?

 - get rid of /run/ceph-rgw entirely and let the admin do this on their 
own if they want to do fastcgi instead of civetweb?

I like of like the last option...
sage
