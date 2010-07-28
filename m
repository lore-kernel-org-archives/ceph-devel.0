From: Sage Weil <sage@newdream.net>
Subject: Re: Roadmap to production
Date: Wed, 28 Jul 2010 11:25:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007271024060.28672@cobra.newdream.net>
References: <i29ckr$lab$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41858 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab0G1SXK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jul 2010 14:23:10 -0400
In-Reply-To: <i29ckr$lab$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Thu, 22 Jul 2010, Thomas Mueller wrote:
> reading http://ceph.newdream.net/roadmap/ leaves me with some 
> questions. :)
> 
> * is there some roadmap when CEPH will be official announced "production 
> ready" 

These are good questions.  :)

I've made the Ceph site link directly into the redmine roadmap, where 
we'll be maintaining a detailed set of issues (features, bugs) for each 
upcoming release along with a target release date.  The roadmap now 
includes a v1.0, which will be something we at least will cautiously 
deploy in production.  I would like to get there (or close to it) by the 
end of the year.

I prefer to avoid "production ready" as that is a bit of a subjective 
term.  Different people have different stability requirements and 
expectations.  That said, I would like v1.0 to be something I am 
comfortable encouraging people to use in real (but non-critical) 
deployments.

> * and will there be commercial support for it?

Yes.  We haven't settled on exactly what form that will take (what the 
support contract terms will look like, whether there will be a 
semi-independent entity, etc.), but that will be settled once we get 
closer to v1.0.

sage
