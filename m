From: John Spray <john.spray@inktank.com>
Subject: Re: RADOS translator for GlusterFS
Date: Mon, 5 May 2014 17:43:38 +0100
Message-ID: <CAGd4Wr2ez_Sb6TCdtTzxEUx6Jrb5dfWuFEWQkmYHeWmqJVT0rg@mail.gmail.com>
References: <980181538.654650.1399300829103.JavaMail.zimbra@redhat.com>
	<355696287.706122.1399303290204.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:61122 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880AbaEEQnj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 May 2014 12:43:39 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so10047573pad.1
        for <ceph-devel@vger.kernel.org>; Mon, 05 May 2014 09:43:39 -0700 (PDT)
In-Reply-To: <355696287.706122.1399303290204.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

In terms of making something work really quickly, one approach would
be to base off the existing POSIX translator, use a local FS backed by
an RBD volume for the metadata, and store the file content directly
using librados.  That would avoid the need to invent a way to map
filesystem-style metadata to librados calls, while still getting
reasonably efficient data operations through to rados.

I would doubt this would be very slick, but it could be a fun hack!

John


On Mon, May 5, 2014 at 4:21 PM, Jeff Darcy <jdarcy@redhat.com> wrote:
>
> Now that we're all one big happy family, I've been mulling over
> different ways that the two technology stacks could work together.  One
> idea would be to use some of the GlusterFS upper layers for their
> interface and integration possibilities, but then falling down to RADOS
> instead of GlusterFS's own distribution and replication.  I must
> emphasize that I don't necessarily think this is The Right Way for
> anything real, but I think it's an important experiment just to see what
> the problems are and how well it performs.  So here's what I'm thinking.
>
> For the Ceph folks, I'll describe just a tiny bit of how GlusterFS
> works.  The core concept in GlusterFS is a "translator" which accepts
> file system requests and generates file system requests in exactly the
> same form.  This allows them to be stacked in arbitrary orders, moved
> back and forth across the server/client divide, etc.  There are several
> broad classes of translators:
>
> * Some, such as FUSE or GFAPI, inject new requests into the translator
>   stack.
>
> * Some, such as "posix", satisfy requests by calling a server-local FS.
>
> * The "client" and "server" translators together get requests from one
>   machine to another.
>
> * Some translators *route* requests (one in to one of several out).
>
> * Some translators *fan out* requests (one in to all of several out).
>
> * Most are one in, one out, to add e.g. locks or caching etc.
>
> Of particular interest here are the DHT (routing/distribution) and AFR
> (fan-out/replication) translators, which mirror functionality in RADOS.
> My idea is to cut out everything from these on below, in favor of a
> translator based on librados instead.  How this works is pretty obvious
> for file data - just read and write to RADOS objects instead of to
> files.  It's a bit less obvious for metadata, especially directory
> entries.  One really simple idea is to store metadata as data, in some
> format defined by the translator itself, and have it handle the
> read/modify/write for adding/deleting entries and such.  That would be
> enough to get some basic performance tests done.  A slightly more
> sophisticated idea might be to use OSD class methods to do the
> read/modify/write, but I don't know much about that mechanism so I'm not
> sure that's even feasible.
>
> This is not something I'm going to be working on as part of my main job,
> but I'd like to get the experiment started in some of my "spare" time.
> Is there anyone else interested in collaborating, or are there any other
> obvious ideas I'm missing?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
