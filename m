From: Adam Nielsen <a.nielsen@shikadi.net>
Subject: Re: Newbie questions
Date: Sun, 07 Oct 2012 01:05:59 +1000
Message-ID: <k4phcq$7ep$1@ger.gmane.org>
References: <k4c2dj$s3i$1@ger.gmane.org> <alpine.DEB.2.00.1210010908160.25178@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60142 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234Ab2JFPGT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 6 Oct 2012 11:06:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1TKVxN-0000mz-Hm
	for ceph-devel@vger.kernel.org; Sat, 06 Oct 2012 17:06:21 +0200
Received: from 124-170-67-40.dyn.iinet.net.au ([124.170.67.40])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 06 Oct 2012 17:06:21 +0200
Received: from a.nielsen by 124-170-67-40.dyn.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 06 Oct 2012 17:06:21 +0200
In-Reply-To: <alpine.DEB.2.00.1210010908160.25178@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Thanks both for your answers - very informative.  I think I will set up a test 
Ceph system on my home servers to try it out.

I have one more question:

Ceph seems to handle failed nodes well enough, but what about failed network 
links?  Say you have a few systems in two locations, connected by a single 
link.  If the link fails, you will have two isolated networks, each of which 
will think the other has failed and presumably will try to go on as best it 
can.  What happens when the link comes back up again?  What if the same file 
was modified by both isolated clusters when the link was down?  What version 
will end up back in the cluster?

Thanks again,
Adam.


