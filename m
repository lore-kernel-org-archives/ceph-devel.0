From: Chuck Lever <chuck.lever-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: What's a good default TTL for DNS keys in the kernel
Date: Thu, 16 Apr 2020 09:40:30 -0400
Message-ID: <8DC44895-E904-4155-B7B8-B109A777F23C@oracle.com>
References: <874ktl2ide.fsf@oldenburg2.str.redhat.com>
 <3865908.1586874010@warthog.procyon.org.uk>
 <128769.1587032833@warthog.procyon.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <128769.1587032833-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Linux NFS Mailing List <linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-cifs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-afs-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi David-

> On Apr 16, 2020, at 6:27 AM, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> =
wrote:
>=20
> Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>=20
>> You can get the real TTL if you do a DNS resolution on the name and
>> match the addresses against what you get out of the NSS functions.  =
If
>> they match, you can use the TTL from DNS.  Hackish, but it does give =
you
>> *some* TTL value.
>=20
> I guess I'd have to do that in parallel.  Would calling something like
> res_mkquery() use local DNS caching?
>=20
>> The question remains what the expected impact of TTL expiry is.  Will
>> the kernel just perform a new DNS query if it needs one?  Or would =
you
>> expect that (say) the NFS client rechecks the addresses after TTL =
expiry
>> and if they change, reconnect to a new NFS server?
>=20
> It depends on the filesystem.

Agreed. For example:

The Linux NFS client won't connect to a new server when the server's
DNS information changes. A fresh mount operation would be needed for
the client to recognize and make use of it.

There are mechanisms in the NFSv4 protocol to collect server IP =
addresses
from the server itself (fs_locations) and then try those locations if =
the
current server fails to respond. But currently that is not implemented =
in
Linux (and servers would need to be ready to provide that kind of =
update).


> AFS keeps track of the expiration on the record and will issue a new =
lookup
> when the data expires, but NFS doesn't make use of this information.  =
The
> keyring subsystem will itself dispose of dns_resolver keys that expire =
and
> request_key() will only upcall again if the key has expired.

Our NFS colleagues working on Solaris have noted that handling the =
expiry
of DNS information can be tricky. It is usually desirable to continue =
using
expired information when a new DNS query fails temporarily (times out, =
or
the network is partitioned, etc). That makes for a more robust network =
file
service.


> The problem for NFS is that the host IP address is the primary key for =
the
> superblock (see nfs_compare_super_address()).

I thought that NFSv4.1 and newer have server-provided unique information
that might be used in place of the server's IP address. This information
is supposed to be independent of a server's network addresses.


> CIFS also doesn't make direct use of the TTL, and again this may be =
because it
> uses the server address as part of the primary key for the superblock =
(see
> cifs_match_super()).

--
Chuck Lever
