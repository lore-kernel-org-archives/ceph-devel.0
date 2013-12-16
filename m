From: Sage Weil <sage@inktank.com>
Subject: Re: gitbuilder make check errors
Date: Mon, 16 Dec 2013 08:00:07 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312160759380.1560@cobra.newdream.net>
References: <52AECBDD.9000705@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33987 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033Ab3LPQAH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 11:00:07 -0500
In-Reply-To: <52AECBDD.9000705@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 16 Dec 2013, Loic Dachary wrote:
> Hi,
> 
> http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-tarball-saucy-amd64-basic/log.cgi?log=58d68995c4b09c0ec10cd80cd2e16bdb4fdfffc8
> 
> Shows a failure. However the output of make check is hidden in the log 
> files. Would it be possible to display the content of the log files if 
> an error happens ?

Yeah.. it's in autobuild-ceph.git, build-*.sh (though there's an extra 
step to push it out to the gitbuilder VMs).

sage
