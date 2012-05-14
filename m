From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libcephfs: return error when not mounted
Date: Mon, 14 May 2012 10:34:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205141034001.20330@cobra.newdream.net>
References: <6E886DEA-B266-4677-8206-C817595BBA86@cs.ucsc.edu>
 <CADvuQRENXm=5O+uZ8-UwGidSgbn3KvV212sPkUam9uzOyLrvMg@mail.gmail.com>
 <FC7D87FB-20FE-400E-959D-7C3FC558A89B@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52929 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756604Ab2ENReY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 May 2012 13:34:24 -0400
In-Reply-To: <FC7D87FB-20FE-400E-959D-7C3FC558A89B@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Tommi Virtanen <tv@inktank.com>, ceph-devel@vger.kernel.org, Greg Farnum <gregory.farnum@dreamhost.com>

On Mon, 14 May 2012, Noah Watkins wrote:
> On May 14, 2012, at 10:03 AM, Tommi Virtanen wrote:
> > On Fri, May 11, 2012 at 6:21 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> >> Return an error rather than a segfault if a client uses the interface
> >> when unmounted. The Java bindings were explicitly enforcing the
> >> mounted state, but this was overly complicated, uncommon, and better
> >> handled with a simple exception that can be checked at libcephfs level.
> > ...
> >> +  if (!cmount->is_mounted())
> >> +    return -EDOM;
> > 
> > Noah, this is not really about your patch, as existing code already
> > has return -EDOM, but... oh boy does the API abuse POSIX errors.
> > 
> > "Numerical argument out of domain".
> 
> :)  Yeh, i stared at errno.h for a while. Note that -EDOM is already 
> returned by mount() when it is already mounted.

Given the small number of libcephfs users, let's not be afraid to change 
it to something better.

sage
