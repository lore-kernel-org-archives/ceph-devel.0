From: Gregory Farnum <greg@inktank.com>
Subject: Re: tcmalloc
Date: Tue, 17 Dec 2013 16:59:01 -0800
Message-ID: <CAPYLRzhqLnb6xx2QYnzN8EtMb56Ex3nMpJo50g=PHxrs+w7Hag@mail.gmail.com>
References: <CANP1eJHzHfB+S2enWm80MkLAHvv53A4Pm36X7rU1ro=Wd2QQ7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:36698 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab3LRA7C convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Dec 2013 19:59:02 -0500
Received: by mail-qc0-f182.google.com with SMTP id e16so5608422qcx.13
        for <ceph-devel@vger.kernel.org>; Tue, 17 Dec 2013 16:59:01 -0800 (PST)
In-Reply-To: <CANP1eJHzHfB+S2enWm80MkLAHvv53A4Pm36X7rU1ro=Wd2QQ7A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Dec 17, 2013 at 4:15 PM, Milosz Tanski <milosz@adfin.com> wrote=
:
> I wanted to bring up an issue with Ceph's use of tcmalloc. I know tha=
t
> in Ubuntu (12.04) Ceph uses the distro version of tcmalloc which
> older.
>
> I've personally ran into issues with tcmalloc for our application
> where the amount of private space for our application (analytics
> database) is listed in 10s of gigs but the heap profiler only reports
> a couple hundreds megs of use.
>
> It seams like tcmalloc while fast does a poor job with fragmentation.
> In most cases I rather leave more memory to the OS to cache disk data
> leave it in case the app needs to use it. I've observed issues with
> the MDS when it's grown to a few gigs and it doesn't grow down even
> after I've removed a 2/3 of the tree.
>
> It's possible that this is fixed in newer versions of tcmalloc
> (https://code.google.com/p/gperftools/issues/detail?id=3D368). I was
> curious if anyone else audited this / ran into similar issues and
> bring it up. For us, we moved to jemalloc which does a fine job
> returning the memory back to the OS.

We've seen scattered instances of this happening on systems run by
external users (generally on Gentoo or maybe a Fedora build), but have
never experienced it anywhere that we could reproduce. Helpfully, when
that's the case it's always been easy to resolve by running the "heap
release" command (or whatever it actually is; search the docs) to make
tcmalloc give up its free RAM.
I haven't evaluated jemalloc, but in all the systems we've run it on
tcmalloc behaves perfectly under our workloads and provides some
helpful features (heap analysis, etc); the default system malloc on
the other hand actually did grow without bound.

I'm not sure your MDS memory use test is actually valid =97 removing
inodes from the tree leaves them in cache until they've been cleaned
up out of RADOS, and we have in the past had bugs related to things
not being trimmed. You'd really want to look at the tcmalloc stats on
the MDS to see if tcmalloc is misbehaving or not.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
