Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A275113777E
	for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 03:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784085258; cv=pass; b=Bs2e8htrSa9VqgDHjGWnS9jk34dwuSIux6HHfn5RBgijsxoRxuE+2I1/dq9JK66rAtHpeHMdd2kjO9o/JeKs9Yys3/4BUG6sqOaiGfU72SuE8p0yXSFNJ/uVcIseWQfeWS6OnZ94k+jbLZWHMEbi2xtMfKirL2LOG0fkFG4VBEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784085258; c=relaxed/simple;
	bh=v1NuYT1KgcGwbyF0W43QBaH/V8V/GsPgl1zQ4LDDjIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojE2DiA2cg+hBz69J4i/x4e9L98glDzhm5F4MRStyLfxhuB4Hl7/OzYeerQIoxUelfPfdqTt6w+MoYXvlsfZDiy6noBpIg9dJaToS8kh6BBuY9Pw1sjsIPIFz/vx40r/fZuZf3YJQseRzfJnPfL+WdsEZ8zX6goQwEZ8e1+3hmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=QGWcotf1; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="QGWcotf1"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c166f1bbeaeso158117866b.0
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 20:14:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784085254; cv=none;
        d=google.com; s=arc-20260327;
        b=SmTXAJiAgfBEG1rej7/ZNpsryBVry2ci1S0oeKdnZWH+sFS6SKem7OZ9MH2f5k3+WK
         qOCEz4U9No89nVDLDLh/tyWwvdxebPx4a9neQCNhMy2VcN9RdxPnN8ZNdmVkkc4BSW2s
         EgbDF5tYNPG7cqipnlzgo6NtURY1QapD0F31EM/pzUXCHLzl158mNjWcYfvIkowCkEx9
         +kIJMj07v2pBHY16uBrdd6gpGxkfF3pBn0eTXDf8Lmhv+6nZrqYQT6ZVLSH4zOOXuz9I
         6w9Hz8excr4QXnKHDzUNhxnQt95UQq1Z8BxCA9cPzX1oCc8WnZBVm6qoFd7fFR3JpY9w
         7N3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w7gs38ltYjfZYGP44kRJyYMfgf6yXcWUu86Fi6a4+MM=;
        fh=J7egKOUow7IV2Rj6TGWvxmiTpoKwUiEKFG7SOA8rAU8=;
        b=VYVFUg3V3ETwitDmFVXXiRxn8zom3s+WRaK1KzutDVmtq1maE9Y5p/lkYPFbcgWLyY
         V9QhdiKcdPQAENpKa5q+GJ9zexzz/XL8zMQVT2PK6EPkDUy30hRN9XPc0dinYZwkM6m5
         r9w88pHZG9aZAoHLZT+SKuW9qrfPBdJ3sIaoSNVQrreKJ8mXRlNgscmHeQo+V8j1dOvw
         SLT/22j6YqDyxWh/7pNwOIaiFKWc8bHLKRBWPUgsPutd4QSlo2Zgt7SN6qJCPqvTYEig
         p2sTOL4oQ9qscjtlzGYePjxFDNKEnd+y6XuIDjtlgLAGPk3r63w3Hu2VCWZfuyJSHuei
         eF+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784085254; x=1784690054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w7gs38ltYjfZYGP44kRJyYMfgf6yXcWUu86Fi6a4+MM=;
        b=QGWcotf1IyCqWjoAYWkKs8OX5Jlx0EOs2xNDXWGxu2evjhgT1pW8kJiNZ5vpe2i1SR
         PbTPARXVD59R9BCMGJmg6ODS3d5ZMr4uYKX95w0vRJUnWaR3AREEObv7kzAg+bx66xjN
         AGgxV6hA2Y1/oDdnKBYtVHB6QMszZw7h1VPbhTNXVRcHIKiL2BhII3Owynqk3bbi/CEZ
         KuKTCSffvKT2IXTtiTEBWwV4JHBCa6ydZUS6vqnP4c6PuX29qvY8vuOrgduf+m7zMqVV
         9PbV4kvHRYEFyIuLmyH90SwM18T5fS5golTG1Wao2d/09iVJoCnpVmmyq6bJ/t9lTbkX
         w9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784085254; x=1784690054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w7gs38ltYjfZYGP44kRJyYMfgf6yXcWUu86Fi6a4+MM=;
        b=lOHGSy0GTc3Yl+PQIeUlEY3rJiv0gkf9blZjMTf5dtT8aBf/JIiFdi3sSdzkRsnk6o
         FTmPBfKhMqtNvgbeV43wrmHPtloREBiIRIfuwYjjcxNt3xlpykjtuq6bf08I1EViyFLR
         dMChA7gNZ92jcFN8gs9vYyT4x0XozrXpx46bcftxzMtrDMkicDmW8bxn2DoMDYKmsQWB
         CSVkHASFivDJmbbXkXlghT4Dp6yi2LKLwPH8u54Nsky/0Y+9JcrRDIBjILJtuOjob5Rt
         kf96Du4VDmH5RDW8R/MhcHzQiXYRbTlxnQ8qGhC1w0Pa7RWtZ8pVVQ9Elz70WPBTO2HB
         KLhA==
X-Forwarded-Encrypted: i=1; AHgh+RqQRRfaV0K3KpNAJ5RSZcixgWCft1mQ+JgXvph0s2FPbdldrCgU/xrjZkn05pM7cPAFHzLa9L+fhank@vger.kernel.org
X-Gm-Message-State: AOJu0YzWSkHuu0Zw2bSDZTkUlvi4aT2SgXDj7/8Vm9qY3IYLPweOaY0t
	KGU7w+BmYsuBboqzvrgyfSZRMpZJXdrGLPX3USo9cWBW/FdbasjGKCD0ZHOP7CDzTHGp68chaVE
	JLB6cuJ6PibVk2eUlqnZX0IqwURIH6I376dQV2o8JEQ==
X-Gm-Gg: AfdE7ckXsXVd6ZmOkhLIHus+HaoX3tahDQKxrdrkPiolWn0DAmcw1BlVORVmddO/CHC
	9IpgSnVkN3edeXnfRNiCzj9Y/mD6L3YXZ0OuHInWFjlZdhMqJphKn4F6IMUTQErMpFutmSvy83o
	y7nlA2qyFaDP/VvrIuwC8CtolRulVh1RBSClD09L+L/t2awApaDcIKV+MybyG8a/vFYXaQHcWTE
	Y9xsGqS9GjLTIsLIw/CSlyQGhPPQZ+aEIeOBlVp4dFh/UyVrpIgWGuL9xDOj6pN81mpww==
X-Received: by 2002:a17:907:3ea0:b0:c16:579e:a0f5 with SMTP id
 a640c23a62f3a-c16619948c0mr333569866b.58.1784085253930; Tue, 14 Jul 2026
 20:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713-ceph-mdsc-mutex-optimization-v1-0-9ae5ac135c34@clyso.com>
 <20260713-ceph-mdsc-mutex-optimization-v1-5-9ae5ac135c34@clyso.com> <b8ada95978d282df87ed12d9f631571c4ab74574.camel@dubeyko.com>
In-Reply-To: <b8ada95978d282df87ed12d9f631571c4ab74574.camel@dubeyko.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Wed, 15 Jul 2026 11:14:02 +0800
X-Gm-Features: AUfX_mzD8Z5OVgfnqu6TqMxz1Mjzq26uWVM1LzP8a--g6AlUC7SggU_7eZPqtGA
Message-ID: <CAOJNxR+OcsNXJAYGALa4W0jX=joLkt-oge14kWvdHfjS+UCkVg@mail.gmail.com>
Subject: Re: [PATCH 5/5] ceph: narrow mdsc->mutex scope in replay_unsafe_requests
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jul 2026 at 03:07, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>
> On Mon, 2026-07-13 at 17:46 +0800, Xiubo Li via B4 Relay wrote:
> > From: Xiubo Li <xiubo.li@clyso.com>
[......]
> > @@ -4673,12 +4673,25 @@ static void replay_unsafe_requests(struct
> > ceph_mds_client *mdsc,
> >  {
> >       struct ceph_mds_request *req, *nreq;
> >       unsigned long idx;
> > +     LIST_HEAD(replay_list);
> >
> >       doutc(mdsc->fsc->client, "mds%d\n", session->s_mds);
> >
> > +     /* collect unsafe requests under the mutex */
> >       mutex_lock(&mdsc->mutex);
> > -     list_for_each_entry_safe(req, nreq, &session->s_unsafe,
> > r_unsafe_item)
> > +     list_for_each_entry_safe(req, nreq, &session->s_unsafe,
> > +                              r_unsafe_item) {
> > +             ceph_mdsc_get_request(req);
> > +             list_move(&req->r_unsafe_item, &replay_list);
> > +     }
> > +     mutex_unlock(&mdsc->mutex);
>
> This loop is done right.
>
> > +
> > +     /* replay unsafe requests =E2=80=94 __send_request is lockless */
> > +     list_for_each_entry_safe(req, nreq, &replay_list,
> > r_unsafe_item) {
> >               __send_request(session, req, true);
> > +             list_del_init(&req->r_unsafe_item);
> > +             ceph_mdsc_put_request(req);
> > +     }
>
> However, this one has issue, if I am right. No ceph_mdsc_get_request()
> anywhere in it. It has always relied entirely on the caller holding
> mdsc->mutex for the duration of the loop.
>
> While this loop is inside __send_request() or
> ceph_mdsc_release_dir_caps_async() for one req, nothing stops another
> thread from acquiring mdsc->mutex and completing/timing-out/aborting
> that same request through the now-fully-unlocked
> __do_request()/wait_requests() path, dropping the last reference and
> freeing it =E2=80=94 at which point the next loop iteration's xa_find() t=
ouches
> freed memory. Am I right here?
>

Good catch. The old-request loop in phase 3 iterates raw pointers from
xa_for_each() / rb_next() without holding a reference. If another
thread completes the request while __send_request() runs without
mdsc->mutex, the request could be freed, leading to UAF.

I will fix it.

Thanks
Xiubo LI
