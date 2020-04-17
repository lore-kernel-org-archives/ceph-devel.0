From: Steve French <smfrench@gmail.com>
Subject: Re: What's a good default TTL for DNS keys in the kernel
Date: Fri, 17 Apr 2020 18:23:53 -0500
Message-ID: <CAH2r5mv5p=WJQu2SbTn53FeTsXyN6ke_CgEjVARQ3fX8QAtK_w@mail.gmail.com>
References: <3865908.1586874010@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <3865908.1586874010@warthog.procyon.org.uk>
Sender: netdev-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, keyrings@vger.kernel.org, Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, fweimer@redhat.com
List-Id: ceph-devel.vger.kernel.org

>> The question remains what the expected impact of TTL expiry is.  Will
>> the kernel just perform a new DNS query if it needs one?

For SMB3/CIFS mounts, Paulo added support last year for automatic
reconnect if the IP address of the server changes.  It also is helpful
when DFS (global name space) addresses change.

It does not require a remount for SMB3/CIFS

On Tue, Apr 14, 2020 at 11:09 AM David Howells <dhowells@redhat.com> wrote:
>
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
> David
>


-- 
Thanks,

Steve
