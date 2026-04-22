Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E843CA4B3
	for <ceph-devel@vger.kernel.org>; Wed, 22 Apr 2026 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776851625; cv=pass; b=tsgqL0NjpRPZC/bHM8sTBOMBEq6JsAy4p+MVEnkUm4gEsGK8Ea7gKDLNsNtmQvfA3fCYjHnFSSX7ElirpCFvwbZV+x6UqqG5NvPqW93F3QPz/qoHjd5HYdLhcEzY11t62GNdlBMgXbdZFMl3/NAgnCrWQuvqhwyyIHCUSrM+Z5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776851625; c=relaxed/simple;
	bh=GUPr8EsK5gS92uLUwLEEw29bZ8CEI+athiZJ7zn7yJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/uNMEvJnS82e9mxN4yVG+qlpPhDb4xgImD/jsvODf6R5A1SDHxSHxz55qJnrd5UMxe3zw1FWlS11hoV0Hr4wRu11po+x5FzkFMKjUF3Y1i/u+JQ61ZmWyvL1m50U4Ag/AdxZL4A+q1gQ+6txtLwuRY0J/gcODYZnZ/OlNZoYR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmESUt4v; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmESUt4v"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c45281a06so6966889c88.1
        for <ceph-devel@vger.kernel.org>; Wed, 22 Apr 2026 02:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776851621; cv=none;
        d=google.com; s=arc-20240605;
        b=W9QDBY76DWLNoLcox4lZAvCnZc9sHmyk+yEzCfE4VXV/Eg4XJvAt6cmHO1GQxsXZFE
         If+r9PYihGDAH8ViBWk+HLnQxLElY3OX5ze0GnJ07ymulgp/ygZ0Y8NYx9wN8d466wVh
         u4fITxL2U8+UIFjfnlvmp+p9uWUmPNGzo5JJ8KWDoWrdcHHOzfTxwagzjIlYjocpX8vA
         4l1omvxeG6DNERn7uI9ydVyrH6jHoDXgd6Gw1B/JKI57fmwsYF90zr5qznVcRwNoftJn
         V0ZPfWraE85HgDQc5eWS8PGvM45cITulntW/eWySoDLT3oz2x1HCghNUtus6Aj54/2k+
         PsUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9QKa2VacjARO2bx+B8271EwJOxuawBk6pnHtNh07m7k=;
        fh=RAygrTdgeyDNM1JaJ03l7FeU/rMkzaUnttYoWhwTsFg=;
        b=LLAgPqW+9E3mdIZeYeVgba1NwszVaWkfVFksQd79NveXEuDaZiCT80223YuqiCgP/8
         5nqUB1qDlLVQ28URbZfYmDH15VuI7SSyBM8yh6B+/1nW3CwSjTQACNwimA3M/QlxKxz5
         W2w50Q0mkYsavGLA5ul7K6mxi9B16gS1cfYyr79ULq3vOBjP6KOSwKxMGc774EKbq2+W
         wfOCOmxAbAx79Bctle2j5bS6YXRTtaa1qhsFNr1exVTj1XulzDlJHS+wj5oIi3FltFNh
         vbnbMAj8rIUqsxfmn/nCWJOa7UxJrjG/2AA5sdjMlIxZHqZt29jT3G5H9UrlpCjFoJ15
         v5fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776851621; x=1777456421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QKa2VacjARO2bx+B8271EwJOxuawBk6pnHtNh07m7k=;
        b=KmESUt4vgmLCmJjCqiU1JjEaA78vLhFeMaxKo77s0207DBNsAW52nDoc4Aecyi0Jm/
         M0SUXaVOHlvZd8+qDPLfNm9tLQX9WtBprCDYZwN+NnXh8yKRC+nJUr5UfgVhfdrW6rus
         4kCJcDIz+x/7FOsrkusMxR1FK5xo/4pOCfMg2mFVqZJmx2Yi2NNZ8CGPbL0PK1Yqj4jR
         joJO9GV6Jn+dzBZBD7n0jbfU/4O+/XGkjtMUSJlbg5vU2Iy1y4IDHJEhGaeKHbXBsFz2
         nHrhsSHLT581RNALo2MRDq6ZyPwJZKET7D2T6x1KegTW0Bh/ykU76spKpvgl5NSVTUy6
         thxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776851621; x=1777456421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9QKa2VacjARO2bx+B8271EwJOxuawBk6pnHtNh07m7k=;
        b=D5KPjGPIBBkPBddZcq/cBtSzZ1ndaCKYDaoWCMJTQWA1glVcfiQtoB+/s1zOp+ytck
         Uh0mNp25+U/EZ0HMkL6kvYtMBFDUBYnU7oYDL/bswuSMTsxdEBw4CgM66YGiMXEUT08H
         lqZ538AEgH5XcI3ugmdFCVf9T8gJS36qv3XWEMcCIQoSgRY94PPyl2ZuB+iYUeXrNtDL
         dFvEojWRTtrh2NtjBo3FBZTF2dntPFGpjVTUZ/cap9X7XLLujm7e0+fj9zVEkqXGDTwZ
         qstsidBCfOL8/xDG1NfapqSpazFyymk3ntHCsAvbIMsL/UO8/1ct7pRuovygGyR4Opsq
         A7iA==
X-Forwarded-Encrypted: i=1; AFNElJ9bT4vBm5XfTx/sS4WVceLIEGnd6BmMCSz01m525hbXktzQjlodcCnX1cvnkLAgNXD6BLluh0o+eSEm@vger.kernel.org
X-Gm-Message-State: AOJu0YzjKpDU2B0QShKGj814HyxxNTT4dMxEAW9KThxm1UJ4gg7j/Afs
	cCiQcXScw++Yo99ESnycfNpa4lfnyR1mmnuROFSdMmBPIDoAaGp/vcdsKaqQz74nDlmDglDvWDC
	yCFMm9Sunzaz2sWt1qBoFBmNpQvp+WQ8=
X-Gm-Gg: AeBDieu7ZanXgfSfa/n3PFGNoSYGEfuWrgBC1UeywFAqRZ0f/Llbbbl/9BX+PIGF+io
	iH37pJL2ANhK89GRp96flF5k547Sbs79oNofYzwU4hjAfO4eOAAnlLTB2gt+R6w9sB7PToybG9i
	Elhtddu5M6cdL+hcWr0HV3/kD6B2Mff5DMGFCplwOT26xkoNssMWbwGJLpLjHwLnWMbpShtS5xA
	o7DSwbvNaWzjWVhFXyVBbbmWgb0rzjbvZI4O5rTrOVTYYN2rXLRWh7SJnL0sQGMB01HL80myeFt
	TM8tM6J50lPm82hYMA==
X-Received: by 2002:a05:7022:fa2:b0:12d:b6de:8da7 with SMTP id
 a92af1059eb24-12db6de9173mr2532821c88.6.1776851621422; Wed, 22 Apr 2026
 02:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404101003.3-ceph-pengpeng@iscas.ac.cn> <20260407120003.3-ceph-v2-pengpeng@iscas.ac.cn>
 <20260408093001.1-ceph-v3-pengpeng@iscas.ac.cn> <20260409110001.1-ceph-v4-pengpeng@iscas.ac.cn>
 <f957bdf6488b391b4329ff3cc892bfdc93c014fb.camel@ibm.com> <847376cbf4408d12389545142311cb5883045937.camel@ibm.com>
 <7e043aa928f13d043552ca650808c0383209f806.camel@ibm.com>
In-Reply-To: <7e043aa928f13d043552ca650808c0383209f806.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 22 Apr 2026 11:53:29 +0200
X-Gm-Features: AQROBzBAbO_HLOntZGuMByVqohHvq1iTC6SmyXhWEmHkL9M834YqLTF0ANSPwnU
Message-ID: <CAOi1vP96JuBi5BhTdiVeL491ziy_hwJUm79TqOb=iPaxck1eyg@mail.gmail.com>
Subject: Re: [PATCH v4] ceph: bound encrypted snapshot suffix formatting
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>, Alex Markuze <amarkuze@redhat.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Luis Henriques <luis@igalia.com>, 
	Xiubo Li <xiubli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 10:46=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Fri, 2026-04-10 at 20:40 +0000, Viacheslav Dubeyko wrote:
> > On Thu, 2026-04-09 at 18:09 +0000, Viacheslav Dubeyko wrote:
> > > On Thu, 2026-04-09 at 10:39 +0800, Pengpeng Hou wrote:
> > > > ceph_encode_encrypted_dname() base64-encodes the encrypted snapshot
> > > > name into the caller buffer and then, for long snapshot names, appe=
nds
> > > > _<ino> with sprintf(p + elen, ...).
> > > >
> > > > Some callers only provide NAME_MAX bytes. For long snapshot names, =
a
> > > > large inode suffix can push the final encoded name past NAME_MAX ev=
en
> > > > though the encrypted prefix stayed within the documented 240-byte
> > > > budget.
> > > >
> > > > Format the suffix into a small local buffer first and reject names
> > > > whose suffix would exceed the caller's NAME_MAX output buffer.
> > > >
> > > > Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> > > > ---
> > > > Changes since v3:
> > > > - reject `elen > 240` explicitly instead of relying only on the ear=
lier
> > > >   `WARN_ON()`
> > > > - rewrite the NAME_MAX bound check in terms of the final total leng=
th
> > > >   instead of `NAME_MAX - prefix_len - elen`
> > > >
> > > >  fs/ceph/crypto.c | 31 +++++++++++++++++++++++++++++--
> > > >  1 file changed, 29 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> > > > index f3de43ccb470..42e3fff34697 100644
> > > > --- a/fs/ceph/crypto.c
> > > > +++ b/fs/ceph/crypto.c
> > > > @@ -15,6 +15,12 @@
> > > >  #include "mds_client.h"
> > > >  #include "crypto.h"
> > > >
> > > > +/*
> > > > + * Reserve room for '_' + decimal 64-bit inode number + trailing N=
UL.
> > > > + * ceph_encode_encrypted_dname() copies only the visible suffix by=
tes.
> > > > + */
> > > > +#define CEPH_ENCRYPTED_SNAP_INO_SUFFIX_MAX       sizeof("_18446744=
073709551615")
> > > > +
> > > >  static int ceph_crypt_get_context(struct inode *inode, void *ctx, =
size_t len)
> > > >  {
> > > >   struct ceph_inode_info *ci =3D ceph_inode(inode);
> > > > @@ -209,6 +215,7 @@ int ceph_encode_encrypted_dname(struct inode *p=
arent, char *buf, int elen)
> > > >   struct inode *dir =3D parent;
> > > >   char *p =3D buf;
> > > >   u32 len;
> > > > + int prefix_len =3D 0;
> > > >   int name_len =3D elen;
> > > >   int ret;
> > > >   u8 *cryptbuf =3D NULL;
> > > > @@ -219,6 +226,7 @@ int ceph_encode_encrypted_dname(struct inode *p=
arent, char *buf, int elen)
> > > >           if (IS_ERR(dir))
> > > >                   return PTR_ERR(dir);
> > > >           p++; /* skip initial '_' */
> > > > +         prefix_len =3D 1;
> > > >   }
> > > >
> > > >   if (!fscrypt_has_encryption_key(dir))
> > > > @@ -271,8 +279,27 @@ int ceph_encode_encrypted_dname(struct inode *=
parent, char *buf, int elen)
> > > >
> > > >   /* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments=
 */
> > > >   WARN_ON(elen > 240);
> > > > - if (dir !=3D parent) // leading _ is already there; append _<inum=
>
> > > > -         elen +=3D 1 + sprintf(p + elen, "_%ld", dir->i_ino);
> > > > + if (elen > 240) {
> > > > +         elen =3D -ENAMETOOLONG;
> > > > +         goto out;
> > > > + }
> > > > +
> > > > + if (dir !=3D parent) {
> > > > +         int total_len;
> > > > +         /* leading '_' is already there; append _<inum> */
> > > > +         char suffix[CEPH_ENCRYPTED_SNAP_INO_SUFFIX_MAX];
> > > > +
> > > > +         ret =3D snprintf(suffix, sizeof(suffix), "_%lu", dir->i_i=
no);
> > > > +         total_len =3D prefix_len + elen + ret;
> > > > +         if (total_len > NAME_MAX) {
> > > > +                 elen =3D -ENAMETOOLONG;
> > > > +                 goto out;
> > > > +         }
> > > > +
> > > > +         memcpy(p + elen, suffix, ret);
> > > > +         /* Include the leading '_' skipped by p. */
> > > > +         elen =3D total_len;
> > > > + }
> > > >
> > > >  out:
> > > >   kfree(cryptbuf);
> > >
> > > Looks good.
> > >
> > > Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > >
> > > Let me run xfstests for the patch to double check that everything is =
OK. I'll
> > > share the result ASAP.
> > >
> >
> > The xfstests run was successful. I don't see any issues with the patch.
> >
> > Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >
> >
>
> Applied on testing branch of CephFS kernel client git tree.

Hi Pengpeng, Slava,

This patch raised my attention because my understanding was that the
entire CEPH_NOHASH_NAME_MAX + sha256() was put in place precisely to
handle longer names nicely and make them fit into NAME_MAX-sized buffer.
Simply rejecting longer names seemed to be in direct contradiction with
that and yet the patch on its own was clearly merited given

 * (240 bytes is the maximum size allowed for snapshot names to take into
 *  account the format: '_<SNAPSHOT-NAME>_<INODE-NUMBER>'.)

comment on CEPH_NOHASH_NAME_MAX definition.

I dug a bit deeper and started a discussion in [1].  The preliminary
conclusion is that the 240 bytes assumption was a mistake -- somehow
the minimum number of characters needed for <inum> ended up being used
instead of the maximum.  CEPH_NOHASH_NAME_MAX value is likely incorrect
and should have been smaller -- something along the lines of 174 -
SHA256_DIGEST_SIZE instead of 180 - SHA256_DIGEST_SIZE.

I kept this patch in the testing branch but not including it for 7.1
pending further investigation.

[1] https://github.com/ceph/ceph/pull/45312

Thanks,

                Ilya
