From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] libceph: osd_client should not take bio reference
Date: Wed, 30 Jan 2013 14:47:32 -0600
Message-ID: <510986E4.7050901@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:36505 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab3A3Ur3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 15:47:29 -0500
Received: by mail-ia0-f173.google.com with SMTP id l29so2962545iag.18
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 12:47:29 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Currently when the osd client gets a request that involves a
bio list, it assumes the initiator (the rbd client) has taken
an extra reference to the first bio on that list.  When the
request is done, the initiator calls ceph_osdc_release_request()
and at that time the osd client drops that presumed reference.

The second patch in this series simply gets rid of that extra
reference entirely, because it's not needed.  Doing this creates
an incompatibility between differing versions of both rbd and
the osd client (libceph).  So The first patch adds a simple
compatibility check capability so it's possible to avoid
that causing any problems.

					-Alex

[PATCH 1/2] libceph: add a compatibility check interface
[PATCH 2/2] rbd: don't take extra bio reference for osd client
