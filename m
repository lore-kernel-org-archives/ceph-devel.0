From: Sage Weil <sage@newdream.net>
Subject: Re: firewall questions
Date: Thu, 21 May 2015 08:37:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505210837480.23818@cobra.newdream.net>
References: <555CE992.10703@redhat.com> <alpine.DEB.2.00.1505201551450.23818@cobra.newdream.net> <555DFB71.6050602@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56345 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867AbbEUPh6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 11:37:58 -0400
In-Reply-To: <555DFB71.6050602@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 21 May 2015, Ken Dreyer wrote:
> On 05/20/2015 04:53 PM, Sage Weil wrote:
> >> 2. I talked recently with Sam about the possible ports an OSD could use,
> >> and our conversation made me think that our firewall docs for OSDs and
> >> MDSs might need to be updated: http://tracker.ceph.com/issues/11688
> >>
> >> Currently the docs say "calculate the number of OSDs or MDSs you're
> >> running and that will tell you what ports to open". That makes it hard
> >> to write a service definition for firewalld, since those are just a list
> >> of static ports.
> > 
> > Yeah, I'm afraid it should just be teh full range we allow... I think 
> > 6800-7100 by default?
> 
> src/common/config_opts.h from master says:
> 
>   OPTION(ms_bind_port_min, OPT_INT, 6800)
>   OPTION(ms_bind_port_max, OPT_INT, 7300)
> 
> I think that would mean we'd want to open 6800-7300 by default?
> 
> And for this firewalld service name, I was thinking of naming this
> 6800-7300 rule "ceph", since it encompasses both the OSD and MDS
> services. Does that name sound ok? (And I'd name the 6789 rule "ceph-mon".)

Yep, sounds good to me!

sage
