From: Sage Weil <sage@inktank.com>
Subject: RE: emperor leftovers
Date: Thu, 7 Nov 2013 21:24:39 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311072123240.17150@cobra.newdream.net>
References: <3566795634879164586@unknownmsgid>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48955 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab3KHFYk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Nov 2013 00:24:40 -0500
In-Reply-To: <3566795634879164586@unknownmsgid>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cesar Mello <cmello@gmail.com>
Cc: "Matt W. Benjamin" <matt@linuxbox.com>, Noah Watkins <noah.watkins@inktank.com>, Patrick McGarry <patrick@inktank.com>, Ceph Devel <ceph-devel@vger.kernel.org>, Noah Watkins <noahwatkins@gmail.com>

On Thu, 7 Nov 2013, Cesar Mello wrote:
> Yes MSVC and straight win32 is the rock solid way to go. That's where I
> would put my late night effort to help.

Me too.  I think the main primitives (mutex, cond, thread) are already 
well abstracted, so hopefully this is a matter of providing win32 (is it 
really still called that??) implementations and adding new wrappers for 
other components as needed.

sage

> 
> Best regards
> Mello
> 
> Enviado pelo meu Windows Phone De: Matt W. Benjamin
> Enviada em: 07/11/2013 23:34
> Para: Noah Watkins
> Cc: Patrick McGarry; Ceph Devel; Noah Watkins; Sage Weil; Cesar Mello
> Assunto: Re: emperor leftovers
> Or, MSVC, frankly.
> 
> ----- "Matt W. Benjamin" <matt@linuxbox.com> wrote:
> 
> > Yes.  But you may wish to think about mingwXX porting rather than
> > Cygwin,
> > if you prefer native results.
> >
> > Matt
> >
> > ----- "Noah Watkins" <noah.watkins@inktank.com> wrote:
> >
> > > On Thu, Nov 7, 2013 at 5:15 PM, Sage Weil <sage@inktank.com> wrote:
> > >
> > > > curious if the discussion on windows portability is relevant here
> > or
> > > if
> > > > it's better treated as a separate but related effort.
> > >
> > > The kernel space talk that's been tossed around probably isn't
> > > relevant, but I'd be nice to learn about cygwin porting if anyone
> > has
> > > knowledge in this area.
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> > ceph-devel"
> > > in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
