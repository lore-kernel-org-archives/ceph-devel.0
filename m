From: Quenten Grasso <QGrasso@onq.com.au>
Subject: Openstack - Boot From New Volume
Date: Thu, 8 Nov 2012 00:16:03 +0000
Message-ID: <7111C6286D862F43B94FD6291D898915081DDF82@EX01.onqtel.local>
References: <509ADA6A.9000807@profihost.ag> <509AF625.8040207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.onqtel.net ([120.88.69.160]:46257 "EHLO mx1.onqtel.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752844Ab2KHAWm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 19:22:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx1.onqtel.net (Postfix) with ESMTP id 7473A8D07D
	for <ceph-devel@vger.kernel.org>; Thu,  8 Nov 2012 10:15:59 +1000 (EST)
Received: from mx1.onqtel.net ([127.0.0.1])
	by localhost (mx1.onqtel.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tklNhgobHOAp for <ceph-devel@vger.kernel.org>;
	Thu,  8 Nov 2012 10:15:58 +1000 (EST)
Received: from ex01.onqtel.local (ex01.onqtel.local [10.21.0.30])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mx1.onqtel.net (Postfix) with ESMTPS id B75B78D009
	for <ceph-devel@vger.kernel.org>; Thu,  8 Nov 2012 10:15:58 +1000 (EST)
In-Reply-To: <509AF625.8040207@inktank.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi All,

I've been looking for this bit of code for awhile how to make open stack create a VM with the dashboard with a attached/imaged volume to avoid the current multistep process of creating a vm with ceph volume.

Here's the code, thanks goes out to vishy on openstack-dev's and I've added a couple of bits to allow for downloading status and better vol naming.

Enjoy!

https://github.com/qgrasso/nova/commit/340210a7f62e9e34bcc15972d97e81eb282fddd6

https://github.com/qgrasso/nova/commit/31f6839a2c2dd72e2cc44c37cb316610b42598bd


** use at your own risk as always etc etc, :)

Regards,
Quenten 
