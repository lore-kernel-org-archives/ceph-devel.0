From: Loic Dachary <loic@dachary.org>
Subject: rgw backports
Date: Thu, 13 Oct 2016 12:37:17 +0200
Message-ID: <57FF63DD.1090806@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:52973 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbcJMKhV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2016 06:37:21 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Matt,

The following jewel backports 

http://tracker.ceph.com/issues/17322
http://tracker.ceph.com/issues/17319
http://tracker.ceph.com/issues/17313

conflict when trying to cherry-pick them and I would appreciate your advice on how to handle them. Should they be resolved or do you think the best action is to try to backport the commits that could prevent the conflict ? If you don't have an opinion it's also fine, I'll figure it out ;-)

Cheers
-- 
Loïc Dachary, Artisan Logiciel Libre
