From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [patch RFC] client: return stripe address replicas
Date: Mon, 7 Nov 2011 13:43:18 -0800
Message-ID: <CAF3hT9BhwtpjZx8WcAk-5rPrBbzU8ufUQZxRrcn-ah_noWJOxg@mail.gmail.com>
References: <172453601.38993.1320698769959.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43811 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab1KGVnS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2011 16:43:18 -0500
Received: by iage36 with SMTP id e36so6303580iag.19
        for <ceph-devel@vger.kernel.org>; Mon, 07 Nov 2011 13:43:18 -0800 (PST)
In-Reply-To: <172453601.38993.1320698769959.JavaMail.root@mail-01.cse.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 7, 2011 at 12:46 PM, Noah Watkins <jayhawk@soe.ucsc.edu> wr=
ote:
> The patch below is a first attempt at updating the libcephfs API to r=
eturn replica locations. I wanted to get opinions on the interface. The=
 short version of the patch is the API changes:
>
> Client.h: returns vector of entity_addr_t
> =A0-int Client::get_file_stripe_address(int fd, loff_t offset, string=
& address)
> =A0+int Client::get_file_stripe_address(int fd, loff_t offset, vector=
<entity_addr_t>& address)
>
> libcephfs.h: returns array of sockaddr_storage
> =A0int ceph_get_file_stripe_address(struct ceph_mount_info *cmount, i=
nt fd,
> =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0loff_=
t offset, char *buf, int buflen);
> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0loff_=
t offset, struct sockaddr_storage *addr, int naddr);
>
> Thanks,
> Noah
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Changes ceph_get_file_stripe_address to return a
> vector of entity_addr_t's for the primary and the
> replicas. libcephfs is updated to return the
> associated sockaddr_storage for each address.
> ---
> =A0src/client/Client.cc =A0 =A0 =A0 =A0 =A0 | =A0 17 +++++++---------=
-
> =A0src/client/Client.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0src/include/cephfs/libcephfs.h | =A0 =A02 +-
> =A0src/libcephfs.cc =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 28 ++++++++++++=
+++-------------
> =A04 files changed, 24 insertions(+), 25 deletions(-)
>
> diff --git a/src/client/Client.cc b/src/client/Client.cc
> index 816fe83..1f01b80 100644
> --- a/src/client/Client.cc
> +++ b/src/client/Client.cc
> @@ -6829,7 +6829,7 @@ int Client::get_pool_replication(int64_t pool)
> =A0 return osdmap->get_pg_pool(pool)->get_size();
> =A0}
>
> -int Client::get_file_stripe_address(int fd, loff_t offset, string& a=
ddress)
> +int Client::get_file_stripe_address(int fd, loff_t offset, vector<en=
tity_addr_t>& address)
> =A0{
> =A0 Mutex::Locker lock(client_lock);
>
> @@ -6848,15 +6848,12 @@ int Client::get_file_stripe_address(int fd, l=
off_t offset, string& address)
> =A0 osdmap->pg_to_acting_osds(pg, osds);
> =A0 if (!osds.size())
> =A0 =A0 return -EINVAL;
> -
> - =A0// now we have the osd(s)
> - =A0entity_addr_t addr =3D osdmap->get_addr(osds[0]);
> -
> - =A0// now we need to turn it into a string
> - =A0char foo[30];
> - =A0__u8 *quad =3D (__u8*) &addr.in4_addr().sin_addr;
> - =A0snprintf(foo, sizeof(foo), "%d.%d.%d.%d", (int)quad[0], (int)qua=
d[1], (int)quad[2], (int)quad[3]);
> - =A0address =3D foo;
> +
> + =A0for (unsigned i =3D 0; i < osds.size(); i++) {
> + =A0 =A0entity_addr_t addr =3D osdmap->get_addr(osds[i]);
> + =A0 =A0address.push_back(addr);
> + =A0}
> +
> =A0 return 0;
> =A0}
>
> diff --git a/src/client/Client.h b/src/client/Client.h
> index bc98ac5..a30b73c 100644
> --- a/src/client/Client.h
> +++ b/src/client/Client.h
> @@ -607,7 +607,7 @@ public:
>
> =A0 // expose file layout
> =A0 int describe_layout(int fd, ceph_file_layout* layout);
> - =A0int get_file_stripe_address(int fd, loff_t offset, string& addre=
ss);
> + =A0int get_file_stripe_address(int fd, loff_t offset, vector<entity=
_addr_t>& address);
>
> =A0 // expose osdmap
> =A0 int get_local_osd();
> diff --git a/src/include/cephfs/libcephfs.h b/src/include/cephfs/libc=
ephfs.h
> index 4b2b64f..6a4a20b 100644
> --- a/src/include/cephfs/libcephfs.h
> +++ b/src/include/cephfs/libcephfs.h
> @@ -157,7 +157,7 @@ int ceph_get_file_stripe_unit(struct ceph_mount_i=
nfo *cmount, int fh);
> =A0int ceph_get_file_pool(struct ceph_mount_info *cmount, int fh);
> =A0int ceph_get_file_replication(struct ceph_mount_info *cmount, int =
fh);
> =A0int ceph_get_file_stripe_address(struct ceph_mount_info *cmount, i=
nt fd,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0loff=
_t offset, char *buf, int buflen);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0loff=
_t offset, struct sockaddr_storage *addr, int naddr);
>
> =A0/* set default layout for new files */
> =A0int ceph_set_default_file_stripe_unit(struct ceph_mount_info *cmou=
nt, int stripe);
> diff --git a/src/libcephfs.cc b/src/libcephfs.cc
> index 153348c..378ce7e 100644
> --- a/src/libcephfs.cc
> +++ b/src/libcephfs.cc
> @@ -584,21 +584,23 @@ extern "C" int ceph_set_default_preferred_pg(st=
ruct ceph_mount_info *cmount, int
> =A0}
>
> =A0extern "C" int ceph_get_file_stripe_address(struct ceph_mount_info=
 *cmount, int fh,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 loff_t offset, char *buf, int buflen)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 loff_t offset, struct sockaddr_storage *addr, int nadd=
r)
> =A0{
> - =A0string address;
> - =A0int r =3D cmount->get_client()->get_file_stripe_address(fh, offs=
et, address);
> + =A0vector<entity_addr_t> address;
> + =A0unsigned i;
> + =A0int r;
> +
> + =A0if (naddr < 0)
> + =A0 =A0return -EINVAL;
> +
> + =A0r =3D cmount->get_client()->get_file_stripe_address(fh, offset, =
address);
> =A0 if (r < 0)
> - =A0 =A0return r;
> - =A0int len =3D address.size()+1;
> - =A0if (len > buflen) {
> - =A0 =A0if (buflen =3D=3D 0)
> - =A0 =A0 =A0return len;
> - =A0 =A0return -ERANGE;
> - =A0}
> - =A0len =3D address.copy(buf, len, 0);
> - =A0buf[len] =3D '\0'; // write a null char to terminate c-style str=
ing
> - =A0return 0;
> + =A0 =A0return r;
> +
> + =A0for (i =3D 0; i < (unsigned)naddr && i < address.size(); i++)
> + =A0 =A0memcpy(&addr[i], &address[i].ss_addr(), sizeof(*addr));
> +
> + =A0return address.size();
> =A0}
>
> =A0extern "C" int ceph_localize_reads(struct ceph_mount_info *cmount,=
 int val)
This generally looks good to me, but that return statement is weirding
me out a bit. I guess you're trying to compress the information about
the number of returned addresses, and whether or not you got all the
addresses, into that one value? It seems more idiomatic to me to send
back the number of filled-in addresses, or an error code if there
wasn't enough space for all of them.
I'm not sure if that idiom is worth applying here, but it was my one
thought about the interface. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
