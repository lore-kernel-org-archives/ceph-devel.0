From: Sage Weil <sage@inktank.com>
Subject: Re: CephFS locality API RFC
Date: Thu, 14 Mar 2013 12:39:50 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303141239030.32317@cobra.newdream.net>
References: <2A330211-CC95-42FB-967C-6FAD4E1895DC@cs.ucsc.edu> <697CF5409C9749BBA0F2F86CCBDD2B17@inktank.com> <AFC48281-A237-442F-A9FA-98861A32E363@cs.ucsc.edu> <A0B382C5B48F4832B9DFA685943B5BF4@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53703 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989Ab3CNTju (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Mar 2013 15:39:50 -0400
In-Reply-To: <A0B382C5B48F4832B9DFA685943B5BF4@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 14 Mar 2013, Greg Farnum wrote:
> On Thursday, March 14, 2013 at 11:33 AM, Noah Watkins wrote:
> >  
> > On Mar 14, 2013, at 11:29 AM, Greg Farnum <greg@inktank.com (mailto:greg@inktank.com)> wrote:
> >  
> > > On Thursday, March 14, 2013 at 11:14 AM, Noah Watkins wrote:
> > > > The current CephFS API is used to extract locality information as follows:
> > > >  
> > > > First we get a list of OSD IDs:
> > > >  
> > > > ceph_get_file_extent_osds(offset) -> [OSD ID]*
> > > >  
> > > > Using the OSD IDs we can then query for the CRUSH bucket hierarchy:
> > > >  
> > > > ceph_get_osd_crush_location(osd_id) -> path
> > > >  
> > > > The path includes hostname information, but we'd still like to get the IP. The current API for doing this is:
> > > >  
> > > > ceph_get_file_stripe_address(offset) -> [sockaddr]*
> > > >  
> > > > that returns an IP for each OSD holds replicas. The order of the output list should be the same as the the OSD list, but It'd be nice to have a consistent API that deals with OSD id, making the correspondence explicit.
> > > Agreed. We should probably deprecate the get_file_stripe_address() and make them turn IDs into addresses on their own.
> >  
> >  
> >  
> > Is there an API deprecation protocol, or just -ENOTSUPP?
> Well, for the moment I was thinking sticking "DEPRECATED" next to it and not using it anywhere else ? but that is probably an acceptable choice instead. I doubt anybody's using it outside of the old Hadoop bindings. Which I am looking forward to being able to purge out of all memory?. ;)

Let's deprecate but leave in place for a while, until these bindings are 
completely done and out, and then EOPNOTSUPP the method a bit later.  
Unless those old bindings are already broken because of the preferred osd 
thing...

s 
