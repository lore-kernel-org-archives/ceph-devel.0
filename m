Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1739472526
	for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787767441; cv=pass; b=mXP++l0oaU8oAo9jR0YnaENRASBZYA6I1sTMaKECwW+bXnburYkDogZ2jxrCrIFv1114GC0Q+gRNB1io3/uGyxvR1uuGq1t4H1fVhJNbK+ML/kZkxANp3Pd3MpWlTfYNc2fdpmGkgidlKnX4IMC7YyqGyt4GSwKXcEt/IVZAWlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787767441; c=relaxed/simple;
	bh=vlunGDORYnN4I1eDvcjkoY+inqq++M3fXiICy/IaP0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3gghiIlxQHE815/2vL65fa4AvWDkPaDA3Pa+ZOJu/danJBWErgAo0e68DWy3hy2DVtwyYZO2r0RruUfC937OjZXn7hMKtI1cwUVRJrjWNCQ3HV9b9bRjXiAM3o7F+ow46gsZVEfzTgBmhtpP6w7WYIoegrvl0n48BdEi7LfrKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9nyj7Yp; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9nyj7Yp"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-97bf91b2e6eso362476241.2
        for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 11:03:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787767426; cv=none;
        d=google.com; s=arc-20260327;
        b=lJtjupfKHecPUlEeS2JE+rzn7FxZQ/UCKgwl8eTEGFV1gTJzJGzRNKzC1GH0SAx8GR
         QpXnQ7ihtGYt3Txz8Rt1EelkcS0oGWLyXYV5bqcHaqyfrg/TtfIMbU/yCfwnawvHy+Rr
         QtluSVeIaWCdL9J56Ki9LgNnEmwtNt7Hl1D3p/ps1XDlzYZ/Ye1BkIQvdxPlVXPdyMwu
         ycOya0smzmk4hgNeSWLVnIHqgKYdi1zIXXOLpZIAE9fEpqwVo8Ww7FzI2eqo5Uflcmbi
         n/PMootTgMgLU7pIm7FYQBlaFvJOqJDmtLzfynYueU3tTM4Y/9bPpDlMuBtg58GyUSQC
         bsow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n6GZ1INBQUmtkN/B0w6qEy33byupGG0jswj1sBwU18w=;
        fh=MrSqUvNV+1ToUXuxdWCmpgC/3kn+mpslTd7EZlCFRts=;
        b=XmnOriKj4wU3IGA+32lXFPqKEQIOfSOIrmPkfOcKfgoZpcRtgaKo9Y5EEy2J5GPyYu
         DO+P6G0jZkyz41kphycLGSXuyYkl4fiboEu+bmSE3pd5TeJstsGYtdpaI/wCY35IbgXQ
         9qjTh2x7zS0mPxZWmUcFzIEICuyW2CamlzeRo7oVvwUiR6JvWRa4j7Z5pMrLvJ3/qKdw
         Ei0aCjCEhAHTQ0CLShbmGlJS4IfLNZG3E2zNKffz+UNKBfkKhjddaizxLlnVzvAmJNtt
         XFgwPbOc8sf8lzlb/4GlhUBoBSNljf618jg8bW8f1Nm4hOxPwep5zgXfXkuaSZJ45pbC
         7eKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787767426; x=1788372226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n6GZ1INBQUmtkN/B0w6qEy33byupGG0jswj1sBwU18w=;
        b=e9nyj7YptMaEEycUVEgfggKmEkH8QMi5jCSGmgTc3HSrBPTb9TxASIsaMyaGmVo/ad
         GzgefEP8c0qig5cwa7DYnO62YzOkoN1kNWanFv0yqzxsUeiSmjGiVzwdof6yxqNRx1JL
         xYxDh1IPaMmdpJiHKb9LY3EKniRMHnG9YXUMjarmszcNVSzywU/YfBbAjRLFj2hWD3Ev
         iNsU76CWiwQI6wdTEh8x3HNdPmVd6RNTcxFqXTLNL5W03z6N1K4AcM5cpAXvGb3Mb4ui
         EhlayiWwlLEBKl7YU6LAoPKXMrkFRPNggrDsaNx3B40Z3OTT8qqUUk+T9c0DoYMdsimX
         JXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787767426; x=1788372226;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n6GZ1INBQUmtkN/B0w6qEy33byupGG0jswj1sBwU18w=;
        b=SuRqgVHjexRn5Js3ecCKpLgnB5OS9lKknHfhd5jgwY+RyLdjgAKsfQ6O71H81AcXBO
         xwrocuOxZLfpKk/CRpIAPxV635xv5QDmBXJeQa/A7LT0QlRtl1rX5E41qwexlfVjBHf8
         PWTxE6gX/ZqzDS97kjWpE7vGPJ8ei7Gvy9Lj4h43OpfSaERRLBfGvLyQaXxLCct+yBOt
         AVvsRhTuRrfoSv9+GiPlMwIobdLKU3b+E7cb13YAUeinj7D4J0gl61dsEVy2zWtQPCdT
         m7pOHovwwwka70YAXbvWtmBYSjGkBdSOPe12EEgzl8N+XBjix/Nq6ZzjFSeosnjHNIb6
         N9/Q==
X-Forwarded-Encrypted: i=1; AHgh+RpSoThIphxjC+qHOYJOIuhZzYQjirGQP7Ne5LP5GgZZ7F8bZ3OqI8/8Z9j42S4F7nT854nZF6qxy2/k@vger.kernel.org
X-Gm-Message-State: AFuF++kc4GU95hB8PlUqezyZaWuGWXySjyCvy/JXNov4KL8hOnJwi1/f
	u0Jrngl/ILxyE1j0yku8R8Tp3lX4iSrR/JwfxnvywmPai88oVSlNq4OgPJztKsMRbcIdMC46BtQ
	HBEU01rEgL15rHVMy5+tVGDzvly7lc3E=
X-Gm-Gg: AR+sD11Nz+YvXyo+vbrxiM4uZHVjoE/+V54ZpPOPXaj56spwPjbMHGLhC0qRM+0n5kK
	ekJyY/amudhrmdmsf77pqLkkekIv37/avIdW63RAquyxhZXCipMIM7GZUSulAUqZwEJ6XwwjE5o
	hjiAzHwXao/4GVoStdKMngN3PjxWAKuRqGF089qlYfA7nIG1MgCdTnCnn8FZ7f/G9RXJMptzqQg
	kh6R1PjNdMuIoO5Y/8xeFU2CkJSikZcxPFoGiEJKuWtsFK1zZN0aU4zFxeOTaC1nv/bAvZlvO9W
	goDM2zdw940gxxjD2KG5bFa48NCLgcpJm9d/bJXGk0a08aY9kQv04Vfl/TxH4QodzYr+9tGfFx8
	aS+lkb1RhzSRn
X-Received: by 2002:a05:6102:2c85:b0:77e:7a57:dd89 with SMTP id
 ada2fe7eead31-782c03e2430mr2692921137.5.1787767425993; Wed, 26 Aug 2026
 11:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817-b4-ceph-copyfrom-v2-1-08029d1ad42a@clyso.com>
In-Reply-To: <20260817-b4-ceph-copyfrom-v2-1-08029d1ad42a@clyso.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 26 Aug 2026 20:03:34 +0200
X-Gm-Features: AcwNN1VjZDmp50sztoueJj33Zle9DpA18guckuny5f8ZpHRgIUwFysEEVRPYIRI
Message-ID: <CAOi1vP-O+6-w4YPxxpLJg3zD7mX_d4xnQUwhpWKy66aofKS_ng@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: parallelize object copy in ceph_do_objects_copy()
To: xiubo.li@clyso.com
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 3:48=E2=80=AFAM Xiubo Li via B4 Relay
<devnull+xiubo.li.clyso.com@kernel.org> wrote:
>
> From: Xiubo Li <xiubo.li@clyso.com>
>
> The current ceph_do_objects_copy() submits COPY_FROM2 requests serially
> (submit-wait-submit-wait), which means the total latency scales linearly
> with the number of objects being copied.
>
> Convert to a sliding-window parallel model: submit up to
> copyfrom_max_inflight (16) requests concurrently, then wait for them
> in FIFO order.  Because all in-flight requests make progress while we
> wait for the oldest one, the total wait time is MAX(latency_i) rather
> than SUM(latency_i).
>
> Error handling uses a 'truncate at first failure' strategy: results are
> scanned in offset order and the copy is truncated at the first failing
> object.  Parallel requests may have already written destination objects
> past the failure point before the failure is detected; that is only
> harmless when the copy starts at or beyond the destination EOF, where
> the excess objects end up beyond the new (truncated) EOF and are
> unreachable through reads.  Copies into the middle of an existing file
> are therefore submitted serially, so they can never modify destination
> data past the position implied by the result.
>
> The window size is snapshotted per call so a concurrent sysfs write to
> copyfrom_max_inflight cannot shift the window bounds mid-copy, and an
> allocation failure is reported only if no earlier in-flight request
> failed with a real I/O error.
>
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> Changes in v2:
> - Address review comments from Alex Markuze:
> - Fix a use-after-free in the drain loop: clear the ring-buffer slot
>   after putting the request, and stop draining once all in-flight
>   requests have been waited on.
> - Snapshot copyfrom_max_inflight once per call (clamped to >=3D 1) and
>   use it for all window bookkeeping, so a concurrent sysfs write can
>   no longer shift the window bounds mid-copy.
> - Track request-allocation failures separately so they never mask a
>   real I/O error from an earlier in-flight request.
> - Only parallelize copies that start at or beyond the destination EOF.
>   Copies into the middle of an existing file are submitted serially
>   (window of 1), so a failed copy can never leave destination objects
>   written past the failure point inside the file.  This assumes the
>   destination size is stable during the copy: CephFS does not serialize
>   concurrent size updates (FILE_WR caps are shared among clients and no
>   inode/MDS lock is held across the copies), and concurrent
>   modification is outside copy_file_range()'s guarantees.
> - Widen the object indices to u64 to avoid overflow for very large
>   copies with small object sizes.
> - Link to v1: https://patch.msgid.link/20260720-b4-ceph-copyfrom-v1-1-9a4=
c229df6e2@clyso.com
>
> To: Ilya Dryomov <idryomov@gmail.com>
> To: Alex Markuze <amarkuze@redhat.com>
> To: Viacheslav Dubeyko <slava@dubeyko.com>
> Cc: ceph-devel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/ceph/file.c | 242 +++++++++++++++++++++++++++++++++++++++++++++++----=
------
>  1 file changed, 201 insertions(+), 41 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 9d89d7fc1095..d6dfa0473e52 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -2965,6 +2965,22 @@ ceph_alloc_copyfrom_request(struct ceph_osd_client=
 *osdc,
>         return ERR_PTR(ret);
>  }
>
> +/*
> + * Default maximum number of in-flight COPY_FROM2 requests.  Can be
> + * overridden at module load time or at runtime via sysfs through the
> + * copyfrom_max_inflight parameter.  The value is snapshotted per
> + * copy_file_range call, so a runtime change only affects new copies.
> + *
> + * Higher values improve throughput over high-latency links, but too man=
y
> + * concurrent requests can saturate OSD disk queues, especially in small
> + * clusters.  Tune this to match the number of OSDs and their concurrenc=
y
> + * capability.  For most clusters 16--64 is a reasonable range.
> + */
> +static unsigned int copyfrom_max_inflight =3D 16;
> +module_param(copyfrom_max_inflight, uint, 0644);
> +MODULE_PARM_DESC(copyfrom_max_inflight,
> +                "Maximum in-flight COPY_FROM2 requests per copy_file_ran=
ge call");
> +
>  static ssize_t ceph_do_objects_copy(struct ceph_inode_info *src_ci, u64 =
*src_off,
>                                     struct ceph_inode_info *dst_ci, u64 *=
dst_off,
>                                     struct ceph_fs_client *fsc,
> @@ -2973,13 +2989,21 @@ static ssize_t ceph_do_objects_copy(struct ceph_i=
node_info *src_ci, u64 *src_off
>         struct ceph_object_locator src_oloc, dst_oloc;
>         struct ceph_object_id src_oid, dst_oid;
>         struct ceph_osd_client *osdc;
> +       struct ceph_osd_request **reqs =3D NULL;
>         struct ceph_osd_request *req;
>         ssize_t bytes =3D 0;
>         u64 src_objnum, src_objoff, dst_objnum, dst_objoff;
>         u32 src_objlen, dst_objlen;
>         u32 object_size =3D src_ci->i_layout.object_size;
>         struct ceph_client *cl =3D fsc->client;
> -       int ret;
> +       u64 orig_src_off =3D *src_off;
> +       u64 orig_dst_off =3D *dst_off;
> +       u64 num_objects, head =3D 0, tail =3D 0;
> +       u64 first_fail_obj =3D U64_MAX, alloc_fail_obj =3D U64_MAX;
> +       unsigned int max_inflight;
> +       int first_fail_err =3D 0, alloc_fail_err =3D 0, inflight =3D 0;
> +       int slot, ret;
> +       bool have_eopnotsupp =3D false;
>
>         src_oloc.pool =3D src_ci->i_layout.pool_id;
>         src_oloc.pool_ns =3D ceph_try_get_string(src_ci->i_layout.pool_ns=
);
> @@ -2987,54 +3011,190 @@ static ssize_t ceph_do_objects_copy(struct ceph_=
inode_info *src_ci, u64 *src_off
>         dst_oloc.pool_ns =3D ceph_try_get_string(dst_ci->i_layout.pool_ns=
);
>         osdc =3D &fsc->client->osdc;
>
> -       while (len >=3D object_size) {
> -               ceph_calc_file_object_mapping(&src_ci->i_layout, *src_off=
,
> -                                             object_size, &src_objnum,
> -                                             &src_objoff, &src_objlen);
> -               ceph_calc_file_object_mapping(&dst_ci->i_layout, *dst_off=
,
> -                                             object_size, &dst_objnum,
> -                                             &dst_objoff, &dst_objlen);
> -               ceph_oid_init(&src_oid);
> -               ceph_oid_printf(&src_oid, "%llx.%08llx",
> -                               src_ci->i_vino.ino, src_objnum);
> -               ceph_oid_init(&dst_oid);
> -               ceph_oid_printf(&dst_oid, "%llx.%08llx",
> -                               dst_ci->i_vino.ino, dst_objnum);
> -               /* Do an object remote copy */
> -               req =3D ceph_alloc_copyfrom_request(osdc, src_ci->i_vino.=
snap,
> -                                                 &src_oid, &src_oloc,
> -                                                 &dst_oid, &dst_oloc,
> -                                                 dst_ci->i_truncate_seq,
> -                                                 dst_ci->i_truncate_size=
);
> -               if (IS_ERR(req))
> -                       ret =3D PTR_ERR(req);
> -               else {
> +       num_objects =3D len / object_size;
> +       if (!num_objects)
> +               goto out;
> +
> +       /*
> +        * Snapshot the window size once.  A concurrent sysfs write to
> +        * copyfrom_max_inflight must not be able to shift the window bou=
nds
> +        * mid-copy: that would corrupt the ring-buffer bookkeeping and c=
ould
> +        * index past reqs[].
> +        *
> +        * Parallel requests can write destination objects beyond the fir=
st
> +        * failure before the failure is detected.  That is only harmless
> +        * when the copy starts at or beyond the destination EOF: the exc=
ess
> +        * objects end up beyond the new (truncated) EOF and are unreacha=
ble
> +        * through reads.  When copying into the middle of an existing fi=
le,
> +        * the excess objects would clobber live data on failure, so such
> +        * copies are submitted serially (window of 1).
> +        *
> +        * This assumes the destination size is stable for the duration o=
f
> +        * the copy.  CephFS does not serialize concurrent size updates -=
-
> +        * FILE_WR caps are shared among clients and no inode/MDS lock is
> +        * held across the copies -- but concurrent modification is outsi=
de
> +        * copy_file_range()'s guarantees, and the pre-existing serial
> +        * implementation was equally racy in that case.
> +        */
> +       max_inflight =3D copyfrom_max_inflight;
> +       if (!max_inflight)
> +               max_inflight =3D 1;
> +       if (orig_dst_off < i_size_read(&dst_ci->netfs.inode))
> +               max_inflight =3D 1;
> +
> +       reqs =3D kvmalloc_array(max_inflight, sizeof(*reqs), GFP_KERNEL);
> +       if (!reqs) {
> +               bytes =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       /*
> +        * Sliding window: submit requests up to max_inflight, then wait =
for
> +        * the oldest in-flight request to complete before submitting mor=
e.
> +        * The reqs[] ring buffer is indexed by (slot % max_inflight), so
> +        * memory is bounded to max_inflight regardless of num_objects.
> +        * First-failure and EOPNOTSUPP detection happen inline =E2=80=94=
 no post-scan
> +        * needed.
> +        */
> +       /*
> +        * Drain only the valid window: stop once all in-flight requests =
are
> +        * waited on (head =3D=3D tail) and no new submission can follow,=
 instead
> +        * of walking head past the tail over freed/never-filled slots.
> +        */
> +       while (head < tail ||
> +              (tail < num_objects &&
> +               first_fail_obj =3D=3D U64_MAX && alloc_fail_obj =3D=3D U6=
4_MAX)) {
> +               /* Submit new requests while the window has room */
> +               while (tail < num_objects &&
> +                      first_fail_obj =3D=3D U64_MAX && alloc_fail_obj =
=3D=3D U64_MAX &&
> +                      inflight < max_inflight) {
> +                       u64 object_src_off =3D orig_src_off +
> +                                            (u64)tail * object_size;
> +                       u64 object_dst_off =3D orig_dst_off +
> +                                            (u64)tail * object_size;
> +
> +                       ceph_calc_file_object_mapping(&src_ci->i_layout,
> +                                                     object_src_off,
> +                                                     object_size,
> +                                                     &src_objnum,
> +                                                     &src_objoff,
> +                                                     &src_objlen);
> +                       ceph_calc_file_object_mapping(&dst_ci->i_layout,
> +                                                     object_dst_off,
> +                                                     object_size,
> +                                                     &dst_objnum,
> +                                                     &dst_objoff,
> +                                                     &dst_objlen);
> +                       ceph_oid_init(&src_oid);
> +                       ceph_oid_printf(&src_oid, "%llx.%08llx",
> +                                       src_ci->i_vino.ino, src_objnum);
> +                       ceph_oid_init(&dst_oid);
> +                       ceph_oid_printf(&dst_oid, "%llx.%08llx",
> +                                       dst_ci->i_vino.ino, dst_objnum);
> +
> +                       /* Do an object remote copy */
> +                       slot =3D tail % max_inflight;

Hi Xiubo,

This and the other 64-bit division below don't compile on 32-bit:

    ERROR: modpost: "__umoddi3" [fs/ceph/ceph.ko] undefined!

I think you would need to employ div_u64_rem() or similar.

Thanks,

                Ilya

> +                       req =3D ceph_alloc_copyfrom_request(osdc,
> +                                               src_ci->i_vino.snap,
> +                                               &src_oid, &src_oloc,
> +                                               &dst_oid, &dst_oloc,
> +                                               dst_ci->i_truncate_seq,
> +                                               dst_ci->i_truncate_size);
> +                       if (IS_ERR(req)) {
> +                               /*
> +                                * Remember the allocation failure and st=
op
> +                                * submitting.  In-flight requests may st=
ill
> +                                * carry a real I/O error for an earlier
> +                                * object; the drain loop records it and =
it
> +                                * takes precedence over this failure whe=
n the
> +                                * result is reported.
> +                                */
> +                               alloc_fail_obj =3D tail;
> +                               alloc_fail_err =3D PTR_ERR(req);
> +                               reqs[slot] =3D NULL;
> +                               tail++;
> +                               continue;
> +                       }
>                         ceph_osdc_start_request(osdc, req);
> -                       ret =3D ceph_osdc_wait_request(osdc, req);
> +                       reqs[slot] =3D req;
> +                       tail++;
> +                       inflight++;
> +               }
> +
> +               /*
> +                * Wait for the oldest in-flight request (FIFO order).
> +                * This is required for correctness: we must determine th=
e
> +                * first failure in object-offset order to know how many
> +                * bytes were successfully copied.  It does not hurt
> +                * performance because all requests in the window are
> +                * submitted concurrently -- later requests complete in
> +                * the background while we wait, so the wall-clock time
> +                * is dominated by the slowest request, not the sum.
> +                */
> +               slot =3D head % max_inflight;
> +               if (reqs[slot]) {
> +                       ret =3D ceph_osdc_wait_request(osdc, reqs[slot]);
>                         ceph_update_copyfrom_metrics(&fsc->mdsc->metric,
> -                                                    req->r_start_latency=
,
> -                                                    req->r_end_latency,
> +                                                    reqs[slot]->r_start_=
latency,
> +                                                    reqs[slot]->r_end_la=
tency,
>                                                      object_size, ret);
> -                       ceph_osdc_put_request(req);
> -               }
> -               if (ret) {
> -                       if (ret =3D=3D -EOPNOTSUPP) {
> -                               fsc->have_copy_from2 =3D false;
> -                               pr_notice_client(cl,
> -                                       "OSDs don't support copy-from2; d=
isabling copy offload\n");
> +                       ceph_osdc_put_request(reqs[slot]);
> +                       reqs[slot] =3D NULL;
> +                       inflight--;
> +
> +                       if (ret =3D=3D -EOPNOTSUPP)
> +                               have_eopnotsupp =3D true;
> +
> +                       if (ret < 0 && first_fail_obj =3D=3D U64_MAX) {
> +                               first_fail_obj =3D head;
> +                               first_fail_err =3D ret;
>                         }
> -                       doutc(cl, "returned %d\n", ret);
> -                       if (bytes <=3D 0)
> -                               bytes =3D ret;
> -                       goto out;
> +                       if (ret)
> +                               doutc(cl, "object %llu returned %d\n", he=
ad, ret);
>                 }
> -               len -=3D object_size;
> -               bytes +=3D object_size;
> -               *src_off +=3D object_size;
> -               *dst_off +=3D object_size;
> +               /*
> +                * A NULL slot means the object was never submitted (its
> +                * allocation failed, or submission stopped after a failu=
re)
> +                * or was already drained -- just skip past it.
> +                */
> +               head++;
> +       }
> +
> +       /*
> +        * Determine bytes copied: all objects before the first failure
> +        * succeeded.  An allocation failure is only reported if no earli=
er
> +        * in-flight request failed, so a real I/O error is never masked =
by
> +        * -ENOMEM.
> +        */
> +       if (first_fail_obj =3D=3D U64_MAX && alloc_fail_obj !=3D U64_MAX)=
 {
> +               first_fail_obj =3D alloc_fail_obj;
> +               first_fail_err =3D alloc_fail_err;
> +       }
> +       if (first_fail_obj =3D=3D U64_MAX)
> +               bytes =3D (ssize_t)num_objects * object_size;
> +       else if (first_fail_obj =3D=3D 0)
> +               bytes =3D first_fail_err;
> +       else
> +               bytes =3D (ssize_t)first_fail_obj * object_size;
> +
> +       /*
> +        * Deferred until after the drain loop, but safe: any request
> +        * failure stops new submissions, so no COPY_FROM2 requests are
> +        * sent after EOPNOTSUPP was seen, and the flag is cleared before
> +        * this function returns.
> +        */
> +       if (have_eopnotsupp) {
> +               fsc->have_copy_from2 =3D false;
> +               pr_notice_client(cl,
> +                       "OSDs don't support copy-from2; disabling copy of=
fload\n");
>         }
>
> +       if (bytes > 0) {
> +               *src_off =3D orig_src_off + bytes;
> +               *dst_off =3D orig_dst_off + bytes;
> +       }
>  out:
> +       kvfree(reqs);
>         ceph_oloc_destroy(&src_oloc);
>         ceph_oloc_destroy(&dst_oloc);
>         return bytes;
>
> ---
> base-commit: fc67edb66b3c9924c4e0bb366a92b32ea13c526a
> change-id: 20260720-b4-ceph-copyfrom-c8680b2d6616
>
> Best regards,
> --
> Xiubo Li <xiubo.li@clyso.com>
>
>
