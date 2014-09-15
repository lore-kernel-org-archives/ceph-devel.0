From: Loic Dachary <loic@dachary.org>
Subject: Re: [PATCH 1/3] buffer: add an aligned buffer with less alignment
 than a page
Date: Mon, 15 Sep 2014 18:46:44 +0200
Message-ID: <541717F4.4050509@dachary.org>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pHqxtxEg62rKadLo1vwJ334a2hI6tNVu6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52513 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753319AbaIOQqw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Sep 2014 12:46:52 -0400
In-Reply-To: <1410796508-28711-1-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Janne Grunau <j@jannau.net>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pHqxtxEg62rKadLo1vwJ334a2hI6tNVu6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Look great !

Running on git builder under the branch wip-9408-buffer-alignment at http=
://ceph.com/gitbuilder.cgi

On 15/09/2014 17:55, Janne Grunau wrote:
> SIMD optimized erasure code computation needs aligned memory. Buffers
> aligned to a page boundary are wasted on it though. The buffers used
> for the erasure code computation are typical smaller than a page.
>=20
> Currently an alignement of 16 bytes is enough for the used
> SIMD instruction sets (SSE4 and NEON).
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  configure.ac         |   9 +++++
>  src/common/buffer.cc | 100 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  src/include/buffer.h |  10 ++++++
>  3 files changed, 119 insertions(+)
>=20
> diff --git a/configure.ac b/configure.ac
> index cccf2d9..1bb27c4 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -793,6 +793,15 @@ AC_MSG_RESULT([no])
>  ])
> =20
>  #
> +# Check for functions to provide aligned memory
> +#
> +AC_CHECK_HEADERS([malloc.h])
> +AC_CHECK_FUNCS([posix_memalign _aligned_malloc memalign aligned_malloc=
],
> +               [found_memalign=3Dyes; break])
> +
> +AS_IF([test "x$found_memalign" !=3D "xyes"], [AC_MSG_WARN([No function=
 for aligned memory allocation found])])
> +
> +#
>  # Check for pthread spinlock (depends on ACX_PTHREAD)
>  #
>  saved_LIBS=3D"$LIBS"
> diff --git a/src/common/buffer.cc b/src/common/buffer.cc
> index b141759..acc221f 100644
> --- a/src/common/buffer.cc
> +++ b/src/common/buffer.cc
> @@ -30,6 +30,10 @@
>  #include <sys/uio.h>
>  #include <limits.h>
> =20
> +#ifdef HAVE_MALLOC_H
> +#include <malloc.h>
> +#endif
> +
>  namespace ceph {
> =20
>  #ifdef BUFFER_DEBUG
> @@ -155,9 +159,15 @@ static simple_spinlock_t buffer_debug_lock =3D SIM=
PLE_SPINLOCK_INITIALIZER;
>      virtual int zero_copy_to_fd(int fd, loff_t *offset) {
>        return -ENOTSUP;
>      }
> +    virtual bool is_aligned() {
> +      return ((long)data & ~CEPH_ALIGN_MASK) =3D=3D 0;
> +    }
>      virtual bool is_page_aligned() {
>        return ((long)data & ~CEPH_PAGE_MASK) =3D=3D 0;
>      }
> +    bool is_n_align_sized() {
> +      return (len & ~CEPH_ALIGN_MASK) =3D=3D 0;
> +    }
>      bool is_n_page_sized() {
>        return (len & ~CEPH_PAGE_MASK) =3D=3D 0;
>      }
> @@ -209,6 +219,41 @@ static simple_spinlock_t buffer_debug_lock =3D SIM=
PLE_SPINLOCK_INITIALIZER;
>      }
>    };
> =20
> +  class buffer::raw_aligned : public buffer::raw {
> +  public:
> +    raw_aligned(unsigned l) : raw(l) {
> +      if (len) {
> +#if HAVE_POSIX_MEMALIGN
> +        if (posix_memalign((void **) &data, CEPH_ALIGN, len))
> +          data =3D 0;
> +#elif HAVE__ALIGNED_MALLOC
> +        data =3D _aligned_malloc(len, CEPH_ALIGN);
> +#elif HAVE_MEMALIGN
> +        data =3D memalign(CEPH_ALIGN, len);
> +#elif HAVE_ALIGNED_MALLOC
> +        data =3D aligned_malloc((len + CEPH_ALIGN - 1) & ~CEPH_ALIGN_M=
ASK,
> +                              CEPH_ALIGN);
> +#else
> +        data =3D malloc(len);
> +#endif
> +        if (!data)
> +          throw bad_alloc();
> +      } else {
> +        data =3D 0;
> +      }
> +      inc_total_alloc(len);
> +      bdout << "raw_aligned " << this << " alloc " << (void *)data << =
" " << l << " " << buffer::get_total_alloc() << bendl;
> +    }
> +    ~raw_aligned() {
> +      free(data);
> +      dec_total_alloc(len);
> +      bdout << "raw_aligned " << this << " free " << (void *)data << "=
 " << buffer::get_total_alloc() << bendl;
> +    }
> +    raw* clone_empty() {
> +      return new raw_aligned(len);
> +    }
> +  };
> +
>  #ifndef __CYGWIN__
>    class buffer::raw_mmap_pages : public buffer::raw {
>    public:
> @@ -334,6 +379,10 @@ static simple_spinlock_t buffer_debug_lock =3D SIM=
PLE_SPINLOCK_INITIALIZER;
>        return true;
>      }
> =20
> +    bool is_aligned() {
> +      return false;
> +    }
> +
>      bool is_page_aligned() {
>        return false;
>      }
> @@ -520,6 +569,9 @@ static simple_spinlock_t buffer_debug_lock =3D SIMP=
LE_SPINLOCK_INITIALIZER;
>    buffer::raw* buffer::create_static(unsigned len, char *buf) {
>      return new raw_static(buf, len);
>    }
> +  buffer::raw* buffer::create_aligned(unsigned len) {
> +    return new raw_aligned(len);
> +  }
>    buffer::raw* buffer::create_page_aligned(unsigned len) {
>  #ifndef __CYGWIN__
>      //return new raw_mmap_pages(len);
> @@ -1013,6 +1065,16 @@ static simple_spinlock_t buffer_debug_lock =3D S=
IMPLE_SPINLOCK_INITIALIZER;
>      return true;
>    }
> =20
> +  bool buffer::list::is_aligned() const
> +  {
> +    for (std::list<ptr>::const_iterator it =3D _buffers.begin();
> +         it !=3D _buffers.end();
> +         ++it)
> +      if (!it->is_aligned())
> +        return false;
> +    return true;
> +  }
> +
>    bool buffer::list::is_page_aligned() const
>    {
>      for (std::list<ptr>::const_iterator it =3D _buffers.begin();
> @@ -1101,6 +1163,44 @@ static simple_spinlock_t buffer_debug_lock =3D S=
IMPLE_SPINLOCK_INITIALIZER;
>      _buffers.push_back(nb);
>    }
> =20
> +void buffer::list::rebuild_aligned()
> +{
> +  std::list<ptr>::iterator p =3D _buffers.begin();
> +  while (p !=3D _buffers.end()) {
> +    // keep anything that's already page sized+aligned
> +    if (p->is_aligned() && p->is_n_align_sized()) {
> +      /*cout << " segment " << (void*)p->c_str()
> +             << " offset " << ((unsigned long)p->c_str() & ~CEPH_ALIGN=
_MASK)
> +             << " length " << p->length()
> +             << " " << (p->length() & ~CEPH_ALIGN_MASK) << " ok" << st=
d::endl;
> +      */
> +      ++p;
> +      continue;
> +    }
> +
> +    // consolidate unaligned items, until we get something that is siz=
ed+aligned
> +    list unaligned;
> +    unsigned offset =3D 0;
> +    do {
> +      /*cout << " segment " << (void*)p->c_str()
> +             << " offset " << ((unsigned long)p->c_str() & ~CEPH_ALIGN=
_MASK)
> +             << " length " << p->length() << " " << (p->length() & ~CE=
PH_ALIGN_MASK)
> +             << " overall offset " << offset << " " << (offset & ~CEPH=
_ALIGN_MASK)
> +             << " not ok" << std::endl;
> +      */
> +      offset +=3D p->length();
> +      unaligned.push_back(*p);
> +      _buffers.erase(p++);
> +    } while (p !=3D _buffers.end() &&
> +	     (!p->is_aligned() ||
> +	      !p->is_n_align_sized() ||
> +	      (offset & ~CEPH_ALIGN_MASK)));
> +    ptr nb(buffer::create_aligned(unaligned._len));
> +    unaligned.rebuild(nb);
> +    _buffers.insert(p, unaligned._buffers.front());
> +  }
> +}
> +
>  void buffer::list::rebuild_page_aligned()
>  {
>    std::list<ptr>::iterator p =3D _buffers.begin();
> diff --git a/src/include/buffer.h b/src/include/buffer.h
> index e5c1b50..ea362e7 100644
> --- a/src/include/buffer.h
> +++ b/src/include/buffer.h
> @@ -56,6 +56,9 @@
>  # include <assert.h>
>  #endif
> =20
> +#define CEPH_ALIGN 16
> +#define CEPH_ALIGN_MASK (~(CEPH_ALIGN - 1LLU))
> +
>  namespace ceph {
> =20
>  class buffer {
> @@ -124,6 +127,7 @@ private:
>     */
>    class raw;
>    class raw_malloc;
> +  class raw_aligned;
>    class raw_static;
>    class raw_mmap_pages;
>    class raw_posix_aligned;
> @@ -144,6 +148,7 @@ public:
>    static raw* create_malloc(unsigned len);
>    static raw* claim_malloc(unsigned len, char *buf);
>    static raw* create_static(unsigned len, char *buf);
> +  static raw* create_aligned(unsigned len);
>    static raw* create_page_aligned(unsigned len);
>    static raw* create_zero_copy(unsigned len, int fd, int64_t *offset);=

> =20
> @@ -177,7 +182,9 @@ public:
>      bool at_buffer_head() const { return _off =3D=3D 0; }
>      bool at_buffer_tail() const;
> =20
> +    bool is_aligned() const { return ((long)c_str() & ~CEPH_ALIGN_MASK=
) =3D=3D 0; }
>      bool is_page_aligned() const { return ((long)c_str() & ~CEPH_PAGE_=
MASK) =3D=3D 0; }
> +    bool is_n_align_sized() const { return (length() & ~CEPH_ALIGN_MAS=
K) =3D=3D 0; }
>      bool is_n_page_sized() const { return (length() & ~CEPH_PAGE_MASK)=
 =3D=3D 0; }
> =20
>      // accessors
> @@ -344,7 +351,9 @@ public:
>      bool contents_equal(buffer::list& other);
> =20
>      bool can_zero_copy() const;
> +    bool is_aligned() const;
>      bool is_page_aligned() const;
> +    bool is_n_align_sized() const;
>      bool is_n_page_sized() const;
> =20
>      bool is_zero() const;
> @@ -382,6 +391,7 @@ public:
>      bool is_contiguous();
>      void rebuild();
>      void rebuild(ptr& nb);
> +    void rebuild_aligned();
>      void rebuild_page_aligned();
> =20
>      // sort-of-like-assignment-op
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--pHqxtxEg62rKadLo1vwJ334a2hI6tNVu6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQXF/QACgkQ8dLMyEl6F23abwCgu4dzZR1Tu+jhHVFhlkQGKOFq
oJkAn1cOnhZMU6ztX++VNLIHUpSiXpH8
=1di8
-----END PGP SIGNATURE-----

--pHqxtxEg62rKadLo1vwJ334a2hI6tNVu6--
