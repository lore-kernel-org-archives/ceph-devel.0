From: "Gunna (Gunneswara) Marripudi-SSI" <g.marripudi@ssi.samsung.com>
Subject: RE: dm-clock queue
Date: Fri, 6 Nov 2015 06:17:55 +0000
Message-ID: <B635C18AD584704D94E8BCDF6FB98A9B1BAEB520@SSIEXCH-MB3.ssi.samsung.com>
References: <alpine.DEB.2.00.1511021051450.24297@cobra.newdream.net>
 <20151106055806.GA14287@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.ssi.samsung.com ([207.140.43.206]:33066 "EHLO
	mx2.ssi.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbbKFGR5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Nov 2015 01:17:57 -0500
In-Reply-To: <20151106055806.GA14287@infradead.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Sage Weil <sweil@redhat.com>
Cc: "ivancich@redhat.com" <ivancich@redhat.com>, "mbenjami@redhat.com" <mbenjami@redhat.com>, "sjust@redhat.com" <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This generally refers to QoS work on Ceph.

This was discussed in one of the perf calls about a month ago; on 9/30/2015. 
https://bluejeans.com/playback/s/ZqUMSWr0fBl8GR1ZrU0OrZDnM3KnglsYxTiUG5X7oUeCixrlsANNPQFuXlPojBp9#

Please refer to the following paper for additional details.

https://www.usenix.org/legacy/event/osdi10/tech/full_papers/Gulati.pdf

Regards,

Gunna

-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org] 
Sent: Thursday, November 05, 2015 9:58 PM
To: Sage Weil
Cc: Gunna (Gunneswara) Marripudi-SSI; ivancich@redhat.com; mbenjami@redhat.com; sjust@redhat.com; ceph-devel@vger.kernel.org
Subject: Re: dm-clock queue

Can someone explain what dm-clock is?
