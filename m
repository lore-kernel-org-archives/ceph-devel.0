From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: explicitly specifying pgnum on pool creation
Date: Mon, 05 Nov 2012 10:55:31 -0800
Message-ID: <50980BA3.20709@inktank.com>
References: <alpine.DEB.2.00.1211040338400.30792@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37099 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107Ab2KESzu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 13:55:50 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so4124624pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Nov 2012 10:55:50 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211040338400.30792@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 11/04/2012 03:42 AM, Sage Weil wrote:
> The wip-explicit-pgnum changes the 'ceph osd pool create <name> <pgnum>'
> command to require the pg_num value instead of defaulting to 8.  This
> would make it harder for users to get this wrong.

I like this. It'd be great if we could add a pgnum argument to
'rados mkpool' and the corresponding librados pool_create* functions
too.

> On the other hand, it probably also breaks some scripts for deploying
> OpenStack that create volume and image pools.  :/

If those scripts are creating pools with 8 pgs, they're going to
create problems anyway. I don't mind breaking them as long as it's well
documented (i.e. release notes and docs on 'ceph osd pool create'
should mention the change).

> Ideas?
>
> The original idea was that the monitor would automagically notice when a
> small pgnum pool gets lots of objects and trigger a split.  Even if we
> don't do that, pretty soon now you'll be able to explicitly increase
> pg_num.  I still think it might be a good idea to require it up-front,
> though.

Until split is implemented and well-tested, I think it makes sense to
require it up-front. It's easy to relax that requirement later if we
want to make it more automatic.

> An alternative would be to default to a larger number (say, num_osds <<
> 2).  My concern there is that it makes it easy to create lots of pgs for
> pools that may be small, and it's still not large enough to get good
> performance for the "create pool, run rados bench" crowd.

It would also be easy to create too few pgs, and then add a bunch of
osds later.

Josh
