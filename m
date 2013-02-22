From: Alex Elder <elder@inktank.com>
Subject: Four miscellaneous patches
Date: Fri, 22 Feb 2013 11:15:45 -0600
Message-ID: <5127A7C1.3070609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45878 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757679Ab3BVRPt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 12:15:49 -0500
Received: by mail-ie0-f174.google.com with SMTP id k10so971725iea.5
        for <ceph-devel@vger.kernel.org>; Fri, 22 Feb 2013 09:15:49 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

The following patches address some issues that were found while
investigating a kernel rbd client performance issue this week.

These patches are available in the branch "test/wip-4234,5,7,8"
in the ceph-client git repository.

					-Alex

[PATCH] rbd: ignore zero-length requests
[PATCH] rbd: barriers are hard
[PATCH] rbd: normalize dout() calls
[PATCH] libceph: define connection flag helpers
