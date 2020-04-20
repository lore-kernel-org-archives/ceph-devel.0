From: David Howells <dhowells@redhat.com>
Subject: cifs - Race between IP address change and sget()?
Date: Mon, 20 Apr 2020 23:14:39 +0100
Message-ID: <1986040.1587420879@warthog.procyon.org.uk>
References: <878siq587w.fsf@cjr.nz> <87imhvj7m6.fsf@cjr.nz> <CAH2r5mv5p=WJQu2SbTn53FeTsXyN6ke_CgEjVARQ3fX8QAtK_w@mail.gmail.com> <3865908.1586874010@warthog.procyon.org.uk> <927453.1587285472@warthog.procyon.org.uk> <1136024.1587388420@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <878siq587w.fsf@cjr.nz>
Content-ID: <1986039.1587420879.1@warthog.procyon.org.uk>
Sender: netdev-owner@vger.kernel.org
To: Paulo Alcantara <pc@cjr.nz>
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk, Steve French <smfrench@gmail.com>, jlayton@redhat.com, linux-nfs <linux-nfs@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, keyrings@vger.kernel.org, Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, fweimer@redhat.com
List-Id: ceph-devel.vger.kernel.org

Paulo Alcantara <pc@cjr.nz> wrote:

> >> > What happens if the IP address the superblock is going to changes, then
> >> > another mount is made back to the original IP address?  Does the second
> >> > mount just pick the original superblock?
> >> 
> >> It is going to transparently reconnect to the new ip address, SMB share,
> >> and cifs superblock is kept unchanged.  We, however, update internal
> >> TCP_Server_Info structure to reflect new destination ip address.
> >> 
> >> For the second mount, since the hostname (extracted out of the UNC path
> >> at mount time) resolves to a new ip address and that address was saved
> >> earlier in TCP_Server_Info structure during reconnect, we will end up
> >> reusing same cifs superblock as per fs/cifs/connect.c:cifs_match_super().
> >
> > Would that be a bug?
> 
> Probably.
> 
> I'm not sure how that code is supposed to work, TBH.

Hmmm...  I think there may be a race here then - but I'm not sure it can be
avoided or if it matters.

Since the address is part of the primary key to sget() for cifs, changing the
IP address will change the primary key.  Jeff tells me that this is governed
by a spinlock taken by cifs_match_super().  However, sget() may be busy
attaching a new mount to the old superblock under the sb_lock core vfs lock,
having already found a match.

Should the change of parameters made by cifs be effected with sb_lock held to
try and avoid ending up using the wrong superblock?

However, because the TCP_Server_Info is apparently updated, it looks like my
original concern is not actually a problem (the idea that if a mounted server
changes its IP address and then a new server comes online at the old IP
address, it might end up sharing superblocks because the IP address is part of
the key).

David
