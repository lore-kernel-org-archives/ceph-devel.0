From: Sage Weil <sage@newdream.net>
Subject: Re: Commit 13a98a972cef3560ddaa2462f8cab50a2d820cfb breaks compilation
Date: Wed, 22 Sep 2010 09:09:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009220909420.6962@cobra.newdream.net>
References: <1285152268.2392.32.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33909 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab0IVQH6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Sep 2010 12:07:58 -0400
In-Reply-To: <1285152268.2392.32.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Yep, reverted.  Thanks!
sage

On Wed, 22 Sep 2010, Wido den Hollander wrote:

> Hi,
> 
> In commit 13a98a972cef3560ddaa2462f8cab50a2d820cfb the flock type was
> moved to "flock.h", but flock.h wasn't added to the repository, thus
> breaking compilation.
> 
> Reverting to c33685764a3f0c63fab5e75fe287059b7f6d97fd gives you Ceph
> packages again :-)
> 
> Wido
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
