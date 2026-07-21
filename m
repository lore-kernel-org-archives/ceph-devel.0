Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2745D3845A7
	for <ceph-devel@vger.kernel.org>; Tue, 21 Jul 2026 04:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784609662; cv=pass; b=hQxX7/3OFptUOmfUP+tBdqvYenrjsFK0fsq2TntdJ9lBsRk7gc/XVr2mjQlAJo4Oc3GK2mdc5omzo841b9uiWZ6ZD2ceR5nS8tmkSGhgWbplM9eUyIGZHzRlXM/b1nRr3+GM5QmHFCi9G5XyWglBt4tFJsUZQy63jN0T3J1jhWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784609662; c=relaxed/simple;
	bh=Efa+aRZEqBdUdrLPdu2nFM3R/DE2308/+Qxm7d5R9pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XoKawW6YBEeqJKge/ctt6WZd2Wd4yTaXsficR6n14kQSDPGqIL0DZiZFG6ZGFNBI2L5KsT0V1mTYhGR5llbD1aGN2lOxwylYYOQnna0FuBNhPDDV4HBVhVwm3KVc2X6Dszu9Z1wqG1gCa1/bA0yIvTfSYoAvHQXEQZkg2wdlRH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=JhGBBOhM; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="JhGBBOhM"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15e2dab83eso1220905366b.1
        for <ceph-devel@vger.kernel.org>; Mon, 20 Jul 2026 21:54:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784609657; cv=none;
        d=google.com; s=arc-20260327;
        b=MRrQYGQpZcRIPh0whDyYHcfIt+JkKOQPOJuHHZj74p3kAfi5P8BwMC03ZrypG1MS6q
         +LBK2IslK1H0YDL5smUulDedMqJ7Fhx8/kj9/BLjJoBaBJA2R588ygS+/kQZ5TL35WBg
         FPRjRc8OdCh3gzGTjLtMfv5Yo9FjrS3XS64xP4yW2xBdOR/YIjYrdHXixZbbSZ6O8pSp
         kvY2FhHE45pVXV13mgq/kuqbPzcoEtbH08K4Exjt7aYFcxGgI7mSoxycjrg641GxTVLN
         yQnse3wwAxyl7tnHEztYm6u1Obe/+Ew7UJkX+B6BWDBUlpnRNYb42nt5mMVCfPMVMcL3
         35Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fspFCubw9NXYMk4WvwKltyc9s9D/o0aBDurS/NZh+9c=;
        fh=ArNuI69qavRNTPmpkIJDWl6FMBkyeLbLfhDtDU1WRyg=;
        b=ha3Q0TG+Y4T7syG6JQpkfJEzOjvTNdtjoOw2QKAJbE45nffK74E2MHwik+2x91rY6B
         rmDcW6GaQMtSZ8TBtm2u+8m4trYvQBOWMJDg7dNQQAP24dgkRqFWnKVRhBjlrrNpFzQC
         7UPQCry3d5gZBSGXgBpa+YROfGsx2Uq3a5H9M4YJ9ttNwjod4bHKFAuVB+LA457vEOA5
         QpuafP8xMEc5qQ+lpOhm74nxRLHGzGiDZ71wh5igEYkO452xtZLGFhgHQlWjKTFbSc7O
         F4HoHjnbywE5GXHDj61V5eF8cdqI5vE8zJRy829gfZtanPYFYMXi8ng7QCCJsK/qMULj
         p4iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784609657; x=1785214457; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fspFCubw9NXYMk4WvwKltyc9s9D/o0aBDurS/NZh+9c=;
        b=JhGBBOhMKFlWzlPahMi5rR/Nedx1Pa6XtzjtbNFVsFwJMPQZoB2r1eAMasGrF6xDCX
         jtiRhLIOORhkHMUvTcrpWf9Z2sO3bdST4rUVxh7CcVhaFQcIfWPoAR5uFfI1TCD3+8CR
         g+Gw7RPjU3Q/kQWRudz7S7EhfEX+pXd5XhpZEaiYcF3sAyoTkpPpRua827RPw3y87pzw
         8qeb6WKe/32Hm7A9w2CWJi9TJaw7Hvywz7hiXiF+cVCPq3VvoC2UakpUdmgtv6oXKjw5
         G0MkitiWCARtd+rPmkYh5ZiD24E/dGk5QSov+PBbS2C9JNlxFB7tT5Hc4gQXeY+FjIgM
         XQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784609657; x=1785214457;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fspFCubw9NXYMk4WvwKltyc9s9D/o0aBDurS/NZh+9c=;
        b=VYtP8A6dLc79tGW09hNdEW+9DudyWwZWiydRfNrb2SUlGN5Bh9QyE8RKJKrpFQsaR/
         W5n6uhHGmauXnIRR4u/i83bohSPDHxJh/F6GaDmqAAx/B8NEsm2gx2a1lnCiS88bBV7h
         SHRZbwVHU1KmLZItmQfFeVY8Hhijix2VPFo9+EKT1ta9AToN1aaXXsBIZsEbZHD5HCdt
         BZJPja99n/ck3+/LcCkdvnz5WfmeM4bkMFEqpg5FsbAg9mDs2i1pRPW2reTg5uXf0rWz
         RjOIbjaV1GjxJHjUTFT+7jQBRwcS1iJ3yyxmbsdyhna6JtXxgwjSb0+Y0yemQrasarmW
         Qrbg==
X-Forwarded-Encrypted: i=1; AHgh+RpGwbcdMB19c0YTinBQLtIoKqcaGvBOy00Pm3w0eRQRtR9/JjiXU/pwizzV2lTAMe44AxLIUWmbibxR@vger.kernel.org
X-Gm-Message-State: AOJu0YwMSeZLvm2E03RmnNISJF2H7o0QPEy6OsZ6oddVU9U+7KBodwjv
	TxzDIucrpDvmuh6M848/R9pDeN0Hm1HarB0BAzq+cbGXG5v81/htSJsyLVcNzK0VzbQ7FEB6+Wa
	qHb/1Q5ok3efRfKhh+rxZJoriA5MUssRwFrDNdno9BNaWpSmAG7K4N07GSg==
X-Gm-Gg: AfdE7cl3vfRMD2Zr4xx1jI7RPPAl7NliiDh0M40wFfInHP3yFBmg7PTGSOOOTIr/NS1
	X8DuqJP5NdwUdmGzfqdOWH79r/O+UB3dAkJhlJRJSHmwxduKR6ypCvvj9UitwTOj3PyM+mhs8ke
	Yx4k35pJUXJoDE/NV25OIphXStt3HQ6YAkyQT4z/9PT/2YBewxUsacw2lZfS18i8OpVF1ICQpb7
	PwCgBevxBO//WWfk6BhJJeNnpAgSO+zABZWgAkpGLiPmVYP2I5i6iSSZaqPMQauvdbmopCcfxA=
X-Received: by 2002:a17:907:7b87:b0:c12:b277:c7de with SMTP id
 a640c23a62f3a-c16b4a3795cmr704164766b.61.1784609657073; Mon, 20 Jul 2026
 21:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718-ceph-append-fix-v2-1-88dcc4f8371f@clyso.com> <e9ce96c3edf6b91bbb316e1107e81eb8aa13c99d.camel@dubeyko.com>
In-Reply-To: <e9ce96c3edf6b91bbb316e1107e81eb8aa13c99d.camel@dubeyko.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Tue, 21 Jul 2026 12:54:04 +0800
X-Gm-Features: AUfX_mxN8IC9wNzAZWALYCVjvnt2PiSkqfG62HFQr0ffxto0bfSQ-tmx1gevZhs
Message-ID: <CAOJNxRJB4_CxWeJ+5bKjTeQVQOgS3vYrDDZUv35d+cq+jCrLyg@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: revalidate ki_pos for O_APPEND writes after cap acquisition
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Jul 2026 at 01:38, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>
> On Sat, 2026-07-18 at 10:29 +0800, Xiubo Li via B4 Relay wrote:
> > From: Xiubo Li <xiubo.li@clyso.com>
> >
> > For O_APPEND writes, ki_pos is set to the current EOF via
> > generic_write_checks() after fetching i_size from the MDS.  However,
> > ceph_get_caps() may need to wait for Fwx exclusive caps if the write
> > extends the file (endoff > i_max_size).  While waiting for Fwx, the
> > previous Fwx holder (another client) may have already extended the
> > file.  When the MDS grants us Fwx, the cap grant message updates the
> > local i_size, but ki_pos remains at the old EOF, causing the append
> > write to land at a stale offset and overwrite data from the other
> > client.
> >
> > Fix by re-reading i_size_read(inode) after ceph_get_caps() returns.
> > At this point we hold Fwx exclusive caps, no other client can modify
> > the file, and i_size reflects the true EOF from the MDS cap grant.
> > No extra MDS round-trip is needed.  Only adjust ki_pos when the EOF
> > has actually changed.
> >
> > After adjusting ki_pos forward, the write range [pos, pos+count) may
> > now exceed the i_max_size that was validated by ceph_get_caps() for
> > the old range.  Re-check against i_max_size and truncate the write
> > if necessary to stay within the MDS-granted limit.
> >
> > Fixes: 8e4473bb50a1 ("ceph: do not execute direct write in parallel
> > if O_APPEND is specified")
> > Link: https://tracker.ceph.com/issues/7333
> > Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> > ---
> > Changes in v2:
> > - Re-check write range against i_max_size after adjusting ki_pos
> > forward, and truncate if it exceeds the MDS-granted limit.(Viacheslav
> > Dubeyko)
> > - Link to v1:
> > https://patch.msgid.link/20260717-ceph-append-fix-v1-1-c51907ac8e36@clyso.com
> > ---
> >  fs/ceph/file.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 9d89d7fc1095..a2b4d261e23c 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -2491,6 +2491,48 @@ static ssize_t ceph_write_iter(struct kiocb
> > *iocb, struct iov_iter *from)
> >       if (err < 0)
> >               goto out;
> >
> > +     /*
> > +      * For O_APPEND writes we may have waited for Fwx exclusive
> > caps
> > +      * while the previous Fwx holder (another client) extended
> > the
> > +      * file.  i_size has been updated via the cap grant message
> > from
> > +      * the MDS, but ki_pos is still the old EOF.  Re-read i_size
> > here
> > +      * (no extra MDS round-trip needed) and adjust ki_pos to the
> > true
> > +      * EOF.  Since we hold Fwx, no other client can change the
> > file.
> > +      */
> > +     if (iocb->ki_flags & IOCB_APPEND) {
> > +             loff_t cur_eof = i_size_read(inode);
> > +
> > +             if (cur_eof != pos) {
> > +                     doutc(cl,
> > +                           "%p %llx.%llx O_APPEND: pos adjusted
> > %lld -> %lld\n",
> > +                           inode, ceph_vinop(inode), pos,
> > cur_eof);
> > +                     iocb->ki_pos = cur_eof;
> > +                     pos = cur_eof;
> > +                     if (pos >= limit) {
> > +                             err = -EFBIG;
> > +                             goto out_caps;
> > +                     }
> > +                     iov_iter_truncate(from, limit - pos);
> > +                     count = iov_iter_count(from);
> > +
> > +                     /*
> > +                      * ceph_get_caps() validated the old endoff
> > +                      * against i_max_size; adjusting ki_pos
> > forward
> > +                      * may have shifted the write range beyond
> > the
> > +                      * granted max_size.  Re-check and truncate
> > if
> > +                      * necessary.
> > +                      */
> > +                     if (pos + count > (loff_t)ci->i_max_size) {
>
> If I am not wrong, every access of i_max_size is done under ci-
> >i_ceph_lock. Should we use this lock here?
>

Hi Slava,

Good question. Actually this is a benign race: after ceph_get_caps()
returns with Fwx, the MDS won't decrease our i_max_size without first
revoking Fwx (which can't happen while we hold a cap reference). So
i_max_size can only increase or stay the same. The worst case: we read
a stale smaller value and unnecessarily truncate the write. No data
corruption.

To maintain consistency with other locations, I will improve this anyway.

Thanks
- Xiubo


> Thanks,
> Slava.
>
> > +                             if (pos >= (loff_t)ci->i_max_size) {
> > +                                     err = -EFBIG;
> > +                                     goto out_caps;
> > +                             }
> > +                             iov_iter_truncate(from, ci-
> > >i_max_size - pos);
> > +                             count = iov_iter_count(from);
> > +                     }
> > +             }
> > +     }
> > +
> >       err = file_update_time(file);
> >       if (err)
> >               goto out_caps;
> >
> > ---
> > base-commit: df47791ab9f12cd9144aca477ddae195f68072a5
> > change-id: 20260717-ceph-append-fix-9820e3b1a78c
> >
> > Best regards,
> > --
> > Xiubo Li <xiubo.li@clyso.com>
> >
