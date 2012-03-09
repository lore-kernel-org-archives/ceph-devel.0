From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [PATCH 0/3] Generic libcephfs Java wrappers
Date: Thu, 8 Mar 2012 18:16:20 -0800
Message-ID: <B062F95691EF4CE8AB4FC02F2727C038@dreamhost.com>
References: <4F516A20.8060901@cs.ucsc.edu>
 <Pine.LNX.4.64.1203070935010.8008@cobra.newdream.net>
 <3071055F-EFD8-441A-913C-B04C8BC662FF@cs.ucsc.edu>
 <FCB709D302224AD984BB00F851ACE8C2@dreamhost.com>
 <E6A73CCF-3C17-42C1-BA41-33E1CADA6675@cs.ucsc.edu>
 <E71CA82A2DB647E193C249D30CA491A8@dreamhost.com>
 <4B306D7B-E017-445D-8F76-AB0EDC7B61D7@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43818 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757241Ab2CICQY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Mar 2012 21:16:24 -0500
Received: by pbcun15 with SMTP id un15so2079437pbc.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Mar 2012 18:16:23 -0800 (PST)
In-Reply-To: <4B306D7B-E017-445D-8F76-AB0EDC7B61D7@cs.ucsc.edu>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Josh Durgin <josh.durgin@dreamhost.com>

On Thursday, March 8, 2012 at 10:54 AM, Noah Watkins wrote:
> =20
> On Mar 8, 2012, at 10:48 AM, Greg Farnum wrote:
> =20
> > On Thursday, March 8, 2012 at 9:30 AM, Noah Watkins wrote:
> > > =20
> > > On Mar 7, 2012, at 1:40 PM, Greg Farnum wrote:
> > > =20
> > > > CephMount::conf_get requires a buf_size. But we freely adjust t=
hat if we need more space, so is there any point to it? I can't see cal=
lers really having a better idea of size than we do.
> > > Good point. I can't think of a reason to publicly expose the buff=
er length param in CephMount to users, but CephProxy is a private inter=
face. On a related a related note:
> > > =20
> > > int ceph_conf_get(struct ceph_mount_info *cmount, const char *opt=
ion, char *buf, size_t len);
> > > =20
> > > shouldn't the 'buf' parameter be char ** if libcephfs is going to=
 be doing a re-alloc, or is there some voodoo behind the scenes?
> > libcephfs doesn't do a re-alloc there; I was talking about the Java=
 stuff when I said it freely adjusts. :)
> =20
> =20
> =20
> The documentation seems to indicate that it does do a malloc. Maybe i=
t is just out of date?
> =20
> /* Returns a configuration value as a string.
> * If len is positive, that is the maximum number of bytes we'll write=
 into the
> * buffer. If len =3D=3D -1, we'll call malloc() and set *buf.
> * Returns 0 on success, error code otherwise. Returns ENAMETOOLONG if=
 the
> * buffer is too short. */

Ah. Two things from that:
1) "If len =3D=3D -1". Which it isn't, here.
2) There is no voodoo, that just isn't going to work. Either it was cre=
ated incorrectly in reference to md_config_t::get_val, or else code got=
 moved around without updating that documentation. :/ Options including=
 char ** (as you said), char *& (ewww), or=E2=80=A6not doing that?

Anybody have thoughts on the right solution?
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
