From: Sage Weil <sweil@redhat.com>
Subject: some stuff for kraken
Date: Mon, 18 Apr 2016 16:39:11 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604181631320.4803@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60192 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbcDRUjQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 18 Apr 2016 16:39:16 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B014485365
	for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2016 20:39:09 +0000 (UTC)
Received: from cpach ([10.3.112.6])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u3IKd7BF017520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2016 16:39:09 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Here are some of the small/medium size items I have on my list (so I don't 
forget them).  There's also the bigger stuff (e.g., EC overwrites for RBD 
etc.).

cleanups
- objectstore: remove deprecated collection attr methods
- objectstore: object handles?
- buffer: c_str(( -> data()

compat stuff
- migrate to new IANA monitor port
- wip-addr

ops
- ceph-disk support for multiple bluestore devices
- ceph-disk support for dm-cache, bcache, etc.
- etcd for ceph config?

mon
- initial ceph-mgr separation / calamari merge
- kerberos auth?
- mon public/admin/cluster network(s)

rados
- msgr on-the-wire encryption
- crush weight anomaly
- bluestore: checksums
- bluestore: compression
- bluestore: smr
- pmstore?
- dmclock

rgw
- storage pools
- sts
- compression?
- encryption?
