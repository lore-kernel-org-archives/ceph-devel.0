From: Mark Nelson <mnelson@redhat.com>
Subject: Re: AsyncMessenger maturity
Date: Thu, 16 Jun 2016 03:45:29 -0500
Message-ID: <1351ac7a-468c-47b1-5ce2-38ce10f81404@redhat.com>
References: <DB5PR05MB160725A2A9228123780F67CFA9550@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <alpine.DEB.2.11.1606151412450.6221@cpach.fuggernut.com>
 <CACJqLyYuTDKobwLjSCEmY4Kk+AsiAaX06AX1M6dieBfObBbAuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43617 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619AbcFPIpi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Jun 2016 04:45:38 -0400
In-Reply-To: <CACJqLyYuTDKobwLjSCEmY4Kk+AsiAaX06AX1M6dieBfObBbAuw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>, Sage Weil <sage@newdream.net>
Cc: Avner Ben Hanoch <avnerb@mellanox.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


> Recently we tested on a ~70 osds cluster used as rgw case. We can
> obverse ~20% performance improvement compared to simple while do
> cosbench benchmark. I'm not sure the actual reason now, but I guess in
> a resource-limited env, async behavior much better.
>

I've noticed that async messenger especially does much better when the 
memory allocator is not specifically optimized.  When it is, sometimes 
simplemessenger did better in my old tests.  I need to retest now though 
to see if that is still the case.  It's good to hear you are seeing 
better performance with async messenger now!

Mark
