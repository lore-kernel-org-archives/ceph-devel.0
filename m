From: Luis Periquito <periquito@gmail.com>
Subject: radosgw with openstack auth v3
Date: Tue, 6 Oct 2015 10:03:51 +0100
Message-ID: <CACx0BdPJsOO39XGZPFr_TXk4+xSsw5_yU6fG2Ahw_B2cBNkttA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:36107 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbbJFJDv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Oct 2015 05:03:51 -0400
Received: by obcgx8 with SMTP id gx8so148921186obc.3
        for <ceph-devel@vger.kernel.org>; Tue, 06 Oct 2015 02:03:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I was trying to get radosgw to authenticate using API v3, as I thought
it would be relatively straightforward, but my C++ is not up to
standard.

That and the time it takes to compile and make the radosgw binary is
way too long. Is there a way to just compile radosgw so I can make the
tests quickly?

I can share all the progress I made, and share some thoughts. I also
have a complete setup that I can use to test the solution.

Is there anyone currently looking into this?

thanks,
