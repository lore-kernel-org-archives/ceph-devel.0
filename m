From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Re: xio messenger is not building by default
Date: Mon, 16 Mar 2015 14:22:04 -0400 (EDT)
Message-ID: <1231373626.55.1426530124905.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CA3E46@SACMBXIP01.sdcorp.global.sandisk.com>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2443 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754657AbbCPSWP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 16 Mar 2015 14:22:15 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CA3E46@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>, Ken Dreyer <kdreyer@redhat.com>

Hi,

----- "Somnath Roy" <Somnath.Roy@sandisk.com> wrote:

> I think installing the MLNX_OFED driver package will install most of
> the stuff(including libibverbs-dev). We need the following extra
> packages for building accelio.
> numactl libnuma-dev

Ah, that's also true.

> 
> But, what if user is building it without OFED driver package installed
> ?

Should it be possible?  I mean, to both build Xio and not have the header interface?

> BTW, I saw accelio was giving assert if I manually install
> libibverbs-dev from Ubuntu repo and upgrade this OFED driver later.
> Cleaning the repo and rebuilding solved the issue. Seems it was
> linking wrong libraries.

I think I've seen this.

> 
> Thanks & Regards
> Somnath
> 
> 
> -----Original Message-----
> From: Matt W. Benjamin [mailto:matt@cohortfs.com]
> Sent: Monday, March 16, 2015 9:34 AM
> To: Ken Dreyer
> Cc: ceph-devel@vger.kernel.org; Sage Weil; Somnath Roy
> Subject: Re: xio messenger is not building by default
> 
> Hi,
> 
> Yes, agree.  We do depend on librdmacm!
> 
> Matt
> 
> ----- "Ken Dreyer" <kdreyer@redhat.com> wrote:
> 
> > On 03/16/2015 10:20 AM, Matt W. Benjamin wrote:
> > > Hi,
> > >
> > > Arent OFED dependencies already packaged?  I assumed that only
> > Accelio would
> > > be a submodule.
> > >
> >
> > Thanks for pointing that out. It's in Fedora as libibverbs-devel,
> and
> > it's in Debian as libibverbs-dev. So you're right, Accelio is the
> only
> > one to be packaged.
> >
> > Looking at configure.ac, does README.xio need to be updated to
> mention
> > librdmacm?
> >
> > - Ken
> 
> --
> Matt Benjamin
> CohortFS, LLC.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
> 
> http://cohortfs.com
> 
> tel.  734-761-4689
> fax.  734-769-8938
> cel.  734-216-5309
> 
> ________________________________
> 
> PLEASE NOTE: The information contained in this electronic mail message
> is intended only for the use of the designated recipient(s) named
> above. If the reader of this message is not the intended recipient,
> you are hereby notified that you have received this message in error
> and that any review, dissemination, distribution, or copying of this
> message is strictly prohibited. If you have received this
> communication in error, please notify the sender by telephone or
> e-mail (as shown above) immediately and destroy any and all copies of
> this message in your possession (whether hard copies or electronically
> stored copies).

-- 
Matt Benjamin
CohortFS, LLC.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://cohortfs.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
