From: Ali Maredia <ali@linuxbox.com>
Subject: Ceph Build Using CMake Update
Date: Fri, 4 Apr 2014 18:35:05 -0400 (EDT)
Message-ID: <876358909.115.1396650905156.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <1168038206.111.1396650701045.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1706 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753036AbaDDWfO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Apr 2014 18:35:14 -0400
In-Reply-To: <1168038206.111.1396650701045.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>

Ceph Community,

Last November I presented a speed up of Ceph's build by switching from autotools to CMake. I have been able to build core ceph components and just updated my work. 

One problem I noticed in testing is that when the fastcgi and/or curl development libraries are not present, CMake runs sucessfully but has compiled errors when building it instead of print a warning or disable the rados gateway. Before you build please make sure all necessary build pre-requitsites are met. 

I would love feedback and input on future editions and problems! 

https://github.com/linuxbox2/linuxbox-ceph/tree/cmake

-Ali
