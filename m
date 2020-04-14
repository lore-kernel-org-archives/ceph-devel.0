From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: What's a good default TTL for DNS keys in the kernel
Date: Tue, 14 Apr 2020 15:20:10 +0100
Message-ID: <3865908.1586874010@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-ID: <3865907.1586874010.1-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-cifs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-afs-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Since key.dns_resolver isn't given a TTL for the address information obtained
for getaddrinfo(), no expiry is set on dns_resolver keys in the kernel for
NFS, CIFS or Ceph.  AFS gets one if it looks up a cell SRV or AFSDB record
because that is looked up in the DNS directly, but it doesn't look up A or
AAAA records, so doesn't get an expiry for the addresses themselves.

I've previously asked the libc folks if there's a way to get this information
exposed in struct addrinfo, but I don't think that ended up going anywhere -
and, in any case, would take a few years to work through the system.

For the moment, I think I should put a default on any dns_resolver keys and
have it applied either by the kernel (configurable with a /proc/sys/ setting)
or by the key.dnf_resolver program (configurable with an /etc file).

Any suggestion as to the preferred default TTL?  10 minutes?

David
