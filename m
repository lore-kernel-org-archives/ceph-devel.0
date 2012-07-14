From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] vstart: use absolute path for keyring
Date: Fri, 13 Jul 2012 17:28:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1207131727400.3266@cobra.newdream.net>
References: <EAE9FF3D-13E6-46CB-8D2F-31AE0C1D583A@cs.ucsc.edu> <CADvuQRFptoXhEUCkwP6Uobwu7YXy5dv0nFDCWVvtO4iJ=M+0pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57030 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755839Ab2GNA2j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jul 2012 20:28:39 -0400
In-Reply-To: <CADvuQRFptoXhEUCkwP6Uobwu7YXy5dv0nFDCWVvtO4iJ=M+0pA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel@vger.kernel.org

On Fri, 13 Jul 2012, Tommi Virtanen wrote:
> On Fri, Jul 13, 2012 at 5:01 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> > Stores absolute path to the generated keyring so that tests running in
> > other directories (e.g. src/java/test) can simply reference the
> > generated ceph.conf.
> 
> Perhaps relative paths in ceph.conf should be interpreted as relative
> to the config file? That's a fairly standard convention in other
> software..

Good idea.  That'll mean some changes in teh config code.  ..

In the meantime, I'll apply this!

sag
