From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [ceph-users] Deprecating ext4 support
Date: Mon, 11 Apr 2016 23:54:32 +0000
Message-ID: <robbat2-20160411T234525-979122476Z@orbis-terrarum.net>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
 <alpine.DEB.2.11.1604111742010.29593@cpach.fuggernut.com>
 <570C1DBC.3040408@redhat.com>
 <910987783.8526680.1460414949416.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:52156 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755112AbcDKXyd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 11 Apr 2016 19:54:33 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 55C1A340BB4
	for <ceph-devel@vger.kernel.org>; Mon, 11 Apr 2016 23:54:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <910987783.8526680.1460414949416.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shinobu Kinjo <skinjo@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

On Mon, Apr 11, 2016 at 06:49:09PM -0400,  Shinobu Kinjo wrote:
> Just to clarify to prevent any confusion.
> 
> Honestly I've never used ext4 as underlying filesystem for the Ceph cluster, but according to wiki [1], ext4 is recommended -;
> 
> [1] https://en.wikipedia.org/wiki/Ceph_%28software%29
Clearly somebody made a copy&paste error from the actual documentation.

Here's the docs on master and the recent LTS releases.
http://docs.ceph.com/docs/firefly/rados/configuration/filesystem-recommendations/
http://docs.ceph.com/docs/hammer/rados/configuration/filesystem-recommendations/
http://docs.ceph.com/docs/master2/rados/configuration/filesystem-recommendations/

The documentation has NEVER recommended ext4.
Here's a slice of all history for that file:
http://dev.gentoo.org/~robbat2/ceph-history-of-filesystem-recommendations.patch

Generated with 
$ git log -C -C -M -p ceph/master -- \
	doc/rados/configuration/filesystem-recommendations.rst \
	doc/config-cluster/file-system-recommendations.rst \
	doc/config-cluster/file_system_recommendations.rst

The very first version, back in 2012, said:
> ``ext4`` is a poor file system choice if you intend to deploy the
> RADOS Gateway or use snapshots on versions earlier than 0.45. 


-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead, Foundation Trustee
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
