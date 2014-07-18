From: Sage Weil <sweil@redhat.com>
Subject: Re: rpm dependencies
Date: Thu, 17 Jul 2014 21:58:15 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407172149130.28285@cobra.newdream.net>
References: <alpine.DEB.2.00.1407142132260.21295@cobra.newdream.net> <53C57AC6.2030303@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59158 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbaGRE6Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jul 2014 00:58:16 -0400
In-Reply-To: <53C57AC6.2030303@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dan.mick@inktank.com, =?ISO-8859-15?Q?Luis_Pab=F3n?= <lpabon@redhat.com>
Cc: lhh@redhat.com, ceph-devel@vger.kernel.org

This includes the move of ceph-dencoder from ceph to ceph-common, and a 
simple change to configure.ac that avoids putting leveldb in LIBS.

	https://github.com/ceph/ceph/pull/2104

Look ok to merge?

Thanks!
sage

On Tue, 15 Jul 2014, Luis Pab?n wrote:

> Hi Sage,
>     Looks like it is configuration issue in configure.ac.  I'm fixing the
> issue now and will be sending a patch soon.
> 
> - Luis
> 
> 
> On 07/15/2014 12:39 AM, Sage Weil wrote:
> > Hey Luis,
> > 
> > I pushed wip-dencoder, which moves ceph-dencoder to ceph from ceph-common.
> > This avoids the dependency for ceph-common.
> > 
> > For the librados2 package, though, there is still a leveldb dependency
> > that makes no sense.  See the packages at
> > 
> >   http://gitbuilder.ceph.com/ceph-rpm-rhel6_5-x86_64-basic/ref/wip-dencoder/x86_64/
> > 
> >   $ wget
> > http://gitbuilder.ceph.com/ceph-rpm-rhel6_5-x86_64-basic/ref/wip-dencoder/x86_64/librados2-0.82-595.g95f5a44.el6.x86_64.rpm
> >   $ rpm -qpR librados2-0.82-595.g95f5a44.el6.x86_64.rpm | grep level
> >   warning: librados2-0.82-595.g95f5a44.el6.x86_64.rpm: Header V4 DSA/SHA1
> > Signature, key ID 03c3951a: NOKEY
> >   libleveldb.so.1()(64bit)
> >   $ rpm2cpio librados2-0.82-595.g95f5a44.el6.x86_64.rpm | cpio -i
> > --make-directories
> >   ...
> >   $ ldd usr/lib/librados2.so.2 | grep -c leveldb
> >   1
> > 
> > Our Makefile.am doesn't specify that we link against leveldb for librados,
> > although strangely it is listed in the librados.la file anyway (along with
> > every other lib anything links against).  Despite this, ldd
> > .libs/librados.so on my (debian) box doesn't list it when building
> > locally.
> > 
> > The Makefile-env.am has --as-needed, which is supposed to make us only use
> > dependencies we actually use.
> > 
> > Not sure what is going on with the RPM build that is putting this
> > dependency in place...
> > 
> > Any idea what is going on?  :/
> > 
> > sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
