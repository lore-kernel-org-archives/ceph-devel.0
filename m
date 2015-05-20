From: Sage Weil <sage@newdream.net>
Subject: Re: firewall questions
Date: Wed, 20 May 2015 15:53:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505201551450.23818@cobra.newdream.net>
References: <555CE992.10703@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53437 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335AbbETWxs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 May 2015 18:53:48 -0400
In-Reply-To: <555CE992.10703@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 20 May 2015, Ken Dreyer wrote:
> It would be really convenient to have human-readable firewalld service
> definitions for Ceph, so that users could do things like:
> 
>   firewall-cmd --add-service=ceph-mon
> 
> or
> 
>   firewall-cmd --add-service=ceph
> 
> ... instead of having to know specific port numbers to open.
> 
> In order to submit service definitions to firewalld upstream, I had a
> couples questions:
> 
> 1. In April there was a mailing list thread about the IANA #821110
> ticket Sage filed for ceph-mon. Did anything come of that? I filed
> http://tracker.ceph.com/issues/11689 to track this in Redmine.

Not yet.  Was waiting for someone to suggest a port they liked off 
the free list and then got distracted.

Either way, though, we should make an interim rule on the current ports 
since the transition will take a while.

> 2. I talked recently with Sam about the possible ports an OSD could use,
> and our conversation made me think that our firewall docs for OSDs and
> MDSs might need to be updated: http://tracker.ceph.com/issues/11688
> 
> Currently the docs say "calculate the number of OSDs or MDSs you're
> running and that will tell you what ports to open". That makes it hard
> to write a service definition for firewalld, since those are just a list
> of static ports.

Yeah, I'm afraid it should just be teh full range we allow... I think 
6800-7100 by default?

> 3. Lastly, on a scale of "yeah, sounds do-able" to "everything will come
> to a grinding halt", how hard would it be to run with firewalls enabled
> in our sepia and typica labs that are running Teuthology? :) Do our
> Teuthology tests use TCP ports outside of 80, 6789, and 6800-7300 ?

Civetweb binds to 7280 (?) by default, but I don't think we use it on that 
port in teuthology.  Soo... I think it'll work!

s
