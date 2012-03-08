From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [PATCH 0/3] Generic libcephfs Java wrappers
Date: Thu, 8 Mar 2012 10:48:08 -0800
Message-ID: <E71CA82A2DB647E193C249D30CA491A8@dreamhost.com>
References: <4F516A20.8060901@cs.ucsc.edu>
 <Pine.LNX.4.64.1203070935010.8008@cobra.newdream.net>
 <3071055F-EFD8-441A-913C-B04C8BC662FF@cs.ucsc.edu>
 <FCB709D302224AD984BB00F851ACE8C2@dreamhost.com>
 <E6A73CCF-3C17-42C1-BA41-33E1CADA6675@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59109 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab2CHSsM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Mar 2012 13:48:12 -0500
Received: by dajr28 with SMTP id r28so718233daj.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Mar 2012 10:48:12 -0800 (PST)
In-Reply-To: <E6A73CCF-3C17-42C1-BA41-33E1CADA6675@cs.ucsc.edu>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Thursday, March 8, 2012 at 9:30 AM, Noah Watkins wrote:
> =20
> On Mar 7, 2012, at 1:40 PM, Greg Farnum wrote:
> =20
> > CephMount::conf_get requires a buf_size. But we freely adjust that =
if we need more space, so is there any point to it? I can't see callers=
 really having a better idea of size than we do.
> Good point. I can't think of a reason to publicly expose the buffer l=
ength param in CephMount to users, but CephProxy is a private interface=
=2E On a related a related note:
> =20
> int ceph_conf_get(struct ceph_mount_info *cmount, const char *option,=
 char *buf, size_t len);
> =20
> shouldn't the 'buf' parameter be char ** if libcephfs is going to be =
doing a re-alloc, or is there some voodoo behind the scenes?
libcephfs doesn't do a re-alloc there; I was talking about the Java stu=
ff when I said it freely adjusts. :)
 =20
> > (Oh, now I see there's another one that doesn't take buf_size. Do w=
e have a use case for the with-size option, though?)
> > Similarly with getdnames
> =20
> Yes, the default buf_size interfaces are meant to be friendly, while =
the explicit buf_size interfaces are primarily meant for the unit tests=
 so that the buffer expansion logic can be tested. It would be safe to =
leave it public, but maybe it is better for it to be protected and used=
 explicitly by the unit tests.

Ah, I see. Well, leaving the explicit buf_size versions public expands =
the public interface, so I vote to make them protected (or whatever's a=
ppropriate in Java; I forget how the privacy settings map).
> > We don't implement CephMount::mkdir, just mkdirs? I *can* see use c=
ases for not wanting recursive creates=E2=80=A6
> =20
> I was going for the minimum to support Hadoop. I'll stick mkdirs on t=
he short list of API expansion TODOs.

Okay, makes sense.
 =20
> > I like the states and require_state() stuff. It's making me notice =
that you need a little more documentation on stuff like closedir and wh=
at happens to the CephDirectory under success and error returns. :)
> =20
> The state checking is really helpful to catch set faults when blindly=
 casting Java long to void* :) I wonder if there is a way to push the s=
tate checking even further down in libcephfs? Currently all errors are =
communicated through a generic CephException, but making things more sp=
ecific as we go along will be nice.

I'm not sure how we'd push it farther down in a way that's any cleaner,=
 did you have some thoughts or just a wish to not do it in Java?

Oh, and I forgot something important last time: there's no licensing as=
sociated with any of these files right now. :) I think we talked previo=
usly about making it Apache, but whatever it is should be clearly noted=
!
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
