From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 0/3] rbd: no need for file mapping calculation
Date: Fri, 04 Jan 2013 08:51:48 -0600
Message-ID: <50E6EC84.2060304@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:51233 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740Ab3ADOvt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 09:51:49 -0500
Received: by mail-ie0-f177.google.com with SMTP id k13so19179677iea.8
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 06:51:49 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Currently every osd request submitted by the rbd code undergoes a
file mapping operation, which is common with what the ceph file system
uses.  But some analysis shows that there is no need to do this for
rbd, because it already takes care of its own blocking of image data
into distinct objects.  Removing this simplifies things.  I especially
think removing this improves things conceptually, removing a complex
mapping operation from the I/O path.

					-Alex

[PATCH REPOST 1/3] rbd: pull in ceph_calc_raw_layout()
[PATCH REPOST 2/3] rbd: open code rbd_calc_raw_layout()
[PATCH REPOST 3/3] rbd: don't bother calculating file mapping
