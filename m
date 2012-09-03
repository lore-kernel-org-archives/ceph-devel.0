From: ramu eppa <ramu.freesystems@gmail.com>
Subject: Re: RADOS gateway and the S3 compatibility.
Date: Mon, 3 Sep 2012 12:56:17 +0000 (UTC)
Message-ID: <loom.20120903T145424-592@post.gmane.org>
References: <loom.20120903T104858-555@post.gmane.org> <CAC-hyiESAAtXu2woKQRN6K0U=8PV8LRkMYAozMcD_yq9W9PqUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54191 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753114Ab2ICM4a (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Sep 2012 08:56:30 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1T8WCb-0001eT-5n
	for ceph-devel@vger.kernel.org; Mon, 03 Sep 2012 14:56:29 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 03 Sep 2012 14:56:29 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 03 Sep 2012 14:56:29 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

  I disabled the default configuration and enable rgw.conf.But am getting same 
error.

Syntax error on line 1 of /etc/apache2/sites-enabled/rgw.conf:
FastCgiExternalServer: redefinition of previously defined class 
"/var/www/s3gw.fcgi"
Action 'configtest' failed.
The Apache error log may have more information.
   ...fail!

please help me to configure radosgw and s3.

Thanks,
Ramu.

