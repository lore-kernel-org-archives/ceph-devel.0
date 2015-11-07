From: Martin Millnert <martin@millnert.se>
Subject: Infernalis uninstallable - jenkins virtualenv misconfiguration?
Date: Sat, 07 Nov 2015 03:08:44 +0100
Message-ID: <1446862124.12033.91.camel@millnert.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncis.millnert.se ([185.19.66.196]:45181 "EHLO mail.millnert.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030462AbbKGCIr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Nov 2015 21:08:47 -0500
Received: from pishuli (dynamic.1.9.c0255cb5b480.f46d4e0fc2a.cust.bredband2.com [31.208.64.196])
	by mail.millnert.se (Postfix) with ESMTPSA id D675E7FF8A
	for <ceph-devel@vger.kernel.org>; Sat,  7 Nov 2015 03:08:51 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

tried to install the infernalis RPMS published on
http://download.ceph.com today, but was met with the following problem:
[root@ceph-dev-clust01-mon01 tmp]# rpm -qpR ceph-9.2.0-0.el7.x86_64.rpm 
/bin/bash
/bin/sh
/bin/sh
/bin/sh
/bin/sh
/bin/sh
/home/jenkins-build/build/workspace/ceph-build-next/ARCH/x86_64/DIST/centos7/venv/bin/python
/usr/bin/env
[snip]

That "Requires: " at least doesn't work on my systems.

I confirmed by building the SRPM in my own build host (without
virtualenvs):
[anticimex@rpmbuilder-dev-app3 ceph]$ rpm -qpR
rpmbuild/RPMS/x86_64/ceph-9.2.0-0.el7.x86_64.rpm 
/bin/bash
/bin/sh
/bin/sh
/bin/sh
/bin/sh
/bin/sh
/usr/bin/env
/usr/bin/python
[snip]

Seems virtualenv on the jenkins build host is affecting some python
path/env variable in the spec file somehow. Haven't dug further.

Regards,
-- 
Martin Millnert <martin@millnert.se>

