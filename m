From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Restarting an OSD while a RBD device is mapped leads to kernel crash
Date: Fri, 17 Aug 2012 00:01:00 +0200
Message-ID: <CAOLwVU=6K1wmBoypEuBmSg3dsmifdX+V_rv7eJKxNPOB_mFWbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:40468 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753103Ab2HPWBW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Aug 2012 18:01:22 -0400
Received: by lagy9 with SMTP id y9so1751903lag.19
        for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 15:01:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi guys,

The subject is explicit enough :). It happened quite often..

Here's a link from the monitor, sorry I don't have any kernel dump at
the moment:

http://www.sebastien-han.fr/images/ceph-kernel-crash.jpg

It happened on 2 different servers running Ubuntu 12.04 with 3.2 for
the first one and 3.5 for the second. Every node runs 0.48.1

Any insight will be appreciated :)

Cheers!
