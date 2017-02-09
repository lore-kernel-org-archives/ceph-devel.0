From: Sage Weil <sage@newdream.net>
Subject: Re: ondisk_read/write lock
Date: Thu, 9 Feb 2017 02:41:49 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702090238450.7782@piezo.novalocal>
References: <CAB7xdin7da09+NC5qjXu7Yoz6wmGCVFztDDUmtUXPSk5+m=eJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57086 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbdBIDgk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Feb 2017 22:36:40 -0500
In-Reply-To: <CAB7xdin7da09+NC5qjXu7Yoz6wmGCVFztDDUmtUXPSk5+m=eJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 8 Feb 2017, sheng qiu wrote:
> Hi cepher,
> 
> I noticed that when PG worker is processing the op, it may acquire
> obc->ondisk_read_lock or obc->ondisk_write_lock. it's used to protect
> concurrent read and write to same object.
> 
> But to my understanding, the PG lock is held while worker is
> processing op which already prevent concurrent access for the same
> object. Does that mean those locks are not actually needed?

This is an artifact of the somewhat weird FileStore write behavior.  The 
OSD takes the lock, queues a write, and a callback called when the write 
completes releases the lock.  This ensures that if there is a read it will 
block until the write is applied.

FileStore is a bit strange in that the lock isn't released until the write 
is readable, which is actually *after* the write is committed.  That's 
because it's doing write-ahead journaling, which commits the transaction 
to the journal before actually writing it to the file system (where it can 
be read back).

BlueStore doesn't behave this way, but unfortunately it would take a lot 
of work to remove the need for the FileStore callback releasing 
ondisk_write_lock so that it could be removed.  :(

sage
