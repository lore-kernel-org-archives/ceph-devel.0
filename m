Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794197432;
	b=fN+7KlxK4sqpnm0mclxm3UWTCxRwcbcCY811cMPIGKoqoxzlFpVqEei2jKPt3I7SJclN
	 Zme6i+iDQFkNqbfNRTMAob1zxfJ767dB4rVjW8KpRQIMOR8QhoFhnq/GYXugXKjXv2BTp
	 DJm/kJqzGFWh3M9P4012q7GeujaVJfEmasfurwu3Pb9fKPDW1NU/0uGHLiYGDHMGdSRnj
	 4DG6dQmCVa/T4IoQrN+eNZwm59A/IqZoHcJkdToLc3u0yXNZ6dddNEWaIuYsAADd7quQB
	 Qr7idpdCx4K2n4sW8X+20HGcY1nDMBjN4GaE8mGPOJzTW2ad1G7LS1XeuTI2kQA4QKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794197432;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8S5DM78zElTqwaOBcaW0m0f9w1FmRk2jB2iY+XjpYmw=;
	b=CbqNvPtNlCgamBBAL5EKI/LhFPC5Af3wpEXvOYjG4oGXVim3jc1/02XhtNqqpAdH22Oz
	 99pZ5gqSFheWSGCfIB/SeAFAx3gPEfRLcVuaVFmS72+O5rHCzp6iX4YG/5y5/jhW0sDzQ
	 ej0SZdYKQUQdZ5VycgudaNQ8CWxzm5gEfAbRKkhgrcSOxyjgqNsZds60plizgMRIqwJrl
	 9TSZ7J3q6B1n1I/Z89dueaftmHECOuk5mojc9yFcadGdmbvcYLXmP3g6L4ldC3xFcTSzq
	 0xG3ExpTXW4yTM4fJzJBeGObJsTK+4cPLyjFQ42fA5WE1HWCgqnFEnah7lHZdTuzPBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Jg4f/3lg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38390606A321
	for <ceph-devel@vger.kernel.org>; Mon,  9 Nov 2026 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jg4f/3lg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D789D1F008A4
	for <ceph-devel@vger.kernel.org>; Mon,  9 Nov 2026 04:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794197431;
	bh=8S5DM78zElTqwaOBcaW0m0f9w1FmRk2jB2iY+XjpYmw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Jg4f/3lg91PEHrjJlkp9NV4Ab7anuDRaOG0SPxwmzJb4ipXnTUc+KHBy/syr8IgPK
	 y1dr/NRgiHJWF6cClbE3z4zo69rvNekrA5B+3Fxpe7FF+mZ7s5ZQCiECFbZwgZ8Gz5
	 W/T8AgQZ7AkJE0KrKLFvXXxf2zqaV+1vuVpyO4ZE95XYR2SjO2gBogGmCA3bY24Avg
	 bc5+JwfLojQAGPxMmp718JKNMPtrjs9JCvXcvqb9wflH6HzfJAxmOHPjeG4fJKQYe9
	 OAwkbXFsNxu9LeWrmZkkDN/HnGSeckfknvj+jVi/cgo5JlLj40tnLqjdizNIfuq6UC
	 nPzZh0cG9KY3w==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso322211e87.3
        for <ceph-devel@vger.kernel.org>; Sun, 08 Nov 2026 20:10:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFzybJ8eFGfBokcOHlzXc97JJVdcoMlmfR8x8Xw5L1OgpZGtJtsULjwSlBIi2GR4ef2kiGEq6T9K0wq@vger.kernel.org
X-Gm-Message-State: APuU4Z/U2XZpyYEDuigstqIkNb2dVAClod+nUnFKEjEP7YmVAc1dlfA/
	HWNhJCt/fnQTozz5KKvzNFT8brb4XYQDz4XAKjsV6Tt+p7UW2i3aWGEaCPWiPrxczooBYeD/PNk
	jFBRtjDwAgztFlTZjk0aUB7TCYV/5kUQ=
X-Received: by 2002:a05:6512:220e:b0:5be:588d:a0dd with SMTP id
 2adb3069b0e04-5c14bfe4683mr744303e87.15.1794197430534; Sun, 08 Nov 2026
 20:10:30 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106021310.777075-1-dlzhangak@isoftstone.com>
 <CAOuZWzyZoQ9oAHKmxVg7B292Vx-QZ2E+QLt6xVnpfKpps+4Yfw@mail.gmail.com> <1794188329.6AF12428.004.4jNC9j12vbz23pF@fangwg01>
In-Reply-To: <1794188329.6AF12428.004.4jNC9j12vbz23pF@fangwg01>
From: Xiubo Li <xiubli@kernel.org>
Date: Mon, 9 Nov 2026 05:10:18 +0100
X-Gmail-Original-Message-ID: <CAOuZWzx7eg1bNzyoY+kTP2CB4NqwwC23K1RC-etdWW1VyF01fA@mail.gmail.com>
X-Gm-Features: AclHuK_h6dgwJlKOOZQGOnuzJuzzvMmy-nxM8CV0pLLb1lhVXu3oOZAKsTf1pwA
Message-ID: <CAOuZWzx7eg1bNzyoY+kTP2CB4NqwwC23K1RC-etdWW1VyF01fA@mail.gmail.com>
Subject: Re: [PATCH] ceph: revalidate dentries under snapdir to drop stale snapshots
To: zhangdaolong <dlzhangak@isoftstone.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 zhangdaolong <dlzhangak@isoftstone.com> wrote:
> Validating the dentry against the head directory's snap realm
> cached_context (when holding caps on the head directory) before falling
> back to LOOKUPSNAP makes total sense and avoids the unnecessary MDS round
> trips on cache hits. Could you please share the diff you tested? I would
> be glad to incorporate it and test it for v2.

Sure, below is the diff I tested. It already contains your ceph_d_revalidat=
e()
change and the comment update, so it can replace that part of your patch in
v2. It leaves out the ceph_unlink() hunk.

I tested it with two kernel clients on one host, against a vstart
cluster, on a KASAN + lockdep kernel. It covered recreating a removed
snapshot, stale data after a same-name snapshot was recreated, a removed
ancestor snapshot (_p1_<ino>), 50 rounds of "B rmdir, A mkdir right
away", and a removed snapshot while A has its cwd inside it after an MDS
"cache drop". All of them behave the same as with your patch. Cached
lookups send no LOOKUPSNAP (0 vs 3000 for 3000 stats). There were no
KASAN reports. Lockdep stayed clean when I ran the same diff on top of
our development branch; on plain master, an unrelated VFS lockdep report
turned lockdep off before these tests ran.

> Agreed. I will drop this hunk from v2 and send it as a separate patch.

> In v2, I will update the comment and point Fixes: to 2817b000b02c
> (while also mentioning 200fd27c8fa2 in the commit message).

Sounds good, thanks.

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 6eb5b1cb039b..21983e14cb67 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1979,6 +1979,58 @@ static int dir_lease_is_valid(struct inode
*dir, struct dentry *dentry,
        return valid;
 }

+/*
+ * Check whether a cached dentry under .snap still names an existing snaps=
hot.
+ *
+ * The MDS issues no lease for these dentries, but it sends a snap update =
to
+ * every client holding caps in a realm when a snapshot in it is created o=
r
+ * removed.  So as long as we hold caps on the snapped directory, its real=
m's
+ * snap context tells us whether the snapshot still exists.  Without caps =
we
+ * cannot tell, and the caller has to ask the MDS.
+ */
+static int snapdir_dentry_is_valid(struct inode *dir, struct dentry *dentr=
y,
+                                  struct ceph_mds_client *mdsc)
+{
+       struct inode *inode =3D d_inode(dentry);
+       struct ceph_vino vino =3D {
+               .ino =3D ceph_ino(dir),
+               .snap =3D CEPH_NOSNAP,
+       };
+       struct ceph_snap_context *snapc =3D NULL;
+       struct ceph_inode_info *pci;
+       struct inode *parent;
+       u32 i;
+       int valid =3D 0;
+
+       if (!inode || ceph_snap(inode) > CEPH_MAXSNAP)
+               return 0;
+
+       parent =3D ceph_find_inode(dir->i_sb, vino);
+       if (!parent)
+               return 0;
+       pci =3D ceph_inode(parent);
+
+       down_read(&mdsc->snap_rwsem);
+       spin_lock(&pci->i_ceph_lock);
+       if (__ceph_is_any_real_caps(pci) && pci->i_snap_realm &&
+           pci->i_snap_realm->cached_context)
+               snapc =3D
ceph_get_snap_context(pci->i_snap_realm->cached_context);
+       spin_unlock(&pci->i_ceph_lock);
+       up_read(&mdsc->snap_rwsem);
+       iput(parent);
+
+       if (!snapc)
+               return 0;
+       for (i =3D 0; i < snapc->num_snaps; i++) {
+               if (snapc->snaps[i] =3D=3D ceph_snap(inode)) {
+                       valid =3D 1;
+                       break;
+               }
+       }
+       ceph_put_snap_context(snapc);
+       return valid;
+}
+
 /*
  * Check if cached dentry can be trusted.
  */
@@ -2002,12 +2054,20 @@ static int ceph_d_revalidate(struct inode
*dir, const struct qstr *name,

        mdsc =3D ceph_sb_to_fs_client(dir->i_sb)->mdsc;

-       /* always trust cached snapped dentries, snapdir dentry */
-       if (ceph_in_snap(dir)) {
+       if (ceph_snap(dir) =3D=3D CEPH_SNAPDIR) {
+               /* a snapshot under .snap may have been removed by others *=
/
+               if (flags & LOOKUP_RCU)
+                       return -ECHILD;
+               valid =3D snapdir_dentry_is_valid(dir, dentry, mdsc);
+               doutc(cl, "%p '%pd' inode %p under snapdir, valid %d\n",
+                     dentry, dentry, inode, valid);
+       } else if (ceph_in_snap(dir)) {
+               /* snapshots are immutable: trust dentries inside one */
                doutc(cl, "%p '%pd' inode %p is SNAPPED\n", dentry,
                      dentry, inode);
                valid =3D 1;
        } else if (inode && ceph_snap(inode) =3D=3D CEPH_SNAPDIR) {
+               /* the .snap dentry itself */
                valid =3D 1;
        } else {
                valid =3D dentry_lease_is_valid(dentry, flags);

Thanks,
- Xiubo

zhangdaolong <dlzhangak@isoftstone.com> =E4=BA=8E2026=E5=B9=B411=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=B8=80 02:39=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Nov 7, 2026 at 12:17 PM Xiubo Li <xiubli@kernel.org> wrote:
> >
> > Hi Daolong,
> >
> > Thanks for the patch. I can reproduce this with two kernel clients, and
> > it is a bit worse than described: after B removes .snap/s3 and creates =
a
> > new .snap/s3, A still reads the file contents of the old snapshot. A
> > removed ancestor snapshot also stays visible as .snap/_p1_<ino> in chil=
d
> > directories. Your patch fixes all of these cases.
> >
> > [...]
> >
> > >         /* always trust cached snapped dentries, snapdir dentry */
> > > -       if (ceph_in_snap(dir)) {
> > > +       if (ceph_in_snap(dir) && ceph_snap(dir) !=3D CEPH_SNAPDIR) {
> >
> > With this change nothing can validate a dentry under .snap anymore. The
> > MDS issues no lease for it, the snapdir only has CEPH_CAP_PIN, and a
> > snapped inode has no real caps. So every path walk through .snap/<name>
> > does a synchronous LOOKUPSNAP. With 3000 stats of .snap/s3/f on a cache=
d
> > snapshot (in a VM, so only the order of magnitude matters):
> >
> >                  ops/s   LOOKUPSNAP   p50/p99 (us)
> >   unpatched     257834        0         3.1/6.9
> >   this patch     10065     3000        89.9/273.1
> >   realm check   234741        0         3.4/7.5
> >
> > The "realm check" row is an alternative that avoids the round trip. The
> > client already knows which snapshots exist: the directory's snap realm
> > keeps the list in cached_context, and the MDS sends a snap update to
> > every client with caps in the realm when a snapshot is created or
> > removed. So d_revalidate can keep trusting a dentry under .snap while
> > its snapid (ceph_snap(inode)) is still in the realm's snap context of
> > the head directory, and only fall back to LOOKUPSNAP when it is not, or
> > when we hold no caps on that directory.
> >
> > I tried this on 7.2.9. It fixes the same cases as your patch: recreatin=
g
> > a snapshot, reading stale data, removed ancestor snapshots, and 50/50
> > "B rmdir, A mkdir right away" rounds. It sends no LOOKUPSNAP on cache
> > hits. I can send you the diff I tested if it helps.
>
> Hi Xiubo,
>
> Thank you very much for reproducing the issue, identifying the additional
> stale read and removed ancestor snapshot cases, and benchmarking the
> LOOKUPSNAP overhead.
>
> Validating the dentry against the head directory's snap realm
> cached_context (when holding caps on the head directory) before falling
> back to LOOKUPSNAP makes total sense and avoids the unnecessary MDS round
> trips on cache hits. Could you please share the diff you tested? I would
> be glad to incorporate it and test it for v2.
>
> > >                 if (!err && !req->r_reply_info.head->is_dentry)
> > >                         d_delete(dentry);
> > > +               else if (err =3D=3D -ENOENT)
> > > +                       d_drop(dentry);
> >
> > Please make this a separate patch. With the revalidate fix, rmdir of a
> > stale snapshot already fails in the lookup and never sends RMSNAP. I
> > checked the MDS counter with and without this hunk. Also, this hunk
> > affects unlink() of regular files too.
>
> Agreed. I will drop this hunk from v2 and send it as a separate patch.
>
> > Nits: the "always trust cached snapped dentries, snapdir dentry" commen=
t
> > needs an update. Also, the trust-all check dates back to 2817b000b02c,
> > while 200fd27c8fa2 only added the unreachable LOOKUPSNAP branch, so
> > please explain the choice of Fixes: tag.
>
> I originally chose 200fd27c8fa2 ("ceph: use lookup request to revalidate
> dentry") because it explicitly added the CEPH_MDS_OP_LOOKUPSNAP branch in
> ceph_d_revalidate() intending to revalidate dentries under CEPH_SNAPDIR,
> but overlooked that the earlier check from 2817b000b02c ("ceph: directory
> operations") made it unreachable. In v2, I will update the comment and
> point Fixes: to 2817b000b02c (while also mentioning 200fd27c8fa2 in the
> commit message).
>
> Thanks,
> Daolong
