From: Sage Weil <sage@newdream.net>
Subject: rados pool object listing suckage
Date: Wed, 11 May 2011 14:57:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105111445100.14296@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60209 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702Ab1EKV5H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2011 17:57:07 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 44973BC77D
	for <ceph-devel@vger.kernel.org>; Wed, 11 May 2011 14:57:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 1452CBC77D
	for <ceph-devel@vger.kernel.org>; Wed, 11 May 2011 14:57:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The ability to list objects in rados pools is something we originally 
added to round out the librados interface and to support the requirements 
of radosgw (S3 and swift both let you list objects in buckets).  The 
current interface is stateless.  You iterate over the PGs in the pool, and 
for each one, request up to N objects.  The result has up to N results and 
(optionally) a cookie to continue and get more objects for that pg. 
Currently, that cookie is a readdir offset from the directory on the 
server.

The problem is that we currently list objects based only on what we have 
on disk.  If the PG is degraded and we're recovery, we miss any objects 
that aren't yet copied locally.

Because the 'list all objects in a pool' operation consists of many 
smaller requests, and there is no state to associate them, it's hard to 
solve this one correctly.  The osd _knows_ which objects are missing at 
all times, but it needs to include those in the results in a sane way.

My original thought was use the low 2^63 values of the offset/cookie to 
represent any (potentially) missing objects and use that as an index into 
the missing set, and then use the high values to represent the readdir 
offset.  That's easy enough to do (and I just did), but because recovery 
is progressing while the client is doing the series of list-objects calls, 
you can get duplicates (client sees an object while it was missing, and 
also sees it later when it was on disk).  Conversely, if a pg starts out 
as not degraded, we may return no missing objects, and later return an 
incomplete set of on-disk objects because the primary changed.

This approach can be hacked if the client restarts the whole process (for 
a given pg) when the primary changes (because, for any given pg mapping, 
the missing set will also shrink or stay the same).  That will work, but 
will potentially return some objects twice.

I'm not having any bright ideas how to solve this more gracefully given 
the current client/server request format.  Any other suggestions?  Would 
making the client/server exchange more stateful help?  A simple answer 
would be to defer all list requests until the pg recovery completes, but 
that is probably unacceptable from an availability standpoint (and worse 
than dups in the response).

sage
