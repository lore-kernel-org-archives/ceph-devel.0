From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: Compiling for FreeBSD
Date: Mon, 30 Nov 2015 08:58:13 +0200
Message-ID: <20151130065812.GA20205@gmail.com>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36415 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbbK3G6R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Nov 2015 01:58:17 -0500
Received: by lfs39 with SMTP id 39so181953543lfs.3
        for <ceph-devel@vger.kernel.org>; Sun, 29 Nov 2015 22:58:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Willem Jan Withagen <wjw@digiware.nl>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Nov 30, 2015 at 11:46:27AM +0800, Yan, Zheng wrote:
> On Mon, Nov 30, 2015 at 2:57 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> >
> > On 29-11-2015 19:08, Haomai Wang wrote:
> >
> > > I guess we still expect FreeBSD support, which version do you test to
> > > compile? I'd like to help to make bsd work :-)
> >
> > I considered it is best to develop against HEAD aka:
> > 11.0-CURRENT FreeBSD 11.0-CURRENT #0 r291381: Sat Nov 28 14:22:54 CET 2015
> > I'm also training configure the use as much of CLANG as possible.
> >
> > I would guess that by the time we get anything worth mentioning 11.0
> > will be released of close to release.
> > Note that the release date for 11.0 is july 2016
> >
> > --WjW
> >
> 
> I can compile infernalis on FreeBSD 10.1 with following commands
> 
> ./autogen.sh
> ./configure CPPFLAGS="-I/usr/local/include" LDFLAGS="-L/usr/local/lib"
> CXXFLAGS="-DGTEST_HAS_TR1_TUPLE=0" --without-tcmalloc --without-libaio
> --without-libxfs
> gmake
> 
> I don't know extact list of packages dependencies. But ./configure
> should tell you what is missing.

I have a branch in my repo that contains patches to make compilation
on FreeBSD easier:

https://github.com/trociny/ceph/commits/wip-freebsd

The branch have not been rebased against master since March though,
still I hope to find time in future to update and pull some bits
upstream.

Particularly, this patch contains packages dependencies list:

https://github.com/trociny/ceph/commit/2307706461ae09922c087065a8b50a04a61159b1

And this one configuration options I used

https://github.com/trociny/ceph/commit/dcee0c0635d37f2b36257c55a3cc69d05b5afe5e

I have seen several commits since that time in master aimed to improve
FreeBSD compilation, so I suppose some of my patches are not needed
any more.

Still, if you experince issues building upstream Ceph on FreeBSD, and
just want to try it on FreeBSD, you could try my branch:

git clone --recursive -b wip-freebsd https://github.com/trociny/ceph.git
cd ceph
./install-deps.sh
./do_autogen.sh
gmake
cd src
./vstart.sh # start dev cluster
./ceph -s # check it works

-- 
Mykola Golub
