From: Sage Weil <sage@inktank.com>
Subject: Re: Master needs newer version of boost on centos?
Date: Fri, 14 Feb 2014 16:13:00 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402141612070.17843@cobra.newdream.net>
References: <1171102862.189.1392422947238.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53302 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbaBOANB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Feb 2014 19:13:01 -0500
In-Reply-To: <1171102862.189.1392422947238.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: ceph-devel@vger.kernel.org, Sandon Van Ness <sandon@inktank.com>

On Fri, 14 Feb 2014, Matt W. Benjamin wrote:
> but we haven't built on centos, to my knowledge...

I think the question is really: is there an interval_set in boost 1.41 
that you can use, can you use something else instead, or do we need to do 
a boost backport in order to build for centos/rhel 6.x?

sage

> 
> ----- "Matt W. Benjamin" <matt@linuxbox.com> wrote:
> 
> > oh, ok.  I think they need an extra boost rpm?
> > 
> > ----- "Sage Weil" <sage@inktank.com> wrote:
> > 
> > > Hey Matt,
> > > 
> > > This is in the libcephfs code I merged yesterday.  Any ideas?
> > > 
> > > Thanks!
> > > sage
> > > 
> > > 
> > > On Fri, 14 Feb 2014, Sandon Van Ness wrote:
> > > 
> > > > 
> > > > The last couple builds of master have been failing on the centos
> > > gitbuilder.
> > > > here is the build log:
> > > > 
> > > >
> > >
> > http://gitbuilder.sepia.ceph.com/gitbuilder-centos6-amd64/log.cgi?log=f47062d8a66b94743888aaea13e0766579379395
> > > > 
> > > > Its running into:
> > > > 
> > > > CXX mds/Capability.lo
> > > > CXX mds/Dumper.lo
> > > > In file included from client/Client.h:38,
> > > > from libcephfs.cc:21:
> > > > 
> > > >      error: client/barrier.h:25:38: boost/icl/interval_set.hpp:
> > No
> > > such
> > > >      file or directory 
> > > > 
> > > > It looks like its not effecting fedora gitbuilders that have a
> > newer
> > > version
> > > > of boost but on centos/rhel the version is only 1.41.0-18. Is
> > there
> > > something
> > > > we can do to get around this without back-porting or will
> > > backporting a newer
> > > > boost for rhel/centos be necessary?
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe
> > > ceph-devel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html
> > > > 
> > > >
> > 
> > -- 
> > Matt Benjamin
> > The Linux Box
> > 206 South Fifth Ave. Suite 150
> > Ann Arbor, MI  48104
> > 
> > http://linuxbox.com
> > 
> > tel.  734-761-4689 
> > fax.  734-769-8938 
> > cel.  734-216-5309 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Matt Benjamin
> The Linux Box
> 206 South Fifth Ave. Suite 150
> Ann Arbor, MI  48104
> 
> http://linuxbox.com
> 
> tel.  734-761-4689 
> fax.  734-769-8938 
> cel.  734-216-5309 
> 
> 
