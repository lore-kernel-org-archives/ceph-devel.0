From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: Master needs newer version of boost on centos?
Date: Fri, 14 Feb 2014 19:09:07 -0500 (EST)
Message-ID: <1171102862.189.1392422947238.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <224397503.187.1392422778642.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2624 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788AbaBOAJK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 14 Feb 2014 19:09:10 -0500
In-Reply-To: <224397503.187.1392422778642.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, Sandon Van Ness <sandon@inktank.com>

but we haven't built on centos, to my knowledge...

----- "Matt W. Benjamin" <matt@linuxbox.com> wrote:

> oh, ok.  I think they need an extra boost rpm?
> 
> ----- "Sage Weil" <sage@inktank.com> wrote:
> 
> > Hey Matt,
> > 
> > This is in the libcephfs code I merged yesterday.  Any ideas?
> > 
> > Thanks!
> > sage
> > 
> > 
> > On Fri, 14 Feb 2014, Sandon Van Ness wrote:
> > 
> > > 
> > > The last couple builds of master have been failing on the centos
> > gitbuilder.
> > > here is the build log:
> > > 
> > >
> >
> http://gitbuilder.sepia.ceph.com/gitbuilder-centos6-amd64/log.cgi?log=f47062d8a66b94743888aaea13e0766579379395
> > > 
> > > Its running into:
> > > 
> > > CXX mds/Capability.lo
> > > CXX mds/Dumper.lo
> > > In file included from client/Client.h:38,
> > > from libcephfs.cc:21:
> > > 
> > >      error: client/barrier.h:25:38: boost/icl/interval_set.hpp:
> No
> > such
> > >      file or directory 
> > > 
> > > It looks like its not effecting fedora gitbuilders that have a
> newer
> > version
> > > of boost but on centos/rhel the version is only 1.41.0-18. Is
> there
> > something
> > > we can do to get around this without back-porting or will
> > backporting a newer
> > > boost for rhel/centos be necessary?
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> > ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > > 
> > >
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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
