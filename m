From: Amit Tiwary <tiwaryamt@gmail.com>
Subject: Re: extremely-high-unreasonable number of threads and memory usage on the client side using librados C++ api
Date: Thu, 17 Jul 2014 05:42:32 +0000 (UTC)
Message-ID: <loom.20140717T073809-116@post.gmane.org>
References: <loom.20140716T121228-862@post.gmane.org> <alpine.DEB.2.00.1407160844020.28285@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46230 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604AbaGQFmo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 17 Jul 2014 01:42:44 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1X7eSo-0004NX-GT
	for ceph-devel@vger.kernel.org; Thu, 17 Jul 2014 07:42:42 +0200
Received: from NSG-Static-099.53.71.182.airtel.in ([NSG-Static-099.53.71.182.airtel.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jul 2014 07:42:42 +0200
Received: from tiwaryamt by NSG-Static-099.53.71.182.airtel.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jul 2014 07:42:42 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil <sweil <at> redhat.com> writes:
> Increasing the open file limit is the way to address this currently.  The 
> underlying problem is that we are creating threads to service each 
> connection and there isn't a max open connection limit.  The real fix is 
> to reimplement the SimpleMessenger, but the workaround is simple enough 
> (ulimit -n) that we haven't addressed that yet.  Yes, it will consume more 
> resources than it probably should.. sorry about that!
> 
Thanks Sage. Would eagerly await work on SimpleMessenger and other items 
from this blueprint to improve threading. 
https://wiki.ceph.com/Planning/Blueprints/Giant/librados%2F%2Fobjecter%3A_im
prove_threading
--
Amit Tiwary




