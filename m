From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: pg in creating state can't be removed?
Date: Thu, 5 Apr 2012 21:28:11 +0800
Message-ID: <CANExM-N3DQsBzG+sLoj8x3Gs4tAdRGOXu=n0Evr5yfEfq1jF=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40182 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959Ab2DEN2N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Apr 2012 09:28:13 -0400
Received: by yhmm54 with SMTP id m54so663345yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Apr 2012 06:28:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi folks,

I created a pool without adding any osds to it in the crushmap. As
expected, all pgs remains in creating state since no osds take care of
them.

However, I do expect that this pool should be able to be removed.
Currently, removing such a pool hangs forever as the pg removal has to
wait until the pg have been created. Does my expectation make sense?

Henry
