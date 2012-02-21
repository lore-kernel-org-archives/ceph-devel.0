From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Ceph 0.42: Cannot make RPM from spec-file (unpackaged file ceph-dencoder)
Date: Tue, 21 Feb 2012 18:41:47 +0100
Message-ID: <4008345.82nISvLeLu@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:47460 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654Ab2BURlz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Feb 2012 12:41:55 -0500
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id 6206E10C866
	for <ceph-devel@vger.kernel.org>; Tue, 21 Feb 2012 18:41:54 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

With Ceph 0.42, I am unable to create an RPM from supplied spec-file.

When running rpmbuild -ba ceph-0.42/ceph.spec, the command fails at the end 
with this:

Checking for unpackaged file(s): /usr/lib/rpm/check-files 
/root/rpmbuild/BUILDROOT/ceph-0.42-6.fc14.x86_64
error: Installed (but unpackaged) file(s) found:
   /usr/bin/ceph-dencoder


RPM build errors:
    Installed (but unpackaged) file(s) found:
   /usr/bin/ceph-dencoder

I could get it to build anyway by including the line

%{_bindir}/ceph-dencoder

in the files section of the spec file.

Regards,

	Guido
