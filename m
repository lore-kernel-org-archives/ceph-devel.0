From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: Question to RWLock & reverse DNS ip=>hostname
Date: Tue, 9 Sep 2014 13:54:22 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE7B5737@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:48618 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784AbaIINyY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Sep 2014 09:54:24 -0400
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi, 
by chance I had a look to the RWLock class. To my best knowledge the way you create RW locks it defaults to writer-starvation e.g. all readers will always jump a head of a pending writer. I cannot imagine that you never have the opposite requirement in the CEPH multithreaded code but I didn't review where it is used. In case you are aware, you can just ignore this comment, otherwise one could add the option to create a writer-prefering RWLock at construction time using e.g.
pthread_rwlockattr_setkind_np(&attr, PTHREAD_RWLOCK_PREFER_WRITER_NP)

Another question: I couldn't find a base implementation to translate IPV4/6 ip's to host names?
Is there same configuration table/method allowing to get back from an OSD address retrieved via OSDMap::get_addr() the original host name avoiding the use of DNS lookups?

Thanks Andreas.



