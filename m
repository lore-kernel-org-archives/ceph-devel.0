From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/3] Generic libcephfs Java wrappers
Date: Thu, 8 Mar 2012 21:18:57 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203082117370.26661@cobra.newdream.net>
References: <4F516A20.8060901@cs.ucsc.edu> <Pine.LNX.4.64.1203070935010.8008@cobra.newdream.net>
 <3071055F-EFD8-441A-913C-B04C8BC662FF@cs.ucsc.edu>
 <FCB709D302224AD984BB00F851ACE8C2@dreamhost.com> <E6A73CCF-3C17-42C1-BA41-33E1CADA6675@cs.ucsc.edu>
 <E71CA82A2DB647E193C249D30CA491A8@dreamhost.com> <4B306D7B-E017-445D-8F76-AB0EDC7B61D7@cs.ucsc.edu>
 <B062F95691EF4CE8AB4FC02F2727C038@dreamhost.com> <BE584457-833A-4812-B74B-6764D292CCB8@cs.ucsc.edu>
 <4F596F45.5090703@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50735 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab2CIFS6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Mar 2012 00:18:58 -0500
In-Reply-To: <4F596F45.5090703@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, Greg Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Thu, 8 Mar 2012, Josh Durgin wrote:
> On 03/08/2012 06:28 PM, Noah Watkins wrote:
> > 
> > On Mar 8, 2012, at 6:16 PM, Greg Farnum wrote:
> > 
> > > > /* Returns a configuration value as a string.
> > > > * If len is positive, that is the maximum number of bytes we'll write
> > > > into the
> > > > * buffer. If len == -1, we'll call malloc() and set *buf.
> > > > * Returns 0 on success, error code otherwise. Returns ENAMETOOLONG if
> > > > the
> > > > * buffer is too short. */
> > > 
> > > Ah. Two things from that:
> > > 1) "If len == -1". Which it isn't, here.
> > > 2) There is no voodoo, that just isn't going to work. Either it was
> > > created incorrectly in reference to md_config_t::get_val, or else code got
> > > moved around without updating that documentation. :/ Options including
> > > char ** (as you said), char *&  (ewww), or?not doing that?
> > > 
> > > Anybody have thoughts on the right solution?
> > 
> > I am partial to APIs that put the burden on the caller to free/expand the
> > buffer in response to -ENAMETOOLONG. /2cents
> 
> That sounds good to me. That comment exactly describes the behavior of
> md_config_t::get_val(). It would also be cleaner if len didn't have a special
> meaning and md_config_t::get_val() used strings instead of char*. It already
> uses strings internally, and only the librados C++ api actually uses len=-1.

On a related note, I think we should be keeping a list somewhere of all 
the little annoying API changes we want to make, so that when we DO go and 
bump the SONAME we can cram it all in at once.

Something like http://ceph.newdream.net/wiki/API_change_wishlist ?

sage
