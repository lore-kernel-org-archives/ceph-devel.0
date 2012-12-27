From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/3] libceph: three bug fixes
Date: Thu, 27 Dec 2012 17:09:56 -0600
Message-ID: <50DCD544.8000602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:44165 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab2L0XKA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Dec 2012 18:10:00 -0500
Received: by mail-ia0-f175.google.com with SMTP id z3so8393390iad.34
        for <ceph-devel@vger.kernel.org>; Thu, 27 Dec 2012 15:09:59 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series includes three bug fixes that should be included
in Linux 3.8.

					-Alex

[PATCH 1/3] libceph: move linger requests sooner in kick_requests()
[PATCH 2/3] libceph: always reset osds when kicking
[PATCH 3/3] libceph: WARN, don't BUG on unexpected connection states
