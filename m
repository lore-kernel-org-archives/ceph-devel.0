From: Sage Weil <sage@newdream.net>
Subject: Re: [Y2038] [PATCH] include: ceph: Fix encode and decode type
 conversions
Date: Tue, 1 Mar 2016 11:18:56 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603011117280.1904@cpach.fuggernut.com>
References: <1455505313-1298-1-git-send-email-deepa.kernel@gmail.com> <3047619.1giXQfFTZa@wuerfel> <CAOi1vP8fnBXw3pOspN7KeAVUk3wEEbMLhdbW2qQ4xryrGpoyTg@mail.gmail.com> <2888792.FMmWd8y8pW@wuerfel>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46675 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbcCAQTY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Mar 2016 11:19:24 -0500
In-Reply-To: <2888792.FMmWd8y8pW@wuerfel>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>

On Fri, 19 Feb 2016, Arnd Bergmann wrote:
> On Friday 19 February 2016 12:42:02 Ilya Dryomov wrote:
> > I want the kernel client to be bug compatible with servers and other
> > clients in ceph.git.
> > 
> > >
> > > a) Remain consistent with current 64-bit servers and clients,
> > >    interpreting the number as an unsigned 32-bit integer where
> > >    possible, and remain broken on existing 32-bit machines
> > >    until they start using 64-bit time_t.
> > >
> > > b) Change 64-bit clients to behave the same way that that 32-bit
> > >    clients and servers do today, and actually use the times as
> > >    a signed number that you claimed they already did.
> > >
> > > c) Interpret all times before 1980 or after 2038 as buggy servers
> > >    and only accept times that are always handled consistently.
> > >    Also fix the server to reject those times coming from broken
> > >    clients.
> > >
> > > d) Leave 64-bit clients unchanged (using unsigned timestamps) and
> > >    document that 32-bit clients should keep interpreting them as
> > >    signed even when we fix VFS, to preserve the existing behavior.
> > >
> > > I think a), b) and c) are all reasonable, and I can send a patch
> > > as soon as you know what you want. If you want d), please leave
> > > me out of that and do it yourself.
> > 
> > My preference would be a), possibly with some comments along the lines
> > of c), to make the ..2038 range more explicit, as I doubt we've ever
> > assumed ..2106 on 64-bit.  This is all really old code and goes back to
> > the dawn of ceph and beyond the kernel client, so let's wait for Sage
> > to chime in.
> 
> Ok, thanks!
> 
> I think the same problem appeared in a lot of places when code was
> originally written with the assumption that time_t is 32-bit,
> and then it kept working in practice when ported to 64-bit systems
> for the first time but the underlying assumptions changed.
> 
> /*
>  * ceph timestamp handling is traditionally inconsistent between
>  * 32-bit clients and servers using them as a signed 32-bit time_t
>  * ranging from 1902 to 2038, and 64-bit clients and servers
>  * interpreting the same numbers as unsigned 32-bit integers
>  * with negative numbers turning into dates between 2038 and 2106.
>  *
>  * Most clients and servers these days are 64-bit, so let's pretend
>  * that interpreting the times as "__u32" is intended, and use
>  * that on 32-bit systems as well once using a 64-bit time_t.
>  */

This sounsd right to me.  In practice we never have negative timestamps, 
so keeping the unsigned interpretation makes the most sense, and buys us 
several decades.  Although it's pretty likely we'll switch to a 64-bit 
encoding long before then...

sage
