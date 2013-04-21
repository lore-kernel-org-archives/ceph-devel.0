From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] libceph: odds and ends
Date: Sun, 21 Apr 2013 16:12:09 -0500
Message-ID: <51745629.7080207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:38248 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab3DUVML (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Apr 2013 17:12:11 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so3875690ieb.40
        for <ceph-devel@vger.kernel.org>; Sun, 21 Apr 2013 14:12:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

(These patches, along with the patches I'll be
posting in the next few minutes, are available in
the "review/wip-stripe-v2" branch of the ceph-client
git repository.)


This series just fleshes out some code in libceph.
The first completes the set of definitions for limit
values (like U8_MAX) to include the signed minimum
and maximum values.  The second just adds some error
checking and type casting to timespec encoding and
decoding routines.

					-Alex

[PATCH 1/2] libceph: add signed type limits
[PATCH 2/2] libceph: validate timespec conversions
