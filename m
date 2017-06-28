From: Rolland Santimano <rolland.s@flipkart.com>
Subject: Downstream IO circuit-breaker in RGW ?
Date: Wed, 28 Jun 2017 07:07:23 +0530
Message-ID: <CACiNYre28nZjMhLevyBPWLMcvu0_iayKsq8kH267y+Y3_Tccwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34416 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753066AbdF1Bho (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jun 2017 21:37:44 -0400
Received: by mail-oi0-f44.google.com with SMTP id l83so31047300oif.1
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jun 2017 18:37:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Saood Khan (Engineering Manager)" <saood.khan@flipkart.com>

(Please retain the CC list in your replies)

Our Ceph deployment is a S3 service with an SSD index pool, and HDD
data pool. We often see service outages due to blocked requests
against latent OSDs, mostly at the index pool.

I have been looking at code-changes in the RGW IO path that fence-off
latent OSDs or fast-fail IOs targeted to such OSDs; ie. something like
a circuit breaker pattern. A "retry-after" header is inserted in user
responses for such failed user requests.

The above circuit-breaker uses local knowledge at each RGW, ie. there
is no central state about latent OSDs at the MON or elsewhere -- maybe
this is something that can be piggy-backed on the OSD map maintained
by the MON, or pushed to the ceph-mgr.

Any thoughts or suggestions on the above ?

(I was not sure about the folks to target this mail to, please
re-direct as appropriate.)

-- 
Rolland
