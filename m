From: Sage Weil <sweil@redhat.com>
Subject: ceph-disk improvements
Date: Fri, 1 Apr 2016 11:36:17 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604011129360.22014@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48995 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752811AbcDAPg0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 Apr 2016 11:36:26 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 72923C00EB28
	for <ceph-devel@vger.kernel.org>; Fri,  1 Apr 2016 15:36:26 +0000 (UTC)
Received: from cpach (ovpn-112-83.phx2.redhat.com [10.3.112.83])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u31FaNjm013547
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Fri, 1 Apr 2016 11:36:24 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

There are a couple of looming features for ceph-disk:

1- Support for additional devices when using BlueStore.  There can be up 
to three: the main device, a WAL/journal device (small, ~128MB, ideally 
NVRAM), and a fast metadata device (as big as you have available; will be 
used for internal metadata).

2- Support for setting up dm-cache, bcache, and/or FlashCache underneath 
filestore or bluestore.

The current syntax of

 ceph-disk prepare [--dmcrypt] [--bluestore] DATADEV [JOURNALDEV]

isn't terribly expressive.  For example, the journal device size is set 
via a config option, not on the command line.  For bluestore, the metadata 
device will probably want/need explicit user input so they can ensure it's 
1/Nth of their SSD (if they have N HDDs to each SSD).

And if we put dmcache in there, that partition will need to be sized too.

Another consideration is that right now we don't play nice with LVM at 
all.  Should we?  dm-cache is usually used in conjunction with LVM 
(although it doesn't have to be).  Does LVM provide value?  Like, the 
ability for users to add a second SSD to a box and migrate cache, wal, or 
journal partitions around?

I'm interested in hearing feedback on requirements, approaches, and 
interfaces before we go too far down the road...

Thanks!
sage
