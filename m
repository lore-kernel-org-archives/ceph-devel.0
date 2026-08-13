Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A2438B7BC
	for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626934; cv=pass; b=oVsEUqnlZkLMku76bfTW8mBi3o32NAmtmOoMjMUXT+4j2XwD2ID7pNeIOO74FhjNgBqzcNBYgRzgOFKocs0GvSQggJXqpoSjGoYPtglBhEnIZpJySHJ/St7klkvwZKvco6FIW8Sfq5OFHhdMPV1v1bDHCbc9yWcqdgOunYvT6+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626934; c=relaxed/simple;
	bh=EihUpB4TtEUj7X7xavOJXj/nFV+kCe8gL0N7+cAPYJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlKTdBY/0Od6fZScFeRlpMLt8TQ9Zbz1Wg3XKzJcDFqk4h6oJc38+c9/FEATeIEeDj26npn5IiAdWrNPpCq4qZ3IkcG39ri6z2YkRuzm+G2JFRcdH1ByjfxEVbiBMhhBtJzdCorpnEyIokd0R5W2tE53zeM91HZODpyqXy7aQXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVVdGX0a; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVVdGX0a"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-977258a75d9so439694241.3
        for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 06:15:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786626932; cv=none;
        d=google.com; s=arc-20260327;
        b=lBrtWRlqAzayQO9WsEtCV32udxyzyCFR9qm5TLGuujXOjpVQ30Nmy/0SbobdEjPa2D
         WGwOE78KJULvBxzQCn2PDEsFvki0RY7y1bc6j9oeoi2LcfWI8jU6t9bS3y835cyHIqYu
         uALDtrptvEJys+YhsmJUc21SMH3z8ZXenzdKM4naE452QafpY1UG5n/tFjMpfDGB6KUe
         EFf6UdWJ7RXu+Zu0/Fj7Dvo0CPZaj5egwKqyhcVLH2r3wah+E1/07ltvULYOj86lSquO
         GbEnTijypZ11ITSlHNgEk5BVIvabcwSCqMbZMQUkfBXVqy0ch3lBVxxveqAXAMVhvOI1
         FpWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7P0xTCuuVplsIk8xDbfG+QsTWp0sxfboqg8Ac8B3fVU=;
        fh=IgbK1CPwzVpvx22WrPRgHM5+UYNLt/7Fq1aIpKBdjZ4=;
        b=T2aV7qG7mI55zsWIPhP92SH3d7n8N3DsMRgDNLTXGyo23UuLDFTwaHI5VBZWr0Jnxe
         3QtK/mgQLroDvbGbmzKP6XNrmi5z8Oi4tO0wr74MQDh8QVCOYQuqQXD93oQznaLqW6HI
         iiwnd2H2FDwO9ja9oT0Zrbt8TxkBDSuAOXfhYK/9JaFeUEAEFlZHNHoHevKc/Xd1Krqr
         tLeTT3vs34+ikn/XIGm2PSj647SucmjPQkOj/YRjrzxWWsxkh1lp7KJtAMxxtjEaxESg
         lVlmbUePGKNHPh/9FRSsNtYOEZJqJlZoGRCDjAlKaPQ3AAsSMuGBG12Dg9MEqc7ohF3+
         f94A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786626932; x=1787231732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7P0xTCuuVplsIk8xDbfG+QsTWp0sxfboqg8Ac8B3fVU=;
        b=WVVdGX0a7UruYNvlAAckBOuUu3Nz3YY9O7EdayWTrDdACwIbHWDeYK++iscMmTSOXT
         rOB13hX3aZZoMaM3ZWMY/XtaMsSGL5ABi3mHkd7RprXUXE1S1w1lgICJgNYOWsUwXO20
         ziTOFJGvG8W6V1eS+FOG0C966uYB70u5BxyYpX/vstIteKVidEC8MYG8+Mb/ierG/Xm+
         uUjzACK+ydbN4cY6qylh2Ht8hWy2drDCT/6bzvGu1ttB0r6Pb+1PIHRD3OD+G+xeN0uO
         WErs4/ZFzM6hGu6Od8TyBZZ3W5XpQJ7epGeSss1JHrhGhUT5+P+EBMVKVYXDEFyaz+3p
         b+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786626932; x=1787231732;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7P0xTCuuVplsIk8xDbfG+QsTWp0sxfboqg8Ac8B3fVU=;
        b=TEvVZYv4O82gDWGFAth85ZlgBn/diFASq3bAffeyR/nZfhrJCxOym9nYT6QALrNgu7
         p6eN/qmjL7IS8CXCdJHgC88FM+L8viaSKyoNxkmrvHA0MmfVuOFmKSrZxwmH8nOkw1r9
         YPBCrfkkeVFNu9hDwMsHGn5XjqCspntE/b5R9kU4uT57t3ZLhc2rrZ9hnx5zXdLezmd8
         6b8H4GQ4QldpCjcceNfMcWY67XZ/NgEv0b0lGSENZsx1dqigaMpt38T37u2pTv6bRqW6
         MCii5v/1A2PsURzVV3sSxQDOPuDK3fpU4dsUO1QIw+mEIlGKBR3fwXFE64qzQ7xRqOeq
         kAIQ==
X-Forwarded-Encrypted: i=1; AHgh+RrZropqB+c20IRXv5CHrPE8OGRMSVLDS0KAhuBLOaQuNlhOFic6+82GuDkIAQs8YGe4BQ7F8dhMT6JE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8yLsSArJid3ccVxfqCnqraLV+O4KtldVZYJrxZ0OkPsF8FlNl
	FVjaJYvHNqWn3coyRvuweHe7MkKEfmsk2Qnv3gbrgMDeFmV24ny6Ta05hAmYBGBlSUlIJGJAq6G
	YkM5CsxcLVb+kjltEnFGKH0P8uDd9Zy4=
X-Gm-Gg: AR+sD10UuAQ/Ael6UQ3zZphPB06IEyteub9DZvBNN84c9O2/irsMvMkyzDPYTx8oW8A
	z7KsAJJx0WiSbPkUgm5FJc36E++L/CNCjkzc5q9GvH5Lie9zynmivFuvqgkxPISqC22HDyfV8tY
	2KRwIpt9/qAhmcShvAyrVZZS7rRZ7QgaD0klgdRNEP/iIUUkILMo7pXyFcUOxTS/0OyL2aucqGz
	B08xZdr676KiX4hr/mu+AT/bS58iWY0qZjAj01t51G6NFjivGksuW/UItJQ+8sKYv+6eKSebtTs
	S7CFeW7d8gvnRAoD8daJ0zH4xQ+z+ivBx8IsLPSlVBCATLGV3cbYvXbgzm9Kg/Hd7sYD/rOTJpC
	fH/g=
X-Received: by 2002:a05:6102:4495:b0:74d:cef6:af78 with SMTP id
 ada2fe7eead31-76db6082df7mr1582491137.7.1786626931769; Thu, 13 Aug 2026
 06:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809-ceph-put-page-vector-v1-1-57ab2a08ec90@columbia.edu>
 <CAOi1vP9j72RiKGiwPo6oRe_sA1VjjORUPDvEYAsraLnH55pcwA@mail.gmail.com> <636c10c2-298a-4d39-8628-938accf56ff7@columbia.edu>
In-Reply-To: <636c10c2-298a-4d39-8628-938accf56ff7@columbia.edu>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 13 Aug 2026 15:15:17 +0200
X-Gm-Features: AUfX_mxq2d2mNAfWqKJ8-5knqiYKPv8CZscQ8MNf0kNROrTGe5wFr58jNmlDFaQ
Message-ID: <CAOi1vP9La9h+UwPvtp1yEVcdLYgvE43Gz_4LF1ArugbhDNS-qw@mail.gmail.com>
Subject: Re: [PATCH] libceph: remove the dead dirty path in ceph_put_page_vector()
To: Tal Zussman <tz2294@columbia.edu>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 1:41=E2=80=AFPM Tal Zussman <tz2294@columbia.edu> w=
rote:
>
> On 8/13/26 4:11 AM, Ilya Dryomov wrote:
> > On Sun, Aug 9, 2026 at 5:04=E2=80=AFPM Tal Zussman <tz2294@columbia.edu=
> wrote:
> >>
> >> The only caller of ceph_put_page_vector() passes dirty =3D false, so t=
he
> >> branch is dead code. Remove it along with the parameter. This removes =
a
> >> call to the deprecated set_page_dirty_lock().
> >>
> >> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> >> ---
> >>  fs/ceph/addr.c               | 2 +-
> >>  include/linux/ceph/libceph.h | 3 +--
> >>  net/ceph/pagevec.c           | 7 ++-----
> >>  3 files changed, 4 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> >> index e2da3ab9f808..83752f3688fa 100644
> >> --- a/fs/ceph/addr.c
> >> +++ b/fs/ceph/addr.c
> >> @@ -257,7 +257,7 @@ static void finish_netfs_read(struct ceph_osd_requ=
est *req)
> >>         if (osd_data->type =3D=3D CEPH_OSD_DATA_TYPE_PAGES) {
> >>                 ceph_put_page_vector(osd_data->pages,
> >>                                      calc_pages_for(osd_data->alignmen=
t,
> >> -                                       osd_data->length), false);
> >> +                                       osd_data->length));
> >>         }
> >>         if (err > 0) {
> >>                 ceph_subvolume_metrics_record_io(fsc->mdsc, ceph_inode=
(inode),
> >> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph=
.h
> >> index 63e0e2aa1ce9..3098306e6173 100644
> >> --- a/include/linux/ceph/libceph.h
> >> +++ b/include/linux/ceph/libceph.h
> >> @@ -313,8 +313,7 @@ int ceph_wait_for_latest_osdmap(struct ceph_client=
 *client,
> >>
> >>  /* pagevec.c */
> >>  extern void ceph_release_page_vector(struct page **pages, int num_pag=
es);
> >> -extern void ceph_put_page_vector(struct page **pages, int num_pages,
> >> -                                bool dirty);
> >> +void ceph_put_page_vector(struct page **pages, int num_pages);
> >>  extern struct page **ceph_alloc_page_vector(int num_pages, gfp_t flag=
s);
> >>  extern void ceph_copy_from_page_vector(struct page **pages,
> >>                                     void *data,
> >> diff --git a/net/ceph/pagevec.c b/net/ceph/pagevec.c
> >> index 858359873c4d..828b003aa2fc 100644
> >> --- a/net/ceph/pagevec.c
> >> +++ b/net/ceph/pagevec.c
> >> @@ -10,15 +10,12 @@
> >>
> >>  #include <linux/ceph/libceph.h>
> >>
> >> -void ceph_put_page_vector(struct page **pages, int num_pages, bool di=
rty)
> >> +void ceph_put_page_vector(struct page **pages, int num_pages)
> >>  {
> >>         int i;
> >>
> >> -       for (i =3D 0; i < num_pages; i++) {
> >> -               if (dirty)
> >> -                       set_page_dirty_lock(pages[i]);
> >> +       for (i =3D 0; i < num_pages; i++)
> >>                 put_page(pages[i]);
> >> -       }
> >>         kvfree(pages);
> >>  }
> >>  EXPORT_SYMBOL(ceph_put_page_vector);
> >>
> >> ---
> >> base-commit: 30c0913a2b44a66dc17283a88489b3f3e12f4327
> >> change-id: 20260809-ceph-put-page-vector-458bb3aa87f6
> >>
> >> Best regards,
> >> --
> >> Tal Zussman <tz2294@columbia.edu>
> >>
> >
> > Hi Tal,
> >
> > I'd suggest getting rid of ceph_put_page_vector() altogether -- it's
> > pretty confusing to use it to put something that wasn't allocated with
> > some ceph_*_page_vector() helper.  It looks like ceph_put_page_vector()
> > was paired with ceph_get_direct_page_vector() which is long gone.  The
> > put_page() loop and kvfree() could be done in that single caller.
> >
> > As I was looking into this, I think I spotted a related memory leak in
> > ceph_netfs_issue_read().  On the fscrypt path, the "page vector" coming
> > from iov_iter_get_pages_alloc2() isn't put in case of EIO caused by
> > ceph_inc_osd_stopping_blocker().  Alex, please take note.
> >
> > Thanks,
> >
> >                  Ilya
> >
>
> Hi Ilya,
>
> Thanks for the review!
>
> I'm happy to fix the ceph_netfs_issue_read() issue as well in a separate
> patch by using ceph_put_page_vector() there (for backporting purposes) an=
d
> then inlining ceph_put_page_vector() in the (now two) callers. Does that
> sound reasonable to you?

I'd rather see if the ceph_netfs_issue_read() issue can be taken care of
by moving ceph_inc_osd_stopping_blocker() call.  If so, there would only
be one place where the "page vector" needs to be put.

Thanks,

                Ilya
