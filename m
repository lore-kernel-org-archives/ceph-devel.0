From: ramu eppa <ramu.freesystems@gmail.com>
Subject: Re: RADOS gateway and the S3 compatibility.
Date: Wed, 29 Aug 2012 06:33:08 +0000 (UTC)
Message-ID: <loom.20120829T083049-345@post.gmane.org>
References: <loom.20120827T091156-421@post.gmane.org> <loom.20120828T122919-139@post.gmane.org> <20120828160607.GC19573@splice>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:56614 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914Ab2H2GdV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Aug 2012 02:33:21 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1T6bq4-0001j8-HA
	for ceph-devel@vger.kernel.org; Wed, 29 Aug 2012 08:33:20 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 08:33:20 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 08:33:20 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
  
  After rebooting my system,I restarted the Apache2 but it's  not restarting,
service apache2 restart (or)/etc/init.d/apache2 restart

Syntax error on line 1 of /etc/apache2/sites-enabled/rgw.conf:
FastCgiExternalServer: redefinition of previously defined class 
"/var/www/s3gw.fcgi"
Action 'configtest' failed.
The Apache error log may have more information.
   ...fail!


Thanks,
Ramu.

