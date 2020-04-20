From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: What's a good default TTL for DNS keys in the kernel
Date: Mon, 20 Apr 2020 14:13:40 +0100
Message-ID: <1136024.1587388420@warthog.procyon.org.uk>
References: <87imhvj7m6.fsf@cjr.nz> <CAH2r5mv5p=WJQu2SbTn53FeTsXyN6ke_CgEjVARQ3fX8QAtK_w@mail.gmail.com> <3865908.1586874010@warthog.procyon.org.uk> <927453.1587285472@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87imhvj7m6.fsf-jNnf+gw1pmM@public.gmane.org>
Content-ID: <1136023.1587388420.1-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paulo Alcantara <pc-jNnf+gw1pmM@public.gmane.org>
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Steve French <smfrench-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-nfs <linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, CIFS <linux-cifs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-afs-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Network Development <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Paulo Alcantara <pc-jNnf+gw1pmM@public.gmane.org> wrote:

> >> For SMB3/CIFS mounts, Paulo added support last year for automatic
> >> reconnect if the IP address of the server changes.  It also is helpfu=
l
> >> when DFS (global name space) addresses change.
> >
> > What happens if the IP address the superblock is going to changes, the=
n
> > another mount is made back to the original IP address?  Does the secon=
d mount
> > just pick the original superblock?
> =

> It is going to transparently reconnect to the new ip address, SMB share,
> and cifs superblock is kept unchanged.  We, however, update internal
> TCP_Server_Info structure to reflect new destination ip address.
> =

> For the second mount, since the hostname (extracted out of the UNC path
> at mount time) resolves to a new ip address and that address was saved e=
arlier
> in TCP_Server_Info structure during reconnect, we will end up
> reusing same cifs superblock as per fs/cifs/connect.c:cifs_match_super()=
.

Would that be a bug?

David
