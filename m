From: Gregory Farnum <greg@inktank.com>
Subject: Re: On tmap, omap, xattr physical layout
Date: Sun, 26 Aug 2012 11:06:37 -0700
Message-ID: <CAPYLRzhCz1Si2-NuR-JKp2LNf3RkuL+OpYkCyhfi1upUNe8cHQ@mail.gmail.com>
References: <CAPrxi58O6PTgQ70GGrQbcvkOTwN6212=wGWaRNo+9-GFGqCGHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62890 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab2HZSGj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Aug 2012 14:06:39 -0400
Received: by lbbgj3 with SMTP id gj3so2095959lbb.19
        for <ceph-devel@vger.kernel.org>; Sun, 26 Aug 2012 11:06:37 -0700 (PDT)
In-Reply-To: <CAPrxi58O6PTgQ70GGrQbcvkOTwN6212=wGWaRNo+9-GFGqCGHw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Aug 26, 2012 at 10:09 AM, Noah Watkins <jayhawk@cs.ucsc.edu> wr=
ote:
> Would anyone mind giving a short overview of the difference between
> tmap, omap, and xattrs, and the physical layout of these with respect
> to the object payload?
xattrs are (usually =97 caveat below) stored in the filesystem attached
to the object. Their physical layout varies quite a bit =97 in btrfs yo=
u
can usually count on them being in-line with the inode IIRC; in xfs
they'll start out in-line but tend to overflow into separate blocks
unless you set it to use large xattrs; in ext4...I have no idea.
tmap is an old system in which the actual object is used to store
key-value pairs sequentially=A0=97 so it *is* the object payload. There=
's
nothing special about it as far as the filesystem is concerned, and
the OSD only knows it's different from a regular object if you access
it with the tmap ops (you can also use get and put on the object, and
it'll work if your client recognizes the tmap interface). Generally
speaking though, you should consider this deprecated in favor of...
omaps are put in a per-osd leveldb store, carefully keyed so they can
be associated with the correct object. The on-disk layout for these is
more complicated (read about leveldb if you're interested) and has no
relation to the object payload's layout. But they're generally pretty
quick to access since leveldb is so well optimized.

Additionally, there's an OSD flag filestore_xattr_use_omap, which will
use leveldb instead of xattrs for all xattrs over a certain size
(filestore_max_inline_xattr_size) or if you have more than a certain
number of xattrs associated with an object
(filestore_max_inline_xattrs). This option defaults to false but the
OSD will enable it automatically if you are using ext4.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
