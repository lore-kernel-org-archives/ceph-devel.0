From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Caught the first erroneous translated errorcode
Date: Sat, 17 Jun 2017 12:50:22 +0200
Message-ID: <34251a6c-a335-fe31-0705-a5fe7af9ae08@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:19331 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752726AbdFQKub (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 17 Jun 2017 06:50:31 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id AEC344322B
        for <ceph-devel@vger.kernel.org>; Sat, 17 Jun 2017 12:50:28 +0200 (CEST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I think I've found the first fact where the errno translation (ceph ->
hostos -> client-ceph ) goes wrong....

Repeatedly I get the following error:
116:
/home/jenkins/workspace/ceph-master/src/test/libradosstriper/rados-striper.sh:42:
run:  rados --pool rbd --striper put toy
file td/rados-striper/toyfile
116: 2017-06-17 12:32:05.290234 810016000 -1 libradosstriper:
RadosStriperImpl::openStripedObjectForWrite : could not set new s
ize for toyfile : rc = -125error putting rbd/toyfile: (125) Unknown
error: 125

125 is ECANCELD on Linux
but FreeBSD
#define ECANCELED       85              /* Operation canceled */

So probably the server returns ECANCELD in network format (125)
but the client does not translate back...

Now if I want to have some logging for this in Freebsd_errno.cc
What is the easiest way to get something in the logs?
What descriptor is available there?

--WjW
