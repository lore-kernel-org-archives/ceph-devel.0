From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: loadable objectstore
Date: Fri, 10 Apr 2015 18:03:39 -0400 (EDT)
Message-ID: <1395275405.143.1428703419864.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2184 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756504AbbDJWDr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Apr 2015 18:03:47 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada.Kari@sandisk.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Varada,

I pushed branch hammer-osfactory to https://github.com/linuxbox2/ceph.git

It can at least provide a starting point for discussion, if not a jumping off
point;  I do think it's basically what Sage described.

I was able to update the CMake build system to build the tree, I haven't
attempted Autotools. :(

Regards,

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
