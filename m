From: Ken Dreyer <kdreyer@redhat.com>
Subject: proposal to stop using "backport: " in commit logs
Date: Mon, 13 Apr 2015 10:48:09 -0600
Message-ID: <552BF349.50909@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47358 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932150AbbDMQsK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 Apr 2015 12:48:10 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3DGmAda020829
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Mon, 13 Apr 2015 12:48:10 -0400
Received: from mbp.ktdreyer.com (vpn-62-245.rdu2.redhat.com [10.10.62.245])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3DGm9Uf020086
	for <ceph-devel@vger.kernel.org>; Mon, 13 Apr 2015 12:48:10 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

A while ago this came up in #ceph-devel and I wanted to bring it to a
wider audience.

Should we stop the convention of adding the "backport: " tags in Git?

Loic brought up the point that this data is essentially immutable after
we merge it, and it's better to point at a Redmine tracker where we can
alter the "backport" field.

This makes it easier to adjust the "backport" data after the code's been
merged to master. It also makes it easier for whoever is corralling the
backport efforts, because the person only have one place to look
(Redmine) instead of two (Redmine + git commit logs).

For what it's worth I agree with Loic on this.

Any objections?

- Ken
