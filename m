From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: XioMessenger (RDMA) Status Update
Date: Tue, 13 May 2014 17:08:13 -0400 (EDT)
Message-ID: <624098295.166.1400015293897.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <1143714307.164.1400015257404.JavaMail.root@thunderbeast.private.linuxbox.com>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2027 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089AbaEMVIW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 13 May 2014 17:08:22 -0400
In-Reply-To: <1143714307.164.1400015257404.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Gregory Farnum <greg@inktank.com>, Sage Weil <sage@inktank.com>

Hi Ceph Devs,

I've pushed two Ceph+Accelio branches, xio-firefly and xio-firefly-cmake to our
public ceph repository https://github.com/linuxbox2/linuxbox-ceph.git .

These branches are pulled up to the HEAD of ceph/firefly, and also have improvements
to XioMessenger which allow:

1. operation of (at least) a minimal Ceph Mon and OSD cluster over Xio messaging alone
2. initial support for Accelio in the MDS server and Client/libcephfs (not formally tested)

There are some new config options:

(global addr) "rdma local" sets a local rdma interface address
(global bool) "cluster rdma" selects Accelio for intra-cluster communication
(global bool) "client rdma" selecs Accelio for libcephfs communications

These changes haven't been strenuously tested, we'll expect to have additional information
and likely new, simple rados bench results against this code in the next several days,
at latest.

Thanks,

Matt

-- 
Matt Benjamin
CohortFS, LLC.
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://cohortfs.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
