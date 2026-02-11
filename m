Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DEF9476
	for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2026 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770821572; cv=pass; b=EdavG0Z8qBhWwgFlUPE/odsDhMYy4c1uVZ1fKV6GiYgnNePbTPeGyVhoCK+AvlgcYGCoqn/j17AsnTDOjweo3dKuDfoZB4k4ZjLXP+WmzXkEs+QR3FtbwjU+WMOPRkTYcMML+3IU0+FcW7mGYR5m36ILHf948cMxSGZ3z3gT3HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770821572; c=relaxed/simple;
	bh=QUjQkJUWi024k1J7TmBam8PKt8oHP4ipS1phvf+eqjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nE8FBHYepSJhJGIebUDsRCEeiIqOkX51b6jcl6/GspT8C9OwAHqzTP/e6d3TwIq5jvi+RQ4Frajvy/ioqokDD4O5zIY77UxqP6QCHm8W7qpEm5+ZaQSj5/7vdRHIHhAv7rWC17YH5BWoOUKoscxeRdHk/mcEHVmfOuoxXIqoAtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCpt7LPp; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCpt7LPp"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1249b9f5703so7216303c88.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2026 06:52:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770821570; cv=none;
        d=google.com; s=arc-20240605;
        b=TPaHsWEjuO9xjQ5OIb4fPnRzgKBrVbCCw+VIdzVv8giWtPqTNovlWRnsicMSLX8+ON
         1Zlxf1mnqeUvRaXbGCr3PB/4FCkvLwJwZx0WjPjovsHMuO+ThxoEgSuM5HPp71d/1Bed
         6VkpFv6VVSI8vQz0kzDOaYVHgxHVQckqtqB8R1yL8ZsCYW/Mn+uyw2U507BCy6Uq7tiA
         fRnkY0VGuJDJIclcUeDV4MWbWuci8h+J6fSScn2p8SxzbllPW9eKRvixQTeH0cK1++8r
         rvaHTtDp6atP1uVJZqZbGPhq1knIIzaLn6lnziAEdcACU3+qQZq1mG6vUSHKyu6tES9S
         2NDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dS9JYFVceYu7Eyr24Du7RLvPPjHmThdSPq2If02YLxI=;
        fh=W2w0w993/n1XMPP182n9UD/AMj0tMoGO2RmET0HKl1M=;
        b=XM2DKGbu4unnLYEKQjquiqBlvw+t7Laebaqx9+2UzIUYed9zsrXAzSc/2q3imSzdcf
         7dBRbw5nRNpZBPmbgd4JoZicu1RdE4gW9g98tcG41RBJwpfhM5Ra3w+2RommAy4ezqmi
         Llpshz28wuQJvXBEWFDgekjdYBFfLYHv1BEyuRvI9e8lcn/1qK0Usu0evjwklNWgvygn
         KVVMvBBT+BZ47Chc8piFxZ7Yy6VH83YQsrpj2ZYBla9Efl9I0FcpwJ0v92x3V//E+7mk
         8veB52m/CFRag4iBOoWqJheUI7XSitNrymeESsb1ODUufhifn7dilXykgIOY5Ntb1qFb
         T1QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770821570; x=1771426370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dS9JYFVceYu7Eyr24Du7RLvPPjHmThdSPq2If02YLxI=;
        b=cCpt7LPpQ+Nry0x8cUHUSkOlOwVpfPEWWjg+zAawf+lfhzzfVkmDMZ7VHdMMwgIRYw
         x3lnxXa07Yzy90/ZKa0HOOYa2usN/N4AoGcvUok6rprlAzGdU2Vn/UJ5lQOryFnaM+Gy
         xqmQJL0jKHtXZrdKECGcIBw/xW/OfRLTbbPx7/L0T2XrbqYJ0/A3rnHdVdhV06LNLHii
         L83u/RN8oTAH+Kv0IfN1er33Q/0Hqk5t4o/YU5kpcAkgu7pKBBQCh8cxthIsoEmGJLXk
         j3qUw32r40gc4DvEsxvaVzF7QLV2SrCV8OnILKklPWvEwwhXNeQiPEz2ECLXNxQMAu+h
         mmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770821570; x=1771426370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dS9JYFVceYu7Eyr24Du7RLvPPjHmThdSPq2If02YLxI=;
        b=Nbf1/XDTBotJc9rEhGWXzRg9C0LevuZm5OSW6d1k6PwNkZTh7F4tw8ITUt37RRzkYb
         SHfdW0qY5u380KL8kK6VqA4zgn4pswr3Iiof5kOr5ETgiaPtg+1WZLx4LbHPGnIZpBFc
         1ZXbeICFV/QgMcLcIaig7RpAdrKmj1syKiIa07aVFWEEnOuLCHvpyd3V1BexMarHcXrx
         VNp199KudohmqV7j/O9HGamZhOj6C8bMmnMS1xYPWwi7p6GtbEvxzqX6Iab0KAJs/PLx
         6Qb6cOmABaHrNkECOjCFAeNKQUVU0gnbK8L4tdUe/iHb25cAnS/LNEqWOS8GB+upRTCW
         Rxhw==
X-Forwarded-Encrypted: i=1; AJvYcCUSKQGNtKFBl8v1GbbUvp+SlWOsdhQnxB26rZU12eYDtidhQfcPHWfp5fkmbGVyT00jFQy4eHzTH1+q@vger.kernel.org
X-Gm-Message-State: AOJu0YwzcjdTdba93ySzHWM0kD4FnobE0ycZ89covWJIfvg7vW/DVzs8
	5MHzN5XScJOA+CVbQtOJRqDcHB7/OlnwTdysKa11CnGTwAiZZVrTULdz+4z1th+z1EKAO3zF8WO
	I6IzF3QusXcOB2izsDm1OzMHg8kmweG0=
X-Gm-Gg: AZuq6aJQ6jAAmD8tRUkamirzwD2PlkD6Qgr+n65Ajxlgi8xVv2FX44rEGn1zPxWHcc2
	l/LvKhCUoU+drNezCphbZ8kUPF2gOVN0AMDUVLl7J59Tya2y++62lsPU5Vg26RnqTWHX6ecMc1x
	1vVL1dNQaIiUa1RY91N27umQNLO+3YPXSjvUhOvllbjegT6BxWvPewsLHxCS7bfvKZnuflW481o
	0XbsyQQEhPjedQySPsSm3qv+vcc+dYNhBBm46RkyndOsCK8j7HrSFNXAjnIEkOAJG9dFNd4VWNh
	ogmQZog=
X-Received: by 2002:a05:7022:2524:b0:11b:9386:8267 with SMTP id
 a92af1059eb24-127299a1ac7mr910474c88.44.1770821569744; Wed, 11 Feb 2026
 06:52:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126022715.404984-1-CFSworks@gmail.com> <20260126022715.404984-2-CFSworks@gmail.com>
 <CAOi1vP_2asCJyLOZH0GP=u8gRLU6jqnS-hC-R7ayjPOkk0zc0g@mail.gmail.com>
In-Reply-To: <CAOi1vP_2asCJyLOZH0GP=u8gRLU6jqnS-hC-R7ayjPOkk0zc0g@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 11 Feb 2026 15:52:36 +0100
X-Gm-Features: AZwV_QiotgS2yAouwVnoHKIigFAQ_INSP408FySRNaJw97uNnRox7TAAplSuGWE
Message-ID: <CAOi1vP-_Kr5MM=0pM0+1aRQAAzoVsrQazp9uCsjpF9OVfW9S1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ceph: free page array when ceph_submit_write() fails
To: Sam Edwards <cfsworks@gmail.com>
Cc: Xiubo Li <xiubli@redhat.com>, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	Christian Brauner <brauner@kernel.org>, Milind Changire <mchangir@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 3:10=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> w=
rote:
>
> On Mon, Jan 26, 2026 at 3:27=E2=80=AFAM Sam Edwards <cfsworks@gmail.com> =
wrote:
> >
> > If `locked_pages` is zero, the page array must not be allocated:
> > ceph_process_folio_batch() uses `locked_pages` to decide when to
> > allocate `pages`, and redundant allocations trigger
> > ceph_allocate_page_array()'s BUG_ON(), resulting in a worker oops (and
> > writeback stall) or even a kernel panic. Consequently, the main loop in
> > ceph_writepages_start() assumes that the lifetime of `pages` is confine=
d
> > to a single iteration.
> >
> > The ceph_submit_write() function claims ownership of the page array on
> > success (it is later freed when the write concludes). But failures only
> > redirty/unlock the pages and fail to free the array, making the failure
> > case in ceph_submit_write() fatal.
> >
> > Free the page array (and reset locked_pages) in ceph_submit_write()'s
> > error-handling 'if' block so that the caller's invariant (that the arra=
y
> > does not remain in ceph_wbc) is maintained unconditionally, making
> > failures in ceph_submit_write() recoverable as originally intended.
> >
> > Fixes: 1551ec61dc55 ("ceph: introduce ceph_submit_write() method")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >  fs/ceph/addr.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 63b75d214210..c3e0b5b429ea 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -1470,6 +1470,14 @@ int ceph_submit_write(struct address_space *mapp=
ing,
> >                         unlock_page(page);
> >                 }
> >
> > +               if (ceph_wbc->from_pool) {
> > +                       mempool_free(ceph_wbc->pages, ceph_wb_pagevec_p=
ool);
> > +                       ceph_wbc->from_pool =3D false;
> > +               } else
> > +                       kfree(ceph_wbc->pages);
> > +               ceph_wbc->pages =3D NULL;
> > +               ceph_wbc->locked_pages =3D 0;
>
> Hi Sam,
>
> While I don't see anything wrong with the patch per se, I can't help
> but question the existence of this entire branch along with the meaning
> of the error.
>
> ceph_writepages_start() is the only caller of ceph_submit_write() and
> it already calls ceph_inc_osd_stopping_blocker() at the top where the
> error can be handled naturally -- nothing needs to be unlocked or freed
> at that point.  Since mdsc->stopping_blockers is just a counter, all
> calls made by ceph_submit_write() invocations in a loop would be
> "contained" within that ceph_writepages_start() call.  The only benefit
> achieved is potentially faster response to the MDS client moving to
> CEPH_MDSC_STOPPING_FLUSHING state, but it's rather dubious because
> sneaking in/having to wait for some more OSD requests isn't really the
> end of the world.
>
> Rather than patching the error path, I wonder if instead of calling
> ceph_inc_osd_stopping_blocker() the counter could just be incremented
> unconditionally, with the check for CEPH_MDSC_STOPPING_FLUSHING bypassed
> there?  This could be wrapped into a new helper that could also assert
> that the counter is already elevated before the increment.

Something along the lines of

void __ceph_inc_osd_stopping_blocker(struct ceph_mds_client *mdsc)
{
        BUG_ON(!atomic_inc_not_zero(&mdsc->stopping_blockers));
}

and switching to __ceph_inc_osd_stopping_blocker() in place of
ceph_inc_osd_stopping_blocker() in ceph_submit_write().

Thanks,

                Ilya
