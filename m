From: Ali Maredia <ali@linuxbox.com>
Subject: Building Ceph using CMake
Date: Tue, 26 Nov 2013 17:06:51 -0500 (EST)
Message-ID: <1553187460.169.1385503611236.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <824799450.167.1385503496759.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:3928 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754402Ab3KZWGx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 26 Nov 2013 17:06:53 -0500
Received: from thunderbeast.private.linuxbox.com (thunderbeast.private.linuxbox.com [10.1.1.55])
	by aa.linuxbox.com (8.13.1/8.13.1/SuSE Linux 0.7) with ESMTP id rAQM6qqF032431
	for <ceph-devel@vger.kernel.org>; Tue, 26 Nov 2013 17:06:52 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by thunderbeast.private.linuxbox.com (Postfix) with ESMTP id B773F3FC8497
	for <ceph-devel@vger.kernel.org>; Tue, 26 Nov 2013 17:06:52 -0500 (EST)
Received: from thunderbeast.private.linuxbox.com ([127.0.0.1])
	by localhost (thunderbeast.private.linuxbox.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hVUz7TmyeLv2 for <ceph-devel@vger.kernel.org>;
	Tue, 26 Nov 2013 17:06:51 -0500 (EST)
Received: from thunderbeast.private.linuxbox.com (thunderbeast.private.linuxbox.com [10.1.1.55])
	by thunderbeast.private.linuxbox.com (Postfix) with ESMTP id 70BDD3FC848B
	for <ceph-devel@vger.kernel.org>; Tue, 26 Nov 2013 17:06:51 -0500 (EST)
In-Reply-To: <824799450.167.1385503496759.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I'm a student working on a project to make ceph build faster and to help with efforts to port ceph to other platforms using cmake. 

Using the cmake build, I have been able to build core ceph components in a little under 20 minutes. For in depth information on the work done so far there is a README.cmake file in the top-level ceph directory. Please try it out and I would love to get feedback on future editions and problems.

You can find a branch cmake in the below repo.

https://github.com/linuxbox2/linuxbox-ceph.git


Best,

Ali
