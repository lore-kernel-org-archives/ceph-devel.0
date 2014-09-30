From: Sage Weil <sweil@redhat.com>
Subject: Re: ceph-disk vs keyvaluestore
Date: Mon, 29 Sep 2014 21:05:36 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409292103250.6593@cobra.newdream.net>
References: <alpine.DEB.2.00.1409291645320.20141@cobra.newdream.net> <CACJqLyaY90afTC8UCn6jTOWNhJyvyGEaEwiou4S8_sX0hUnB6g@mail.gmail.com> <CACJqLyZpG7rPB1oi0jAxL2+B-xhRrWMg8oyFNqp10cm=+DmgLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51175 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbaI3EFh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Sep 2014 00:05:37 -0400
In-Reply-To: <CACJqLyZpG7rPB1oi0jAxL2+B-xhRrWMg8oyFNqp10cm=+DmgLg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Mark Kirkwood <mark.kirkwood@catalyst.net.nz>

On Tue, 30 Sep 2014, Haomai Wang wrote:
> Hi sage,
> 
> What do you think use existing ObjectStore::peek_journal_fsid
> interface to detect whether journal needed.
> 
> KeyValueStore and MemStore could set passing argument "fsid" to zero
> to indicate no journal.

I'm not sure it's a good fit... it's called on an existing store and tells 
you something about it.  I would probably expect a zeroed fsid to mean 
that the specified journal is empty or does not exist, not that it doesn't 
need to exist.

What we need, on the other hand, is something that just tells us whether 
we should create a journal...

sage
