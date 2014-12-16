From: Sage Weil <sweil@redhat.com>
Subject: Re: tcp tuning
Date: Tue, 16 Dec 2014 14:13:47 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412161413080.22847@cobra.newdream.net>
References: <alpine.DEB.2.00.1412161334200.20966@cobra.newdream.net> <5490A736.4090902@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40803 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbaLPWNt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Dec 2014 17:13:49 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBGMDmBH019785
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 16 Dec 2014 17:13:49 -0500
In-Reply-To: <5490A736.4090902@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mnelson@redhat.com
Cc: ceph-devel@vger.kernel.org

> > Disable TCP slow start on idle connections
> > net.ipv4.tcp_slow_start_after_idle = 0

This looks like it's generically applicable and sensible?

> > Disable source routing and redirects
> > net.ipv4.conf.all.send_redirects = 0
> > net.ipv4.conf.all.accept_redirects = 0
> > net.ipv4.conf.all.accept_source_route = 0

These too, tho I doubt there is much benefit.

sage
