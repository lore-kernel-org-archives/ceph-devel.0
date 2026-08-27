Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B17175A6D
	for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2026 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813618; cv=pass; b=oDZXj7PPIYdJ/CU7TaJ2z6lJEE2h2SDltoXnJPv9TFisal1jPNF3oRvMoRU1iYwYYnO47EnnQ15i+nDtFUmB4uVLFc9JaMNy6BbNi1oG2WCjE6MP9n+67Nht4npfQV58vQtd9wsFqsIw7bRmbnW4aiLMrOvvIpmZwCWu22v0jnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813618; c=relaxed/simple;
	bh=FWc/JjFppFIs8yVZ38YVpnhb8DOznjAV8U53xIjywvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJT0hB1PTxzsvz0KlzxGGLA8lhE2uzGm/sup49FxAhvail1dQNbiYyN2bB5bUSBzl/B50+FV9boo3jsgnRPYLMgB/ywZdO2Opl4RaIsG7jqW8vY2KSt+HAKSUSVH13/a32xeZaUPXmeydwAXgJVEdC2UOGr3SSKyxsXCvMZuDus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=Y62iXj5a; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="Y62iXj5a"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so3318790a12.2
        for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 23:53:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787813612; cv=none;
        d=google.com; s=arc-20260327;
        b=Uf1NRUc+OOKU72J98BKZBnNgHNnk8aX9bLmUYtTHcZZbW16MB7zJAPQTHmDRZahKar
         ColW69khG29Yzqugb553/zjvOEg1RMlJdbIULIU2j5syuSmbsS3HvUgufsf129ONvY3I
         fiK+tndnGQI6w9AMbZr0wFUf+mHqtLCLKdEiNWQ073mXYEnMH4oeTpC3jxTtsgEuqWcz
         QZz/oXLESX5o03j+cwBwy9olDMay5qBniAAuH4UlgkefmKCRPPhP9IpAsMLo+Xj4Uvdu
         5lNLzHpsxQXSHtb2qVHQkfOtYRI3/K0oMkyYnYXoMBV4K68vXjvKCV2jVPOnvIhJJbuJ
         Va+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h7+E73gRvyXQ/2NNWDsddwMGk/puwap96dw0gco+l3M=;
        fh=qifA34Pf/CyJ7udLnalvh76RMkcnF8KD93Vzaf+axhU=;
        b=GndXziVhXu5XPrzWU/ODiJf6Ve7CL0IkUxzFingPSuXqKgOJ2agkg2/ubZ05oSbAWX
         VyhRW2dxY4XWJ+rAkTS/VB552uyrwIcJjRL1T3rt9fQRBOenm10L5hdeZevyUaKucn/Y
         iTjpgBF131v2K6CgzEqXsOk7Po0KdheDh0woIZAwkMX3V21ms7n7ka/xrSpkppu0sca0
         izLsKcE7+xQcavHI+rXdP/GaRLT5G7e3K1aOkNJMFUSruEwMJb0b1z5DsfeG2Q3SGBj6
         NVdBGj5cmhLRuSFylZDoMiEXou12dYJDOjWuSSEZfnhaR7TcBnzyqbMM1Xgjtktr9ctT
         aeNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1787813612; x=1788418412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h7+E73gRvyXQ/2NNWDsddwMGk/puwap96dw0gco+l3M=;
        b=Y62iXj5aP9jcWLj0zduaomjIuaTuZcJ16zR3hi+Yki0CT/sM5iVMXA8YdiYDpe6O67
         qjIhzoZz4XWp33LXl0x8lfOVXXajDsaXBMwG6T7aN+IRbRsGiNOvQiyc8UKHrl5APhHq
         yZJHHPG6vB4FmnjjROcRwZdshGW6O0odeRPVOiTh+tLSnZwT8Qh8+8u+nAoKQzS+9Dfr
         xMAGIOhCQMuIvln2XwF/nZHqb5moaoRMe1nhRrmlPUj9vAIlrKNwvMsltXRQrV8hmUte
         VQe+klPsMmUW67hR5EnfGFwDvpPJeTo2iGthgEFRrek4dl0ZK9Z9+W37jLBTfMc/I4TS
         07cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787813612; x=1788418412;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h7+E73gRvyXQ/2NNWDsddwMGk/puwap96dw0gco+l3M=;
        b=eOuXdqvRprQ5YIMonPhXSUPn5ceAjCM42KV2oO9Q8Ewd5O10RhyMQjKdjNyo7l3lrW
         WvsWoQth8UB+LTg0XRNghP85RWq0PiKV0nbXrqCuIuFU4DJ+vsh5USgiLVLwhly5VWbF
         FMj69rQmpWD4vuXMayBg0g0sRklqkq6vP+67tBEiWIkGWGf4tPow2RI16M9Rd1Pz2/1T
         qj+08uWMr0P7DI6i8iL1M4D/Zrmww/VKDIgW3ZfJmHhZ2FqaQ/8z+MbxOr9W1xx6oi++
         E0Bb1tLc5HhnCvERENXUIOO4tFchGSjG43rW4dW71Q7yJMHP9xQ1VHhZUbTLP2KKSp0W
         o9FQ==
X-Forwarded-Encrypted: i=1; AHgh+RoGA/WBlgMtMpBdnR5VeLW6gLOkVhef1ojmeN2UiTmIoyKxrK2OaPHqpjni9SS7IwP60cQPHFFyko2k@vger.kernel.org
X-Gm-Message-State: AFuF++naXatS9hrhAP/joVO+AF6SsDJwTq02lPkH+Xl5WbPbIZVhXide
	KHsFSyLAu/mlpUkCQ8LuhM2mKzvG0xACACyv8M1jKRyjQbEqqEAngRLxjCKnHuY0gN36MaD8uZz
	A+Ax0vw28i0LWZOrbB0e1M80sNGSEm2zujyXIbaKSWA==
X-Gm-Gg: AR+sD13Gr88bMKNjjSrDr7tDdkFmqxQWLuR39YXGLAm9YNaQYQCzHbYoatKJ+c+/sd4
	QDQck7Icy3AR61sfPe2OubUNVnNvKfASeGmqQ7Pj48o7tGFMh5bJn3r12MW7C4ZFBQeqEKBtOG1
	5cOtYyaH2CTqCHKGGD1t1TBhYsFQIrbPejW2OLOsdzv5wEXq2g8BByJ+DNHKw5DfNHjSCImEDJH
	dXFkCOvIVNGKa8MIMFVUfD5rNZ2DVvQj1+LSuNEmQamE3br43dUiVErCeaSmTflXZnqQbRSlwwW
	SDAxGc3uJYk07pJWOSYXXPuXlbFkwq6ymuwWLlp2dBbM0A==
X-Received: by 2002:a05:6402:2b94:b0:6a5:d3a1:3426 with SMTP id
 4fb4d7f45d1cf-6a5df665fb3mr14064867a12.16.1787813612311; Wed, 26 Aug 2026
 23:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817-b4-ceph-copyfrom-v2-1-08029d1ad42a@clyso.com> <CAOi1vP-O+6-w4YPxxpLJg3zD7mX_d4xnQUwhpWKy66aofKS_ng@mail.gmail.com>
In-Reply-To: <CAOi1vP-O+6-w4YPxxpLJg3zD7mX_d4xnQUwhpWKy66aofKS_ng@mail.gmail.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Wed, 26 Aug 2026 23:53:21 -0700
X-Gm-Features: AcwNN1V6xleiyAcgSGGJR3M1ayfp9qOowKgrCRhZ80_BnJrrnPEv1EaA4NZspBk
Message-ID: <CAOJNxRKQGg-ewATofaucYpSObcY04CmO+Cw-64HYR=9jAUUPSw@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: parallelize object copy in ceph_do_objects_copy()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilya,

Thanks for pointing that out. Fixed it and sent out the V3.

BRs
Xiubo

On Wed, 26 Aug 2026 at 11:03, Ilya Dryomov <idryomov@gmail.com> wrote:
>
> On Tue, Aug 18, 2026 at 3:48=E2=80=AFAM Xiubo Li via B4 Relay
> <devnull+xiubo.li.clyso.com@kernel.org> wrote:
> >
> > From: Xiubo Li <xiubo.li@clyso.com>
> >
> > The current ceph_do_objects_copy() submits COPY_FROM2 requests serially
> > (submit-wait-submit-wait), which means the total latency scales linearl=
y
> > with the number of objects being copied.
> >
> > Convert to a sliding-window parallel model: submit up to
> > copyfrom_max_inflight (16) requests concurrently, then wait for them
> > in FIFO order.  Because all in-flight requests make progress while we
> > wait for the oldest one, the total wait time is MAX(latency_i) rather
> > than SUM(latency_i).
> >
> > Error handling uses a 'truncate at first failure' strategy: results are
> > scanned in offset order and the copy is truncated at the first failing
> > object.  Parallel requests may have already written destination objects
> > past the failure point before the failure is detected; that is only
> > harmless when the copy starts at or beyond the destination EOF, where
> > the excess objects end up beyond the new (truncated) EOF and are
> > unreachable through reads.  Copies into the middle of an existing file
> > are therefore submitted serially, so they can never modify destination
> > data past the position implied by the result.
> >
> > The window size is snapshotted per call so a concurrent sysfs write to
> > copyfrom_max_inflight cannot shift the window bounds mid-copy, and an
> > allocation failure is reported only if no earlier in-flight request
> > failed with a real I/O error.
> >
> > Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> > ---
> > Changes in v2:
> > - Address review comments from Alex Markuze:
> > - Fix a use-after-free in the drain loop: clear the ring-buffer slot
> >   after putting the request, and stop draining once all in-flight
> >   requests have been waited on.
> > - Snapshot copyfrom_max_inflight once per call (clamped to >=3D 1) and
> >   use it for all window bookkeeping, so a concurrent sysfs write can
> >   no longer shift the window bounds mid-copy.
> > - Track request-allocation failures separately so they never mask a
> >   real I/O error from an earlier in-flight request.
> > - Only parallelize copies that start at or beyond the destination EOF.
> >   Copies into the middle of an existing file are submitted serially
> >   (window of 1), so a failed copy can never leave destination objects
> >   written past the failure point inside the file.  This assumes the
> >   destination size is stable during the copy: CephFS does not serialize
> >   concurrent size updates (FILE_WR caps are shared among clients and no
> >   inode/MDS lock is held across the copies), and concurrent
> >   modification is outside copy_file_range()'s guarantees.
> > - Widen the object indices to u64 to avoid overflow for very large
> >   copies with small object sizes.
> > - Link to v1: https://patch.msgid.link/20260720-b4-ceph-copyfrom-v1-1-9=
a4c229df6e2@clyso.com
> >
> > To: Ilya Dryomov <idryomov@gmail.com>
> > To: Alex Markuze <amarkuze@redhat.com>
> > To: Viacheslav Dubeyko <slava@dubeyko.com>
> > Cc: ceph-devel@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  fs/ceph/file.c | 242 +++++++++++++++++++++++++++++++++++++++++++++++--=
--------
> >  1 file changed, 201 insertions(+), 41 deletions(-)
> >
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 9d89d7fc1095..d6dfa0473e52 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -2965,6 +2965,22 @@ ceph_alloc_copyfrom_request(struct ceph_osd_clie=
nt *osdc,
> >         return ERR_PTR(ret);
> >  }
> >
> > +/*
> > + * Default maximum number of in-flight COPY_FROM2 requests.  Can be
> > + * overridden at module load time or at runtime via sysfs through the
> > + * copyfrom_max_inflight parameter.  The value is snapshotted per
> > + * copy_file_range call, so a runtime change only affects new copies.
> > + *
> > + * Higher values improve throughput over high-latency links, but too m=
any
> > + * concurrent requests can saturate OSD disk queues, especially in sma=
ll
> > + * clusters.  Tune this to match the number of OSDs and their concurre=
ncy
> > + * capability.  For most clusters 16--64 is a reasonable range.
> > + */
> > +static unsigned int copyfrom_max_inflight =3D 16;
> > +module_param(copyfrom_max_inflight, uint, 0644);
> > +MODULE_PARM_DESC(copyfrom_max_inflight,
> > +                "Maximum in-flight COPY_FROM2 requests per copy_file_r=
ange call");
> > +
> >  static ssize_t ceph_do_objects_copy(struct ceph_inode_info *src_ci, u6=
4 *src_off,
> >                                     struct ceph_inode_info *dst_ci, u64=
 *dst_off,
> >                                     struct ceph_fs_client *fsc,
> > @@ -2973,13 +2989,21 @@ static ssize_t ceph_do_objects_copy(struct ceph=
_inode_info *src_ci, u64 *src_off
> >         struct ceph_object_locator src_oloc, dst_oloc;
> >         struct ceph_object_id src_oid, dst_oid;
> >         struct ceph_osd_client *osdc;
> > +       struct ceph_osd_request **reqs =3D NULL;
> >         struct ceph_osd_request *req;
> >         ssize_t bytes =3D 0;
> >         u64 src_objnum, src_objoff, dst_objnum, dst_objoff;
> >         u32 src_objlen, dst_objlen;
> >         u32 object_size =3D src_ci->i_layout.object_size;
> >         struct ceph_client *cl =3D fsc->client;
> > -       int ret;
> > +       u64 orig_src_off =3D *src_off;
> > +       u64 orig_dst_off =3D *dst_off;
> > +       u64 num_objects, head =3D 0, tail =3D 0;
> > +       u64 first_fail_obj =3D U64_MAX, alloc_fail_obj =3D U64_MAX;
> > +       unsigned int max_inflight;
> > +       int first_fail_err =3D 0, alloc_fail_err =3D 0, inflight =3D 0;
> > +       int slot, ret;
> > +       bool have_eopnotsupp =3D false;
> >
> >         src_oloc.pool =3D src_ci->i_layout.pool_id;
> >         src_oloc.pool_ns =3D ceph_try_get_string(src_ci->i_layout.pool_=
ns);
> > @@ -2987,54 +3011,190 @@ static ssize_t ceph_do_objects_copy(struct cep=
h_inode_info *src_ci, u64 *src_off
> >         dst_oloc.pool_ns =3D ceph_try_get_string(dst_ci->i_layout.pool_=
ns);
> >         osdc =3D &fsc->client->osdc;
> >
> > -       while (len >=3D object_size) {
> > -               ceph_calc_file_object_mapping(&src_ci->i_layout, *src_o=
ff,
> > -                                             object_size, &src_objnum,
> > -                                             &src_objoff, &src_objlen)=
;
> > -               ceph_calc_file_object_mapping(&dst_ci->i_layout, *dst_o=
ff,
> > -                                             object_size, &dst_objnum,
> > -                                             &dst_objoff, &dst_objlen)=
;
> > -               ceph_oid_init(&src_oid);
> > -               ceph_oid_printf(&src_oid, "%llx.%08llx",
> > -                               src_ci->i_vino.ino, src_objnum);
> > -               ceph_oid_init(&dst_oid);
> > -               ceph_oid_printf(&dst_oid, "%llx.%08llx",
> > -                               dst_ci->i_vino.ino, dst_objnum);
> > -               /* Do an object remote copy */
> > -               req =3D ceph_alloc_copyfrom_request(osdc, src_ci->i_vin=
o.snap,
> > -                                                 &src_oid, &src_oloc,
> > -                                                 &dst_oid, &dst_oloc,
> > -                                                 dst_ci->i_truncate_se=
q,
> > -                                                 dst_ci->i_truncate_si=
ze);
> > -               if (IS_ERR(req))
> > -                       ret =3D PTR_ERR(req);
> > -               else {
> > +       num_objects =3D len / object_size;
> > +       if (!num_objects)
> > +               goto out;
> > +
> > +       /*
> > +        * Snapshot the window size once.  A concurrent sysfs write to
> > +        * copyfrom_max_inflight must not be able to shift the window b=
ounds
> > +        * mid-copy: that would corrupt the ring-buffer bookkeeping and=
 could
> > +        * index past reqs[].
> > +        *
> > +        * Parallel requests can write destination objects beyond the f=
irst
> > +        * failure before the failure is detected.  That is only harmle=
ss
> > +        * when the copy starts at or beyond the destination EOF: the e=
xcess
> > +        * objects end up beyond the new (truncated) EOF and are unreac=
hable
> > +        * through reads.  When copying into the middle of an existing =
file,
> > +        * the excess objects would clobber live data on failure, so su=
ch
> > +        * copies are submitted serially (window of 1).
> > +        *
> > +        * This assumes the destination size is stable for the duration=
 of
> > +        * the copy.  CephFS does not serialize concurrent size updates=
 --
> > +        * FILE_WR caps are shared among clients and no inode/MDS lock =
is
> > +        * held across the copies -- but concurrent modification is out=
side
> > +        * copy_file_range()'s guarantees, and the pre-existing serial
> > +        * implementation was equally racy in that case.
> > +        */
> > +       max_inflight =3D copyfrom_max_inflight;
> > +       if (!max_inflight)
> > +               max_inflight =3D 1;
> > +       if (orig_dst_off < i_size_read(&dst_ci->netfs.inode))
> > +               max_inflight =3D 1;
> > +
> > +       reqs =3D kvmalloc_array(max_inflight, sizeof(*reqs), GFP_KERNEL=
);
> > +       if (!reqs) {
> > +               bytes =3D -ENOMEM;
> > +               goto out;
> > +       }
> > +
> > +       /*
> > +        * Sliding window: submit requests up to max_inflight, then wai=
t for
> > +        * the oldest in-flight request to complete before submitting m=
ore.
> > +        * The reqs[] ring buffer is indexed by (slot % max_inflight), =
so
> > +        * memory is bounded to max_inflight regardless of num_objects.
> > +        * First-failure and EOPNOTSUPP detection happen inline =E2=80=
=94 no post-scan
> > +        * needed.
> > +        */
> > +       /*
> > +        * Drain only the valid window: stop once all in-flight request=
s are
> > +        * waited on (head =3D=3D tail) and no new submission can follo=
w, instead
> > +        * of walking head past the tail over freed/never-filled slots.
> > +        */
> > +       while (head < tail ||
> > +              (tail < num_objects &&
> > +               first_fail_obj =3D=3D U64_MAX && alloc_fail_obj =3D=3D =
U64_MAX)) {
> > +               /* Submit new requests while the window has room */
> > +               while (tail < num_objects &&
> > +                      first_fail_obj =3D=3D U64_MAX && alloc_fail_obj =
=3D=3D U64_MAX &&
> > +                      inflight < max_inflight) {
> > +                       u64 object_src_off =3D orig_src_off +
> > +                                            (u64)tail * object_size;
> > +                       u64 object_dst_off =3D orig_dst_off +
> > +                                            (u64)tail * object_size;
> > +
> > +                       ceph_calc_file_object_mapping(&src_ci->i_layout=
,
> > +                                                     object_src_off,
> > +                                                     object_size,
> > +                                                     &src_objnum,
> > +                                                     &src_objoff,
> > +                                                     &src_objlen);
> > +                       ceph_calc_file_object_mapping(&dst_ci->i_layout=
,
> > +                                                     object_dst_off,
> > +                                                     object_size,
> > +                                                     &dst_objnum,
> > +                                                     &dst_objoff,
> > +                                                     &dst_objlen);
> > +                       ceph_oid_init(&src_oid);
> > +                       ceph_oid_printf(&src_oid, "%llx.%08llx",
> > +                                       src_ci->i_vino.ino, src_objnum)=
;
> > +                       ceph_oid_init(&dst_oid);
> > +                       ceph_oid_printf(&dst_oid, "%llx.%08llx",
> > +                                       dst_ci->i_vino.ino, dst_objnum)=
;
> > +
> > +                       /* Do an object remote copy */
> > +                       slot =3D tail % max_inflight;
>
> Hi Xiubo,
>
> This and the other 64-bit division below don't compile on 32-bit:
>
>     ERROR: modpost: "__umoddi3" [fs/ceph/ceph.ko] undefined!
>
> I think you would need to employ div_u64_rem() or similar.
>
> Thanks,
>
>                 Ilya
>
> > +                       req =3D ceph_alloc_copyfrom_request(osdc,
> > +                                               src_ci->i_vino.snap,
> > +                                               &src_oid, &src_oloc,
> > +                                               &dst_oid, &dst_oloc,
> > +                                               dst_ci->i_truncate_seq,
> > +                                               dst_ci->i_truncate_size=
);
> > +                       if (IS_ERR(req)) {
> > +                               /*
> > +                                * Remember the allocation failure and =
stop
> > +                                * submitting.  In-flight requests may =
still
> > +                                * carry a real I/O error for an earlie=
r
> > +                                * object; the drain loop records it an=
d it
> > +                                * takes precedence over this failure w=
hen the
> > +                                * result is reported.
> > +                                */
> > +                               alloc_fail_obj =3D tail;
> > +                               alloc_fail_err =3D PTR_ERR(req);
> > +                               reqs[slot] =3D NULL;
> > +                               tail++;
> > +                               continue;
> > +                       }
> >                         ceph_osdc_start_request(osdc, req);
> > -                       ret =3D ceph_osdc_wait_request(osdc, req);
> > +                       reqs[slot] =3D req;
> > +                       tail++;
> > +                       inflight++;
> > +               }
> > +
> > +               /*
> > +                * Wait for the oldest in-flight request (FIFO order).
> > +                * This is required for correctness: we must determine =
the
> > +                * first failure in object-offset order to know how man=
y
> > +                * bytes were successfully copied.  It does not hurt
> > +                * performance because all requests in the window are
> > +                * submitted concurrently -- later requests complete in
> > +                * the background while we wait, so the wall-clock time
> > +                * is dominated by the slowest request, not the sum.
> > +                */
> > +               slot =3D head % max_inflight;
> > +               if (reqs[slot]) {
> > +                       ret =3D ceph_osdc_wait_request(osdc, reqs[slot]=
);
> >                         ceph_update_copyfrom_metrics(&fsc->mdsc->metric=
,
> > -                                                    req->r_start_laten=
cy,
> > -                                                    req->r_end_latency=
,
> > +                                                    reqs[slot]->r_star=
t_latency,
> > +                                                    reqs[slot]->r_end_=
latency,
> >                                                      object_size, ret);
> > -                       ceph_osdc_put_request(req);
> > -               }
> > -               if (ret) {
> > -                       if (ret =3D=3D -EOPNOTSUPP) {
> > -                               fsc->have_copy_from2 =3D false;
> > -                               pr_notice_client(cl,
> > -                                       "OSDs don't support copy-from2;=
 disabling copy offload\n");
> > +                       ceph_osdc_put_request(reqs[slot]);
> > +                       reqs[slot] =3D NULL;
> > +                       inflight--;
> > +
> > +                       if (ret =3D=3D -EOPNOTSUPP)
> > +                               have_eopnotsupp =3D true;
> > +
> > +                       if (ret < 0 && first_fail_obj =3D=3D U64_MAX) {
> > +                               first_fail_obj =3D head;
> > +                               first_fail_err =3D ret;
> >                         }
> > -                       doutc(cl, "returned %d\n", ret);
> > -                       if (bytes <=3D 0)
> > -                               bytes =3D ret;
> > -                       goto out;
> > +                       if (ret)
> > +                               doutc(cl, "object %llu returned %d\n", =
head, ret);
> >                 }
> > -               len -=3D object_size;
> > -               bytes +=3D object_size;
> > -               *src_off +=3D object_size;
> > -               *dst_off +=3D object_size;
> > +               /*
> > +                * A NULL slot means the object was never submitted (it=
s
> > +                * allocation failed, or submission stopped after a fai=
lure)
> > +                * or was already drained -- just skip past it.
> > +                */
> > +               head++;
> > +       }
> > +
> > +       /*
> > +        * Determine bytes copied: all objects before the first failure
> > +        * succeeded.  An allocation failure is only reported if no ear=
lier
> > +        * in-flight request failed, so a real I/O error is never maske=
d by
> > +        * -ENOMEM.
> > +        */
> > +       if (first_fail_obj =3D=3D U64_MAX && alloc_fail_obj !=3D U64_MA=
X) {
> > +               first_fail_obj =3D alloc_fail_obj;
> > +               first_fail_err =3D alloc_fail_err;
> > +       }
> > +       if (first_fail_obj =3D=3D U64_MAX)
> > +               bytes =3D (ssize_t)num_objects * object_size;
> > +       else if (first_fail_obj =3D=3D 0)
> > +               bytes =3D first_fail_err;
> > +       else
> > +               bytes =3D (ssize_t)first_fail_obj * object_size;
> > +
> > +       /*
> > +        * Deferred until after the drain loop, but safe: any request
> > +        * failure stops new submissions, so no COPY_FROM2 requests are
> > +        * sent after EOPNOTSUPP was seen, and the flag is cleared befo=
re
> > +        * this function returns.
> > +        */
> > +       if (have_eopnotsupp) {
> > +               fsc->have_copy_from2 =3D false;
> > +               pr_notice_client(cl,
> > +                       "OSDs don't support copy-from2; disabling copy =
offload\n");
> >         }
> >
> > +       if (bytes > 0) {
> > +               *src_off =3D orig_src_off + bytes;
> > +               *dst_off =3D orig_dst_off + bytes;
> > +       }
> >  out:
> > +       kvfree(reqs);
> >         ceph_oloc_destroy(&src_oloc);
> >         ceph_oloc_destroy(&dst_oloc);
> >         return bytes;
> >
> > ---
> > base-commit: fc67edb66b3c9924c4e0bb366a92b32ea13c526a
> > change-id: 20260720-b4-ceph-copyfrom-c8680b2d6616
> >
> > Best regards,
> > --
> > Xiubo Li <xiubo.li@clyso.com>
> >
> >
