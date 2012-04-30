From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: rados import/export
Date: Mon, 30 Apr 2012 10:51:56 -0700
Message-ID: <CAORUGqAwzAmOdFQkgNA=6c6_4NxyL+wX4rJ=0xGG-V=dCCfzzg@mail.gmail.com>
References: <CANExM-MCR7wZMyn-gEw7Mx6j-eq2-nw_jLHMYOaK2v+5JRS3Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:62386 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab2D3RwR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Apr 2012 13:52:17 -0400
Received: by vbbff1 with SMTP id ff1so2233481vbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Apr 2012 10:52:16 -0700 (PDT)
In-Reply-To: <CANExM-MCR7wZMyn-gEw7Mx6j-eq2-nw_jLHMYOaK2v+5JRS3Yg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Apr 29, 2012 at 20:31, Henry C Chang <henry.cy.chang@gmail.com> wrote:
> Then, I traced the codes a little bit. It seems the problem is that we
> do not export/import the omaps (stored in leveldb) of the objects.
> Since v0.44, we employed leveldb to store the key/value maps. I think
> we need to take care of the omaps as well during backup and restore.

Yup, it seems you are correct. I filed ticket
http://tracker.newdream.net/issues/2362 for it.
