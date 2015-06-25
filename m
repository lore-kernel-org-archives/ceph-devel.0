From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: xattrs vs. omap with radosgw
Date: Wed, 24 Jun 2015 23:46:23 -0600
Message-ID: <20150624234623.464e3292@guren.zaitcev.lan>
References: <BLU175-W13D5737A24429707F8F978DFA70@phx.gbl>
	<alpine.DEB.2.00.1506161241060.15556@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36885 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267AbbFYFq0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Jun 2015 01:46:26 -0400
In-Reply-To: <alpine.DEB.2.00.1506161241060.15556@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 16 Jun 2015 12:43:08 -0700 (PDT)
Sage Weil <sage@newdream.net> wrote:

> With hammer the size of object_info_t crossed the 255 byte boundary, which 
> is the max xattr value that XFS can inline.  We've since merged something 
> that stripes over several small xattrs so that we can keep things inline, 
> but it hasn't been backported to hammer yet.  See
> c6cdb4081e366f471b372102905a1192910ab2da.

Meanwhile, Swift stopped striping altogether:
 https://github.com/openstack/swift/commit/cc2f0f4ed6f12554b7d8e8cb61e14f2b103445a0

(but yes, it's still advantageous to fit into an inode)

-- Pete
