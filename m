From: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>
Subject: rename whilst in use
Date: Wed, 27 Feb 2013 13:59:51 +0100
Message-ID: <512E0347.4040009@risc-software.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from email.edvz.uni-linz.ac.at ([140.78.3.65]:24843 "EHLO
	email.uni-linz.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759738Ab3B0M7x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Feb 2013 07:59:53 -0500
Received: from ro.risc.uni.linz.ac.at (ro.risc.uni-linz.ac.at [193.170.32.23])
	by email.uni-linz.ac.at (Postfix) with ESMTP id 8FE1A1E8C55
	for <ceph-devel@vger.kernel.org>; Wed, 27 Feb 2013 13:59:51 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi,

I've accidently renamed a rbd object that has been in use within a
kvm-domain.

After detaching the rbd object I could rename it, but the source seems
still to be around in space:

# rbd ls -l rd | grep mysql3
mysql3.new  12000M          2

# rbd create rd/test --size 1
# rbd rename rd/test rd/mysql3
rbd: rename error: 2013-02-27 13:53:29.817863 7f3424ba8780 -1 librbd:
rbd image mysql3 already exists
(17) File exists

unfortunately my scrollback buffer isn't long enough to find out about
the actual error I got during the first rename, but it should be easy to
reproduce.
I assume this is a bug, that's why I posted it to ceph-devel directly.

Wolfgang




-- 
DI (FH) Wolfgang Hennerbichler
Software Development
Unit Advanced Computing Technologies
RISC Software GmbH
A company of the Johannes Kepler University Linz

IT-Center
Softwarepark 35
4232 Hagenberg
Austria

Phone: +43 7236 3343 245
Fax: +43 7236 3343 250
wolfgang.hennerbichler@risc-software.at
http://www.risc-software.at
