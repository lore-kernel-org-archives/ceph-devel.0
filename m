From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Random blocks when accessing rbd images
Date: Thu, 15 Dec 2011 17:44:55 +0100
Message-ID: <6461662.le4U8ybEo2@pc10>
References: <1404301.on6okQVZ04@pc10> <3807778.ycpoZxnZL4@pc10> <CACLRD_1LPhCC3szKfsj_pZ6-5rr=pr+P8KyWO76CxU6x0K17mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:51291 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932525Ab1LOQpA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Dec 2011 11:45:00 -0500
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id 3B35B10C866
	for <ceph-devel@vger.kernel.org>; Thu, 15 Dec 2011 17:44:59 +0100 (CET)
In-Reply-To: <CACLRD_1LPhCC3szKfsj_pZ6-5rr=pr+P8KyWO76CxU6x0K17mA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Donnerstag, 15. Dezember 2011, 08:30:26 schrieben Sie:
> 'ceph pg dump' will tell you the status (active/clean/scrubbing/etc)
> for each pg.  Does the same pg remain in state active+clean+scrubbing
> for more than 10 minutes?

Well, I used ceph -s, which only gave me a summary, but there definitely was a 
PG that was in active+clean+scrubbing for a long time (a lot longer than 10 
minutes), and remained so until I restarted one of the osds.

Unfortunately I don't know how to reliably reproduce the problem, so I can't 
check now...

	Guido
