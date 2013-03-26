From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/6] libceph: send osd requests in tid order
Date: Mon, 25 Mar 2013 21:25:32 -0500
Message-ID: <5151071C.3000309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:50076 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756154Ab3CZCZg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 22:25:36 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so8127184ief.7
        for <ceph-devel@vger.kernel.org>; Mon, 25 Mar 2013 19:25:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series rearranges the way osd requests are placed onto an
osd client's unsent request list so that they are kept in
order based on their transaction ids.  The osd expects its
requests from a client to have monotonically increasing tids.
Since requests are sent to the osd in the order they are on
the unsent list if we keep them sorted there this property
is preserved.

					-Alex

[PATCH 1/6] libceph: slightly defer registering osd request
[PATCH 2/6] libceph: no more kick_requests() race
[PATCH 3/6] libceph: prepend requests in order when kicking
[PATCH 4/6] libceph: keep request lists in tid order
[PATCH 5/6] libceph: send queued requests when starting new one
[PATCH 6/6] libceph: verify requests queued in order
