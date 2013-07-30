From: Yehuda Sadeh <yehuda@inktank.com>
Subject: blueprint: rgw bucket scalability
Date: Mon, 29 Jul 2013 17:38:18 -0700
Message-ID: <CABBk=J9ZcRBbL54d2w5KUT+-4MjPHCotO5==kVsimB=28hqvmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f47.google.com ([209.85.212.47]:46503 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab3G3AiT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jul 2013 20:38:19 -0400
Received: by mail-vb0-f47.google.com with SMTP id h10so3258146vbh.20
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jul 2013 17:38:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I created a new blueprint that discusses rgw bucket scalability:

http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rgw:_bucket_index_scalability

As was brought up on the mailing list recently, bucket index may serve
as a contention point. There are a few suggestions in how to solve /
mitigate the issue, and we'd like to discuss these at CDS. If you want
to participate in the discussion, please add yourself to the blueprint
as an interested party.

Yehuda
