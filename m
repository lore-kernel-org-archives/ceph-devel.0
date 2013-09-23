From: Yehuda Sadeh <yehuda@inktank.com>
Subject: rgw quota
Date: Mon, 23 Sep 2013 14:47:16 -0700
Message-ID: <CABBk=J_XYE8Pz7ZDLATVaw9atniZjZmJgv2FiEMmN3xZEp6RBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:33251 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab3IWVrR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 17:47:17 -0400
Received: by mail-ve0-f179.google.com with SMTP id c14so2942208vea.10
        for <ceph-devel@vger.kernel.org>; Mon, 23 Sep 2013 14:47:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Real short description of rgw quota feature implementation as was discussed:

1. Implement per-bucket quota

 - we already have a per-bucket total info
 - cache per-bucket info in rgw
 - define per-bucket max (can set default per system, per user, per bucket)
 - define a threshold for which operations are synchronous (e.g., 90%)
 - if bucket crossed soft threshold then before each write, update
internal cache, check that not crossed hard limit
 - update internal cache with approximated bucket info after write
 - if not crossed soft threshold then use a ttl to determine when to
re-read the bucket info
     - should reuse data log mechanism for that

2. per-user quota

 - create a new user objclass
 - move user bucket-list omap operations to objclass
 - add a new namespace to user info omap
 - add user objclass functions:
    - set buckets info
    - get total
    - update per-bucket info
 - per-user ttl should determine when to re-examine all user buckets.
This should only be used if user have had data modification since last
time all buckets were checked.
 - cache per-user total in gateway
 - if crossed soft threshold switch to sync mode (like in the bucket case)
 - touched buckets should be updated periodically (in the user buckets list)
