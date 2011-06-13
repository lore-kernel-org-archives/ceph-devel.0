From: "Hemingway, Graham Stuart" <graham.hemingway@Vanderbilt.Edu>
Subject: libgtkmm Dependency
Date: Mon, 13 Jun 2011 09:58:29 -0500
Message-ID: <151A9CB0-0426-4C8E-A55E-B122B5ECF9C2@Vanderbilt.Edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailgate.vanderbilt.edu ([129.59.15.72]:34000 "EHLO
	mailgate.vanderbilt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831Ab1FMP4l convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jun 2011 11:56:41 -0400
Received: from hub.vanderbilt.edu ([10.1.137.38])
	by mailgate02.its.vanderbilt.edu (8.14.3/8.14.3) with ESMTP id p5DEwTl7004183
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 13 Jun 2011 09:58:29 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

I am trying to install Ceph onto a cluster of Ubuntu 10.04 servers, but apt-get is showing a requirement to install libgtkmm (plus its numerous dependencies).  Are the server-side components of Ceph really dependent on gtk?  Is there any way to get Ceph without having to install gtk and its dependencies?

Thanks,
   Graham


