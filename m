From: Sage Weil <sage@inktank.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] rbd: link and load librbd
 dynamically
Date: Fri, 21 Jun 2013 11:42:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306211138310.454@cobra.newdream.net>
References: <20130405093124.GA2351@dhcp-200-207.str.redhat.com> <1365552342-22840-1-git-send-email-josh.durgin@inktank.com> <CAJSP0QWy1CUOX+BVB2kfXfRpcdPuwbywZ3tReo83zK23+B4vbQ@mail.gmail.com> <87ip3uctjv.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54294 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423388Ab3FUSme (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Jun 2013 14:42:34 -0400
In-Reply-To: <87ip3uctjv.fsf@codemonkey.ws>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Josh Durgin <josh.durgin@inktank.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, ceph-devel@vger.kernel.org

Hi Anthony, Stefan, Paolo,

[Resurrecting an old thread, here!]

On Wed, 10 Apr 2013 Anthony Liguori wrote:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
> > NACK
> >
> > I think we're solving the problem at the wrong level.  Writing our own
> > dynamic linker and adding boilerplate to juggle function pointers
> > every time we use a library dependency is ugly.
> >
> > There are two related problems here:
> >
> > 1. Packagers do not want to enable niche dependencies since users will
> > complain that the package is bloated and pulls in too much stuff.
> >
> > 2. QEMU linked against a newer library version fails to run on hosts
> > that have an older library.
> >
> > Problem #1 has several solutions:
> >
> > 1. Let packagers take care of it.  For example, vim is often shipped
> > in several packages that have various amounts of dependencies
> > (vim-tiny, vim-gtk, etc).  Packagers create the specialized packages
> > for specific groups of users to meet their demands without dragging in
> > too many dependencies.
> >
> > 2. Make QEMU modular - host devices should be shared libraries that
> > are loaded at runtime.  There should be no stable API so that
> > development stays flexible and we discourage binary-only modules.
> > This lets packagers easily ship a qemu-rbd package, for example, that
> > drops in a .so file that QEMU can load at runtime.
> >
> > Problem #2 is already solved:
> >
> > The dynamic linker will refuse to load the program if there are
> > missing symbols.  It's not possible to mix and match binaries across
> > environments while downgrading their library dependencies.  With
> > effort, this could be doable but it's not an interesting use case that
> > many users care about - they get their binaries from a distro or build
> > them from source with correct dependencies.
> >
> > Maybe it's time to move block drivers and other components into
> > modules?
> 
> This is really a build system issue more than anything else.  There are
> no internal API changes needed.
> 
> All that's needed is to something like (in module.h):
> 
> /* This should not be used directly.  Use block_init etc. instead.  */
> #ifdef CONFIG_MODULE
> #define module_init(function, type)		   \
> const gchar *g_module_check_init(GModule *module)  \
> {				               	   \
>     register_module_init(function, type);	   \
>     return NULL;				   \
> }
> #else
> #define module_init(function, type)                                         \
> static void __attribute__((constructor)) do_qemu_init_ ## function(void) {  \
>     register_module_init(function, type);                                   \
> }
> #endif

Has any progress been made toward a generic dynamic linking solution for 
block drivers?  It is a conceptually simple change, but non-trivial for 
anyone unfamiliar with the build system.

In the mean time, the inability to dynamically link librbd is continuing 
to cause significant pain for distro users.  Would you consider merging 
the rbd-specific linking as an interim solution until something is 
generically available to qemu?

sage
