From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Ceph updates for 4.7-rc1
Date: Fri, 10 Jun 2016 14:32:21 -0700
Message-ID: <CA+55aFxOZSKjePXaCrB=WDdEr1kxXMCEwonfBODbmk=9x-p0CA@mail.gmail.com>
References: <alpine.DEB.2.11.1605261035390.6221@cpach.fuggernut.com> <3724610.gtEplKGO6B@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36344 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbcFJVcW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jun 2016 17:32:22 -0400
In-Reply-To: <3724610.gtEplKGO6B@wuerfel>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sage Weil <sweil@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>

On Fri, Jun 10, 2016 at 1:42 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> What I see is that this one exported symbol has a __crc of a different
> type from all the others:
>
> $ nm net/ceph/mon_client.o | grep __crc
> 48c2e16e A __crc_ceph_monc_get_version
> 2360d633 A __crc_ceph_monc_get_version_async
> 0c50a10a A __crc_ceph_monc_got_map
>          w __crc_ceph_monc_do_statfs

A lower-case 'w' in a symbol list just means that it's a local weak
symbol (with a upper-case 'A' meaning it's an absolute global).

Afaik, that simply means that it never got resolved, and genksyms
never generated that absolute value for it.

As to _why_ that happens, that's more than I can guess. We've had
problems with genksyms before, and it tends to be hard to debug.

Is it 100% reliable for you? Because the most common problem has been
issues with subtle build races, where just causing a re-build will fix
it.

Your config doesn't work for me, when I do

   cp ~/genksyms-config.txt .config
   make ARCH=i386 oldconfig

I get something else than what you had. I tried with both current -git
and the commit you pinpointed, so I don't know how you generated that
config file..

        Linus
