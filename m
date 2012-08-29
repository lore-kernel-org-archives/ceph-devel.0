From: ramu eppa <ramu.freesystems@gmail.com>
Subject: Re: RADOS gateway and the S3 compatibility.
Date: Wed, 29 Aug 2012 11:41:47 +0000 (UTC)
Message-ID: <loom.20120829T133922-563@post.gmane.org>
References: <loom.20120827T091156-421@post.gmane.org> <loom.20120828T122919-139@post.gmane.org> <20120828160607.GC19573@splice> <loom.20120829T083049-345@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33972 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994Ab2H2LmA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Aug 2012 07:42:00 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1T6gel-0006es-SP
	for ceph-devel@vger.kernel.org; Wed, 29 Aug 2012 13:42:00 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 13:41:59 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 13:41:59 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

   After starting apache2 ,The s3 -u list command working properly,but s3 -u 
create mytest was not working it is showing error is,
ERROR:XMLParseFailure
And error.log is,

[Wed Aug 29 16:34:53 2012] [notice] FastCGI: process manager initialized (pid 
5531)
[Wed Aug 29 16:34:53 2012] [notice] Apache/2.2.22 (Ubuntu) 
mod_fastcgi/mod_fastcgi-SNAP-0910052141 Phusion_Passenger/2.2.11 configured -- 
resuming normal operations
[Wed Aug 29 16:34:59 2012] [notice] Graceful restart requested, doing restart
[Wed Aug 29 16:34:59 2012] [alert] FastCGI: read() from pipe failed (0)
[Wed Aug 29 16:34:59 2012] [alert] FastCGI: the PM is shutting down, Apache 
seems to have disappeared - bye
apache2: Could not reliably determine the server's fully qualified domain name, 
using 127.0.1.1 for ServerName
[Wed Aug 29 16:34:59 2012] [notice] FastCGI: process manager initialized (pid 
5699)
[Wed Aug 29 16:34:59 2012] [notice] Apache/2.2.22 (Ubuntu) 
mod_fastcgi/mod_fastcgi-SNAP-0910052141 Phusion_Passenger/2.2.11 configured -- 
resuming normal operations
[Wed Aug 29 16:35:07 2012] [notice] caught SIGTERM, shutting down
[Wed Aug 29 16:35:08 2012] [notice] FastCGI: process manager initialized (pid 
5808)
PHP Deprecated:  Comments starting with '#' are deprecated in 
/etc/php5/apache2/conf.d/ming.ini on line 1 in Unknown on line 0
[Wed Aug 29 16:35:10 2012] [notice] Apache/2.2.22 (Ubuntu) 
mod_fastcgi/mod_fastcgi-SNAP-0910052141 Phusion_Passenger/2.2.11 PHP/5.3.10-
1ubuntu3.2 with Suhosin-Patch configured -- resuming normal operations
[Wed Aug 29 16:36:43 2012] [notice] caught SIGTERM, shutting down
[Wed Aug 29 16:36:44 2012] [notice] FastCGI: process manager initialized (pid 
6000)
PHP Deprecated:  Comments starting with '#' are deprecated in 
/etc/php5/apache2/conf.d/ming.ini on line 1 in Unknown on line 0
[Wed Aug 29 16:36:44 2012] [notice] Apache/2.2.22 (Ubuntu) 
mod_fastcgi/mod_fastcgi-SNAP-0910052141 Phusion_Passenger/2.2.11 PHP/5.3.10-
1ubuntu3.2 with Suhosin-Patch configured -- resuming normal operations
Thanks,
Ramu.

