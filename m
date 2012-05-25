From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: ceph.spec does not list libuuid as build time dependency
Date: Fri, 25 May 2012 15:33:35 +0200
Message-ID: <3826033.JGMXqDMo11@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:35784 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752783Ab2EYNdk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 25 May 2012 09:33:40 -0400
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id 28E9C10C866
	for <ceph-devel@vger.kernel.org>; Fri, 25 May 2012 15:33:39 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Building ceph 0.47.2 from the included ceph.spec file fails:

checking for uuid_parse in -luuid... no
configure: error: in `/home/guido/rpmbuild/BUILD/ceph-0.47.2':
configure: error: libuuid not found
See `config.log' for more details
error: Bad exit status from /var/tmp/rpm-tmp.SdK9Ms (%build)


RPM build errors:
    Bad exit status from /var/tmp/rpm-tmp.SdK9Ms (%build)

It works after installing libuuid-devel. Maybe that package ought to be listed 
as a dependency in ceph.spec.

Regards,
	Guido

