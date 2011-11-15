From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Fwd: perl binding for rados ?
Date: Tue, 15 Nov 2011 13:10:45 -0800
Message-ID: <CAF3hT9Azh2euQFLWWWuHb38NiQAqdqScpDkiURAyd1WgJWtEPg@mail.gmail.com>
References: <4EC2240B.905@one.com>
	<CAF3hT9AUyBi0ELv84-=FdEr1ZO85OU1TF3akaBL3xS2r-6bNGQ@mail.gmail.com>
	<CALFpzo71Aq=xLeNx0LztjKgi2hAfEfWEMmVF7SEag7dkJcT=HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65219 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318Ab1KOVKr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Nov 2011 16:10:47 -0500
Received: by iage36 with SMTP id e36so8948502iag.19
        for <ceph-devel@vger.kernel.org>; Tue, 15 Nov 2011 13:10:46 -0800 (PST)
In-Reply-To: <CALFpzo71Aq=xLeNx0LztjKgi2hAfEfWEMmVF7SEag7dkJcT=HA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Forwarding to list.
---------- Forwarded message ----------
From: Marcus Sorensen <shadowsor@gmail.com>
Date: Tue, Nov 15, 2011 at 1:05 PM
Subject: Re: perl binding for rados ?
To: Gregory Farnum <gregory.farnum@dreamhost.com>


Admittedly they kind of dropped off my radar after it didn't seem to
Garner much interest. I do however have some code that seems to work
for connecting, listing pools and devices, basic adding and removing.
I dont have all of the functions wrapped but at this point I feel like
it's mainly just a matter of copying what's already there to fill in
the rest. It uses inline::c . I would be happy to tar up what I have
and make it available if someone wants to build on ot

On Nov 15, 2011 12:38 PM, "Gregory Farnum" <gregory.farnum@dreamhost.com> wrote:
>
> On Tue, Nov 15, 2011 at 12:34 AM, Lalit Kumar Bhasin <lkb@one.com> wrote:
> > Hi,
> >
> > Is there any perl bindings available for rados, or be available in near
> > furture? I can't find it on cpan. As of now, only way I can see is to use
> > librados through perl-XS interface.
> >
> > /Lalit
>
> All I can give you is a past discussion thread:
> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/3792
>
> Marcus, did you get anywhere with these?
> -Greg
