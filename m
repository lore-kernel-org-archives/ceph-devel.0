From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Clarification on role of PGs
Date: Tue, 15 Feb 2011 12:19:49 -0800
Message-ID: <20110215201949.GB14510@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56882 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154Ab1BOUTs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Feb 2011 15:19:48 -0500
Received: from dreamer (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 982B12C18C
	for <ceph-devel@vger.kernel.org>; Tue, 15 Feb 2011 12:19:48 -0800 (PST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi. I'm reading the thesis, and wondering what the thinking is behind
how Ceph uses the placement groups (PGs).

It seems that CRUSH is used for a deterministic, pseudorandom mapping,
object_id --> pg --> osds. I'm wondering why the extra level of PGs
was felt desirable, why that isn't just object_id --> osds.

Colin explained on IRC that the primary OSD for a PG is responsible
for some managerial duties, but that just tells me *how* PGs are used;
not *why*. Surely you could organize these responsibilities
differently, e.g. manage replication of an object on an
object-by-object basis, by the primary OSD for that object.

-- 
:(){ :|:&};:
