From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Building documentation offline?
Date: Fri, 15 Jun 2012 08:56:19 -0700
Message-ID: <CADvuQRHCHhGOq8b69Esrxd3Dt1pq-Ds8=+=x9uULd3crqJS6SA@mail.gmail.com>
References: <4FDAB373.1060503@hastexo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56755 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757030Ab2FOP5J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 11:57:09 -0400
Received: by pbbrp8 with SMTP id rp8so5452884pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 15 Jun 2012 08:57:09 -0700 (PDT)
In-Reply-To: <4FDAB373.1060503@hastexo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jun 14, 2012 at 9:00 PM, Florian Haas <florian@hastexo.com> wrote:
> it occurred to me this afternoon that admin/build-doc unconditionally
> tries to fetch some updates from GitHub, which breaks building docs when
> you don't have a network connection. Would there be any reasonably
> simple way to make it support offline build, provided the various pip
> bits have previously been downloaded and installed?

Yeah pip's behavior there isn't quite ideal. I haven't found a way to
make pip do the right thing when all the packages are already
installed; I think that comes down to the fact that it

You can easily comment out the "pip install" line, for now.

The best I can find to make that really a no-op on an already-prepared
virtualenv is to parse "$venv/bin/pip freeze" output and don't run it
if I see the right things in there. I haven't added this, because I
feel like that belongs in pip itself, running "pip install foo" twice
just shouldn't need the network on the second run.
