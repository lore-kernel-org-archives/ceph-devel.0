From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Best insertion point for storage shim
Date: Fri, 31 Aug 2012 11:15:47 -0400
Message-ID: <CADvuQRFoReXqk0h2f_RpG-T9KJHV2p-7zzh4ceo6jqcC0BQDtw@mail.gmail.com>
References: <00b201cd8210$077de070$1679a150$@netmass.com> <alpine.DEB.2.00.1208240938070.29719@cobra.newdream.net>
 <002f01cd8786$31b62340$952269c0$@netmass.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54804 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab2HaPQJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 11:16:09 -0400
Received: by vcbfk26 with SMTP id fk26so3384993vcb.19
        for <ceph-devel@vger.kernel.org>; Fri, 31 Aug 2012 08:16:08 -0700 (PDT)
In-Reply-To: <002f01cd8786$31b62340$952269c0$@netmass.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stephen Perkins <perkins@netmass.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Fri, Aug 31, 2012 at 10:37 AM, Stephen Perkins <perkins@netmass.com> wrote:
> Would this require 2 clusters because of the need to have RADOS keep N
> copies on one and 1 copy on the other?

That's doable with just multiple RADOS pools, no need for multiple clusters.

And CephFS is even able to pick what pool to put a file in, at the
time of its creation (see set_layout).
