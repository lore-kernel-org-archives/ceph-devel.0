From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Questions about OSD recovery
Date: Wed, 8 Feb 2012 10:54:14 +0800
Message-ID: <CANExM-NCijMZX89Bp6wOGkLmkqKeqiqhnMJ8VKKN_QSQXnm7LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43642 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756927Ab2BHCyP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Feb 2012 21:54:15 -0500
Received: by iacb35 with SMTP id b35so173946iac.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Feb 2012 18:54:14 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

I did some experiments on the OSD and had some questions about it.

I removed one object directly from the osd data store. As expected,
the osd didn't notice it until I manually scrubbed the pg. However,
the scrubbing doen't trigger the recovery automatically. I had to do
'ceph pg repair' to fix it.

So, my first question is: can the recovery process be triggered
automatically once the scrubbing has detected the inconsistency?

Then, I tried again and removed another object. But this time, I
didn't scrub the pg. I restarted the osd. As expected, the osd didn't
notice that, either.

My second question is: is it possible to check the existence of the
objects when scanning the pg during osd startup? Does it make sense to
do so?

Regards,
Henry
