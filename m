From: Jeff Layton <jlayton@kernel.org>
Subject: Re: What's a good default TTL for DNS keys in the kernel
Date: Tue, 14 Apr 2020 16:16:05 -0400
Message-ID: <e751977dac616d93806d98f4ad3ce144bb1eb244.camel@kernel.org>
References: <3865908.1586874010@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3865908.1586874010@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org
Cc: keyrings@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, fweimer@redhat.com
List-Id: ceph-devel.vger.kernel.org

On Tue, 2020-04-14 at 15:20 +0100, David Howells wrote:
> Since key.dns_resolver isn't given a TTL for the address information obtained
> for getaddrinfo(), no expiry is set on dns_resolver keys in the kernel for
> NFS, CIFS or Ceph.  AFS gets one if it looks up a cell SRV or AFSDB record
> because that is looked up in the DNS directly, but it doesn't look up A or
> AAAA records, so doesn't get an expiry for the addresses themselves.
> 
> I've previously asked the libc folks if there's a way to get this information
> exposed in struct addrinfo, but I don't think that ended up going anywhere -
> and, in any case, would take a few years to work through the system.
> 
> For the moment, I think I should put a default on any dns_resolver keys and
> have it applied either by the kernel (configurable with a /proc/sys/ setting)
> or by the key.dnf_resolver program (configurable with an /etc file).
> 
> Any suggestion as to the preferred default TTL?  10 minutes?
> 

Typical DNS TTL values are on the order of a day but it can vary widely.
There's really no correct answer for this, since you have no way to tell
how long the entry has been sitting in the DNS server's cache before you
queried for it.

So, you're probably down to just finding some value that doesn't hammer
the DNS server too much, but that allows you to get new entries in a
reasonable amount of time.

10 mins sounds like a reasonable default to me.
-- 
Jeff Layton <jlayton@kernel.org>
