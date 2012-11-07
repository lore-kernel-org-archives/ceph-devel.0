From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Mons network
Date: Wed, 7 Nov 2012 16:20:46 +0100
Message-ID: <CAJH6TXhtkdQZPrX3sX96b7JvHjR42y1T4ig7qHnzniPaaF2_wA@mail.gmail.com>
References: <CAJH6TXiqRbuX=8gKL9hkVd=9X3vZew5jFHwM8xe=wjpu7_+5-Q@mail.gmail.com>
	<CAPYLRzhvX3D4RUGmj=VT74=prLdxh0abeUOCGwiYOO0qQexhMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49796 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581Ab2KGPUr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 10:20:47 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so970018eek.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Nov 2012 07:20:46 -0800 (PST)
In-Reply-To: <CAPYLRzhvX3D4RUGmj=VT74=prLdxh0abeUOCGwiYOO0qQexhMQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2012/11/7 Gregory Farnum <greg@inktank.com>:
> The mons need to be reachable by everybody. They don't do a ton of
> network traffic, but 100Mb/s might be pushing it a bit low...

Some portion of my network are 10/100 with gigabit uplink.
In this portion we have many XenServer nodes that we would like to use
for mons, but maximum speed of each is 100mbit
Moving mons to the SAN will result in new hardware to buy.
