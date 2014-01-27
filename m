From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 07/11] libceph: add ceph_pg_pool_by_id()
Date: Mon, 27 Jan 2014 09:19:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1401270919070.2149@cobra.newdream.net>
References: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com> <1390838333-32266-8-git-send-email-ilya.dryomov@inktank.com> <alpine.DEB.2.00.1401270838060.1080@cobra.newdream.net>
 <CALFYKtAiP71sMBiDK7D6c9o_0-a_Nc4aGs27ChLCZK88oWNNtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60719 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516AbaA0RTV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jan 2014 12:19:21 -0500
In-Reply-To: <CALFYKtAiP71sMBiDK7D6c9o_0-a_Nc4aGs27ChLCZK88oWNNtw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 27 Jan 2014, Ilya Dryomov wrote:
> On Mon, Jan 27, 2014 at 6:38 PM, Sage Weil <sage@inktank.com> wrote:
> > Would it make more sense to just rename and export the existing function?
> > I'm not sure __ is particularly meaningful in the context of osdmap.c...
> 
> I added a new one because __lookup_pg_pool() takes rb_root, whereas all
> existing exported osdmap functions take osdmap.  If we were to rename
> and export __lookup_pg_pool(), it should probably be changed to take
> osdmap.  What do you say?

Oh, missed that.  I think it's fine as it is then.

sage

> 
> Thanks,
> 
>                 Ilya
> 
> 
