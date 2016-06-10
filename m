From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] Ceph updates for 4.7-rc1
Date: Sat, 11 Jun 2016 01:04:21 +0200
Message-ID: <3311445.Ou5N5TeFZc@wuerfel>
References: <alpine.DEB.2.11.1605261035390.6221@cpach.fuggernut.com> <3724610.gtEplKGO6B@wuerfel> <CA+55aFxOZSKjePXaCrB=WDdEr1kxXMCEwonfBODbmk=9x-p0CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFxOZSKjePXaCrB=WDdEr1kxXMCEwonfBODbmk=9x-p0CA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sage Weil <sweil@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>
List-Id: ceph-devel.vger.kernel.org

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

In a few thousand randconfig builds, this is the only symbol I ever
see the problem with, and I always see it with the same configurations
after rebuilding dozens of times, including with different compiler
versions (I only tried arm-gcc-4.9, arm-gcc-6.1 and x86-gcc-5.3, but
that seems to cover a wide range).

> Your config doesn't work for me, when I do
> 
>    cp ~/genksyms-config.txt .config
>    make ARCH=i386 oldconfig
> 
> I get something else than what you had. I tried with both current -git
> and the commit you pinpointed, so I don't know how you generated that
> config file..

I had not tried building the entire kernel on x86, and indeed I don't
see the warning there either, but I do see this one weak symbol in my
configuration:

arm-soc/obj-x86$ nm vmlinux | grep __crc | grep -w 'w'
         w __crc_ceph_monc_do_statfs

Also, the .config I first uploaded was based on my randconfig tree
that has some other changes to avoid all existing warnings. I've
done a 'make oldconfig' on your current HEAD now and put that
on http://pastebin.com/raw/EJBaG0FV just to make sure we have an
identical configuration.

The respective ARM .config file does produce the warning on
mainline, and I've uploaded that to http://pastebin.com/3NRSFSdr
I generated the x86 configuration by starting with this one
and running 'make olddefconfig ARCH=x86' on it.

I have found 15 more random configurations with the same symptom
now, and about 50 configurations with CONFIG_CEPH_FS=m that
don't show it, so I can mine the configurations for more hints
next week to see what influences it.

	Arnd
