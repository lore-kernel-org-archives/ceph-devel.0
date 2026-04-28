Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4479D374728
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2026 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777414005; cv=pass; b=LyTMHdpvM6zzCaLVTXLC7NQiX6lN80ShpJFPXJIu5WBsXnStfLXeIgzO0u21ihaqkkFKohewYz1wjmIDt4hCcOuHDIPJQ6xiyMd9RrpGQ0G9I41qjCGngvk32SNBM7TkivIVGfeiAbpusnEMosKbOLz4UXESqWhcJ+MZANxBktc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777414005; c=relaxed/simple;
	bh=WyP7nPrPtPqtyr6/URCI4Apap9WDHuW+mqDo/IlYt+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+XBDBNv+4PyS3TbFyKy/tLVJqlcH7AnbALQDysKUHFP6bo4g+JyjKCnYYR1bBEqc61roP1bRCo4A++bJM56SzeorO4sCyHajIvisStHdkU2wYQvKxSALQz6aXGK/y9Y3mbcPL2oS4B3ZY2qz3i2+Ps+y3xo2yROULqiwk7G3u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ci0JEUoz; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ci0JEUoz"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12ddbe104ccso2142905c88.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2026 15:06:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777414003; cv=none;
        d=google.com; s=arc-20240605;
        b=iiIqZvZsaEIYgStL0sBjAduU0k730TEvFyiGhWH9jqO8/dWw0w6PTSP+b+R1EIAiQE
         zX/i03eju3otZ55qKz1lbdQxSBKaew4VMOb8KOaAHJEyRHOYin/N6xkuoCqLgr6h0WNJ
         Ys54QJKclRypO08ha5LyINm3raG40XLP77Vfc8NoATAaOAapZN16VNMN8GDnJCrsIHJN
         6CXCFRghmmAvolj9vhhTiEbKU2sOGx3BFivFFoiSJ5730uS4rM2mnDRXnJ1AT7+72KsE
         vkEDLgDj74x0i2+a3JJlGTehXToXBk26mumSKMmiE4mAels9lZhivsLTUofDYv9zmLdq
         XdnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EfhhdHruc3Joy400ylQzHb0UM5HE5aa8zxWkMNyiQVw=;
        fh=wrILRYgbbx3svagD0qz10ni+RxC4hxgaD4X/GGen/UQ=;
        b=M745/vR8XsYZtrSW7iDR+JF/DuDpGCSbzZYL63SzL2JBSH2dbXyul1fKJJnbxWtpo1
         gF23ux+aFpiwTx/xCq/lalbbL0nEdlqXDRn0Whx3grOt38QVV40BEs3spMh3cgGoP97b
         1i8d/TBjtnhGI/jh04+rljpQOcFtielYdDdPJNrkzBMyQuBCOQh8Jh1E6yYEYowOUGC9
         RYaPZpEUeNERyLKJPWnpNdy9OkdZ3cgIPI+OdOnwSiTss3T0B3WPSML+ltF3tO6buCiD
         ottv0zSJjQ4TF5wpkanekeXbtUevIK+JgXH2baBSXjo3/z5kyPIeWur5hst3wQ730tT9
         xomw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777414003; x=1778018803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfhhdHruc3Joy400ylQzHb0UM5HE5aa8zxWkMNyiQVw=;
        b=Ci0JEUozQASDL6GwI2clm8pNcqaYU1vAdizIIYhxga5ziwjlm4xBnZK34T+wuvINCd
         HGatM0rG3cH8ex+OU9KG/KKtB9MW8cgxNqPeTKGgvSkLT6RYBhzcgqfNoCqNkNmycfYv
         ZtvRGY+dOAQG+zj3Y6zmbZepaQNfKenV6ZHkdsXJFI6aN3+rYFQBvSnFo5x8MZB74n4V
         NgaffyTT52zhWh4Zl8shkadcQbR8DJmF7uDK66E8r3BrlVJ6vUWYsD1zm/9a/1kecVm7
         QGMom+zWjVhP0k54jSMB74+T4GHV/yv87AovOSQB+KnKxoKfYE7Hg1pdAskuMvzMOfMD
         c2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777414003; x=1778018803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EfhhdHruc3Joy400ylQzHb0UM5HE5aa8zxWkMNyiQVw=;
        b=Pt6nFZV7s5f5QRM2RKYcHFq/ApPuriQlZT3NzMSQoB3Tl0ebsG3EWQguqXDj6o7/1g
         dH9KjKJSWGzeLqAsccndy1T5Ij6YSxiAKFJJdiIxJ6OuyKxVjufIwWd489rPgHMiYq/K
         KaToPapTvnqW6756V+QANqJle0LYfnirU69cmwYUHCif8pOLRlZD0GjlLNOJVvz9t46l
         aYOzKab/QanX2hTRaexT+WP6mueNP5jaSrU00cFfd24FtRh8/q8cDdPxgQD9tb9nf5De
         ZU2HkUzJMkJBTkyWU5RsPZ9StZJowDOUbk49Cpa0G9GwsmrlNHH31F46y6pNQEP/lsnI
         prFQ==
X-Forwarded-Encrypted: i=1; AFNElJ/sAh+9CMd6K2hWj7I5h+NzeV4WYGGgFSyLXhas/+PMhAtNzJSP5bLDLpg2hQ2DgBHTzjS2v7+dCUeX@vger.kernel.org
X-Gm-Message-State: AOJu0YwXjKw/2tKU05p97E6vX4XpmYkV+UAZ+CELW2yJxbtk36GEYrPn
	zfXDtootCWE07bpUR5mnjU4YlKofh0K2RIc15r1hXIRzDNHGRYI7p/KvsKVr+SG85LmqOq077QS
	wfAfCo6Cs28NO7317HxFV3Jmv2YDGYAU=
X-Gm-Gg: AeBDietfA4aPTPbhl2nVUTiAzJzYonH6DoWLeZQIRFbfJGOLqgG+DOmeBYI4rr0DM9c
	w1COpu3ggOQRclj5tyIq9OuGvUcLOcvzhCuNM1kZzMDErn2/SFvfmpiIgBgYZibf84N48eCpOse
	G/KEzpz8KO+HHPVr+z8h/rjJ2d2m2hI69BCju9yvosb/LJS6n8Zs2GXRLtIIcQhiJXYsNy1x8Qm
	s9twqTXnx9ut5OIAwisMgFR35920BwpkU7QxZkQeOKQD9GbjKHW6tnXa5LmnOBaEtsJr5+aaTzT
	HlIwUXBKYM0poISy/A==
X-Received: by 2002:a05:7022:4583:b0:12a:8ea4:252 with SMTP id
 a92af1059eb24-12ddd93f1f1mr1904671c88.4.1777414003188; Tue, 28 Apr 2026
 15:06:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206202757.1535351-2-slava@dubeyko.com> <CAO8a2SgqvbP-WJAMnKLn=pKmDfjdaq1f86-1MFoqeo-4iehBOg@mail.gmail.com>
In-Reply-To: <CAO8a2SgqvbP-WJAMnKLn=pKmDfjdaq1f86-1MFoqeo-4iehBOg@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 29 Apr 2026 00:06:31 +0200
X-Gm-Features: AVHnY4IxnYgvLO6gv2dhy5InpC4XEPsYzK5WDUnuYnkaCnYxSPnbnQvlqg7_4VY
Message-ID: <CAOi1vP8tGqgYTmcUVHBGziCcr9njJaEvdxxEkmAv8mUVK9C_yg@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix generic/639 xfstests failure
To: Alex Markuze <amarkuze@redhat.com>, Xiubo Li <xiubli@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 2:20=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
>
> Reviewed-by: Alex Markuze <amarkuze@redhat.com>`
>
>
> On Fri, Feb 6, 2026 at 10:28=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko=
.com> wrote:
> >
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >
> > The generic/639 xfstest fails for Ceph msgr2 protocol:

Hi Slava, Alex,

This can't be specific to msgr2 protocol, so I wouldn't emphasize it.

> >
> > Ubuntu 22.04.5 LTS (GNU/Linux 6.17.0-rc7+ x86_64)
> >
> > sudo mount -t ceph :/ /mnt/cephfs/ -o name=3Dadmin,fs=3Dcephfs,ms_mode=
=3Dsecure
> >
> > sudo ./check generic/639
> > FSTYP -- ceph
> > PLATFORM -- Linux/x86_64 ceph-0005 6.17.0-rc7+ #16 SMP PREEMPT_DYNAMIC =
Wed Nov 12 11:01:48 PST 2025
> > MKFS_OPTIONS -- 192.168.1.213:3300:/scratch
> > MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:/s=
cratch /mnt/cephfs/scratch
> >
> > generic/639 - output mismatch (see /home/slavad/XFSTESTS-2/xfstests-dev=
/results//generic/639.out.bad)
> >
> > The simple way to reproduce the issue simply running these steps:
> >
> > mount -t ceph :/ /mnt/cephfs/ -o name=3Dadmin,fs=3Dcephfs,ms_mode=3Dsec=
ure
> > xfs_io -f -c "pwrite -q 0 32" ./testfile251125-0004
> > umount /mnt/cephfs/
> > mount -t ceph :/ /mnt/cephfs/ -o name=3Dadmin,fs=3Dcephfs,ms_mode=3Dsec=
ure
> > xfs_io -c "pwrite -q 32 32" ./testfile251125-0004
> >
> > Finally, we have the unexpected content of the file:
> >
> > hexdump ./testfile251125-0004
> > 0000000 0000 0000 0000 0000 0000 0000 0000 0000
> > *
> > 0000020 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
> > *
> > 0000040
> >
> > Initial analysis has shown that if we try to write out of
> > end of file, then ceph_write_begin() is responsible for
> > the issue because it calls netfs_write_begin() and we have
> > such logic:
> >
> > int netfs_write_begin(struct netfs_inode *ctx,
> >               struct file *file, struct address_space *mapping,
> >               loff_t pos, unsigned int len, struct folio **_folio,
> >               void **_fsdata)
> > {
> > <skipped>
> >
> >     folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> >                     mapping_gfp_mask(mapping));
> >
> > <skipped>
> >
> >     if (folio_test_uptodate(folio))
> >         goto have_folio;
> >
> > <skipped>
> > }
> >
> > The reason of the issue that somehow we have folio in uptodate
> > state and netfs_write_begin() simply skips the logic of
> > reading existing file's content.
> >
> > Futher analysis revealed that we call ceph_fill_inode() and
> > ceph_fill_inline_data() before ceph_write_begin().

With my limited understanding of the inline data feature and its
history (it was deprecated years ago but is still in "will likely be
removed altogether in a future release" state?), it doesn't make sense
that ceph_fill_inline_data() gets called on a file that is created by
the kernel client.  The kernel client doesn't write inline data -- it
only supports reading it (after it's written by the userspace client)
and potentially uninlining it.

> >
> > void ceph_fill_inline_data(struct inode *inode, struct page *locked_pag=
e,
> >                char    *data, size_t len)
> > {
> > <skipped>
> >
> >     if (page !=3D locked_page) {
> >         if (len < PAGE_SIZE)
> >             zero_user_segment(page, len, PAGE_SIZE);
> >         else
> >             flush_dcache_page(page);
> >
> >         SetPageUptodate(page); <--- We set page uptodate if len =3D=3D =
0!!!!

How does a small file that has a non-zero size but no data (e.g.
"truncate -s 32 testfile") is supposed to look when the inline data
feature is enabled?

I'm asking because I'm not sure I see anything wrong with this call
given the surrounding code.  In case of len =3D=3D 0 zero_user_segment() is
called to zero out the entire page.  This call to SetPageUptodate()
follows that and seems to be on point: if the page isn't going to be
marked uptodate, the whole sequence of looking up, locking, zeroing and
unlocking it is pointless.

IMO the actual root cause of the issue here is ceph_fill_inline_data()
getting called in the first place.  ci->i_inline_version for the file
in question should be 1 and according to commit 4849077604f0 ("ceph:
don't get the inline data for new creating files") that is equivalent
to "no inline data".  That commit changed how fill_inline is assigned
in ceph_fill_inode() but not in handle_cap_grant() -- I think that was
an unintended omission and adding Xiubo to confirm.

If handle_cap_grant() gets changed to use ceph_has_inline_data()
instead of checking for CEPH_INLINE_NONE directly, the issue should
go away.

Thanks,

                Ilya

> >         unlock_page(page);
> >         put_page(page);
> >     }
> > }
> >
> > This patch fixes the issue by checking the len argument and
> > setting memory page uptodate only if len > 0.
> >
> > sudo ./check generic/639
> > FSTYP         -- ceph
> > PLATFORM      -- Linux/x86_64 ceph-0005 6.19.0-rc5+ #2 SMP PREEMPT_DYNA=
MIC Thu Feb  5 15:43:51 PST 2026
> > MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> > MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:/s=
cratch /mnt/cephfs/scratch
> >
> > generic/639 6s ...  6s
> > Ran: generic/639
> > Passed all 1 tests
> >
> > [1] https://tracker.ceph.com/issues/73829
> >
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > cc: Alex Markuze <amarkuze@redhat.com>
> > cc: Ilya Dryomov <idryomov@gmail.com>
> > cc: Patrick Donnelly <pdonnell@redhat.com>
> > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > ---
> >  fs/ceph/addr.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 63b75d214210..436a287fd311 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -2184,7 +2184,9 @@ void ceph_fill_inline_data(struct inode *inode, s=
truct page *locked_page,
> >                 else
> >                         flush_dcache_page(page);
> >
> > -               SetPageUptodate(page);
> > +               if (len > 0)
> > +                       SetPageUptodate(page);
> > +
> >                 unlock_page(page);
> >                 put_page(page);
> >         }
> > --
> > 2.53.0
> >
>
