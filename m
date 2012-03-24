From: Sage Weil <sage@newdream.net>
Subject: Re: leveldb build issues in 0.44
Date: Fri, 23 Mar 2012 17:28:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203221343230.25117@cobra.newdream.net>
References: <4F6AE7FF02000099000DD5F9@collaborate.seakr.com>
 <orfwd0e8wr.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56592 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577Ab2CXA2H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Mar 2012 20:28:07 -0400
In-Reply-To: <orfwd0e8wr.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: Nick Couchman <Nick.Couchman@seakr.com>, ceph-devel@vger.kernel.org

Hey Nick-

Can you confirm this fixes your problem?  If so I can apply this to the 
stable branch (for 0.44.1).

Thanks!
sage


On Thu, 22 Mar 2012, Alexandre Oliva wrote:

> On Mar 22, 2012, "Nick Couchman" <Nick.Couchman@seakr.com> wrote:
> 
> > ./db/builder.h:8:28: fatal error: leveldb/status.h: No such file or directory
> > compilation terminated.
> 
> > This is an RPM build
> 
> This patch fixed it for me.
> 
> 
