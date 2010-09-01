From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: support for multiple data placement policies
Date: Wed, 1 Sep 2010 11:44:02 -0700
Message-ID: <AANLkTi=K3ASGMoN1DTkQu-hqMzXm43eVyb64LhEqgxRC@mail.gmail.com>
References: <AANLkTin8GVQfPmV0d3xGThEMPYeRMKYuCR1b6Fk5XPre@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56382 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351Ab0IASoD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Sep 2010 14:44:03 -0400
Received: by qwh6 with SMTP id 6so6648828qwh.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Sep 2010 11:44:02 -0700 (PDT)
In-Reply-To: <AANLkTin8GVQfPmV0d3xGThEMPYeRMKYuCR1b6Fk5XPre@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: H Chang <heracles@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Sep 1, 2010 at 11:33 AM, H Chang <heracles@gmail.com> wrote:
> Hi Ceph team,
>
> I'm a newbie in Ceph, so please bear with me if my question sounds stupid.
>
> I'd like to explore the possibility to support multiple placement
> policies in Ceph.
>
> For example, suppose each user using Ceph has its own placement policy
> which may be different from one user to another.
> So, all the files created by the user and their replicas will be placed based on
> the user's policy. Essentially each user would have its own CRUSH map.
>
> Do you think Ceph could somehow be modified to support this kinda scenario?
> If so, where do we start?
>
> Regards,
> HS
This is something we've been asked about before and plan to look at in
the future. Unfortunately it may turn out to be a bit of a chore. The
CRUSH map and data distribution policies are handled by RADOS (the
underlying object store) rather than the Ceph filesystem components.
Specifying separate data placement policies for each user will require
that each user has their own RADOS pool and that those pools all be
accessible via the filesystem. Currently the Ceph filesystem has just
two pools -- one for data and one for metadata management -- and it
puts all the user's data in the "data" pool.
Anybody implementing this kind of change would also be enabling some
stronger security, which also makes it look desirable.

But it will require changing several pretty low-level structs and
modifying the metadata server and both versions of the client to
enable, so it's not a good introductory project and you shouldn't
expect it soon. :(
-Greg
