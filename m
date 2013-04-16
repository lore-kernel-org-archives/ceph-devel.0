From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: ceph and efficient access of distributed resources
Date: Tue, 16 Apr 2013 09:20:18 +0200
Message-ID: <CAJH6TXhRtWQ1ypEb5JOwzp9T3Nd7A=J_6Dn0M25vXjYMg8j7fQ@mail.gmail.com>
References: <loom.20130412T055215-88@post.gmane.org>
	<51683184.9010301@inktank.com>
	<CAJH6TXgurT4yUshaH4QOgUKOaB3DqQd1-=HPshp+eH5HB7p3Hg@mail.gmail.com>
	<516C7E55.1050801@inktank.com>
	<516C8168.40402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:41627 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157Ab3DPHUT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Apr 2013 03:20:19 -0400
Received: by mail-wg0-f53.google.com with SMTP id z11so139753wgg.8
        for <ceph-devel@vger.kernel.org>; Tue, 16 Apr 2013 00:20:18 -0700 (PDT)
In-Reply-To: <516C8168.40402@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <mark.kampe@inktank.com>
Cc: Matthias Urlichs <matthias@urlichs.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2013/4/16 Mark Kampe <mark.kampe@inktank.com>:
> The entire web is richly festooned with cache servers whose
> sole raison d'etre is to solve precisely this problem.  They
> are so good at it that back-bone providers often find it more
> cash-efficient to buy more cache servers than to lay more
> fiber.  Cache servers don't merely save disk I/O, they catch
> these requests before they reach the server (or even the
> backbone).

Mine was just an example, there are many other cases where a frotnend
cache is not possible.
I think that ceph should spread reads across the whole clusters by
default (like a big RAID-1), to archieve bandwidth improvement.

Glusters does this, and also MooseFS.

What happens in case of a big file (for example, 100MB) with multiple
chunks? Is ceph smart enough to read multiple chunks from multiple
servers simultaneously or the whole file will be served by just an OSD
?
