From: Paulo Alcantara <pc-jNnf+gw1pmM@public.gmane.org>
Subject: Re: What's a good default TTL for DNS keys in the kernel
Date: Sun, 19 Apr 2020 21:58:25 -0300
Message-ID: <87imhvj7m6.fsf@cjr.nz>
References: <CAH2r5mv5p=WJQu2SbTn53FeTsXyN6ke_CgEjVARQ3fX8QAtK_w@mail.gmail.com>
 <3865908.1586874010@warthog.procyon.org.uk>
 <927453.1587285472@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <927453.1587285472-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steve French <smfrench-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-nfs <linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, CIFS <linux-cifs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-afs-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Network Development <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> writes:

> Steve French <smfrench-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>> For SMB3/CIFS mounts, Paulo added support last year for automatic
>> reconnect if the IP address of the server changes.  It also is helpful
>> when DFS (global name space) addresses change.
>
> What happens if the IP address the superblock is going to changes, then
> another mount is made back to the original IP address?  Does the second mount
> just pick the original superblock?

It is going to transparently reconnect to the new ip address, SMB share,
and cifs superblock is kept unchanged.  We, however, update internal
TCP_Server_Info structure to reflect new destination ip address.

For the second mount, since the hostname (extracted out of the UNC path
at mount time) resolves to a new ip address and that address was saved earlier
in TCP_Server_Info structure during reconnect, we will end up
reusing same cifs superblock as per fs/cifs/connect.c:cifs_match_super().
