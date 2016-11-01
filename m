From: Willem Jan Withagen <wjw@digiware.nl>
Subject: crashing test: test-erasure-eio.sh
Date: Tue, 1 Nov 2016 02:27:48 +0100
Message-ID: <ac94ec84-bd70-5959-fea8-e78f0e0c4b51@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:56300 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965193AbcKAB1z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 31 Oct 2016 21:27:55 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id D9EAA2B07C
        for <ceph-devel@vger.kernel.org>; Tue,  1 Nov 2016 02:27:49 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I have the feeling that this could be due to the fact that the path for
the admin socket is too long.

This is my curent path under the FreeBSD jenkins:
# echo
/home/jenkins/workspace/ceph-master/build/src/test/erasure-code/testdir/test-erasure-eio/ceph-osd.1.asok
| wc
105

And note that this is the size of the absolute path. Referencing only a
relative part does not help. The limit is in the libs/kernel and starts
counting from the root /.

And what I can see from the 500Mb log output that crashes my browser...
is that the basic path with the Jenkins tests is even longer than my
FreeBSD jenkins path.

So perhaps i would be wise to reduce the path where the testdir is going
to land. Now it is:
	build/src/test/erasure-code/testdir/test-erasure-eio
and perhaps
	build/src/test/testdir/erasure-eio
would work as well.

Or even better, start putting the sockets in somewhere like:
	/var/run/ceph/testdir/.....

--WjW

