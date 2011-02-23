From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: g_conf.id, g_conf.name, g_conf.type and friends
Date: Wed, 23 Feb 2011 14:13:53 -0800
Message-ID: <20110223221353.GA30697@dreamer>
References: <AANLkTi=zwxN0RW-gjejEONnvpR+RyVUTdx4mWB1qh=En@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39196 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817Ab1BWWNx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Feb 2011 17:13:53 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=zwxN0RW-gjejEONnvpR+RyVUTdx4mWB1qh=En@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Feb 23, 2011 at 01:58:19PM -0800, Colin Patrick McCabe wrote:
> *** g_conf.id: this is a username or a daemon name, depending on the program.
> It defaults to "admin" for our various command-line tools, but can be
> changed by the -i command-line argument.
> For an MDS, this would be "a" or "b", or similar.

Noob question: why not 0, 1, ..?

> *** g_conf.type: nobody seems to know what this is.
> It seems like at one point, g_conf.type was intended to be one of
> "auth", "mon", "osd", "mds", or "client".

This seems to be tied to cconf's use of "type" as in sections "osd0"
and "osd.0" are both type=osd, id=0. So, it soudns to be like it's
there mostly to get around the fact that config section names are not
predictable.

-- 
:(){ :|:&};:
