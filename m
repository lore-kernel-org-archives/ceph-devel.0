From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: questions on networks and hardware
Date: Sun, 20 Jan 2013 23:43:45 +0100
Message-ID: <CAJH6TXiutMfJ51G3itP83=-eSX+W9xtdPftNj0j0xcg+rHANmw@mail.gmail.com>
References: <EFFE82E1-B74B-4DAB-8801-5311FA903618@jnielsen.net>
	<CAJH6TXi40uB5Xup3xob+zVJaf6q=4dKjdgs4+NkD-fa5Bh2z0Q@mail.gmail.com>
	<6C6B937F81BD480D8B439B27D504FE9C@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38698 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab3ATWnr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Jan 2013 17:43:47 -0500
Received: by mail-wi0-f179.google.com with SMTP id o1so4449373wic.12
        for <ceph-devel@vger.kernel.org>; Sun, 20 Jan 2013 14:43:46 -0800 (PST)
In-Reply-To: <6C6B937F81BD480D8B439B27D504FE9C@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: John Nielsen <lists@jnielsen.net>, ceph-devel@vger.kernel.org

2013/1/20 Gregory Farnum <greg@inktank.com>:
> This is a bit embarrassing, but if you're actually using two networks and the cluster network fails but the client network stays up, things behave pretty badly (the OSDs will keep insisting it's failed, while the monitor will insist it's still working). I believe there's a branch working on this problem, but I haven't been involved with it.
> It's not necessary to have split networks though, no.

Ok.

> Does that answer your question?

Absolutely, but usually cluster network is faster than client network
and being forced to use two cluster network is very very expensive.
