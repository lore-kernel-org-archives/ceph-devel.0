From: Jeff Darcy <jdarcy@redhat.com>
Subject: Re: RADOS translator for GlusterFS
Date: Mon, 5 May 2014 13:08:05 -0400 (EDT)
Message-ID: <1793642728.775752.1399309685692.JavaMail.zimbra@redhat.com>
References: <980181538.654650.1399300829103.JavaMail.zimbra@redhat.com> <355696287.706122.1399303290204.JavaMail.zimbra@redhat.com> <CABBk=J8=GgAPM7qWfs9=OZt6yHVERggiugPui31w4b=GPk8Oow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:45181 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210AbaEERIH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 May 2014 13:08:07 -0400
In-Reply-To: <CABBk=J8=GgAPM7qWfs9=OZt6yHVERggiugPui31w4b=GPk8Oow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, gluster-devel@gluster.org

> > Of particular interest here are the DHT (routing/distribution) and AFR
> > (fan-out/replication) translators, which mirror functionality in RADOS.
> > My idea is to cut out everything from these on below, in favor of a
> > translator based on librados instead.  How this works is pretty obvious
> > for file data - just read and write to RADOS objects instead of to
> > files.  It's a bit less obvious for metadata, especially directory
> 
> Sorry if I'm missing something obvious, but how are reads / writes
> actually done? Do you keep an open file descriptor and work on that
> (e.g., are there open() / close() operations), or are operations don't
> require any state? With RADOS it's the latter case, so we don't
> provide certain guarantees and there are no file-state operations
> (like open(), close(), lock(), etc.). Anything like that needs to be
> implemented on top of it.

We'd have an open file descriptor on the client side, and associated with
that we would keep the OID for the corresponding RADOS object.  In the
simplest case, we could just use those for rados_read/rados_write and not
worry about consistency.  For stronger consistency, we'd need something
more.  Would that be rados_watch/rados_notify or something else?

> > entries.  One really simple idea is to store metadata as data, in some
> > format defined by the translator itself, and have it handle the
> > read/modify/write for adding/deleting entries and such.  That would be
> 
> Maybe integrate it with the mds (which by itself stores metadata as
> data and does all the relevant work)?

Well, part of the point is not to go through the Ceph file system layer,
since that's almost guaranteed to be worse than using the Ceph file
system client.  The question to be answered here is whether there's
something to be gained by mixing and matching somewhere in the middle,
as opposed to just layering one file system implementation on top of
the other.

> > enough to get some basic performance tests done.  A slightly more
> > sophisticated idea might be to use OSD class methods to do the
> > read/modify/write, but I don't know much about that mechanism so I'm not
> > sure that's even feasible.
> 
> I don't see why it wouldn't work. The rados gateway does things
> similarly for handling the bucket index.

Good to know.  I'll take a look at how it does that.  Thanks!
