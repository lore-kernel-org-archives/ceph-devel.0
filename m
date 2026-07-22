Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4253612F3
	for <ceph-devel@vger.kernel.org>; Wed, 22 Jul 2026 01:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784683154; cv=pass; b=QHDChvwZ1pKj0TFxnUxRnMEvmyz0b9whbIpFKwMD2GjzJ0OK4Ez+XLW/EEmvXozwecXsnZ0xfPxZBk60jK+JRz5pNv4TvMifBO95q+EDiyNBRlnk69G6suWFiHP5tkfGCSbSIiJAzNcmO+LkYB7PLBJ+/L6bcsDlt3WBhk/2mQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784683154; c=relaxed/simple;
	bh=D4DDm3K95W+MDAC/Jrao+JGarvzQBha3V+vBXG31Bmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJfkJ7amrzFRtojrcrc/zreg3XFGQYPkXzqHSE0+ZJRaz24OOz1kuQBllhswceGbfQ0tLE18zc3ek4MFSEP50tbHaMJdlDkaDUA9vZCq7levvwW3JqCNAtVnpcp27bAO9ZN1zC1HzocrqNKTw4vmGTxXnRP+mpcT/tv4Mb/X8PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=EMQ0syzy; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="EMQ0syzy"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-697cee2eb6dso8846813a12.0
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jul 2026 18:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784683150; cv=none;
        d=google.com; s=arc-20260327;
        b=XzMOs4nbBWBurAqxiknzhGTxoRb5jMHxlP9DlIdzgTYrI2gY1KyVyNE5TLBtNus1DW
         wtprfAqvp4ZOSE4CIF3FHhVmaLKUOgIW+uOvdLL8vtagWsMdANFJdv6Lo49GYSpBoahw
         YUd5q/stQyYKOm0KV8e0dAzbGJbARddzgStf/OVHsiYjCc+7p18Jun9JwsyAt6nhmgSj
         u+Pil6ib+Si/TY41QfufvIlrd/9pGOCPqF+QpM3XDHk62HkK075pM4/gwEA46nHz3aRb
         zNKPnSSNd9j7lvgjrP8vLj1O4Lv2Nh/JlodhqWzdnE9/BLj+By6eyQCPvkvjq8cL8iXD
         935A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=19EyWSL3UZZlkWYiqrw568DOimbAGv1dbfhOkHDF7/s=;
        fh=+I4bq4BpqP/cE/EsT02dacoTp4NaosxOJ/DHoRYuBbs=;
        b=iJ3AqYYOvOZNJPurHShTSuZ2HDX6+4Uko4xaCKfVeMxNTe8kTow6V50CN2q1pNorj+
         5+VDbdzW5llRz4wQ4lM4+criJh9yaQmqcCEcQVlvtpePLeErINL1QFwKeIR7rQ5NINxX
         ATw5VKF/+8z/+PP4gUW4X4ssZlOvIwigwFp+r6l2cKeyZsCOGHpICmTYyATUIrwSPBN/
         FoZ9owqx9lKW35H7+eRP5qF1A/L94UHSqITJE+1RG7blKtW++vvDopK9vvEnSyQWm4QM
         wqJNg58zkNR+P60CZjLhR86KgGNtRawOFekVnY9amRinfM6Wdaj0SOZR+W/IWUA8GcqD
         ub2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784683150; x=1785287950; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=19EyWSL3UZZlkWYiqrw568DOimbAGv1dbfhOkHDF7/s=;
        b=EMQ0syzya5phpiAaEKjdnd7FPaqxFFqWC7Cy3bV/Xg7ED5L+DP0J2B4QiEGtOGUCq8
         xtyq+AXzILBG0LuTqgHytmZKyAOgYxgSt2cWAHbLj7RTLBIgPUBfTIBqUl44DqZdo6tR
         f1hauAAw/ijIDM7YGj9k2at+0xKDQz6t2zCqzFRQ5iGJ3WETxtxuTwEJ8cDkNoE44kCW
         A6XLShMNDZWmB+yHGXeCMVbfGjaqMgdSruHXiRYJfFceu7fMlovzHnymz8tDorJ5yvJZ
         8bwQwAQQj0Ag1sZKPPBTWk7EOk70vMwdszpUUeYOpB1yssrsvaTimz1GGth0smkdtimC
         qfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784683150; x=1785287950;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=19EyWSL3UZZlkWYiqrw568DOimbAGv1dbfhOkHDF7/s=;
        b=pkKbPb4O0H3CATZkRaJX7Tsg8l17+EdswkWZjbS1WOPjQaYdAqeX8V9FrPui3gdS0k
         wXjSRRgd1ppcNJ6crf0UcgD3mZCkK3Qb6XO7/FOP17iGiEktVxdBKYUBe4I8BHeOs0x5
         7cjZ8yg4aAW6KEWp9VBqAFcP9I1CR90+SFPXTd+Lz3v83k1Wc47EuXVUFGH9t2wS9/9M
         9YNGjOlD7UOzDJ63dRnI8j+IWzlBSp8UxihkJFc9N7bDy999Cx/f8ZWoAcq+7mJ+FqCA
         rjIuYNqHuPO7t7kh0KepRSHZzL6U16g0pKwRTcWkUPqphsf9GdV6qlB429xnzElr6B9i
         da+A==
X-Forwarded-Encrypted: i=1; AHgh+RoXiTFvgEls5+1iAvQFg6H9qvJB2PpxC8L7BIock4oKjb1BIHuHsgux5ut1oYNtCz2fEYrMvIoKBU4H@vger.kernel.org
X-Gm-Message-State: AOJu0YySOpfd8xyocsddxpLQulzqTeC187SOknB1IGNmaP37wwlDczVt
	hnj8t9iH4KLiOKzKwh7QDY2VkjNFYq43Zz0zOcS2Bf3rsavYS+Rt8vqRUCZs/ZsjxQB/M/mHsNv
	pYLctLBKpntmU7SMy1q+Mq8KSZauaNzkLZq9ekyyI4Q==
X-Gm-Gg: AfdE7cmatyPnltBGls1EZx9Mx+ZvAe/gvSikIVkRH+CcSwpW8WNReqEGjOfT7/MWbjT
	kE9O2XpjkvMq+HGNGeAR/HabiwKDMrSVjlgB/9sFmSzmYkEhBiBCGV9A1WYiDq3uVE8okz/Ma9m
	JyfSdLCmIKzRCQPskyOSbWLDm6cZslRvSFTjrKfSIkGy0Ou/dW9KBKf1FmbCXTazhYeuM4/ZFRL
	BMIHTBzlBIKETse+jyQFPvkZ6GLsFvkp2X+H97sA3w15o5q7keUnFP4sl8d4tV+
X-Received: by 2002:a17:907:c8a4:b0:c16:af70:f981 with SMTP id
 a640c23a62f3a-c16b48551d8mr733382066b.32.1784683150003; Tue, 21 Jul 2026
 18:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721-ceph-append-fix-v3-1-403d1b5204d3@clyso.com> <c3e7be316a957f5363322991529c0c4a69937beb.camel@dubeyko.com>
In-Reply-To: <c3e7be316a957f5363322991529c0c4a69937beb.camel@dubeyko.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Wed, 22 Jul 2026 09:18:58 +0800
X-Gm-Features: AUfX_mw0eVmrZZX8gNNhon90Eb17vwAAQbrSO3t1SdjlBmwRTTQ7MMB1UrWtfac
Message-ID: <CAOJNxRKVKnUwwrC9NjOGD5LhD92S9xQBWH62sM+YNhsWE8g-yA@mail.gmail.com>
Subject: Re: [PATCH v3] ceph: revalidate ki_pos for O_APPEND writes after cap acquisition
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Slava,

Sounds good. I'll stick with the current implementation since you
agree it's not critical. Thanks for reviewing and adding the
Reviewed-by tag.

Thanks
Xiubo

On Wed, 22 Jul 2026 at 01:23, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>
> On Tue, 2026-07-21 at 13:06 +0800, Xiubo Li via B4 Relay wrote:
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
> > Changes in v3:
> > - Protect ci->i_max_size access with i_ceph_lock to avoid data race
> > with handle_cap_grant() which updates i_max_size from the messenger
> > thread.(Viacheslav Dubeyko)
> > - Link to v2:
> > https://patch.msgid.link/20260718-ceph-append-fix-v2-1-88dcc4f8371f@clyso.com
> >
> > Changes in v2:
> > - Re-check write range against i_max_size after adjusting ki_pos
> > forward, and truncate if it exceeds the MDS-granted limit.(Viacheslav
> > Dubeyko)
> > - Link to v1:
> > https://patch.msgid.link/20260717-ceph-append-fix-v1-1-c51907ac8e36@clyso.com
> > ---
> >  fs/ceph/file.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 3823671ab95a..c26bd4fef7d3 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -2489,6 +2489,54 @@ static ssize_t ceph_write_iter(struct kiocb
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
> > +                     spin_lock(&ci->i_ceph_lock);
> > +                     if (pos + count > (loff_t)ci->i_max_size) {
> > +                             loff_t max_size = ci->i_max_size;
> > +
> > +                             spin_unlock(&ci->i_ceph_lock);
> > +                             if (pos >= max_size) {
> > +                                     err = -EFBIG;
> > +                                     goto out_caps;
> > +                             }
> > +                             iov_iter_truncate(from, max_size -
> > pos);
> > +                             count = iov_iter_count(from);
> > +                     } else {
> > +                             spin_unlock(&ci->i_ceph_lock);
> > +                     }
> > +             }
> > +     }
>
> Just comment... :) For my taste, it is better to take the i_max_size
> under the lock and then to use it:
>
> spin_lock(&ci->i_ceph_lock);
> loff_t max_size = ci->i_max_size;
> spin_unlock(&ci->i_ceph_lock);
>
> But it is not critical remarks and I don't see any issue with the
> current implementation.
>
> Looks good.
>
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
>
> Thanks,
> Slava.
>
> > +
> >       err = file_update_time(file);
> >       if (err)
> >               goto out_caps;
> >
> > ---
> > base-commit: afffcd98d2d22f2e7ebe42f71231d52d4eed8ef7
> > change-id: 20260717-ceph-append-fix-9820e3b1a78c
> >
> > Best regards,
> > --
> > Xiubo Li <xiubo.li@clyso.com>
> >
