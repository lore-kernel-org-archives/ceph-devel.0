From: NeilBrown <neilb@suse.de>
Subject: Re: fscache recursive hang -- similar to loopback NFS issues
Date: Mon, 21 Jul 2014 16:40:44 +1000
Message-ID: <20140721164044.2845f3fd@notabene.brown>
References: <CANP1eJE7tU9touhSq+Utt=MLE4w5D_C4pT1TAFAiFNBh8ee_mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/dnPA4Qxg9m_jy9VlA_Ge.pE"; protocol="application/pgp-signature"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <CANP1eJE7tU9touhSq+Utt=MLE4w5D_C4pT1TAFAiFNBh8ee_mA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Milosz Tanski <milosz@adfin.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>, David Howells <dhowells@redhat.com>
List-Id: ceph-devel.vger.kernel.org

--Sig_/dnPA4Qxg9m_jy9VlA_Ge.pE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 19 Jul 2014 16:20:01 -0400 Milosz Tanski <milosz@adfin.com> wrote:

> Neil,
>=20
> I saw your recent patcheset for improving the wait_on_bit interface
> (particular: SCHED: allow wait_on_bit_action functions to support a
> timeout.) I'm looking on some guidance on leveraging that work to
> solve other recursive lock hang in fscache.
>=20
> I've ran into similar issues you're trying to solve with loopback NFS
> but in the fscache code. This happens under heavy vma preasure when
> the kernel is aggressively trying to trim the page cache.
>=20
> The hang is caused by this serious of events
> 1. cachefiles_write_page - cachefiles (the fscache backend, sitting on
> ext4) tries to write page to disk
> 2. ext4 tries to allocate a page in writeback (without GPF_NOFS and
> with wait flag)
> 3. due to vma preasure the kernel tries to free-up pages
> 4. this causes release pages in ceph to be called
> 5. the selected page is cached page in process of write out (from step #1)
> 6. fscache_wait_on_page_write hangs forever
>=20
> Is there a solution that you have to NFS as another patch that
> implements the timeout that I can use a template? I'm not familiar
> with that piece of the code base.

It looks like the comment in  __fscache_maybe_release_page

	/* We will wait here if we're allowed to, but that could deadlock the
	 * allocator as the work threads writing to the cache may all end up
	 * sleeping on memory allocation, so we may need to impose a timeout
	 * too. */

is correct when it says "we may need to impose a timeout".
The following __fscache_wait_on_page_write() needs to timeout.

However that doesn't use wait_on_bit(), it just has a simple wait_event.
So something like this should fix it (or should at least move the problem
along a bit).

NeilBrown



diff --git a/fs/fscache/page.c b/fs/fscache/page.c
index ed70714503fa..58035024c5cf 100644
--- a/fs/fscache/page.c
+++ b/fs/fscache/page.c
@@ -43,6 +43,13 @@ void __fscache_wait_on_page_write(struct fscache_cookie =
*cookie, struct page *pa
 }
 EXPORT_SYMBOL(__fscache_wait_on_page_write);
=20
+void __fscache_wait_on_page_write_timeout(struct fscache_cookie *cookie, s=
truct page *page, unsigned long timeout)
+{
+	wait_queue_head_t *wq =3D bit_waitqueue(&cookie->flags, 0);
+
+	wait_event_timeout(*wq, !__fscache_check_page_write(cookie, page), timeou=
t);
+}
+
 /*
  * decide whether a page can be released, possibly by cancelling a store t=
o it
  * - we're allowed to sleep if __GFP_WAIT is flagged
@@ -115,7 +122,7 @@ page_busy:
 	}
=20
 	fscache_stat(&fscache_n_store_vmscan_wait);
-	__fscache_wait_on_page_write(cookie, page);
+	__fscache_wait_on_page_write_timeout(cookie, page, HZ);
 	gfp &=3D ~__GFP_WAIT;
 	goto try_again;
 }




--Sig_/dnPA4Qxg9m_jy9VlA_Ge.pE
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIVAwUBU8y18jnsnt1WYoG5AQLi0w/+JLh8nSNVRElmEaaZCR54uE4su8F54Xxi
O4YX+9l8ZOy/w2wcJHixcHOWfhm7JGSyBiPhEfOw+CzGWJ2ct94c5/RvlbaIl2Hp
nrieGj7ot2H8BRDShdksL57nfCFYtcIolA90tw1/mpxtnugDh4X9RAIjigNU3Fgm
6B67ezhBWRUovCjNtW7hR4iYv58pdekEjIh47Bf5fITg5uU11j4UB3cvp5esSX3O
dJULdT66Cu4kvmN1JjpqS3xHeGJW8UwAq7LIwC+azPTBd5goej7S0kveYVaR9q0B
CgTJO8aC3VD3M7pK4TteV6QstcSv8eQcbVnltKey8meWfSFRuB/1B+ZAOYZiHNTp
CIcBKJE0F7iUq1vEzVBLZ0dJh5SgSD/9SQ2cbsI1C6VUkvlS5aNE+HtmCpnRVL/I
61ij4FQOajBe0c2Q4rjR2DRFO9UJdqeCtcfCLxZYjfMY3b7/J/1rVi0Ah/BjMWo3
u8usPMS4qkAahBCRQmqLuiGzVik/ayLogD29pwZZJAXY0j3+I6BmAM82WiVLAq1P
74k9x0m3komcRPGx77+0+4ODervSuXD9N3AygaOlBv0ZdlfgJ9JfW+dgqgk7oWCU
Mjhlds6pAmE2xnTYxzmxijWiFU45kNazpU7ZQUmKAEhARy/NT3wsLoE4BVsa7C9A
z2HCMqDPhjo=
=VSJD
-----END PGP SIGNATURE-----

--Sig_/dnPA4Qxg9m_jy9VlA_Ge.pE--
