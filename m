From: Sage Weil <sage@newdream.net>
Subject: Re: Some thoughts regarding the new store
Date: Wed, 27 May 2015 14:14:20 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505271411430.6462@cobra.newdream.net>
References: <55658320.3060907@ubuntukylin.com> <CACJqLyZzw+2ZbX6zDN_x6SZ4kCk+NJ6bty_yu+s_6gCACYRvww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57833 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbE0VOU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 May 2015 17:14:20 -0400
In-Reply-To: <CACJqLyZzw+2ZbX6zDN_x6SZ4kCk+NJ6bty_yu+s_6gCACYRvww@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Li Wang <liwang@ubuntukylin.com>, Samuel Just <sjust@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 27 May 2015, Haomai Wang wrote:
> On Wed, May 27, 2015 at 4:41 PM, Li Wang <liwang@ubuntukylin.com> wrote:
> > I have just noticed the new store development, and had a
> > look at the idea behind it (http://www.spinics.net/lists/ceph-
> > devel/msg22712.html), so my understanding, we wanna avoid the
> > double-write penalty of WRITE_AHEAD_LOGGING journal mechanism,
> > the straightforward thought is to optimize CREATE, APPEND and
> > FULL-OBJECT-OVERWRITE by writing into new files directly,
> > then update the metadata in a transaction. Other changes include:
> > move the object metadata from filesystem extend attrbutes into
> > key value database; map an object into possibly multiple files.
> >
> > If my understanding is correct, then it seems there follows some issues,
> >
> > 1 Garbage collection is needed to reclaim orphan files generated
> > from crashing;
> 
> Yes, but still now we haven't dive into this problem. Because
> currently newstore only allow one object one file.
> 
> Anyway I guess GC isn't a big problem. journal keys should be help, is
> something I missed here?

Currently we are sloppy.  We could add an additional key on each commit to 
make sure that we don't leak fragments on crash, but honestly I'm not sure 
it's worth the effort given that it's such a tiny amount of space.

sage
