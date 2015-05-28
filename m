From: Dan van der Ster <dan@vanderster.com>
Subject: selinux scanning all OSD objects
Date: Thu, 28 May 2015 14:30:31 +0200
Message-ID: <CABZ+qq=-rGfsk4MJo-PWm2-9PzxxfocpH=b1CRMW1aUsF=vqbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33860 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103AbbE1MbO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 08:31:14 -0400
Received: by obew15 with SMTP id w15so31403043obe.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 05:31:13 -0700 (PDT)
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com. [209.85.214.179])
        by mx.google.com with ESMTPSA id t20sm1124070oie.22.2015.05.28.05.31.12
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2015 05:31:12 -0700 (PDT)
Received: by obew15 with SMTP id w15so31402389obe.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 05:31:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Ken,

I had forgotten about this issue:

  http://tracker.ceph.com/issues/9927

(as you see, it's similar to the updatedb indexing issue you recently
inquired about)

I didn't check, but I suspect this still affects major version
upgrades also in RHEL7. Do you think this should also be sent
upstream?

Cheers, Dan
