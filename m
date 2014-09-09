From: Sage Weil <sweil@redhat.com>
Subject: Re: Question to RWLock & reverse DNS ip=>hostname
Date: Tue, 9 Sep 2014 10:50:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409091050040.11887@cobra.newdream.net>
References: <3472A07E6605974CBC9BC573F1BC02E4AE7B5737@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57755 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbaIIRu7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Sep 2014 13:50:59 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE7B5737@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 9 Sep 2014, Andreas Joachim Peters wrote:
> Hi, 
> by chance I had a look to the RWLock class. To my best knowledge the way 
> you create RW locks it defaults to writer-starvation e.g. all readers 
> will always jump a head of a pending writer. I cannot imagine that you 
> never have the opposite requirement in the CEPH multithreaded code but I 
> didn't review where it is used. In case you are aware, you can just 
> ignore this comment, otherwise one could add the option to create a 
> writer-prefering RWLock at construction time using e.g. 
> pthread_rwlockattr_setkind_np(&attr, PTHREAD_RWLOCK_PREFER_WRITER_NP)

Hmm, I was not aware.  Perhaps we should make the reader vs writer 
preference explicit during construction?

> Another question: I couldn't find a base implementation to translate 
> IPV4/6 ip's to host names? Is there same configuration table/method 
> allowing to get back from an OSD address retrieved via 
> OSDMap::get_addr() the original host name avoiding the use of DNS 
> lookups?

I don't think we are doing reverse DNS lookups anywhere in the ceph 
code ...

sage
