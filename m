From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] Ceph updates for 4.7-rc1
Date: Mon, 13 Jun 2016 15:06:51 +0200
Message-ID: <6717851.ptlac7jbfE@wuerfel>
References: <alpine.DEB.2.11.1605261035390.6221@cpach.fuggernut.com> <3724610.gtEplKGO6B@wuerfel> <CA+55aFxOZSKjePXaCrB=WDdEr1kxXMCEwonfBODbmk=9x-p0CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:55186 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422821AbcFMNFf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jun 2016 09:05:35 -0400
In-Reply-To: <CA+55aFxOZSKjePXaCrB=WDdEr1kxXMCEwonfBODbmk=9x-p0CA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sage Weil <sweil@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>

On Friday, June 10, 2016 2:32:21 PM CEST Linus Torvalds wrote:
> On Fri, Jun 10, 2016 at 1:42 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > What I see is that this one exported symbol has a __crc of a different
> > type from all the others:
> >
> > $ nm net/ceph/mon_client.o | grep __crc
> > 48c2e16e A __crc_ceph_monc_get_version
> > 2360d633 A __crc_ceph_monc_get_version_async
> > 0c50a10a A __crc_ceph_monc_got_map
> >          w __crc_ceph_monc_do_statfs
> 
> A lower-case 'w' in a symbol list just means that it's a local weak
> symbol (with a upper-case 'A' meaning it's an absolute global).
> 
> Afaik, that simply means that it never got resolved, and genksyms
> never generated that absolute value for it.
> 
> As to _why_ that happens, that's more than I can guess. We've had
> problems with genksyms before, and it tends to be hard to debug.
> 
> Is it 100% reliable for you? Because the most common problem has been
> issues with subtle build races, where just causing a re-build will fix
> it.
> 
> Your config doesn't work for me, when I do
> 
>    cp ~/genksyms-config.txt .config
>    make ARCH=i386 oldconfig
> 
> I get something else than what you had. I tried with both current -git
> and the commit you pinpointed, so I don't know how you generated that
> config file..

I've tracked it down to the use of the 'typeof(((type *)0)->keyfld)'
expression in  DEFINE_RB_LOOKUP() now, and sent a patch with subject
"ceph: fix symbol versioning for ceph_monc_do_statfs" that works
around it by rewriting that line in a way that genksyms understands.

	Arnd
