From: Mark Nelson <mnelson@redhat.com>
Subject: Fun probably useless QMC PG distribution simulation
Date: Fri, 12 Feb 2016 16:46:45 -0600
Message-ID: <56BE60D5.1050300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42787 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbcBLWqs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Feb 2016 17:46:48 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id D3EE8804E0
	for <ceph-devel@vger.kernel.org>; Fri, 12 Feb 2016 22:46:48 +0000 (UTC)
Received: from [10.3.112.52] (ovpn-112-52.phx2.redhat.com [10.3.112.52])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1CMkja7009853
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Fri, 12 Feb 2016 17:46:47 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi All,

In my spare time I've started playing around with an idea I've been 
kicking around since the Inktank days.  Basically I wanted to see what 
would happen if I tried to use a quasi-monte-carlo method like a Halton 
Sequence for distributing PGs.

The current toy code is here:

https://github.com/markhpc/pghalton

So the good news is that as expected, the distribution quality is 
fantastic, even at low PG counts.  Remapping is inexpensive so long as 
the bucket count is near what was specified in the original mapping, but 
every bucket removal (or reinsertion) increases the remapping cost by 
1/<bucket count>.  IE if you have 70/100 OSDs out, and 1 comes back up, 
you have ~30% data movement, the same cost in fact if 30 OSDs came back 
up.  Adding new buckets is also going to be difficult, probably 
requiring a doubling of the buckets and then marking some of them out to 
avoid remapping the entire sequence.

I think it would be fairly easy to re-partition the space in this 
approach to allow for arbitrary weighting and you could probably do 
something vaguely crush like with hierarchical placement.  The data 
movement problem is the big issue.  I suspect you could do some kind of 
fancy tree structure to reduce the remapping cost, but I don't think it 
would every be as good as crush.

Anyway, thought people might interesting in playing with it and maybe it 
will get someone's noodle going to think up other exotic ideas. :)

Mark
