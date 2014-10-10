From: Samuel Just <sam.just@inktank.com>
Subject: Firefly v0.80.6 issues 9696 and 9732
Date: Fri, 10 Oct 2014 15:17:15 -0700
Message-ID: <CA+4uBUa7=DU1KkutKNm_A3_Tkg5A90sf=M+2Lpwa2iroS7Hf3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44042 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbaJJWRR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 18:17:17 -0400
Received: by mail-lb0-f174.google.com with SMTP id p9so3895037lbv.19
        for <ceph-devel@vger.kernel.org>; Fri, 10 Oct 2014 15:17:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

We've gotten some reports of a couple of issues on v0.80.6:

1) #9696: mixed clusters (or upgrading clusters) with v0.80.6 and
pre-firefly osds/mons can hit an assert in PG::choose_acting during
backfill.  The fix appears to be to remove the assert
(wip-9696[-firefly]).

2) #9731: there is a bug in PGLog::IndexedLog::trim() which can cause
a segfault.  The bug primarily triggers on OSDs which recently
upgraded from any version prior to v0.80.6 (wip-9731[-firefly])

You may want to hold off on v0.80.6, particularly on upgrades, until
we have a point release out with fixes.  The fixes appear to be
simple, we hope to have a .7 release out next week.
-Sam
