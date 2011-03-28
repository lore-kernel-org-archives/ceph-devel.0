From: Sylar Shen <kimulaaa@gmail.com>
Subject: The stability of OSD
Date: Mon, 28 Mar 2011 12:23:43 +0800
Message-ID: <AANLkTinCNSuWXPQVaSOD82eXaRCtT5FKA=-0JFFTc51p@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61527 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab1C1E0p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2011 00:26:45 -0400
Received: by bwz15 with SMTP id 15so2141455bwz.19
        for <ceph-devel@vger.kernel.org>; Sun, 27 Mar 2011 21:26:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
I set an environment of 20 servers which include 2 MDSs, 3 MONs and 18
OSDes(3 monitors on 18 OSDes)
My version is 0.24.3 and OS is Fedora 14.
There's a problem when I was doing the writing tests.
Whether I was writing the data or not, some OSDes were randomly marked
down and out one by one after a period of time.
And when that happened, the whole performance soon got worse and worse.
I checked the /var/log/ceph/osd.log but found nothing.
So I am curious that is there anyone who has the same problem with me?
Or maybe it's just a problem of my hardware......><
--
Best Regards,
Sylar Shen
