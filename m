From: ramu <ramu.freesystems@gmail.com>
Subject: Re: S3 comapatible with java-rados.
Date: Tue, 21 Aug 2012 09:06:53 +0000 (UTC)
Message-ID: <loom.20120821T110501-143@post.gmane.org>
References: <loom.20120820T091919-196@post.gmane.org> <loom.20120821T072518-665@post.gmane.org> <loom.20120821T082125-510@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47902 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754758Ab2HUJHI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Aug 2012 05:07:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1T3kQU-0001Th-SI
	for ceph-devel@vger.kernel.org; Tue, 21 Aug 2012 11:07:07 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 21 Aug 2012 11:07:06 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 21 Aug 2012 11:07:06 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

    And also create bucket using this command"s3 -u create test"
But it is showing error,

root@vu-AP480-S:/home/vu# export S3_ACCESS_KEY_ID=NUQ18TE2DPLGIQAJN83B
root@vu-AP480-S:/home/vu# export 
S3_SECRET_ACCESS_KEY=hLgKCloH+ZI4rWAnS3JH89zSFd9lMXbA6lwpbqRr
root@vu-AP480-S:/home/vu# export S3_HOSTNAME=rgw.node32
root@vu-AP480-S:/home/vu# s3 -u create alpha
s3: command not found
root@vu-AP480-S:/home/vu# s3 -u list
s3: command not found



