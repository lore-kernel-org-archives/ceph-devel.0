From: David Howells <dhowells@redhat.com>
Subject: Re: What's a good default TTL for DNS keys in the kernel
Date: Thu, 16 Apr 2020 11:27:13 +0100
Message-ID: <128769.1587032833@warthog.procyon.org.uk>
References: <874ktl2ide.fsf@oldenburg2.str.redhat.com> <3865908.1586874010@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <874ktl2ide.fsf@oldenburg2.str.redhat.com>
Content-ID: <128768.1587032833.1@warthog.procyon.org.uk>
Sender: netdev-owner@vger.kernel.org
To: Florian Weimer <fweimer@redhat.com>
Cc: dhowells@redhat.com, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, keyrings@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Florian Weimer <fweimer@redhat.com> wrote:

> You can get the real TTL if you do a DNS resolution on the name and
> match the addresses against what you get out of the NSS functions.  If
> they match, you can use the TTL from DNS.  Hackish, but it does give you
> *some* TTL value.

I guess I'd have to do that in parallel.  Would calling something like
res_mkquery() use local DNS caching?

> The question remains what the expected impact of TTL expiry is.  Will
> the kernel just perform a new DNS query if it needs one?  Or would you
> expect that (say) the NFS client rechecks the addresses after TTL expiry
> and if they change, reconnect to a new NFS server?

It depends on the filesystem.

AFS keeps track of the expiration on the record and will issue a new lookup
when the data expires, but NFS doesn't make use of this information.  The
keyring subsystem will itself dispose of dns_resolver keys that expire and
request_key() will only upcall again if the key has expired.

The problem for NFS is that the host IP address is the primary key for the
superblock (see nfs_compare_super_address()).

CIFS also doesn't make direct use of the TTL, and again this may be because it
uses the server address as part of the primary key for the superblock (see
cifs_match_super()).

David
