From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Let's Not Destroy the World in 2038
Date: Tue, 22 Dec 2015 19:54:43 -0800
Message-ID: <CAJ4mKGbmA=gpagHLa23TKEVDsqdJGitv+1GA51QL3PST3a-5UA@mail.gmail.com>
References: <20151222201039.GA24590@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34250 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbbLWDyo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Dec 2015 22:54:44 -0500
Received: by mail-wm0-f42.google.com with SMTP id l126so131397131wml.1
        for <ceph-devel@vger.kernel.org>; Tue, 22 Dec 2015 19:54:44 -0800 (PST)
In-Reply-To: <20151222201039.GA24590@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Tue, Dec 22, 2015 at 12:10 PM, Adam C. Emerson <aemerson@redhat.com>=
 wrote:
> Comrades,
>
> Ceph's victory is assured. It will be the storage system of The Futur=
e.
> Matt Benjamin has reminded me that if we don't act fast=C2=B9 Ceph wi=
ll be
> responsible for destroying the world.
>
> utime_t() uses a 32-bit second count internally. This isn't great, bu=
t it's
> something we can fix. ceph::real_time currently uses a 64-bit bit cou=
nt of
> nanoseconds, which is better. And we can change it to something else =
without
> having to rewrite much other code.
>
> The problem lies in our encode/deocde functions for time (both utime_=
t
> and ceph::real_time, since I didn't want to break compatibility.) we
> use a 32-bit second count. I would like to change the wire and disk
> representation to a 64-bit second count and a 32-bit nanosecond count=
=2E
>
> Would there be resistance to a project to do this? I don't know if a
> FEATURE bit would help. A FEATURE bit to toggle the width of the seco=
nd
> count would be ideal if it would work. Otherwise it looks like the be=
st
> way to do this would be to find all the structures currently ::encode=
d
> that hold time values, bump the version number and have an 'old_utime=
'
> that we use for everything pre-change.

Unfortunately, we include utimes in structures that are written to
disk. So I think we're stuck with creating a new utime_t and
incrementing the struct_v on everything that contains them. :/

Of course, we'll also then need the full feature bit system to make
sure we send the old encoding to clients which don't understand the
new one, and to prevent a mid-upgrade cluster from writing data on a
new node that gets moved to a new node which doesn't understand it.

Given that utime_t occurs in a lot of places, and really can't change
*again* after this, we probably shouldn't set up the new version with
versioned encoding?
-Greg

>
> Thank you!
>
> =C2=B9 Within the next twenty-three years. But that's not really a lo=
ng time in the
>   larger scheme of things.
>
> --
> Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
> IRC: Aemerson@{RedHat, OFTC, Freenode}
> 0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
