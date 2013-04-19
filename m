From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: bug in rbd rename command?
Date: Fri, 19 Apr 2013 09:28:23 +0200
Message-ID: <5170F217.9020105@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:34264 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967906Ab3DSH2f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Apr 2013 03:28:35 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

if i issue rbd -p POOLNAME ... rename a b

It uses the POOL for a but not for b.

Output is then:
rbd: mv/rename across pools not supported
source pool: vmstorssd1 dest pool: rbd

Shouldn't it use the pool provided by -p for both?

Stefan
