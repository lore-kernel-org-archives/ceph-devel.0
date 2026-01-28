Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E018E1B4257
	for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623976; cv=pass; b=egxtlokovYFGSazm3j3+Zkrffxz+BDDeGZ9TmlWzLA8Wm0Reyt63v7ti8ynIUrfNBg0pBF83e6qnefSYesgES6wAR6TrsD0osUeH3FcLxT6bAhD6LllxtohJ6beU7JqeBeENJJLYFbTYfQMgxyr+gKkqyfC+H29H0LCV07bummU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623976; c=relaxed/simple;
	bh=8S13+mwGrDe+fCW6wWPUOH5CZEl5aAEYbS5ftjBONh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AliyXn0h7T11zgm2G8sph2yhKB9aX0BJHQWHznvv3QaNBvUOPdxXf77b5cPdiR0sELFNhprP9oSD3EpBACnoPuUr+wrWgLSU2Je06Uv++BBvFj7R+wMpt9hxk4o2Dc6AU35ScT5PpgC2zOAzZyOXLYXJ4fTwsm7sm3xSyui+1+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqaRYaxF; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqaRYaxF"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12336c0a8b6so89237c88.1
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 10:12:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769623974; cv=none;
        d=google.com; s=arc-20240605;
        b=Eaazf35gXkMjjHE1ttWY+5Rf6T8kKU4p7R+ovZLjl+Kn4Y5mESfNBP5yCdT8LpEw/c
         8ifAD3TAynLSvHFlUjv0lL7QLuSxmgE9f1RmArHCCe7ix3A8AmFuG7Y/DQA+wRBcwkWb
         mGa0XtThaNjUrLEUIl05E6hDf1Q4h4EZMIWFnfaBvuwktSJvLBOXUhUXbJSdgpxycx/T
         GiAbelFmxry6lXY/cVl+4FyC8uJCKirxqSNW1NUeW3naBhP8eMdBgrrkI/Rd+0LgtC+8
         vkbZROLs1Ap+ADmrL9e8VP0PZNAJ6gfrH2v+pelVmZAP8wSjNAOaus9wkFMySX6j6V/D
         z9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9L31Qce2Ptj5HlLtAZVlYxI8OUdc6kse7tfrJsT+/pw=;
        fh=0DA4ZGUZIs5Aof9qvL73iu21fhe2WbWo4OB0ReJjVXE=;
        b=Ptv8JOq/XER3LYgCKEvSvSo7i87sit9dlQM8suydUTtlua9eqXO9nvJmMM769ARi/A
         0yVPA9fUxi62M1IgqTXqvPm6ppnQ7oS0PnIdmoA9e2fHwH74htGDRV7pFB7Cd+wQHXfR
         wJA66ifjdr0g2izat0+etNJ3vCfLn3vKFnxBH7UWylyaXMZoT1LrhE79INCUIgfmDQGH
         Iol523PbjGCX2aNTHkdD0S/v85eKOa35wz93vFpA9+WlknZGv13iDU/b8ZjDwo/3M5V/
         4Sa1bpdLUkEzdrL1DUlzgGbJ28CR0DNH7g1Jr+GAWzZ4szd8o2YkCUSz632xfEHTC3qV
         6bsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769623974; x=1770228774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9L31Qce2Ptj5HlLtAZVlYxI8OUdc6kse7tfrJsT+/pw=;
        b=bqaRYaxFPoEMdHoG+fbsx+vIpxGWxWCAj55MBUj8u3sscKLHWM1t96d+ZUV9Tfpe+9
         0nf3x3/4p+0zORl0BlG6EoLHK4gxhPrvbEdv+k2qCcwySpzjMZkRAnDTIXsfZITcWqYm
         kPdo9TA0hZlxwAPQO5lrKJIdoDv5cCz8+4BmDeeeCgiIE9BwBIEv1uhRo5mz9MYnR9b8
         k8mSPw0WTrjFvU81BeBx3a88B8+G6AbeO9VnExKiwW8wY58VYsIyMNdfE7jgWsnzp02y
         HW0igZQuXgoAe7onDIwK1Oc99YxujyKC5FWptm2aYSnIiBzLTya2R4SDL6+RzldQUOic
         BvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769623974; x=1770228774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9L31Qce2Ptj5HlLtAZVlYxI8OUdc6kse7tfrJsT+/pw=;
        b=v+z/nNYtvQ5yP5F83K++aLkntF8cjpo0fiHBpXU5VSvlzNB/hX2DFV2CnMJvQSOKdq
         zmAPbIK1mhKSyD9ofaYv2aJDkGC4q4e9+M7fSTX/KOdXUdU29jsRiTYpDSKcANr+yjZ1
         vxa/0Ev90UvL+1rAYIyYqKuvrrSsDGrzXFWevg9ypDA9WeglBSzGOholIyC4h+lxAWNA
         ahonSdfY2qkRyWnqe/RPSg+lb7qM3BvULldaxDOLJsxu8f8Fit/e+ltFyBOWHVxMSgDP
         KXsLQrEF4mQaDAiMdO5Xyg6LHgjjjLK1FjOqWNWOjVMruWG5t4YWpFpkrR70rgP1j0XM
         i8ng==
X-Forwarded-Encrypted: i=1; AJvYcCU6Y2/UVt8f7Q4Q3YFFV4SgFLunGifAXHf7b6ahwsoR6LeKeUItUcOsifv9N3YD79cTmfFdMNqrT8Ve@vger.kernel.org
X-Gm-Message-State: AOJu0YzWaiEbyQp11SiVhSvYBv6zXwykvqwlB+xFoIqmLJKzRNGnar6w
	n3pNDe4pMnbYd9xlaTc+bWdliqag2CJ7++6fGUE1rEedaRxKruQ6x8j8i0O0E2eWjD3gWY9ezFT
	wqbILnwiB7kEzBuql2N3GCp/zLfj3Fbg=
X-Gm-Gg: AZuq6aI+32PoGpXWLnX0bh8BzZ/tbhYulmqx/3IqLo2+wA1jjaWJ1TxVK7l1PcuGisT
	HVh2SfhbSKqdkYiHoD4a5AI31sATDDO/8zQkcu0cJUzhtZCBhcpA/rlVLDoOCI32uFDJkuK4I+y
	LxRcDsteaTZ8Ehfq+XzpCliiXv5qppjIj4UGTkTj0lK/ZUE2tHjBFK4pIZ+ViKzjo3XlinNnYpC
	vROB9IUwr58kvijlUdwc1LiFeRqO/XeAfnLBT7EgfH46iESokNMBUAcbWJBK2MJJ73lYZM=
X-Received: by 2002:a05:7022:910:b0:11b:88a7:e1b0 with SMTP id
 a92af1059eb24-124a00b9151mr3453147c88.26.1769623973962; Wed, 28 Jan 2026
 10:12:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114195524.1025067-2-slava@dubeyko.com> <CAOi1vP8CwX5T_R4gdZ0egg2oxCwFGAvoi6Us2k4=QFKmtqHmjQ@mail.gmail.com>
 <CA+2bHPa+NK1eBo56ryJ-_4=FK-xRRcbyGsEUOE09wb6U8muVRQ@mail.gmail.com>
In-Reply-To: <CA+2bHPa+NK1eBo56ryJ-_4=FK-xRRcbyGsEUOE09wb6U8muVRQ@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 28 Jan 2026 19:12:42 +0100
X-Gm-Features: AZwV_Qg--eDgI3HAIGUqozTx6HLUMnHXncn-L46tWgP6Y4_IUBt5ZMyJU5pEpEE
Message-ID: <CAOi1vP8dtzUesBa0h8wLhh+gz66dgD2LRDhuhQP_28+X3Y7a9Q@mail.gmail.com>
Subject: Re: [PATCH v5] ceph: fix kernel crash in ceph_open()
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com, khiremat@redhat.com, Pavan.Rallabhandi@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 6:15=E2=80=AFPM Patrick Donnelly <pdonnell@redhat.c=
om> wrote:
>
> On Mon, Jan 26, 2026 at 7:36=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com>=
 wrote:
> > Hi Slava,
> >
> > How was this tested?  In particular, do you have a test case covering
> > an MDS auth cap that specifies a particular fs_name (i.e. one where
> > auth->match.fs_name wouldn't be NULL or CEPH_NAMESPACE_WILDCARD)?
> >
> > I'm asking because it looks like ceph_namespace_match() would always
> > declare a mismatch in that scenario due to the fact that NAME_MAX is
> > passed for target_len and
> >
> >     if (strlen(pattern) !=3D target_len)
> >             return false;
> >
> > condition inside of ceph_namespace_match().
>
> Yes, passing NAME_MAX looks like a bug. Is this parameter even useful?
> Why not just rely on string comparisons without any length
> restrictions?

I think this parameter came about because ceph_namespace_match() is
being forwarded to from namespace_equals() which needs it -- but this
forwarding is actually harmful and results in undesired behavior as
discussed in the adjacent sub-thread.  Once the forwarding goes away,
the parameter would become obviously redundant.

>
> >This in turn means that
> > ceph_mds_check_access() would disregard the respective cap and might
> > allow access where it's supposed to be denied.
>
> From what I can tell, it will always consider the cap invalid for the
> fsname. So it's the reverse?

Yes, the cap wouldn't be used but it appears that if no other cap
matches/gets used ceph_mds_check_access() would allow access:

    struct ceph_mds_cap_auth *rw_perms_s =3D NULL;
    bool root_squash_perms =3D true;
    ...
    for (i =3D 0; i < mdsc->s_cap_auths_num; i++) {
            struct ceph_mds_cap_auth *s =3D &mdsc->s_cap_auths[i];

            err =3D ceph_mds_auth_match(mdsc, s, cred, tpath);
            if (err < 0) {
                    put_cred(cred);
                    return err;
            } else if (err > 0) {
                    /* always follow the last auth caps' permission */
                    root_squash_perms =3D true;
                    rw_perms_s =3D NULL;
                    if ((mask & MAY_WRITE) && s->writeable &&
                        s->match.root_squash && (!caller_uid || !caller_gid=
))
                            root_squash_perms =3D false;

                    if (((mask & MAY_WRITE) && !s->writeable) ||
                        ((mask & MAY_READ) && !s->readable))
                            rw_perms_s =3D s;
            }
    }
    ...
    if (root_squash_perms && rw_perms_s =3D=3D NULL) {
            doutc(cl, "access allowed\n");
            return 0;
    }
    ...
    doutc(cl, "access denied\n");
    return -EACCES;

Thanks,

                Ilya
