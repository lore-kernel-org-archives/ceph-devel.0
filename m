From: Kamal Mostafa <kamal@canonical.com>
Subject: Re: [BUG] backport commit ebeec2ef4c in ubuntu-vivid.git break cephfs
Date: Thu, 31 Mar 2016 07:39:21 -0700
Message-ID: <20160331143921.GB18035@whence.com>
References: <90A03E70-2B8B-4C29-9655-A73D7D4523D5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:33033 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbcCaOj1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2016 10:39:27 -0400
Content-Disposition: inline
In-Reply-To: <90A03E70-2B8B-4C29-9655-A73D7D4523D5@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: kernel-team@lists.ubuntu.com, Ceph Development <ceph-devel@vger.kernel.org>, Luis Henriques <luis.henriques@canonical.com>

On Thu, Mar 31, 2016 at 12:06:42PM +0800, Yan, Zheng wrote:
> ubuntu-vivid git tree includes commit ebeec2ef4c (ceph: fix message
> length computation), but does not contain backport for upstream commit
> 1f041a89b4 (ceph: fix request time stamp encoding). This breaks cephfs
> kernel driver completely. Please add the later commit to your git
> tree.
> 
> Regards
> Yan, Zheng

Hi Yan-

Thanks for letting us know about this.  If that patch is required for
all trees that carry a backport of 777d738 (ceph: fix message length
computation), then we'll need to apply 1f041a89b4 to:

  3.19.y-ckt (stable)
  3.16.y-ckt (stable)
  ubuntu-vivid
  ubuntu-utopic

For our reference, can you point me to a bug report or email thread
which discusses the breakage?

 -Kamal
