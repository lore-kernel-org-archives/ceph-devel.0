From: Steve French <smfrench-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: What's a good default TTL for DNS keys in the kernel
Date: Wed, 15 Apr 2020 12:07:26 -0500
Message-ID: <CAH2r5mvj7GF3i8AE6E=+5f_Vigtb3uw=665F2uuBOgGzUhHObQ@mail.gmail.com>
References: <3865908.1586874010@warthog.procyon.org.uk> <e751977dac616d93806d98f4ad3ce144bb1eb244.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e751977dac616d93806d98f4ad3ce144bb1eb244.camel-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeff Layton <jlayton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-nfs <linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, CIFS <linux-cifs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-afs-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Network Development <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Wed, Apr 15, 2020 at 8:22 AM Jeff Layton <jlayton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> On Tue, 2020-04-14 at 15:20 +0100, David Howells wrote:
> > Since key.dns_resolver isn't given a TTL for the address information obtained
> > for getaddrinfo(), no expiry is set on dns_resolver keys in the kernel for
> > NFS, CIFS or Ceph.  AFS gets one if it looks up a cell SRV or AFSDB record
> > because that is looked up in the DNS directly, but it doesn't look up A or
> > AAAA records, so doesn't get an expiry for the addresses themselves.
> >
> > I've previously asked the libc folks if there's a way to get this information
> > exposed in struct addrinfo, but I don't think that ended up going anywhere -
> > and, in any case, would take a few years to work through the system.
> >
> > For the moment, I think I should put a default on any dns_resolver keys and
> > have it applied either by the kernel (configurable with a /proc/sys/ setting)
> > or by the key.dnf_resolver program (configurable with an /etc file).
> >
> > Any suggestion as to the preferred default TTL?  10 minutes?
> >
>
> Typical DNS TTL values are on the order of a day but it can vary widely.
> There's really no correct answer for this, since you have no way to tell
> how long the entry has been sitting in the DNS server's cache before you
> queried for it.
>
> So, you're probably down to just finding some value that doesn't hammer
> the DNS server too much, but that allows you to get new entries in a
> reasonable amount of time.
>
> 10 mins sounds like a reasonable default to me.

I would lean toward slightly longer (20 minutes?) but aren't there
usually different timeouts for 'static' vs. 'dynamic' DNS records (so
static records would have longer timeouts)?


-- 
Thanks,

Steve
