From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: OSD nodes with >=8 spinners, SSD-backed journals, and their
 performance impact
Date: Tue, 15 Jan 2013 10:31:28 +0100
Message-ID: <CAJH6TXir4HL0Z7jtEg2r0Or7LygawXQHp0Ou+jF-ow1zXZAryg@mail.gmail.com>
References: <CAPUexz-D2KTf5q_Tmmm1SE3of7urrgn1T=ac_jhjxHHCe42pMA@mail.gmail.com>
	<50F40C4B.6000301@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:43273 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094Ab3AOJb3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 04:31:29 -0500
Received: by mail-wg0-f43.google.com with SMTP id e12so2560234wge.34
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 01:31:28 -0800 (PST)
In-Reply-To: <50F40C4B.6000301@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Florian Haas <florian@hastexo.com>, ceph-devel@vger.kernel.org

2013/1/14 Mark Nelson <mark.nelson@inktank.com>:
> The advice that I usually give people is that if performance is a big
> concern, try to match filestore disk and journal performance is nearly
> matched.  In my test setup, I use 1 intel 520 SSD to host 3 journals for
> 7200rpm enterprise SATA disks.  A 1:4 ratio or even 1:6 ratio may also work
> fine depending on various factors.  So far the limits I've hit with very
> minimal tuning seem to be around 15 spinning disks and 5 SSDs for around
> 1.4GB/s (2.8GB/s including journal writes) to one node.

Is this a ratio based on OSDs/SSDs or on OSDs/Server ?
For example, a server with 12 spinning disks plus 2 internal SSD should be used
for 12 OSDs. The first 6 will have journal on SSD1, the latest 6 will use SSD2.

In this case, ratio is 1:6, right?
Or are you referring to the whole server?
