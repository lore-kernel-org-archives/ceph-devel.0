From: ramu eppa <ramu.freesystems@gmail.com>
Subject: Re: RADOS gateway and the S3 compatibility.
Date: Tue, 4 Sep 2012 04:02:20 +0000 (UTC)
Message-ID: <loom.20120904T055945-878@post.gmane.org>
References: <loom.20120903T104858-555@post.gmane.org> <CAC-hyiESAAtXu2woKQRN6K0U=8PV8LRkMYAozMcD_yq9W9PqUA@mail.gmail.com> <loom.20120903T145424-592@post.gmane.org> <504473FC02000099000E9622@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:45106 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778Ab2IDECi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Sep 2012 00:02:38 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1T8kLV-0002Fs-Gr
	for ceph-devel@vger.kernel.org; Tue, 04 Sep 2012 06:02:37 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 04 Sep 2012 06:02:37 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 04 Sep 2012 06:02:37 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

This is the FastcgiExternalServer status in apache2,

grep -RIs "FastCgiExternalServer" /etc/apache2

/etc/apache2/httpd.conf:FastCgiExternalServer /var/www/s3gw.fcgi -socket 
/tmp/radosgw.sock
/etc/apache2/sites-available/rgw.conf:FastCgiExternalServer /var/www/s3gw.fcgi -
socket /tmp/radosgw.sock
/etc/apache2/sites-enabled/rgw.conf:FastCgiExternalServer /var/www/s3gw.fcgi -
socket /tmp/radosgw.sock


Thanks,
Ramu.

