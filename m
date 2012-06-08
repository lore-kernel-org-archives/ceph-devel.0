From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: Re: mds dump
Date: Fri, 08 Jun 2012 15:22:28 -0400 (EDT)
Message-ID: <cacaf6c2-6adf-456e-85b3-b33a4f477cf7@mail.linserv.se>
References: <Pine.LNX.4.64.1206080857530.8391@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 195-67-7-55.customer.telia.com ([195.67.7.55]:40003 "EHLO
	mail.linserv.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983Ab2FHTWm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 15:22:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.linserv.se (Postfix) with ESMTP id E59ABDA033
	for <ceph-devel@vger.kernel.org>; Fri,  8 Jun 2012 15:22:28 -0400 (EDT)
Received: from mail.linserv.se ([127.0.0.1])
	by localhost (mail.linserv.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id scTeh80DVKr0 for <ceph-devel@vger.kernel.org>;
	Fri,  8 Jun 2012 15:22:28 -0400 (EDT)
Received: from mail.linserv.se (mail.linserv.se [195.67.7.55])
	by mail.linserv.se (Postfix) with ESMTP id 35A51DA031
	for <ceph-devel@vger.kernel.org>; Fri,  8 Jun 2012 15:22:28 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.1206080857530.8391@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello and thanks,

I have removed the data and metadata pool. Do I need to create them again, or 
will they be created automaticly.
Maybe I need the undocumented way of creating the mds map ?. I would like to
get an empty cephfs to play with again.

 /Best Regards Martin

> On Fri, 8 Jun 2012, Tommi Virtanen wrote: 
> > On Fri, Jun 8, 2012 at 12:35 AM, Martin Wilderoth 
> > <martin.wilderoth@linserv.se> wrote: 
> > > And if i just want to mkfs or similar in mds is that possible. Or or my rbd will 
> > > also be removed ? Or how should I recover if I don't care of the data in 
> > > the POSIX file system ? 
> > 
> > By default, the Ceph Distributed File System puts file metadata in the 
> > pool "metadata", and file contents in the pool "data". RBD images, by 
> > default, are stored in the pool "rbd". This means you can empty/remove 
> > the pools "metadata" and "data" without affecting RBD. 
> 
> There is also an undocumented way to recreate a new mdsmap (mds cluster) 
> without affecting the rest of cluster. Is that what you're after? 
> 
> sage 
