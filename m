From: Sage Weil <sweil@redhat.com>
Subject: removing 'rados cppool' command
Date: Fri, 6 May 2016 15:41:34 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605061538160.1841@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47274 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758144AbcEFTlY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 May 2016 15:41:24 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

This PR

	https://github.com/ceph/ceph/pull/8975

removes the 'rados cppool' command.  The main problem is that the command 
does not make a faithful copy of all data because it doesn't preserve the 
snapshots (and snapshot related metadata).  That means if you copy an RBD 
pool it will render the images somewhat broken (snaps won't be present and 
won't work properly).  It also doesn't preserve the user_version field 
that some librados users may rely on.

Since it's obscure and of limited use, this PR just removes it.

Alternatively, we could add safeguards so that it refuses to make a copy 
if there are any selfmanaged_snaps, and/or generate some warnings.  

Any objections?
sage
