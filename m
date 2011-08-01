From: Sage Weil <sage@newdream.net>
Subject: Re: JSON generation in C/C++
Date: Mon, 1 Aug 2011 13:18:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108011317050.6290@cobra.newdream.net>
References: <CAORUGqA91fXDjUSB-YT+5_C6d0Ap8SE7kqcKKZvt4or-VxuTPw@mail.gmail.com>
 <CA+qbEUPiy5equ8Y2PmY-Ua28eFiaWjEAAdWc52CgOe73oYYCkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-824962692-1312229882=:6290"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44776 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab1HAUNz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2011 16:13:55 -0400
In-Reply-To: <CA+qbEUPiy5equ8Y2PmY-Ua28eFiaWjEAAdWc52CgOe73oYYCkg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-824962692-1312229882=:6290
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 1 Aug 2011, Colin Patrick McCabe wrote:
> On Mon, Aug 1, 2011 at 9:24 AM, Tommi Virtanen
> <tommi.virtanen@dreamhost.com> wrote:
> > We've talked about generating/parsing JSON a few times, and how we've
> > run into edge cases whenever we've rolled our own functions for that.
> > I've mentioned this C library a few times, but I'm not sure if I've
> > actually sent the link to anyone.. Here's a C library for
> > generating/parsing JSON, written by an ex-cow-orker of mine.
>=20
> Hi TV,
>=20
> Jansson is a nice library.
>=20
> I would also like to mention JSON-C: http://oss.metaparadigm.com/json-c/
> I used this library in the Ceph collectd plugin to parse JSON and it
> was very easy to use. One nice thing about JSON-C is that it is easy
> to install on Debian, because there is already a package for it.
> Hopefully the Jansson guys can get a package in there too eventually.

FWIW Jansson is in wheezy now, but nothing newer.

Anyway, I think our escaping problems are trivial enough to fix, we just=20
need to merge the rgw and comomn/ implementations.

Thanks!
sage

=20
> One thing that neither Jansson nor JSON-C offer, to my knowledge, is
> the ability to do SAX-style parsing of a JSON document. In other
> words, to set up a bunch of function pointers and have them called at
> various points during parsing. I did not personally feel the need for
> this, since my JSON data was small enough that memory consumption was
> a non-issue, but I guess someone else might. If Jansson wants to do
> something to differentiate itself from the competition, that could be
> it.
>=20
> I am not sure how I feel about using libraries to output (as opposed
> to parse) JSON. There is a point where a task becomes simple enough
> that using more libraries is an anti-pattern. For example, would you
> use a library to output CSV? Probably not. The only thing you have to
> remember is to properly do escaping.
>=20
> Another consideration is that the Formatter code in RGW can output
> both XML or JSON, depending on what configuration the daemon is
> running in. This is something that no libraries that I have seen have
> offered.
>=20
> cheers,
> Colin
>=20
> >
> > One feedback I've received earlier was that the "DOM-style"
> > architecture, where you build up the JSON object in-memory and then
> > dump it out, is not always a good match. If you want to avoid that,
> > you can pull off a trick like this pseudocode:
> >
> > write("{")
> > json.dump(key)
> > write(":")
> > json.dump(value)
> > write(",")
> > json.dump(key2)
> > write(":")
> > json.dump(value2)
> > write("}")
> >
> > The above still uses the library for proper string encoding etc, while
> > letting you control the top-level structure explicitly. And it should
> > be pretty easy to encapsulate the above in a convenience wrapper, to
> > make streaming even nicer; something like this pseudocode:
> >
> > j =3D StreamingJSONObject(fd)
> > j.dump(key, value)
> > j.dump(key2, value2)
> > j.close()
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-824962692-1312229882=:6290--
