Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A05B274B2B;
	Mon, 27 Apr 2026 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277571; cv=none; b=rLKQmQrpddUEklSyMXTw7CdOIABkc9XgVJEIsSQd1tedHt223isGOPPgn3ZnYvB2wyFVfU6eDlZ31Y7eXWCNKjhMec9QiO/IOAQwaY/3Tz8wMjZ1sz/BTMogwSDWxYvvhMex57XfCwPwcXrcZf8IJNDLYFF6kohUoSWyrIwmF8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277571; c=relaxed/simple;
	bh=OJoIXcCy8D7Edrnw0zjQyfSvuhNlgQJm9YNGPUTL/Tc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UfkDMlDqhzago3ykH1hxk3o3o/E2MAq8jAL67L0vIf7Rim/a/fEkQXU940tgfWZGrZix99EFm/e9MNvFH6DFtMt//dMYOl5mKp5nyt9w4G+vD3oYw5LyJ36yItEQCEr+mBrPh3IwryzxVTO6oGOKxXSIhJVvF3roN4ZuWzNdoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JncTCaJ+; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JncTCaJ+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/sTGJLJFK3sLyyeZl5jJJjlqfC12nRvIWQa3ST1GK58=; b=JncTCaJ+8U3e6gyX8DaaRbN6YR
	+oJxYFxTMJAPyFObGW7a70auET4022CHFYGoGbSEo4Qqq0uxdaa2S2FjFHq+nJzySPySehKAQx5a9
	JdqSvDYuktBTSboJprRfGNi2gGHj+FGsj1ZaTCcCWk3F2NkSdeJY6S19/VcFfxql64LhSuBs51YqB
	LMnQRRDjMy0ypNoX7d6z3BgRAdrgSqt1QbpbwlTy6ub8KBNSBHdal5DtvA7df5d01q7xbktBTt7E2
	1m1bRfRxqa2+RtBJNPJvVvqL4RaokrQvaLs1oXICov1mkd1J+JmGQi3M0xLwQheQLYjE3Ke2iiGJg
	64m8DzHQ==;
Received: from bl16-24-16.dsl.telepac.pt ([188.81.24.16] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wHH59-002pBX-QV; Mon, 27 Apr 2026 10:12:43 +0200
From: Luis Henriques <luis@igalia.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
  "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,  Xiubo Li
 <xiubli@redhat.com>,  "pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>,
  "slava@dubeyko.com" <slava@dubeyko.com>,  Alex Markuze
 <amarkuze@redhat.com>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] ceph: bound encrypted snapshot suffix formatting
In-Reply-To: <CAOi1vP8AC3eKeW7rbNmmZdt8aPAhf9AuCEBxbzYDkfn4Mq76gg@mail.gmail.com>
	(Ilya Dryomov's message of "Fri, 24 Apr 2026 21:20:23 +0200")
References: <20260404101003.3-ceph-pengpeng@iscas.ac.cn>
	<20260407120003.3-ceph-v2-pengpeng@iscas.ac.cn>
	<20260408093001.1-ceph-v3-pengpeng@iscas.ac.cn>
	<20260409110001.1-ceph-v4-pengpeng@iscas.ac.cn>
	<f957bdf6488b391b4329ff3cc892bfdc93c014fb.camel@ibm.com>
	<847376cbf4408d12389545142311cb5883045937.camel@ibm.com>
	<7e043aa928f13d043552ca650808c0383209f806.camel@ibm.com>
	<CAOi1vP96JuBi5BhTdiVeL491ziy_hwJUm79TqOb=iPaxck1eyg@mail.gmail.com>
	<4a2802b9a0c82084f833d5211aa3dd0033553a91.camel@ibm.com>
	<CAOi1vP8PUPzqbp32HqQ=UKoMrepdto7kK3OWue3HAvpzccz_Hw@mail.gmail.com>
	<52241308ec39916b0e703e4a8d3d6d1c29d52244.camel@ibm.com>
	<CAOi1vP8AC3eKeW7rbNmmZdt8aPAhf9AuCEBxbzYDkfn4Mq76gg@mail.gmail.com>
Date: Mon, 27 Apr 2026 09:12:42 +0100
Message-ID: <87qzo0keit.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24 2026, Ilya Dryomov wrote:

> On Fri, Apr 24, 2026 at 8:31=E2=80=AFPM Viacheslav Dubeyko
> <Slava.Dubeyko@ibm.com> wrote:
>>
>> On Fri, 2026-04-24 at 11:27 +0200, Ilya Dryomov wrote:
>> > On Thu, Apr 23, 2026 at 8:04=E2=80=AFPM Viacheslav Dubeyko
>> > <Slava.Dubeyko@ibm.com> wrote:
>> > >
>> > > On Wed, 2026-04-22 at 11:53 +0200, Ilya Dryomov wrote:
>> > > > On Fri, Apr 10, 2026 at 10:46=E2=80=AFPM Viacheslav Dubeyko
>> > > > <Slava.Dubeyko@ibm.com> wrote:
>> > > > >
>> > > > > On Fri, 2026-04-10 at 20:40 +0000, Viacheslav Dubeyko wrote:
>> > > > > > On Thu, 2026-04-09 at 18:09 +0000, Viacheslav Dubeyko wrote:
>> > > > > > > On Thu, 2026-04-09 at 10:39 +0800, Pengpeng Hou wrote:
>> > > > > > > > ceph_encode_encrypted_dname() base64-encodes the encrypted=
 snapshot
>> > > > > > > > name into the caller buffer and then, for long snapshot na=
mes, appends
>> > > > > > > > _<ino> with sprintf(p + elen, ...).
>> > > > > > > >
>> > > > > > > > Some callers only provide NAME_MAX bytes. For long snapsho=
t names, a
>> > > > > > > > large inode suffix can push the final encoded name past NA=
ME_MAX even
>> > > > > > > > though the encrypted prefix stayed within the documented 2=
40-byte
>> > > > > > > > budget.
>> > > > > > > >
>> > > > > > > > Format the suffix into a small local buffer first and reje=
ct names
>> > > > > > > > whose suffix would exceed the caller's NAME_MAX output buf=
fer.
>> > > > > > > >
>> > > > > > > > Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
>> > > > > > > > ---
>> > > > > > > > Changes since v3:
>> > > > > > > > - reject `elen > 240` explicitly instead of relying only o=
n the earlier
>> > > > > > > >   `WARN_ON()`
>> > > > > > > > - rewrite the NAME_MAX bound check in terms of the final t=
otal length
>> > > > > > > >   instead of `NAME_MAX - prefix_len - elen`
>> > > > > > > >
>> > > > > > > >  fs/ceph/crypto.c | 31 +++++++++++++++++++++++++++++--
>> > > > > > > >  1 file changed, 29 insertions(+), 2 deletions(-)
>> > > > > > > >
>> > > > > > > > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>> > > > > > > > index f3de43ccb470..42e3fff34697 100644
>> > > > > > > > --- a/fs/ceph/crypto.c
>> > > > > > > > +++ b/fs/ceph/crypto.c
>> > > > > > > > @@ -15,6 +15,12 @@
>> > > > > > > >  #include "mds_client.h"
>> > > > > > > >  #include "crypto.h"
>> > > > > > > >
>> > > > > > > > +/*
>> > > > > > > > + * Reserve room for '_' + decimal 64-bit inode number + t=
railing NUL.
>> > > > > > > > + * ceph_encode_encrypted_dname() copies only the visible =
suffix bytes.
>> > > > > > > > + */
>> > > > > > > > +#define CEPH_ENCRYPTED_SNAP_INO_SUFFIX_MAX       sizeof("=
_18446744073709551615")
>> > > > > > > > +
>> > > > > > > >  static int ceph_crypt_get_context(struct inode *inode, vo=
id *ctx, size_t len)
>> > > > > > > >  {
>> > > > > > > >   struct ceph_inode_info *ci =3D ceph_inode(inode);
>> > > > > > > > @@ -209,6 +215,7 @@ int ceph_encode_encrypted_dname(struct=
 inode *parent, char *buf, int elen)
>> > > > > > > >   struct inode *dir =3D parent;
>> > > > > > > >   char *p =3D buf;
>> > > > > > > >   u32 len;
>> > > > > > > > + int prefix_len =3D 0;
>> > > > > > > >   int name_len =3D elen;
>> > > > > > > >   int ret;
>> > > > > > > >   u8 *cryptbuf =3D NULL;
>> > > > > > > > @@ -219,6 +226,7 @@ int ceph_encode_encrypted_dname(struct=
 inode *parent, char *buf, int elen)
>> > > > > > > >           if (IS_ERR(dir))
>> > > > > > > >                   return PTR_ERR(dir);
>> > > > > > > >           p++; /* skip initial '_' */
>> > > > > > > > +         prefix_len =3D 1;
>> > > > > > > >   }
>> > > > > > > >
>> > > > > > > >   if (!fscrypt_has_encryption_key(dir))
>> > > > > > > > @@ -271,8 +279,27 @@ int ceph_encode_encrypted_dname(struc=
t inode *parent, char *buf, int elen)
>> > > > > > > >
>> > > > > > > >   /* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX=
 comments */
>> > > > > > > >   WARN_ON(elen > 240);
>> > > > > > > > - if (dir !=3D parent) // leading _ is already there; appe=
nd _<inum>
>> > > > > > > > -         elen +=3D 1 + sprintf(p + elen, "_%ld", dir->i_i=
no);
>> > > > > > > > + if (elen > 240) {
>> > > > > > > > +         elen =3D -ENAMETOOLONG;
>> > > > > > > > +         goto out;
>> > > > > > > > + }
>> > > > > > > > +
>> > > > > > > > + if (dir !=3D parent) {
>> > > > > > > > +         int total_len;
>> > > > > > > > +         /* leading '_' is already there; append _<inum> =
*/
>> > > > > > > > +         char suffix[CEPH_ENCRYPTED_SNAP_INO_SUFFIX_MAX];
>> > > > > > > > +
>> > > > > > > > +         ret =3D snprintf(suffix, sizeof(suffix), "_%lu",=
 dir->i_ino);
>> > > > > > > > +         total_len =3D prefix_len + elen + ret;
>> > > > > > > > +         if (total_len > NAME_MAX) {
>> > > > > > > > +                 elen =3D -ENAMETOOLONG;
>> > > > > > > > +                 goto out;
>> > > > > > > > +         }
>> > > > > > > > +
>> > > > > > > > +         memcpy(p + elen, suffix, ret);
>> > > > > > > > +         /* Include the leading '_' skipped by p. */
>> > > > > > > > +         elen =3D total_len;
>> > > > > > > > + }
>> > > > > > > >
>> > > > > > > >  out:
>> > > > > > > >   kfree(cryptbuf);
>> > > > > > >
>> > > > > > > Looks good.
>> > > > > > >
>> > > > > > > Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>> > > > > > >
>> > > > > > > Let me run xfstests for the patch to double check that every=
thing is OK. I'll
>> > > > > > > share the result ASAP.
>> > > > > > >
>> > > > > >
>> > > > > > The xfstests run was successful. I don't see any issues with t=
he patch.
>> > > > > >
>> > > > > > Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>> > > > > >
>> > > > > >
>> > > > >
>> > > > > Applied on testing branch of CephFS kernel client git tree.
>> > > >
>> > > > Hi Pengpeng, Slava,
>> > > >
>> > > > This patch raised my attention because my understanding was that t=
he
>> > > > entire CEPH_NOHASH_NAME_MAX + sha256() was put in place precisely =
to
>> > > > handle longer names nicely and make them fit into NAME_MAX-sized b=
uffer.
>> > > > Simply rejecting longer names seemed to be in direct contradiction=
 with
>> > > > that and yet the patch on its own was clearly merited given
>> > > >
>> > > >  * (240 bytes is the maximum size allowed for snapshot names to ta=
ke into
>> > > >  *  account the format: '_<SNAPSHOT-NAME>_<INODE-NUMBER>'.)
>> > > >
>> > > > comment on CEPH_NOHASH_NAME_MAX definition.
>> > > >
>> > > > I dug a bit deeper and started a discussion in [1].  The prelimina=
ry
>> > > > conclusion is that the 240 bytes assumption was a mistake -- someh=
ow
>> > > > the minimum number of characters needed for <inum> ended up being =
used
>> > > > instead of the maximum.  CEPH_NOHASH_NAME_MAX value is likely inco=
rrect
>> > > > and should have been smaller -- something along the lines of 174 -
>> > > > SHA256_DIGEST_SIZE instead of 180 - SHA256_DIGEST_SIZE.
>> > > >
>> > >
>> > > The limitation could be 240 or bigger one, but anyway we need to pro=
cess this
>> > > limitation in proper way. And this patch has exactly this goal. Is 2=
40 bytes
>> > > limitation your concern? As far as I can see, this patch doesn't int=
roduce this
>> > > limitation. It was there before this modification. We can extend thi=
s limitation
>> > > anytime.
>> >
>> > Hi Slava,
>> >
>> > My take on this is that there shouldn't be a limitation to begin with
>> > (other than NAME_MAX which is natural and applies universally, not just
>> > to snapshot names).  This function has a bunch of code that is there
>> > specifically to handle longer names and avoid any artificial limits:
>> > the part of the name that spills over CEPH_NOHASH_NAME_MAX is hashed
>> > and the whole thing is set up in such a way that the end result is
>> > never bigger than 240 bytes.  240 isn't a random number -- it was
>> > picked on purpose to leave room for _ prefix and _<INODE-NUMBER> suffix
>> > (255 1 - 1 - 13) but a mistake appears to have crept in.  Instead of
>> > accounting for the maximum possible <INODE-NUMBER> length (which is 20
>> > in decimal encoding), it accounted only for 13 (likely because it
>> > happens to be the maximum possible length in a single-MDS setup?).
>> >
>> > IMO the right course of action here would be to see if the hashing
>> > parameters can be adjusted, not introduce new ENAMETOOLONG errors.
>> >
>> >
>>
>> Hi Pengpeng,
>>
>> Could you please rework the patch taking into account the shared remarks?
>
> I would hold on until the discussion in [1] comes to conclusion.  It
> turns out that the userspace client doesn't encrypt snapshot names
> anymore, so another (much worse, at least IMO) route would be to drop
> this bit of functionality from the kernel client as well [2].

OK, let me see if I understood this correctly:

- The user-space client implementation leaks metadata (the snaphsot names)
- The kernel client doesn't leak the snapshots names, thought there are
  bugs to be fixed (including on the MDS side)
- The proposed solution is to drop the kernel snapshot names encryption.

So, currently snapshots created on the kernel client can't be accessed
from the user-space client, and vice-versa?

Also, won't dropping the encryption from the kernel client effectively
make old snapshots created using a kernel client unusable?

Cheers,
--=20
Lu=C3=ADs

>
> [1] https://github.com/ceph/ceph/pull/45312
> [2] https://tracker.ceph.com/issues/76257
>
> Thanks,
>
>                 Ilya
