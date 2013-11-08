From: Cesar Mello <cmello@gmail.com>
Subject: RE: emperor leftovers
Date: Thu, 7 Nov 2013 18:38:53 -0800
Message-ID: <3566795634879164586@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:43304 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756158Ab3KHCiz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 21:38:55 -0500
Received: by mail-we0-f182.google.com with SMTP id t61so1408551wes.27
        for <ceph-devel@vger.kernel.org>; Thu, 07 Nov 2013 18:38:54 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>, Noah Watkins <noah.watkins@inktank.com>
Cc: Patrick McGarry <patrick@inktank.com>, Ceph Devel <ceph-devel@vger.kernel.org>, Noah Watkins <noahwatkins@gmail.com>, Sage Weil <sage@inktank.com>

Yes MSVC and straight win32 is the rock solid way to go. That's where I
would put my late night effort to help.

Best regards
Mello

Enviado pelo meu Windows Phone De: Matt W. Benjamin
Enviada em: 07/11/2013 23:34
Para: Noah Watkins
Cc: Patrick McGarry; Ceph Devel; Noah Watkins; Sage Weil; Cesar Mello
Assunto: Re: emperor leftovers
Or, MSVC, frankly.

----- "Matt W. Benjamin" <matt@linuxbox.com> wrote:

> Yes.  But you may wish to think about mingwXX porting rather than
> Cygwin,
> if you prefer native results.
>
> Matt
>
> ----- "Noah Watkins" <noah.watkins@inktank.com> wrote:
>
> > On Thu, Nov 7, 2013 at 5:15 PM, Sage Weil <sage@inktank.com> wrote:
> >
> > > curious if the discussion on windows portability is relevant here
> or
> > if
> > > it's better treated as a separate but related effort.
> >
> > The kernel space talk that's been tossed around probably isn't
> > relevant, but I'd be nice to learn about cygwin porting if anyone
> has
> > knowledge in this area.
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> ceph-devel"
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
