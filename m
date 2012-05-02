From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: rados import/export
Date: Tue, 1 May 2012 19:06:14 -0700
Message-ID: <CA+qbEUNB4bZZydiCMtqWafEWbE4gEApA2rHh3uE7irUznm-GcA@mail.gmail.com>
References: <CANExM-MCR7wZMyn-gEw7Mx6j-eq2-nw_jLHMYOaK2v+5JRS3Yg@mail.gmail.com>
	<Pine.LNX.4.64.1204301348170.3920@cobra.newdream.net>
	<CAORUGqD=neAYCH2qPZTF6oG=V4yNKhfupXoViAbV5TiR0Qfotg@mail.gmail.com>
	<Pine.LNX.4.64.1204301406120.32303@cobra.newdream.net>
	<CAORUGqDFhA5focC=fvUJVai1ezi+rWp4PRJ=cEz5syxWhCz4aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:63783 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756556Ab2EBCGQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 May 2012 22:06:16 -0400
Received: by wibhj6 with SMTP id hj6so4195951wib.1
        for <ceph-devel@vger.kernel.org>; Tue, 01 May 2012 19:06:15 -0700 (PDT)
In-Reply-To: <CAORUGqDFhA5focC=fvUJVai1ezi+rWp4PRJ=cEz5syxWhCz4aA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, Henry C Chang <henry.cy.chang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

(sorry for repost, vger was cranky about the first message)

The code you are interested in is in src/rados_sync.cc.

It would have been impossible to preserve rados object names fully,
since they can be looong (it was either 2k or 4k, I forget), and most
Linux local filesystems like ext3 can only hold 256 bytes in a single
path component.

The solution was to store the true name in an extended attribute of
the locally exported file, and make the local name simply an
approximation of that true name. =A0If things get hairy, it appends a
hash of the true name to the end of the mangled name. =A0Rados import
ignores the mangled names, and checks the truename stored in the
user.rados_full_name xattr.

Is this a complete solution? =A0No. =A0Two objects could have names tha=
t
mangle to the same short name, and also have the same hash code. =A0If
you are interested in implementing the complete solution, simply use
an incrementing counter rather than a hash.

Another note. =A0If these omaps you speak of are big, you are probably
stuck using a separate file. =A0Don't forget the rather short limits
that ext3/ext4 puts on xattrs. =A0It should be straightforward enough
just to create a $FOO.omap for every $FOO.

cheers,
Colin

On Mon, Apr 30, 2012 at 2:20 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
>
> On Mon, Apr 30, 2012 at 14:08, Sage Weil <sage@newdream.net> wrote:
> >> Does just adding a .db suffix make the name safe? If yes, xattr is=
 not
> >> needed; if no, it's not enough. Reading src/rados_export.cc and
> >> src/rados_sync.cc, I see nothing like that. What if I have objects
> >> "foo" and "foo.db" in a pool?
> >
> > I'm pretty sure we need to mark the object with a magic xattr. =A0W=
hich
> > probably means the filename itself needs to be mangled to avoid col=
liding
> > with other objects. =A0Probably an xattr on the object file referri=
ng to the
> > external mangled file with the k/v content.
>
> Perhaps make the db file use one of the reserved characters that will
> never appear in a plain old rados object. $ is the only one that's
> really safe..
>
> >> Note to self: the only thing avoiding collisions for e.g. "foo/" a=
nd
> >> "foo$" is the hash.
> > I vaguely recall Colin talking about the trailing /, but we may hav=
e
> > decided to ignore the problem for now.
>
> Oh I mean anything that gets mapped to @ can cause collisions. "foo@"
> and "foo$" will collide. "foo\n" and "foo\\" will collide.
>
> Frankly, my gut instinct right now is "kill it with fire". Collisions
> in object names is a miserable problem to have. This would have been
> better off with e.g. a HTTP-style %20 escaping mechanism, or a \x20
> style one; one that preserves the byte, and does not just replace it
> with '@'.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
