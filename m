From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: Blueprint:  Add LevelDB support to ceph cluster backend store
Date: Tue, 30 Jul 2013 22:54:15 +0000
Message-ID: <kta8j6$51o$1@ger.gmane.org>
References: <C0D1D705-4B4F-4189-ACBF-4C39D80984DA@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44632 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716Ab3GaFut (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 31 Jul 2013 01:50:49 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1V4PJ9-0000rb-OU
	for ceph-devel@vger.kernel.org; Wed, 31 Jul 2013 07:50:47 +0200
Received: from c-50-132-41-203.hsd1.wa.comcast.net ([50.132.41.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 31 Jul 2013 07:50:47 +0200
Received: from eternaleye by c-50-132-41-203.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 31 Jul 2013 07:50:47 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I posted this as a comment on the blueprint, but I figured I'd say it here:

The thing I'd worry about here is that LevelDB's performance (along with 
that of various other K/V stores) falls off a cliff for large values.

Symas (who make LMDB, used by OpenLDAP) did some benchmarking that shows 
drastic performance loss with 100KB values on both read and write: 
http://symas.com/mdb/microbench/#sec4

It's not just disk latency, either - an SSD showed the same behavior: 
http://symas.com/mdb/microbench/#sec7

I'd recommend REALLY careful benchmarking with a variety of loads (and value 
sizes).

