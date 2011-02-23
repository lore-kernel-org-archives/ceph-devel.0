From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: g_conf.id, g_conf.name, g_conf.type and friends
Date: Wed, 23 Feb 2011 14:28:41 -0800
Message-ID: <20110223222841.GB30697@dreamer>
References: <AANLkTi=zwxN0RW-gjejEONnvpR+RyVUTdx4mWB1qh=En@mail.gmail.com>
 <20110223221353.GA30697@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:40458 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754196Ab1BWW2l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Feb 2011 17:28:41 -0500
Content-Disposition: inline
In-Reply-To: <20110223221353.GA30697@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Feb 23, 2011 at 02:13:53PM -0800, Tommi Virtanen wrote:
> > *** g_conf.type: nobody seems to know what this is.
> > It seems like at one point, g_conf.type was intended to be one of
> > "auth", "mon", "osd", "mds", or "client".
> 
> This seems to be tied to cconf's use of "type" as in sections "osd0"
> and "osd.0" are both type=osd, id=0. So, it soudns to be like it's
> there mostly to get around the fact that config section names are not
> predictable.

On a related note, this was fairly frustrating to debug:

$ cauthtool --create-keyring --gen-key --name=foo.42 test
creating test
$ cat test
[client.42]
	key = AQCBiWVNuCl4ABAAJjvKiiQvtksfOJtJV8sR9A==
	auid = 18446744073709551615

I hate it when programs silently ignore what I explicitly tell them to
do. cauthtool ignores --name= if it doesn't fit it's expectations.
Why aren't the key names just unique strings?

-- 
:(){ :|:&};:
