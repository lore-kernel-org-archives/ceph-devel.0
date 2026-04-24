Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC7347C7;
	Fri, 24 Apr 2026 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018543; cv=none; b=Bit16HYQiuSVcSt4ifOgcd28xwIKgiInoe3m7roe5eW0gOyv98Tk4JWXruVfQEvKzDiZHHiC5OUrBtr4R3ZmvWFXRsvx04NkmoxYfnp1qvy2nHmTnFrNPlpzmTjJYz6j1CO+VA3BzSEzTRERUgXIjTjFd7qK42iNkndAKRbAM44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018543; c=relaxed/simple;
	bh=6izA1o0nx0nYyXHU3jwwX4HXQXRoRLvGf5IQSNaULPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aOp0n/46r0DzDx/FHIN7BEvChmreEKl7gVG0xcIILp6A6iy3zUkHZlpKdVLraZ5TGU7iv9y17+2aj/rOnkdHvLky4LVKVJfCIpdjo35tayPRRoxnWZ05TWkIPDqD6UN/SaO0eYuDrxFkQe3ZTypoR1u8Bjve5iIYjmnm/T4uzpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qDYEtwti; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qDYEtwti"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rdJCFWYJlSAEtb2g0+PtlfgRPnIztREXzBwYkO3oW7c=; b=qDYEtwti9IsyOMVzd3eawaY66f
	EUL8yDi3t7fIY2ZdpnI7a8F+psC+pmALVDKPXqTrVQDMv4OyhrnAZUY03+AhsmAVaWmtb8PSxXU/y
	4AhIzykztUhenjanjCFzGNPc9F8XJOmJ1yRddAd0WpoNYrEn9eIUyx8VNsZk47Piob4fuKWydTdJS
	zCxL1aKuTsemIUABT9pyX+G2RcE+KIYNl5WnbSdxiTUbKbKGxrdBXu3qMzH3ZBvfmf7p6kYBMAnbQ
	/4sebRT34zGpUon+Kc0pbQTLq6i0rPylePtFrUPSHNPsGS44AU044q5YNjIDtdJy6MXx0IfeX3Bt3
	qh88XC+Q==;
Received: from bl16-24-16.dsl.telepac.pt ([188.81.24.16] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wGBh4-001VWh-1s; Fri, 24 Apr 2026 10:15:21 +0200
From: Luis Henriques <luis@igalia.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,  "pengpeng@iscas.ac.cn"
 <pengpeng@iscas.ac.cn>,  Alex Markuze <amarkuze@redhat.com>,
  "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
  "slava@dubeyko.com" <slava@dubeyko.com>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH v4] ceph: bound encrypted snapshot suffix formatting
In-Reply-To: <CAOi1vP96JuBi5BhTdiVeL491ziy_hwJUm79TqOb=iPaxck1eyg@mail.gmail.com>
	(Ilya Dryomov's message of "Wed, 22 Apr 2026 11:53:29 +0200")
References: <20260404101003.3-ceph-pengpeng@iscas.ac.cn>
	<20260407120003.3-ceph-v2-pengpeng@iscas.ac.cn>
	<20260408093001.1-ceph-v3-pengpeng@iscas.ac.cn>
	<20260409110001.1-ceph-v4-pengpeng@iscas.ac.cn>
	<f957bdf6488b391b4329ff3cc892bfdc93c014fb.camel@ibm.com>
	<847376cbf4408d12389545142311cb5883045937.camel@ibm.com>
	<7e043aa928f13d043552ca650808c0383209f806.camel@ibm.com>
	<CAOi1vP96JuBi5BhTdiVeL491ziy_hwJUm79TqOb=iPaxck1eyg@mail.gmail.com>
Date: Fri, 24 Apr 2026 09:15:15 +0100
Message-ID: <87eck4oju4.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22 2026, Ilya Dryomov wrote:

> On Fri, Apr 10, 2026 at 10:46=E2=80=AFPM Viacheslav Dubeyko
> <Slava.Dubeyko@ibm.com> wrote:
>>
>> On Fri, 2026-04-10 at 20:40 +0000, Viacheslav Dubeyko wrote:
>> > On Thu, 2026-04-09 at 18:09 +0000, Viacheslav Dubeyko wrote:
>> > > On Thu, 2026-04-09 at 10:39 +0800, Pengpeng Hou wrote:
>> > > > ceph_encode_encrypted_dname() base64-encodes the encrypted snapshot
>> > > > name into the caller buffer and then, for long snapshot names, app=
ends
>> > > > _<ino> with sprintf(p + elen, ...).
>> > > >
>> > > > Some callers only provide NAME_MAX bytes. For long snapshot names,=
 a
>> > > > large inode suffix can push the final encoded name past NAME_MAX e=
ven
>> > > > though the encrypted prefix stayed within the documented 240-byte
>> > > > budget.
>> > > >
>> > > > Format the suffix into a small local buffer first and reject names
>> > > > whose suffix would exceed the caller's NAME_MAX output buffer.
>> > > >
>> > > > Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
>> > > > ---
>> > > > Changes since v3:
>> > > > - reject `elen > 240` explicitly instead of relying only on the ea=
rlier
>> > > >   `WARN_ON()`
>> > > > - rewrite the NAME_MAX bound check in terms of the final total len=
gth
>> > > >   instead of `NAME_MAX - prefix_len - elen`
>> > > >
>> > > >  fs/ceph/crypto.c | 31 +++++++++++++++++++++++++++++--
>> > > >  1 file changed, 29 insertions(+), 2 deletions(-)
>> > > >
>> > > > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>> > > > index f3de43ccb470..42e3fff34697 100644
>> > > > --- a/fs/ceph/crypto.c
>> > > > +++ b/fs/ceph/crypto.c
>> > > > @@ -15,6 +15,12 @@
>> > > >  #include "mds_client.h"
>> > > >  #include "crypto.h"
>> > > >
>> > > > +/*
>> > > > + * Reserve room for '_' + decimal 64-bit inode number + trailing =
NUL.
>> > > > + * ceph_encode_encrypted_dname() copies only the visible suffix b=
ytes.
>> > > > + */
>> > > > +#define CEPH_ENCRYPTED_SNAP_INO_SUFFIX_MAX       sizeof("_1844674=
4073709551615")
>> > > > +
>> > > >  static int ceph_crypt_get_context(struct inode *inode, void *ctx,=
 size_t len)
>> > > >  {
>> > > >   struct ceph_inode_info *ci =3D ceph_inode(inode);
>> > > > @@ -209,6 +215,7 @@ int ceph_encode_encrypted_dname(struct inode *=
parent, char *buf, int elen)
>> > > >   struct inode *dir =3D parent;
>> > > >   char *p =3D buf;
>> > > >   u32 len;
>> > > > + int prefix_len =3D 0;
>> > > >   int name_len =3D elen;
>> > > >   int ret;
>> > > >   u8 *cryptbuf =3D NULL;
>> > > > @@ -219,6 +226,7 @@ int ceph_encode_encrypted_dname(struct inode *=
parent, char *buf, int elen)
>> > > >           if (IS_ERR(dir))
>> > > >                   return PTR_ERR(dir);
>> > > >           p++; /* skip initial '_' */
>> > > > +         prefix_len =3D 1;
>> > > >   }
>> > > >
>> > > >   if (!fscrypt_has_encryption_key(dir))
>> > > > @@ -271,8 +279,27 @@ int ceph_encode_encrypted_dname(struct inode =
*parent, char *buf, int elen)
>> > > >
>> > > >   /* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comment=
s */
>> > > >   WARN_ON(elen > 240);
>> > > > - if (dir !=3D parent) // leading _ is already there; append _<inu=
m>
>> > > > -         elen +=3D 1 + sprintf(p + elen, "_%ld", dir->i_ino);
>> > > > + if (elen > 240) {
>> > > > +         elen =3D -ENAMETOOLONG;
>> > > > +         goto out;
>> > > > + }
>> > > > +
>> > > > + if (dir !=3D parent) {
>> > > > +         int total_len;
>> > > > +         /* leading '_' is already there; append _<inum> */
>> > > > +         char suffix[CEPH_ENCRYPTED_SNAP_INO_SUFFIX_MAX];
>> > > > +
>> > > > +         ret =3D snprintf(suffix, sizeof(suffix), "_%lu", dir->i_=
ino);
>> > > > +         total_len =3D prefix_len + elen + ret;
>> > > > +         if (total_len > NAME_MAX) {
>> > > > +                 elen =3D -ENAMETOOLONG;
>> > > > +                 goto out;
>> > > > +         }
>> > > > +
>> > > > +         memcpy(p + elen, suffix, ret);
>> > > > +         /* Include the leading '_' skipped by p. */
>> > > > +         elen =3D total_len;
>> > > > + }
>> > > >
>> > > >  out:
>> > > >   kfree(cryptbuf);
>> > >
>> > > Looks good.
>> > >
>> > > Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>> > >
>> > > Let me run xfstests for the patch to double check that everything is=
 OK. I'll
>> > > share the result ASAP.
>> > >
>> >
>> > The xfstests run was successful. I don't see any issues with the patch.
>> >
>> > Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>> >
>> >
>>
>> Applied on testing branch of CephFS kernel client git tree.
>
> Hi Pengpeng, Slava,
>
> This patch raised my attention because my understanding was that the
> entire CEPH_NOHASH_NAME_MAX + sha256() was put in place precisely to
> handle longer names nicely and make them fit into NAME_MAX-sized buffer.
> Simply rejecting longer names seemed to be in direct contradiction with
> that and yet the patch on its own was clearly merited given
>
>  * (240 bytes is the maximum size allowed for snapshot names to take into
>  *  account the format: '_<SNAPSHOT-NAME>_<INODE-NUMBER>'.)
>
> comment on CEPH_NOHASH_NAME_MAX definition.
>
> I dug a bit deeper and started a discussion in [1].  The preliminary
> conclusion is that the 240 bytes assumption was a mistake -- somehow
> the minimum number of characters needed for <inum> ended up being used
> instead of the maximum.  CEPH_NOHASH_NAME_MAX value is likely incorrect
> and should have been smaller -- something along the lines of 174 -
> SHA256_DIGEST_SIZE instead of 180 - SHA256_DIGEST_SIZE.

FWIW I _think_ Ilya may be correct, and there's actually an issue when
these constants were defined.  I spent quite some time last evening trying
to dig into the details on why the inode length was assumed to be 13.
Apparently, it was just a mistake that no one spotted at the time :-(

Unfortunately, my bandwidth to look into this is quite limited.  But I
believe it should be easy to verify that this is indeed a bug by simply
creating snapshots on an encrypted directory that has an inode number
bigger than 2^40 and then checking the large snapshot name in the '.snap'
directory of a subdirectory.

Cheers,
--=20
Lu=C3=ADs

> I kept this patch in the testing branch but not including it for 7.1
> pending further investigation.
>
> [1] https://github.com/ceph/ceph/pull/45312
>
> Thanks,
>
>                 Ilya
