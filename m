From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 0/4] rbd: four minor patches
Date: Thu, 03 Jan 2013 13:04:33 -0600
Message-ID: <50E5D641.2010405@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:45760 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682Ab3ACTEg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 14:04:36 -0500
Received: by mail-ia0-f175.google.com with SMTP id z3so12825214iad.6
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 11:04:35 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm re-posting my patch backlog, in chunks that may or may not
match how they got posted before.  This series contains some
pretty fairly straightforward changes.

					-Alex

[PATCH REPOST 1/4] rbd: document rbd_spec structure
[PATCH REPOST 2/4] rbd: kill rbd_spec->image_name_len
[PATCH REPOST 3/4] rbd: kill rbd_spec->image_id_len
[PATCH REPOST 4/4] rbd: use kmemdup()
