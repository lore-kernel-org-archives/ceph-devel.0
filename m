From: ramu <ramu.freesystems@gmail.com>
Subject: RADOS gateway and the S3 compatibility.
Date: Mon, 27 Aug 2012 07:17:45 +0000 (UTC)
Message-ID: <loom.20120827T091156-421@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46562 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386Ab2H0HR6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Aug 2012 03:17:58 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1T5ta8-00073R-IY
	for ceph-devel@vger.kernel.org; Mon, 27 Aug 2012 09:17:56 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 09:17:56 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 09:17:56 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

  I configured radosgw and installed s3.And also created user using this 
command,"sudo radosgw-admin user create --uid=ramu --display-name=sree --
email=ram@test.com",it was created user fine,after when am creating s3 bucket 
using"s3 create -u alpha" it is showing error,

ERROR: ConnectionFailed

and s3 -u list also not working.
Please help me to create s3 bucket.

Thanks,
Ramu.

