From: Dan van der Ster <dan@vanderster.com>
Subject: unit test for messaging crc32c
Date: Thu, 18 Jun 2015 09:36:00 +0200
Message-ID: <CABZ+qqndvbGM-nK8FDsyaC=iEV_B6-WxR87ndOuJu6oZ=qXcXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:36567 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409AbbFRHgo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Jun 2015 03:36:44 -0400
Received: by lacny3 with SMTP id ny3so48891747lac.3
        for <ceph-devel@vger.kernel.org>; Thu, 18 Jun 2015 00:36:42 -0700 (PDT)
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com. [209.85.215.51])
        by mx.google.com with ESMTPSA id ky7sm1557295lab.37.2015.06.18.00.36.41
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2015 00:36:41 -0700 (PDT)
Received: by labbc20 with SMTP id bc20so48919966lab.1
        for <ceph-devel@vger.kernel.org>; Thu, 18 Jun 2015 00:36:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

We've recently experienced a broken router than was corrupting packets
in way that the tcp checksums were still valid. There has been some
resulting data corruption -- thus far the confirmed corruptions were
outside of Ceph communications -- but it has made us want to double
check the Ceph messenger crc32c code.

We have crc32c enabled (as default), and I expected to find some "bad
crc" messages logged on the clients and/or osds, but thus far we
haven't found any.

Is there a unit test which validates this mechanism, e.g. one which
intentionally corrupts a Message then confirms that the crc code drops
it? I didn't find anything relevant in src/test/, but I'm not too
familiar with the framework.

Thanks in advance, Dan
