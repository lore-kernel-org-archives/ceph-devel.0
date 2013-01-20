From: Gregory Farnum <greg@inktank.com>
Subject: Re: questions on networks and hardware
Date: Sun, 20 Jan 2013 14:23:43 -0800
Message-ID: <6C6B937F81BD480D8B439B27D504FE9C@inktank.com>
References: <EFFE82E1-B74B-4DAB-8801-5311FA903618@jnielsen.net>
 <CAJH6TXi40uB5Xup3xob+zVJaf6q=4dKjdgs4+NkD-fa5Bh2z0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:35726 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab3ATWXq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Jan 2013 17:23:46 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so2420665dak.28
        for <ceph-devel@vger.kernel.org>; Sun, 20 Jan 2013 14:23:46 -0800 (PST)
In-Reply-To: <CAJH6TXi40uB5Xup3xob+zVJaf6q=4dKjdgs4+NkD-fa5Bh2z0Q@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: John Nielsen <lists@jnielsen.net>, ceph-devel@vger.kernel.org

On Sunday, January 20, 2013 at 12:30 PM, Gandalf Corvotempesta wrote:
> 2013/1/19 John Nielsen <lists@jnielsen.net (mailto:lists@jnielsen.net)>:
> > I'm planning a Ceph deployment which will include:
> > 10Gbit/s public/client network
> > 10Gbit/s cluster network
> 
> 
> 
> I'm still trying to know if a redundant cluster networks is needed or not.
> Is ceph able to manage a cluster network failure from on OSD?
> 
> What I would like to know if ceph will monitor OSD from the public
> side (that should be redundant, because client will use it to connect
> to the cluster) or from the cluster side.
> 
This is a bit embarrassing, but if you're actually using two networks and the cluster network fails but the client network stays up, things behave pretty badly (the OSDs will keep insisting it's failed, while the monitor will insist it's still working). I believe there's a branch working on this problem, but I haven't been involved with it.
It's not necessary to have split networks though, no.

Does that answer your question?
-Greg

