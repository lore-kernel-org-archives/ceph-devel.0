From: ramu eppa <ramu.freesystems@gmail.com>
Subject: RADOS gateway and the S3 compatibility.
Date: Mon, 3 Sep 2012 08:51:46 +0000 (UTC)
Message-ID: <loom.20120903T104858-555@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52299 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754797Ab2ICIwA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Sep 2012 04:52:00 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1T8SNy-0001t8-Qy
	for ceph-devel@vger.kernel.org; Mon, 03 Sep 2012 10:51:59 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 03 Sep 2012 10:51:58 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 03 Sep 2012 10:51:58 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
   I configured radosgateway through,
"http://ceph.com/docs/master/radosgw/config/" this documentation.

But after restarting apache2 server, 
it was not starting and it was showing error.

The error is,
Starting web server apache2.
                                                                                                      
Syntax error on line 1 of /etc/apache2/sites-enabled/rgw.conf.

FastCgiExternalServer:redefinition of previously defined class 
"/var/www/s3gw.fcgi".

Action 'start' failed.
The Apache error log may have more information.

There is no error logs in apache2 error.log file.
Please help me to radosgw and s3.

Thanks,
Ramu.

