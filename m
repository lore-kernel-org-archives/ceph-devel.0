From: Sage Weil <sage@inktank.com>
Subject: Re: mds dump
Date: Fri, 8 Jun 2012 08:58:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206080857530.8391@cobra.newdream.net>
References: <9CFDA4F85EA1425B888F7F62DA77038E@inktank.com>
 <a1cf1173-9a9c-49b9-8f76-6a8267c692b3@mail.linserv.se>
 <CADvuQRF5-hEhHtA_VoyuV0VhpTZ_YY_md4Mc=0-82Cb6D2EvLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51272 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab2FHP6m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 11:58:42 -0400
In-Reply-To: <CADvuQRF5-hEhHtA_VoyuV0VhpTZ_YY_md4Mc=0-82Cb6D2EvLw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Martin Wilderoth <martin.wilderoth@linserv.se>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 8 Jun 2012, Tommi Virtanen wrote:
> On Fri, Jun 8, 2012 at 12:35 AM, Martin Wilderoth
> <martin.wilderoth@linserv.se> wrote:
> > And if i just want to mkfs or similar in mds is that possible. Or or my rbd will
> > also be removed ? Or how should I recover if I don't care of the data in
> > the POSIX file system ?
> 
> By default, the Ceph Distributed File System puts file metadata in the
> pool "metadata", and file contents in the pool "data". RBD images, by
> default, are stored in the pool "rbd". This means you can empty/remove
> the pools "metadata" and "data" without affecting RBD.

There is also an undocumented way to recreate a new mdsmap (mds cluster) 
without affecting the rest of cluster.  Is that what you're after?

sage

