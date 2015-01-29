From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: widening Messenger::create
Date: Thu, 29 Jan 2015 11:34:15 -0500 (EST)
Message-ID: <2015410866.56.1422549255707.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1432 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756330AbbA2QeT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Jan 2015 11:34:19 -0500
Received: from thunderbeast.private.linuxbox.com (thunderbeast.private.linuxbox.com [10.1.1.55])
	by aa.linuxbox.com (8.13.1/8.13.1/SuSE Linux 0.7) with ESMTP id t0TGYHQA009399
	for <ceph-devel@vger.kernel.org>; Thu, 29 Jan 2015 11:34:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by thunderbeast.private.linuxbox.com (Postfix) with ESMTP id 5B1093FC849C
	for <ceph-devel@vger.kernel.org>; Thu, 29 Jan 2015 11:34:17 -0500 (EST)
Received: from thunderbeast.private.linuxbox.com ([127.0.0.1])
	by localhost (thunderbeast.private.linuxbox.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kN46A5j5zpyK for <ceph-devel@vger.kernel.org>;
	Thu, 29 Jan 2015 11:34:16 -0500 (EST)
Received: from thunderbeast.private.linuxbox.com (thunderbeast.private.linuxbox.com [10.1.1.55])
	by thunderbeast.private.linuxbox.com (Postfix) with ESMTP id F0C023FC848B
	for <ceph-devel@vger.kernel.org>; Thu, 29 Jan 2015 11:34:15 -0500 (EST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I'm looking at ways to pass potentially messenger-specific options through the Messenger factory.
The immediate parameter I need to provide is the number of Accelio portals to set up (this should
vary by Messenger instance), but I expect others will be needed in future.  I don't think this fits
cleanly on to the Policy mechanism, though I looked at that.  I think I'd like to provide a
generalized argument to the Messenger factory, which can do the right thing for a given Messenger
(e.g., constructor).

Thanks,

Matt

-- 
Matt Benjamin
CohortFS, LLC.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://cohortfs.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
