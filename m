From: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Subject: Re: 0.61 Cuttlefish / ceph-deploy missing
Date: Wed, 15 May 2013 13:08:42 +0200
Message-ID: <20130515110842.GA28468@oder.mch.fsc.net>
References: <alpine.DEB.2.00.1305061744430.9909@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:55354 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755975Ab3EOLJt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 May 2013 07:09:49 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1305061744430.9909@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

Hi Sage,
I'm a little bit confused about 'ceph-deploy' in 0.61:

. the 0.61 release note says: "ceph-deploy: our new deployment tool to replace 'mkcephfs'"
. http://ceph.com/docs/master/rados/deployment/mkcephfs/
	says "To deploy a test or development cluster, you can use the mkcephfs tool. 
	We do not recommend using this tool for production environments."
. http://ceph.com/docs/master/rados/deployment/
	says "MKCEPHFS (DEPRECATED)
	(...) As of Ceph v0.60, it is deprecated in favor of ceph-deploy."

But, /usr/sbin/mkcephfs is provided by the ceph*0.61.2*rpm(s)
whereas ceph-deploy is missing.

The only way to get ceph-deploy seems to be using git:
git clone https://github.com/ceph/ceph-deploy.git


Is this the way it should be ?
When will ceph-deploy be included in the Cuttlefish rpms ?


Best Regards,
-Dieter


On Tue, May 07, 2013 at 04:51:25AM +0200, Sage Weil wrote:
> Spring has arrived (at least for some of us), and a new stable release of 
> Ceph is ready!  Thank you to everyone who has contributed to this release!
> 
> Bigger ticket items since v0.56.x "Bobtail":
> 
>  * ceph-deploy: our new deployment tool to replace 'mkcephfs'
(...)
