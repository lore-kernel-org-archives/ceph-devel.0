From: Matt Weil <mweil@genome.wustl.edu>
Subject: active MDS and disk write cache
Date: Wed, 31 Oct 2012 12:02:09 -0500
Message-ID: <50915991.3030906@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from gscsmtp.wustl.edu ([128.252.233.26]:49564 "HELO
	gscsmtp.wustl.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754341Ab2JaRMP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 13:12:15 -0400
Received: from vpn-10-1-24-221.gsc.wustl.edu (unknown [10.1.24.221])
	by gscsmtp.wustl.edu (Postfix) with ESMTPSA id DA6C140B8C
	for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 12:02:09 -0500 (CDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I have a system with a bunch or ram that I want to remain the active MDS 
but still have a backup.

This config doesn't seem to be working.  I can make linuscs92 the active 
by stopping and starting the mds on linuscs95. It would be nice for 
linuscs92 to be the active from the start.

[mds.linuscs95]
	host = linuscs95
	mds standby replay = true
	mds standby for name = linuscs92

Also about disk write cache.

If the Data center, servers and storage units are backed by redundant 
power sources, Batteries and a generator.  Is the concern for data loss 
less?

Any one turn disk write cache on and see a great improvement?

Thanks

Matt
