From: John Leach <john@brightbox.co.uk>
Subject: librados: failed to decode message of type 59 v1: buffer::end_of_buffer
Date: Mon, 24 Sep 2012 22:14:39 +0100
Message-ID: <5060CD3F.7060101@brightbox.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp201.iad.emailsrvr.com ([207.97.245.201]:59123 "EHLO
	smtp201.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab2IXVVd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Sep 2012 17:21:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp30.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 89BFA20775
	for <ceph-devel@vger.kernel.org>; Mon, 24 Sep 2012 17:14:41 -0400 (EDT)
Received: by smtp30.relay.iad1a.emailsrvr.com (Authenticated sender: john-AT-brightbox.co.uk) with ESMTPSA id 4386B205CB
	for <ceph-devel@vger.kernel.org>; Mon, 24 Sep 2012 17:14:41 -0400 (EDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm calling rados_ioctx_pool_stat and it's hanging.

logs show:

> 2012-09-24 21:30:08.411947 7f0041251700 failed to decode message of type 59 v1: buffer::end_of_buffer
> 2012-09-24 21:30:08.412286 7f0043255700 monclient: hunting for new mon

my local client is the Ubuntu Precise provided librados2 package
(0.41-1ubuntu2.1)

my cluster is running the unstable packages provided by Ceph
(0.51-1precise).

If I upgrade my client just up to the stable 0.48.1argonaut-1precise
package, it fixes the problem.

If the protocol changed, then I'd expect librados would let me know. Is
there some way to check this? rados_version returns the version of the
library, but I can't see how to get the version of the cluster (or quite
how I'd compare them in a meaningful way).

Thanks,

John.
--
UK multi-zone cloud: http://brightbox.com
