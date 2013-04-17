From: proguest <proguest1942@hotmail.com>
Subject: Re: rados gateway
Date: Wed, 17 Apr 2013 16:58:54 +0000 (UTC)
Message-ID: <loom.20130417T185651-134@post.gmane.org>
References: <loom.20130417T164538-81@post.gmane.org> <CABBk=J8-H9DYTcdca1OjqA5X1q_Zs1oOhjEUDZJVpJSfYx6kNw@mail.gmail.com> <loom.20130417T170632-546@post.gmane.org> <CABBk=J_evJc11twOEgBN51SPq9v_aiSyf=OzYW2i9Ghd5oFhBA@mail.gmail.com> <loom.20130417T172954-546@post.gmane.org> <CABBk=J8o83Srortoe_ouR3jZX7ObtgZ+yEhez5Cz24o-2EK2jw@mail.gmail.com> <loom.20130417T183106-585@post.gmane.org> <CABBk=J9uw5WUcOvkCAuzO2R_nhNmbxzFVFFSQXM5vypVgXAykQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36797 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755568Ab3DQQ7F (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Apr 2013 12:59:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1USVhI-0006Kb-C6
	for ceph-devel@vger.kernel.org; Wed, 17 Apr 2013 18:59:04 +0200
Received: from 114-44-219-144.dynamic.hinet.net ([114.44.219.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 18:59:04 +0200
Received: from proguest1942 by 114-44-219-144.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 18:59:04 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Yehuda Sadeh <yehuda <at> inktank.com> writes:

> 
> Do you have radosgw logs?
> 
Here're radosgw log
The last two line are restart radosgw (2 times)
Others are trying to connect radosgw..

2013-04-17 14:58:24.335168 7fdb2af5c700  2 req 1:0.316409:s3:GET 
/s3gw.fcgi:list_bucket:http status=404
2013-04-17 14:58:24.336074 7fdb2af5c700  1 ====== req done req=0x7fdb240021d0 
http_status=404 ======
2013-04-17 14:58:48.987824 7fdb302af700  0 WARNING: RGWRados::log_usage(): 
user name empty (bucket=s3gw.fcgi), skipping
2013-04-17 16:28:00.331392 7f4df1a767a0 10 allocated request 
req=0x7f4de000d390
2013-04-17 16:35:55.935084 7f4de96d8700  0 monclient: hunting for new mon
2013-04-17 17:19:23.276170 7f7c596ce7a0 10 allocated request 
req=0x7f7c48010170
2013-04-17 17:20:07.184676 7f3dbe64f7a0 10 allocated request 
req=0x7f3db0001420




