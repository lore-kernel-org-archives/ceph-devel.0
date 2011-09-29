From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: radosgw: shadow objects
Date: Fri, 30 Sep 2011 00:14:26 +0800
Message-ID: <CANExM-MPCAj9pzZUSciMrSxg+r=VJ9J9GUH88U-MvzDsyZJp7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48338 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab1I2QO1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Sep 2011 12:14:27 -0400
Received: by iaqq3 with SMTP id q3so838826iaq.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Sep 2011 09:14:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

With radosgw, I noticed that after the actual objects are deleted, the
shadow objects still remains. I am wondering when the shadow object
will be deleted. Is it a bug or on purpose?
My used data size keeps growing...

Henry
