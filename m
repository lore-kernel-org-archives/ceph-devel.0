From: Sage Weil <sage@inktank.com>
Subject: Re: [collectd] [PATCH 0/2] Ceph collectd plugin
Date: Thu, 7 Feb 2013 21:49:33 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302072137580.28547@cobra.newdream.net>
References: <1358558239-7651-1-git-send-email-sage@inktank.com> <20130121115201.GX15478@verplant.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36588 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab3BHFtd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 00:49:33 -0500
In-Reply-To: <20130121115201.GX15478@verplant.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Forster <octo@collectd.org>
Cc: collectd@verplant.org, ceph-devel@vger.kernel.org

Hi Florian!

Sorry for the slow reply...

On Mon, 21 Jan 2013, Florian Forster wrote:
> Hi Sage :)
> 
> thank you very much for your code!
> 
> On Fri, Jan 18, 2013 at 05:17:17PM -0800, Sage Weil wrote:
> > There is an additional patch here to properly detect the libjson
> > dependency that comes from Yves Mettier.  Feel free to adjust the
> > changelog if you want to sign it off differently or something.
> 
> other plugins that use JSON in one way or another use the "yajl" library
> [0]. How much work would it be to refactor the code to use this library
> instead?

The *_tree API Yves mentions[1] looks like it would work.  It would just 
require rewriting a bunch of code that already work, and I don't think 
I'll have time to do that any time soon.  That's not a particularly 
satisfying answer, I'm sure!  :(

Is this a blocker for getting this plugin merged?  I can fish around on 
ceph-devel and see if someone else has some time wrangle it...

Thanks!
sage

[1] http://lloyd.github.com/yajl/yajl-2.0.1/yajl__tree_8h.html
