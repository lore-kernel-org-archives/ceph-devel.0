From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: flatten rbd export / export-diff ?
Date: Tue, 04 Jun 2013 15:39:55 +0200
Message-ID: <51ADEE2B.4050403@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:40261 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337Ab3FDNj7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jun 2013 09:39:59 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

is there a way to flatten the rbd export-diff to a "new" image FILE. Or
do i always have to:

rbd import "OLD BASE IMAGE"
rbd import-diff diff1
rbd import-diff diff1-2
rbd import-diff diff2-3
rbd import-diff diff3-4
rbd import-diff diff4-5
...
and so on?

I would like to apply the diffs on local disk and then import the new file.

Stefan
