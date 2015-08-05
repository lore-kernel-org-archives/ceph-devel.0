From: Srikanth Madugundi <srikanth.madugundi@gmail.com>
Subject: civetweb health check
Date: Wed, 5 Aug 2015 09:37:06 -0700
Message-ID: <CACAg-u9r6jXW7C5dWes3_AnkGkXvzS_vhmw044i4n0mAc31oUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:33060 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649AbbHEQhH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Aug 2015 12:37:07 -0400
Received: by ioii16 with SMTP id i16so54942108ioi.0
        for <ceph-devel@vger.kernel.org>; Wed, 05 Aug 2015 09:37:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

We are planning to move our radosgw setup from apache to civetweb. We
were successfully able to setup and run civetweb on a test cluster.

The radosgw instances are fronted by a VIP with currently checks the
health by getting /status.html file, after moving to civetweb the vip
is unable to get the health of radosgw server using /status.html
endpoint and assumes the server is down.

I looked at ceph radosgw documentation and did not find any
configuration to rewrite urls. What is the best approach for VIP to
get the health of radosgw?

Thanks
Srikanth
