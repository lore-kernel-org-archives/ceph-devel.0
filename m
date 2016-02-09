From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Jenkins error in running tests ....
Date: Tue, 9 Feb 2016 10:25:53 +0100
Message-ID: <56B9B0A1.6090807@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:11323 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753375AbcBIJZ7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 9 Feb 2016 04:25:59 -0500
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 131391534E5
	for <ceph-devel@vger.kernel.org>; Tue,  9 Feb 2016 10:25:56 +0100 (CET)
Received: from [IPv6:2001:4cb8:3:1:803c:86a1:8c68:7aa4] (unknown [IPv6:2001:4cb8:3:1:803c:86a1:8c68:7aa4])
	by smtp.digiware.nl (Postfix) with ESMTP id C3126153401
	for <ceph-devel@vger.kernel.org>; Tue,  9 Feb 2016 10:25:54 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

https://jenkins.ceph.com/job/ceph-pull-requests/1261/console

.......
PASS: test/osd/osd-scrub-repair.sh
make[5]: execvp: /bin/sh: Argument list too long
make[5]: *** [test-suite.log] Error 127
make[5]: Leaving directory 
`/home/jenkins-build/build/workspace/ceph-pull-requests/src'
make[4]: *** [check-TESTS] Error 2
make[4]: Leaving directory 
`/home/jenkins-build/build/workspace/ceph-pull-requests/src'
make[3]: *** [check-am] Error 2	

I'm assuming that it is not something I did in my code.
But then again I've been proven wrong....

--WjW
