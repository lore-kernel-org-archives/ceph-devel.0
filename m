From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] rbd: keep reference to lingering object requests
Date: Sat, 26 Jan 2013 14:39:14 -0600
Message-ID: <51043EF2.4070305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:51216 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120Ab3AZUjQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Jan 2013 15:39:16 -0500
Received: by mail-ia0-f171.google.com with SMTP id z13so2434010iaz.30
        for <ceph-devel@vger.kernel.org>; Sat, 26 Jan 2013 12:39:16 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This series applies on top of the new rbd request code.

When an osd request is marked to linger the osd client will keep
a copy of the request, and will resubmit it if necessary.  If it
gets resubmitted, it will also call the completion routine again,
and because of that we need to make sure the associated object
request structure remains valid.  The last patch in this series
ensures that by taking an extra reference for an object request
set to linger.

					-Alex

[PATCH 1/4] rbd: unregister linger in watch sync routine
[PATCH 2/4] rbd: track object rather than osd request for watch
[PATCH 3/4] rbd: decrement obj request count when deleting
[PATCH 4/4] rbd: don't drop watch requests on completion
