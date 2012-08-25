From: Sage Weil <sage@inktank.com>
Subject: Re: ceph bug
Date: Fri, 24 Aug 2012 19:21:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208241920340.788@cobra.newdream.net>
References: <CALJAiJWABHQCVQMVnpmNfL-+nezTVmchuBKFDPZgzrzMn-UJdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36048 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787Ab2HYCVX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Aug 2012 22:21:23 -0400
In-Reply-To: <CALJAiJWABHQCVQMVnpmNfL-+nezTVmchuBKFDPZgzrzMn-UJdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jx z <seaepigone@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sat, 25 Aug 2012, jx z wrote:
> hello!
> When I use the CEPH, ceph-mds crashes at line 2125 in
> mds/Server.cc,because the mdr->dn[0] is empty, so modify it to:
>   reply_request(mdr, 0, ref,
>   (req->get_op() == CEPH_MDS_OP_LOOKUP && !mdr->dn[0].empty()) ?
> mdr->dn[0].back() : 0);
> Is this right?

Hmm, I think if mdr->dn[0] is empty there is someting else going on.  Is 
this something you can reproduce with 'debug mds = 20'?  That should tell 
us the full picture.

Thanks!
sage


> 
> thanks
> 
> 
> name:zhangjianxin
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
