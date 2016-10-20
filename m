From: Loic Dachary <loic@dachary.org>
Subject: jewel: bad rados_buffer_free from librados python bindings
Date: Thu, 20 Oct 2016 10:35:34 +0200
Message-ID: <580881D6.2070603@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:39428 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933928AbcJTIfk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Oct 2016 04:35:40 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

H Sage,

It looks like http://tracker.ceph.com/issues/15454 surfaced in jewel (failed twice in a row at http://tracker.ceph.com/issues/17487#note-19). It did not occur before, therefore I suspect it's a side effect of some of the commits in the jewel backports integration branch ( http://tracker.ceph.com/issues/17487#note-16 ), but I don't see which commit in that branch could have caused that kind of misbehavior.

Since you marked http://tracker.ceph.com/issues/15454 as Resolved with no commits attached, I suppose it means it went away for some reason. Could you please confirm ? 

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
