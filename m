From: Sage Weil <sweil@redhat.com>
Subject: cephfs root_squash, multitenancy
Date: Fri, 13 Feb 2015 05:05:43 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502130457540.3131@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56120 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466AbbBMNFo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 13 Feb 2015 08:05:44 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1DD5ikv005756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Fri, 13 Feb 2015 08:05:44 -0500
Received: from redhat.com (ovpn-112-33.phx2.redhat.com [10.3.112.33])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t1DD5hWD027123
	for <ceph-devel@vger.kernel.org>; Fri, 13 Feb 2015 08:05:44 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Got this from JJ:

> The SA expanded on this by stating that there are basically three main 
> scenarios here:
>
> 1) We trust the UID/GID in a controlled environment. In which case we 
> can safely rely on the POSIX permissions. As long as root_squash is 
> available this would be fine.

I think adding a root_squash option to client/Client.cc and the ceph.ko 
should be pretty easy...

> 2) Multi-tenant systems. In these cases being able to create keyrings 
> which limit access to specified directories would be ideal.

This is mainly enforcing uid/gid and mount path in MDSAuthCap, and not 
unlike what we'll need for OpenStack Manila.  I think it's something like

 1- establish mount root inode ref when session is opened/authenticated
 2- verify in reply path that any inode we reference is beneath that point
 3- special case inodes in stray directory, hopefully in some secure-ish 
way based on where they lived previously.  (not sure how this'll work...)

> 3) Government and financial sectors, with more sensitive information. In 
> these cases the same capabilities as 2 but also the ability to have an 
> audit trail of what is accessed, when, and from where.

This one I'm happy to ignore for now... :)

sage

