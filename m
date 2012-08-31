From: ramu eppa <ramu.freesystems@gmail.com>
Subject: Re: RADOS gateway and the S3 compatibility.
Date: Fri, 31 Aug 2012 04:13:30 +0000 (UTC)
Message-ID: <loom.20120831T061230-644@post.gmane.org>
References: <loom.20120827T091156-421@post.gmane.org> <loom.20120828T122919-139@post.gmane.org> <20120828160607.GC19573@splice> <loom.20120829T083049-345@post.gmane.org> <loom.20120829T133922-563@post.gmane.org> <20120830145337.GF19573@splice>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54065 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706Ab2HaENm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 31 Aug 2012 00:13:42 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1T7Ic1-0000ky-10
	for ceph-devel@vger.kernel.org; Fri, 31 Aug 2012 06:13:41 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 31 Aug 2012 06:13:41 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 31 Aug 2012 06:13:41 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

The access.log is,

192.168.1.14 - - [31/Aug/2012:09:41:32 +0530] "GET / HTTP/1.1" 200 461 "-" 
"Mozilla/4.0 (Compatible; s3; libs3 0.9; Linux x86_64)"
192.168.1.14 - - [31/Aug/2012:09:41:43 +0530] "PUT /mypol/ HTTP/1.1" 405 540 "-" 
"Mozilla/4.0 (Compatible; s3; libs3 0.9; Linux x86_64)"

Thanks,
Ramu.

