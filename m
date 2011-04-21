From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: long object names
Date: Thu, 21 Apr 2011 15:25:35 -0700
Message-ID: <BANLkTikCG487GB=n+9eT+66hxBVk_gfwqw@mail.gmail.com>
References: <Pine.LNX.4.64.1104202117520.14154@cobra.newdream.net>
	<20110421185606.GC9431@dreamer>
	<BANLkTi=SOKMdSZu3B_+6TS_8-tSJDeu98g@mail.gmail.com>
	<20110421193240.GA26545@dreamer>
	<99672323C62444DFA181A0659E4D37FC@gmail.com>
	<20110421220044.GB26545@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39782 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419Ab1DUWZf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 18:25:35 -0400
Received: by iyb14 with SMTP id 14so128264iyb.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Apr 2011 15:25:35 -0700 (PDT)
In-Reply-To: <20110421220044.GB26545@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Thu, Apr 21, 2011 at 3:00 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Thu, Apr 21, 2011 at 01:03:57PM -0700, Gregory Farnum wrote:
>> I like what Yehuda has here for its relative simplicity
>
> It's far from simple.
>
> Let's look at the unlink path:
>
>
> static int lfn_unlink(const char *pathname)
> {
> =A0const char *filename;
> =A0char short_fn[PATH_MAX];
> =A0char short_fn2[PATH_MAX];
> =A0int r, i, exist, err;
> =A0int path_len;
> =A0int is_lfn;
>
> ** helper function to split the path to dir and file, figure out a
> ** short name for this longname, count the lenght of the directory
> ** part of the path and other things; loops through the candidates,
> ** comparing against the xattr
> =A0r =3D lfn_get(pathname, short_fn, sizeof(short_fn), &filename, &ex=
ist, &is_lfn);
> =A0if (r < 0)
> =A0 =A0return r;
> ** if the filename =A0wasn't actually too long, take the easy way out
> =A0if (!is_lfn)
> =A0 =A0return unlink(pathname);
> =A0if (!exist) {
> =A0 =A0errno =3D ENOENT;
> =A0 =A0return -1;
> =A0}
>
> ** actual file unlink here
> =A0err =3D unlink(short_fn);
> =A0if (err < 0)
> =A0 =A0return err;
>
> ** and then, rename all the collisions, one by one, because they have
> ** a sequential number in them!
> =A0path_len =3D filename - pathname;
> =A0memcpy(short_fn2, pathname, path_len);
>
> ** this loop finds the highest sequential number in this hash
> ** collision bucket, saves it in i
> =A0for (i =3D r + 1; ; i++) {
> =A0 =A0struct stat buf;
> =A0 =A0int ret;
>
> =A0 =A0build_filename(&short_fn2[path_len], sizeof(short_fn2) - path_=
len, filename, i);
> =A0 =A0ret =3D stat(short_fn2, &buf);
> =A0 =A0if (ret < 0) {
> =A0 =A0 =A0if (i =3D=3D r + 1)
> =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0break;
> =A0 =A0}
> =A0}
>
> ** and then the highest seq number munged filename gets renamed to
> ** fill the gap we left behind
> =A0build_filename(&short_fn2[path_len], sizeof(short_fn2) - path_len,=
 filename, i - 1);
> =A0generic_dout(0) << "renaming " << short_fn2 << " -> " << short_fn =
<< dendl;
>
> =A0if (rename(short_fn2, short_fn) < 0) {
> =A0 =A0generic_derr << "ERROR: could not rename " << short_fn2 << " -=
> " << short_fn << dendl;
> =A0 =A0assert(0);
> =A0}
>
> =A0return 0;
> }

This is a work in progress, a proper locking is required and will be ap=
plied.

>
>
> Now, imagine a colliding file create between the stat and the rename
> -> boom. This is not the only race in there.
>
Yeah, we're well aware of those races. Note that splitting to
subdirectories is racey too. Imagine one thread/process creating an
object, while the other one removing a similar object with the same
prefix. The first one tries to create a subtree, while the other is
trying to remove the same subtree. I've seen these issues before,
they're real.
The chances of hitting these issues with none hashed structure is much
greater than the chances of hitting those races when the appropriate
hash algorithm is being used (the 'zzz' hash is just a filler).

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
