From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: wip-claim-2
Date: Mon, 8 Dec 2014 16:48:16 -0500 (EST)
Message-ID: <1732608241.235.1418075296547.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <1582070360.233.1418075135946.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:4580 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520AbaLHVsY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 8 Dec 2014 16:48:24 -0500
In-Reply-To: <1582070360.233.1418075135946.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@newdream.net>

Hi devs,

We've created a new branch wip-claim-2, and new pull request https://github.com/linuxbox2/linuxbox-ceph/pull/3
based on review feedback.

The big change is to replace "volatile" with "sharable", and replace "strong_claim()" with "clone_nonsharable()."
This may not be perfect, feedback appreciated.  It does remove the overloading of "claim()", which people found
confusing.

Thanks!

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
