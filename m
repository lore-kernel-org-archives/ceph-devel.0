From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Review Request
Date: Wed, 16 Sep 2015 14:09:37 -0400
Message-ID: <55F9B061.2090300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49480 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825AbbIPSFA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Sep 2015 14:05:00 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 22EA48E69A
	for <ceph-devel@vger.kernel.org>; Wed, 16 Sep 2015 18:05:00 +0000 (UTC)
Received: from [10.3.113.191] (ovpn-113-191.phx2.redhat.com [10.3.113.191])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t8GI4w8v025535
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Wed, 16 Sep 2015 14:04:59 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Developers <ceph-devel@vger.kernel.org>

Creators of the Storage Squid,

If you're interested in less use of the allocator, you are interested in
Context* elimination. If so, please review the top two commits on the
wip-decontextualization branch of:

https://github.com/cohortfsllc/cohortfs-ceph

They provide an enhanced version of std::function that allows you to
specify how much space gets preallocated for function objects or disable
allocation entirely.

Also, I have two pull requests, wip-cxx11time and wip-cxx11concurrency
that pass check on which I would appreciate any feedback.

Thank you, Comrades!
