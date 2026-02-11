Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B1C3EBF3C
	for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2026 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770819065; cv=pass; b=mrohTKtLHNxmgvT2jglf5erYfXv4L5HhRSJucqG3kHPSvh7iiuMac+jDGgd9kY4vGBRME6id+GxxeM5uFzTW6hwZTh5m6DaYxPiNYjZoIaZR+yEek+9NwMZIiiQZUw9aThUDfpSoPm/rywU6KWTrmH1mfv57+e9MTGLhfffmsMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770819065; c=relaxed/simple;
	bh=HGalqsLDx05eHACnNuEvrSN2qaYfOA2CfqzUgPN10Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qF8ywJc2oqKy7jes/vL3/FJ5lEwL4JHEemIePNV+4igtNvVg4hjKDB7kQl+oLinjeJSXJVnaZd3apUDI0Dk0Z+ksj7UnWkWaSEibW+4h2kutbyeBoqwPnwSvwGQqLBXM+emEtweSJ548orxJxHQ6F6eNnIB2peyshQC+qv1vAR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LccLdpZY; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LccLdpZY"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-124899ee9d3so727543c88.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2026 06:11:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770819062; cv=none;
        d=google.com; s=arc-20240605;
        b=DW0D/86Jxqc8b0j2+mU0XU8As2sVwrRIS0xPvGjouxZlz50wEoSsNEyH2M6r8i2Vqy
         2+hKjFuZ+t+Vph9bf2tEVpCPDfvHjL65Tg167lOzlHWu+e+9oaoCLARWj7gz0tfusmAd
         j2h4XBNB9lMzq8lBYgrTOhry74cZrk41izIwVBGY33GsSyQw58A2REVC03LfPbFZ9V+o
         bz0PSoIRaIDGuqtW9Zd7TBE92KeyzcunpbKtgbJHPZrp0sXTfosrYUuz4GaBNvgMq8/4
         Q7grle0Hh833e/2hNyuSGJ2363Hfft42wJaPD1OCCjMfdQXJdx3GV5vl8JbDBdj9kCN9
         BJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OKIseXHRmyCS6dHGzDMjOY6Hc3lPPbRWiScTys09X+g=;
        fh=ZB52FERe7PUmowJJpnlFObV7DQI20Ga4jrNa9s7r9i4=;
        b=MPcCq8WY/OZYuEOpP3j4Cwt1zmjZc5t9wJkdaFbq8O9J0ws08MiETf/EjzfphylFY2
         0GF+xDGqks2/8/a2qVHkDGXX4NSWvNy1phMH48jJXfHhuKPENwme2+jXu44WlN0AtIzV
         dok9Uh9RJwlsdjiYPQ8eYEaT7MPuo5M2/DTtOivRIrLb/rJ0GpW09EorMsmZ3NlNvmuY
         bofQmo81eO8gvCgxUMm/WX9hq7a5BigPLcXnF6kXeH31coIJB+aU0/XS/Mqjqf/Zd0Bz
         ry+cebinJ3/F/ZpK7+DAtMsOzM8FtVRc4lYZ05YYC9/pwtQCfATPS7Dcfhd5uVSTf0tN
         p6DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770819062; x=1771423862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKIseXHRmyCS6dHGzDMjOY6Hc3lPPbRWiScTys09X+g=;
        b=LccLdpZYYOkWUJzWbk+TxwcRKtRAWM4GSaZoFr2Go6EMDhOBrfCurEg7Qu+qwtqxZI
         IZByxe10LUC/770DAcrSm/hv6sxgL8eNxQPblJb3brRAtetlsbh+ZvMy+murpkLrztqQ
         zoJ9HxgduNCsphe1w3ZaCRT/QLTNgalM01lKE5nQaycc3LXB2uweRtu9HDo3/yCK/4J7
         r35bQlVebwiLOTldlMnVzRP6WaYS6xDwxjPl3S4Sy0e6IvQ9CjaagfKnhRl1xLwgOQOy
         F3oqdawF/hbFdccMC2c346MYy5FjK9iLqvWl9Jg8KcZN1L0ciZitcbkcc/6MqqG78Xy2
         9Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770819062; x=1771423862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OKIseXHRmyCS6dHGzDMjOY6Hc3lPPbRWiScTys09X+g=;
        b=RLMda6DQ72uvizRSBhkl2eWWLPLcwWLX+vlNQuYzp6TrPxeI6W5VNDaANQtbANCsbw
         Z+wJnXhOFTKyoOB5ZUa2E26EYIDVJZ1m6MuK/wstzMg239ZZwQu/8X/91a0lyIMO7Vvs
         vo8pjCbqG5H2gzKQBqVjA8jPXAwrZ7W1YPE9PeWqLua5ZJQek6DYQX1Hxzrfgrhnwgim
         CaRoaHD/+DFWaM7kiiBNjH2vlmDAN/0zVvFkcW3VPTLC2UMOm4izTxIDpWUS8bzsw2t0
         Y5bI4tcDgH27yoEgABk5d7tXaTIFx8efkM8EHznvSzX2FA8EtMlql2cBAnJhmkiTHIqW
         NNQw==
X-Forwarded-Encrypted: i=1; AJvYcCVN69TOYXwlvhwuJc7nvfJHXFNeCmLvn4iotl2wXj8xj1OVgcKHL19gDksBssoQC45vWwrutx/82oAT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ZTkNiEJTDfBcg17mKEmST5K16lTR+ideYbkdL4kdposCI7kv
	hkj7ujv6zP4X7fFc5zcDLqnflLDymvLJZgP6jMtJ7QvQFU3OFojkFsImnCCmuJKz/wQOvtTTpID
	4Nsgt/pHi/cYQd6/q8F+S6Oj09SqPdsE=
X-Gm-Gg: AZuq6aKD1sM8iO5VK6Vvx59mXTbFRGfATNn52UlszMpsd/a/kvcz2Y8NPL+0sAp+W4W
	F41TjdLmreaId/9NCp6mhTrxuJWF45G1TSSTdESznATmJ66vvFbbZsbQa9lLEls6qpTMuy2L5YA
	TfvdeDGxiirP9CM13QbL4E6to/qcmoLzWfknnhwZjHXCIymM/QiNhe6pFwaxrArx2gL/TgxXFWx
	HEjmYk/DN9vZUs7Lmr/g46HCrRz4VOJjIDsLetmPAn3+VyWspc7o0q0zIl3xbEEN2G/HVMAxULq
	iAsDu6jYqb0IBr4b6Q==
X-Received: by 2002:a05:7022:211:b0:11b:a8e3:847b with SMTP id
 a92af1059eb24-127240d1eedmr2212706c88.5.1770819062264; Wed, 11 Feb 2026
 06:11:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126022715.404984-1-CFSworks@gmail.com> <20260126022715.404984-2-CFSworks@gmail.com>
In-Reply-To: <20260126022715.404984-2-CFSworks@gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 11 Feb 2026 15:10:50 +0100
X-Gm-Features: AZwV_QhAs7em2PWlsOnMf3pcdJp5wd8MKB4Albp0QFwLsdVduX4z8P0balC06BI
Message-ID: <CAOi1vP_2asCJyLOZH0GP=u8gRLU6jqnS-hC-R7ayjPOkk0zc0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ceph: free page array when ceph_submit_write() fails
To: Sam Edwards <cfsworks@gmail.com>
Cc: Xiubo Li <xiubli@redhat.com>, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	Christian Brauner <brauner@kernel.org>, Milind Changire <mchangir@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 3:27=E2=80=AFAM Sam Edwards <cfsworks@gmail.com> wr=
ote:
>
> If `locked_pages` is zero, the page array must not be allocated:
> ceph_process_folio_batch() uses `locked_pages` to decide when to
> allocate `pages`, and redundant allocations trigger
> ceph_allocate_page_array()'s BUG_ON(), resulting in a worker oops (and
> writeback stall) or even a kernel panic. Consequently, the main loop in
> ceph_writepages_start() assumes that the lifetime of `pages` is confined
> to a single iteration.
>
> The ceph_submit_write() function claims ownership of the page array on
> success (it is later freed when the write concludes). But failures only
> redirty/unlock the pages and fail to free the array, making the failure
> case in ceph_submit_write() fatal.
>
> Free the page array (and reset locked_pages) in ceph_submit_write()'s
> error-handling 'if' block so that the caller's invariant (that the array
> does not remain in ceph_wbc) is maintained unconditionally, making
> failures in ceph_submit_write() recoverable as originally intended.
>
> Fixes: 1551ec61dc55 ("ceph: introduce ceph_submit_write() method")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  fs/ceph/addr.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 63b75d214210..c3e0b5b429ea 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1470,6 +1470,14 @@ int ceph_submit_write(struct address_space *mappin=
g,
>                         unlock_page(page);
>                 }
>
> +               if (ceph_wbc->from_pool) {
> +                       mempool_free(ceph_wbc->pages, ceph_wb_pagevec_poo=
l);
> +                       ceph_wbc->from_pool =3D false;
> +               } else
> +                       kfree(ceph_wbc->pages);
> +               ceph_wbc->pages =3D NULL;
> +               ceph_wbc->locked_pages =3D 0;

Hi Sam,

While I don't see anything wrong with the patch per se, I can't help
but question the existence of this entire branch along with the meaning
of the error.

ceph_writepages_start() is the only caller of ceph_submit_write() and
it already calls ceph_inc_osd_stopping_blocker() at the top where the
error can be handled naturally -- nothing needs to be unlocked or freed
at that point.  Since mdsc->stopping_blockers is just a counter, all
calls made by ceph_submit_write() invocations in a loop would be
"contained" within that ceph_writepages_start() call.  The only benefit
achieved is potentially faster response to the MDS client moving to
CEPH_MDSC_STOPPING_FLUSHING state, but it's rather dubious because
sneaking in/having to wait for some more OSD requests isn't really the
end of the world.

Rather than patching the error path, I wonder if instead of calling
ceph_inc_osd_stopping_blocker() the counter could just be incremented
unconditionally, with the check for CEPH_MDSC_STOPPING_FLUSHING bypassed
there?  This could be wrapped into a new helper that could also assert
that the counter is already elevated before the increment.

Thanks,

                Ilya
