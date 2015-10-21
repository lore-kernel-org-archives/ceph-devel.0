From: Sage Weil <sage@newdream.net>
Subject: Re: what does ms_objecter do in OSD ?
Date: Wed, 21 Oct 2015 05:39:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510210538490.16833@cobra.newdream.net>
References: <CAKZcxgfPKv1Y8MJtwdbE9pOih-rjJecZNObXc-a7ce_M_KU-jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60908 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbbJUMjk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Oct 2015 08:39:40 -0400
In-Reply-To: <CAKZcxgfPKv1Y8MJtwdbE9pOih-rjJecZNObXc-a7ce_M_KU-jw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jaze Lee <jazeltq@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 21 Oct 2015, Jaze Lee wrote:
> Hello,
>    I find this messenger do not bind to any ip, so i do not know why we do that.
>    Does any one know what ms_object can do ? Thanks a lot.

It is the librados client that is used by the rados copy-from operation 
and for cache tiering (to read/write to other OSDs).  It doesn't bind to 
an IP because it is the client side.

sage
