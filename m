From: Sage Weil <sweil@redhat.com>
Subject: Re: ceph-disk vs keyvaluestore
Date: Wed, 1 Oct 2014 16:53:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410011650140.31126@cobra.newdream.net>
References: <alpine.DEB.2.00.1409291645320.20141@cobra.newdream.net> <CACJqLyaY90afTC8UCn6jTOWNhJyvyGEaEwiou4S8_sX0hUnB6g@mail.gmail.com> <CACJqLyZpG7rPB1oi0jAxL2+B-xhRrWMg8oyFNqp10cm=+DmgLg@mail.gmail.com> <alpine.DEB.2.00.1409292103250.6593@cobra.newdream.net>
 <542C9264.9090300@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45043 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbaJAXxA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Oct 2014 19:53:00 -0400
In-Reply-To: <542C9264.9090300@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 2 Oct 2014, Mark Kirkwood wrote:
> On 30/09/14 17:05, Sage Weil wrote:
> > On Tue, 30 Sep 2014, Haomai Wang wrote:
> > > Hi sage,
> > > 
> > > What do you think use existing ObjectStore::peek_journal_fsid
> > > interface to detect whether journal needed.
> > > 
> > > KeyValueStore and MemStore could set passing argument "fsid" to zero
> > > to indicate no journal.
> > 
> > I'm not sure it's a good fit... it's called on an existing store and tells
> > you something about it.  I would probably expect a zeroed fsid to mean
> > that the specified journal is empty or does not exist, not that it doesn't
> > need to exist.
> > 
> > What we need, on the other hand, is something that just tells us whether
> > we should create a journal...
> > 
> > 
> 
> And perhaps the "type" (probably not the right word) of journal:
> 
> - filestore: device or filesystem
> - rocksdb: filesystem (wal directory)
> - leveldb: none (I think)

Hmm, good point.  Haomai added this as yes/no, maybe 'none' and 'device' 
is a bit more flexible in case we add 'dir' in the future?

> FWIW, it looks like the log files for leveldb *could* benefit from being
> placed somewhere else (e.g on faster storage). Is it worthwhile suggesting to
> the leveldb devs?

Worth a shot, but don't hold your breath :)

sage
