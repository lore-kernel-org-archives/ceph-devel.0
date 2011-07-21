From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: architecture questions - OSD layout
Date: Thu, 21 Jul 2011 09:34:25 -0700
Message-ID: <CAF3hT9DjNB9FM9tXUqg_Qszn+8fFOOL1zcbz20jcm1EdcydEhA@mail.gmail.com>
References: <CALFpzo74hRFUis0-P+ekPuC5eqa1AbM4aEimB+zO=cU-mgpjsw@mail.gmail.com>
	<CA+qbEUNrARNq8PLigcx0H7dQYrSAtgQ_ND4W2sSS1A7KVuoQzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:46953 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab1GUQe0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2011 12:34:26 -0400
Received: by yia27 with SMTP id 27so738545yia.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2011 09:34:25 -0700 (PDT)
In-Reply-To: <CA+qbEUNrARNq8PLigcx0H7dQYrSAtgQ_ND4W2sSS1A7KVuoQzA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Sorensen <shadowsor@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jul 21, 2011 at 9:25 AM, Colin Patrick McCabe
<colin.mccabe@dreamhost.com> wrote:
> On the other hand, there is some fixed overhead to having multiple
> cosd processes running. RAIDing a few disks might be a good option if
> the fixed overhead of having a cosd per disk is too much.
This in particular is important. In general the cosd processes won't
use much CPU or memory, but in some situations (like recovery) they
can spike in a correlated fashion that ends up causing OSD flapping.
These behavior characteristics aren't well-modeled yet simply because
there's bug fixing still going on in those code paths (and some
optimization), but it's something to be aware of. I think you want
something like 1GHz of a modern core per cosd to handle this, even
though a stable system will often do just fine running 4 cosds on an
Atom. (Presumably we can bring these requirements down once we move on
from stabilization to performance.)
-Greg
