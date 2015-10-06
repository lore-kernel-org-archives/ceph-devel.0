From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: [ceph-users] Potential OSD deadlock?
Date: Tue, 6 Oct 2015 10:26:21 -0600
Message-ID: <CALqRxCw=tV5h-xfaxsCwwqhK=zLiP=m_iGTn+dF0Op=Uth_vPA@mail.gmail.com>
References: <CAANLjFpAXaDWQzumg1hCs=SC_0YvdYDd6vyodz5_ZBNvGWdkSw@mail.gmail.com>
	<CAANLjFqbt0y-Ri=q6hXuuS06Sgi1S6phRdb1MJTgR6LTyHPtvw@mail.gmail.com>
	<CAN=+7FVo6D2AoufELCP_qeiJ23i0XEOqQs_yYLrFNXwiiQSthw@mail.gmail.com>
	<alpine.DEB.2.00.1509221450490.11876@cobra.newdream.net>
	<CAANLjFoK4O-3GB_1b40xp-5RtbZhdSXJT5+ydUDX+dq=dBHR8w@mail.gmail.com>
	<CAANLjFrrAyhJ=JR0+K3SX6G1ZsdcUyhTqFzUn_A0+bSh0D=bkA@mail.gmail.com>
	<5602F921.3010204@redhat.com>
	<CAANLjFqTW3750rw6zCnNfcD41GjYxer05m--JAWx-YLnaxcg-Q@mail.gmail.com>
	<CAANLjFrw0AtqvHu5ioRPH7yKjV5ZqfnGKou+fKLTZukLTnLbgw@mail.gmail.com>
	<CAANLjFoafHQ1X8U7LUrvhh2h8fu3WgNpUsMDR+QkSWpfW8ad0g@mail.gmail.com>
	<alpine.DEB.2.00.1510040646020.5233@cobra.newdream.net>
	<CAANLjFqgJbLEsBYEW=bk0h+Lmop-MLX=eA7qx98h-3Z6M1x7_Q@mail.gmail.com>
	<CAANLjFruw-1yySqO=aY05c0bzuqdkBH0-WcKmyP_+JtSyA1kpQ@mail.gmail.com>
	<alpine.DEB.2.00.1510060534010.32037@cobra.newdream.net>
	<CAANLjFo==i7wivrGR9LJFs3GOrD2iQHLdCpEfR-AruHyOMLi-w@mail.gmail.com>
	<alpine.DEB.2.00.1510060737480.32037@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36414 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbbJFQ0W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Oct 2015 12:26:22 -0400
Received: by wicgb1 with SMTP id gb1so173354851wic.1
        for <ceph-devel@vger.kernel.org>; Tue, 06 Oct 2015 09:26:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1510060737480.32037@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Robert LeBlanc <robert@leblancnet.us>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users@lists.ceph.com

On Tue, Oct 6, 2015 at 8:38 AM, Sage Weil <sweil@redhat.com> wrote:
> Oh.. I bet you didn't upgrade the osds to 0.94.4 (or latest hammer build)
> first.  They won't be allowed to boot until that happens... all upgrades
> must stop at 0.94.4 first.

This sounds pretty crucial. is there Redmine ticket(s)?

- Ken
