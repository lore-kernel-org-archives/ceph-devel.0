From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 07/11] libceph: add ceph_pg_pool_by_id()
Date: Mon, 27 Jan 2014 19:14:45 +0200
Message-ID: <CALFYKtAiP71sMBiDK7D6c9o_0-a_Nc4aGs27ChLCZK88oWNNtw@mail.gmail.com>
References: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
	<1390838333-32266-8-git-send-email-ilya.dryomov@inktank.com>
	<alpine.DEB.2.00.1401270838060.1080@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:58589 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473AbaA0ROq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jan 2014 12:14:46 -0500
Received: by mail-we0-f178.google.com with SMTP id t60so5475149wes.23
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jan 2014 09:14:45 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1401270838060.1080@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jan 27, 2014 at 6:38 PM, Sage Weil <sage@inktank.com> wrote:
> Would it make more sense to just rename and export the existing function?
> I'm not sure __ is particularly meaningful in the context of osdmap.c...

I added a new one because __lookup_pg_pool() takes rb_root, whereas all
existing exported osdmap functions take osdmap.  If we were to rename
and export __lookup_pg_pool(), it should probably be changed to take
osdmap.  What do you say?

Thanks,

                Ilya
