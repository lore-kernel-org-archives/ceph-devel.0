From: Ronnie Sahlberg <lsahlber@redhat.com>
Subject: Re: cifs - Race between IP address change and sget()?
Date: Mon, 20 Apr 2020 21:29:59 -0400 (EDT)
Message-ID: <194431215.23515823.1587432599559.JavaMail.zimbra@redhat.com>
References: <878siq587w.fsf@cjr.nz> <87imhvj7m6.fsf@cjr.nz> <CAH2r5mv5p=WJQu2SbTn53FeTsXyN6ke_CgEjVARQ3fX8QAtK_w@mail.gmail.com> <3865908.1586874010@warthog.procyon.org.uk> <927453.1587285472@warthog.procyon.org.uk> <1136024.1587388420@warthog.procyon.org.uk> <1986040.1587420879@warthog.procyon.org.uk> <93e1141d15e44a7490d756b0a00060660306fadc.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24664 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725897AbgDUBaG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Apr 2020 21:30:06 -0400
In-Reply-To: <93e1141d15e44a7490d756b0a00060660306fadc.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@cjr.nz>, viro@zeniv.linux.org.uk, Steve French <smfrench@gmail.com>, linux-nfs <linux-nfs@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, keyrings@vger.kernel.org, Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, fweimer@redhat.com





----- Original Message -----
> From: "Jeff Layton" <jlayton@redhat.com>
> To: "David Howells" <dhowells@redhat.com>, "Paulo Alcantara" <pc@cjr.nz>
> Cc: viro@zeniv.linux.org.uk, "Steve French" <smfrench@gmail.com>, "linux-nfs" <linux-nfs@vger.kernel.org>, "CIFS"
> <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, keyrings@vger.kernel.org,
> "Network Development" <netdev@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>, fweimer@redhat.com
> Sent: Tuesday, 21 April, 2020 8:30:37 AM
> Subject: Re: cifs - Race between IP address change and sget()?
> 
> On Mon, 2020-04-20 at 23:14 +0100, David Howells wrote:
> > Paulo Alcantara <pc@cjr.nz> wrote:
> > 
> > > > > > What happens if the IP address the superblock is going to changes,
> > > > > > then
> > > > > > another mount is made back to the original IP address?  Does the
> > > > > > second
> > > > > > mount just pick the original superblock?
> > > > > 
> > > > > It is going to transparently reconnect to the new ip address, SMB
> > > > > share,
> > > > > and cifs superblock is kept unchanged.  We, however, update internal
> > > > > TCP_Server_Info structure to reflect new destination ip address.
> > > > > 
> > > > > For the second mount, since the hostname (extracted out of the UNC
> > > > > path
> > > > > at mount time) resolves to a new ip address and that address was
> > > > > saved
> > > > > earlier in TCP_Server_Info structure during reconnect, we will end up
> > > > > reusing same cifs superblock as per
> > > > > fs/cifs/connect.c:cifs_match_super().
> > > > 
> > > > Would that be a bug?
> > > 
> > > Probably.
> > > 
> > > I'm not sure how that code is supposed to work, TBH.
> > 
> > Hmmm...  I think there may be a race here then - but I'm not sure it can be
> > avoided or if it matters.
> > 
> > Since the address is part of the primary key to sget() for cifs, changing
> > the
> > IP address will change the primary key.  Jeff tells me that this is
> > governed
> > by a spinlock taken by cifs_match_super().  However, sget() may be busy
> > attaching a new mount to the old superblock under the sb_lock core vfs
> > lock,
> > having already found a match.
> > 
> 
> Not exactly. Both places that match TCP_Server_Info objects by address
> hold the cifs_tcp_ses_lock. The address looks like it gets changed in
> reconn_set_ipaddr, and the lock is not currently taken there, AFAICT. I
> think it probably should be (at least around the cifs_convert_address
> call).

I think you are right. We need the spinlock around this call too.
I will send a patch to the list to add this.

> 
> > Should the change of parameters made by cifs be effected with sb_lock held
> > to
> > try and avoid ending up using the wrong superblock?
> > 
> > However, because the TCP_Server_Info is apparently updated, it looks like
> > my
> > original concern is not actually a problem (the idea that if a mounted
> > server
> > changes its IP address and then a new server comes online at the old IP
> > address, it might end up sharing superblocks because the IP address is part
> > of
> > the key).
> > 
> 
> I'm not sure we should concern ourselves with much more than just not
> allowing addresses to change while matching/searching. If you're
> standing up new servers at old addresses while you still have clients
> are migrating, then you are probably Doing it Wrong.

Agree. That is a migration process issue and not something we can/should
try to address in cifs.ko.



> 
> --
> Jeff Layton <jlayton@redhat.com>
> 
> 
