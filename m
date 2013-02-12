From: "ymorita000@gmail.com" <ymorita000@gmail.com>
Subject: primary pg and replica pg are placed on the same node under
 "ssd-primary" rule
Date: Tue, 12 Feb 2013 12:40:45 -0800
Message-ID: <CAA4Vorr0wN32_-xOmsCQivT5q3WbLbB2WqS2uUK7znjKengtgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:56465 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757140Ab3BLUkq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Feb 2013 15:40:46 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm14so627025wib.10
        for <ceph-devel@vger.kernel.org>; Tue, 12 Feb 2013 12:40:45 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I am trying to test a storage tiering using the following
"ssd-primary" rule set introduced in the Ceph page. However, there
seems to be a chance that primary pg and replica pg are placed on the
same node.

Is there any way to avoid this at this point in time?

      rule ssd-primary {
              ruleset 4
              type replicated
              min_size 0
              max_size 10
              step take ssd
              step chooseleaf 1 type host
              step emit
              step take platter
              step chooseleaf -1 type host
              step emit
      }

Ceph - CRUSH Maps
http://ceph.com/docs/master/rados/operations/crush-map/#placing-different-pools-on-different-osds

Thank you.
Yuji
