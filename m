From: ramu <ramu.freesystems@gmail.com>
Subject: Re: S3 comapatible with java-rados.
Date: Tue, 21 Aug 2012 06:25:45 +0000 (UTC)
Message-ID: <loom.20120821T082125-510@post.gmane.org>
References: <loom.20120820T091919-196@post.gmane.org> <loom.20120821T072518-665@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59005 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769Ab2HUGZ7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Aug 2012 02:25:59 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1T3huY-0004WS-3a
	for ceph-devel@vger.kernel.org; Tue, 21 Aug 2012 08:25:58 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 21 Aug 2012 08:25:58 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 21 Aug 2012 08:25:58 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am installing RADOS Gateway from 
$ ./configure --with-radosgw
$ make install
It was installed.But After I did the steps from the site is 
"http://ceph.com/docs/master/radosgw/config/"
In that enable rados gateway configuration it showing the error is,

root@vu-AP480-S:/etc/apache2/sites-enabled# sudo a2ensite rgw.conf
ERROR: Site rgw.conf does not exist!

Ramu.

