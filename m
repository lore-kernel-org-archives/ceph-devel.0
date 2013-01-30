From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH] PGMap: fix -Wsign-compare warning
Date: Wed, 30 Jan 2013 18:52:24 +0100
Message-ID: <1359568344-7310-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:50633 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751638Ab3A3Rwc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Jan 2013 12:52:32 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix -Wsign-compare compiler warning:

mon/PGMap.cc: In member function 'void PGMap::apply_incremental
 (CephContext*, const PGMap::Incremental&)':
mon/PGMap.cc:247:30: warning: comparison between signed and
 unsigned integer expressions [-Wsign-compare]

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/mon/PGMap.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mon/PGMap.cc b/src/mon/PGMap.cc
index ae089bd..02ae6e9 100644
--- a/src/mon/PGMap.cc
+++ b/src/mon/PGMap.cc
@@ -244,7 +244,7 @@ void PGMap::apply_incremental(CephContext *cct, const Incremental& inc)
   stamp_delta += delta_t;
 
   pg_sum_delta.stats.add(d.stats);
-  if (pg_sum_deltas.size() > MIN(1, cct ? cct->_conf->mon_stat_smooth_intervals : 1)) {
+  if (pg_sum_deltas.size() > (std::list< pair<pool_stat_t, utime_t> >::size_type)MIN(1, cct ? cct->_conf->mon_stat_smooth_intervals : 1)) {
     pg_sum_delta.stats.sub(pg_sum_deltas.front().first.stats);
     stamp_delta -= pg_sum_deltas.front().second;
     pg_sum_deltas.pop_front();
-- 
1.8.1.1

