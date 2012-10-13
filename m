From: Ricardo Auada <rauada@gmail.com>
Subject: Cache, Backup and S3backer
Date: Sat, 13 Oct 2012 03:25:06 +0000 (UTC)
Message-ID: <loom.20121013T051644-437@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40676 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818Ab2JMDaC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Oct 2012 23:30:02 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1TMsQO-00059i-LB
	for ceph-devel@vger.kernel.org; Sat, 13 Oct 2012 05:30:05 +0200
Received: from b1203e3e.virtua.com.br ([b1203e3e.virtua.com.br])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 13 Oct 2012 05:30:04 +0200
Received: from rauada by b1203e3e.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 13 Oct 2012 05:30:04 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, I=C2=B4m just starting to look at CEPH and some questions crossed m=
y mind. I
wonder if someone can help me with them:

1- Does Ceph use any kind of cache to improve speed access to data in O=
SD=C2=B4s ?
2- Because Ceph is usually used for big amounts of data, how can we bac=
kup /
snapshot this data ? How fast can we recover this big backup ? Or we wo=
uldn=C2=B4t
need a backup at all, due to the redundance features ? Here I mean only=
 disaster
recover backup.
3- I see Ceph has an S3 API. Also, we are studying some S3 filesystems =
and
S3backer seems to be a very nice one. What would be the differences in =
using one
or the other ?

Regards,
--
Ricardo Auada

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
