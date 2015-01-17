From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Fri, 16 Jan 2015 18:31:46 -0800
Message-ID: <m9chio$3lp$1@ger.gmane.org>
References: <54B7D2D6.4020503@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53731 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678AbbAQCcA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 16 Jan 2015 21:32:00 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1YCJB7-0007eg-Vl
	for ceph-devel@vger.kernel.org; Sat, 17 Jan 2015 03:31:58 +0100
Received: from 50.245.141.77 ([50.245.141.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 17 Jan 2015 03:31:57 +0100
Received: from eternaleye by 50.245.141.77 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 17 Jan 2015 03:31:57 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Wido den Hollander wrote:

<snip>
> Is it a sane thing to look at 'features' which pools could have? Other
> features which might be set on a pool:
> 
> - Read Only (all write operations return -EPERM)
> - Delete Protected

There's another pool feature I'd find very useful: a WORM flag, that permits 
only create & append (at the RADOS level, not the RBD level as was an 
Emperor blueprint).

In particular, I'd _love_ being able to make something that takes Postgres 
WAL logs and puts them in such a pool, providing real guarantees re: 
consistency. Similarly, audit logs and such for compliance.

