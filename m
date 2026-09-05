Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6010C165F1A
	for <ceph-devel@vger.kernel.org>; Sat,  5 Sep 2026 01:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573165; cv=pass; b=X3MNm+UYyqLOIBTm+RmrY08rauwwGIXtiMTHQrW3aL852+tWl0gIAhFccWMsFkNnDlfgMye7c40aK28mq27cbmDuaC7Y7a6PD62HkxWJmvU2AcF2D/Aw2Oza83HxZ00rCEObLKi3fDsTE8eqVxeOz4xRwT3IZg96mbmM3tDPRKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573165; c=relaxed/simple;
	bh=wubeqTfIk5VUBpRsWPXRo7LgM8grLWk4CjJuaRVPQxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWf8+Sw/qwfCYIvepbs9x2ilJ7w7seba5oc/uzDG3G/tigj50D1Sfzp2abtfMoPk80ki0Pcjex6seh4ocwVDFNcDzmoYP7igGbpICPXc1ZLjGKCeHRPXPv4cQQp9Fh7zGzK85qW7BVU6m1NaKhqeTb9GPaeLrLE+1+LAcPNNCiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=XiaUz7xn; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="XiaUz7xn"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c207cb16cf5so251167466b.1
        for <ceph-devel@vger.kernel.org>; Fri, 04 Sep 2026 18:52:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788573162; cv=none;
        d=google.com; s=arc-20260327;
        b=AaiVKkMm+KVI6qUaE5SiOUb+WL7GmtGt3Ag4aBPU0BaAWkOLlu6n1EyFFMQjAUu/6q
         4/dRaGHW6QW74nm2V4n5KKbwFw4Ddj3ZSehWjB2jFaStf4Qe8l5VmRv3bOACbK9KZj0K
         Wg/RSf1nA/kkr4eI8TU9RVDiRJqB/0QhdHVdWysgtob1/s97+JJ/fAubvjoourHskFWH
         P3+SEsMiyl9G+fGyLuedqeR59x/df24Z5Q+w3T3d/Ho/tF2gRF0sET5NeCf48RnFhKPD
         OplU+EzKWtqXC0Cr1YIQ3jcxaXLDOT98fWx2CzQzGCePy+70gaElK2vZ/wquwuAGLYSM
         kX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yHC93WnHgZ8Dku4rdXUYkGVO/HeKiiDgrDdPTJNxOKw=;
        fh=grFt1DOGsz5/0Q3tU2+swqdr8kfjchgQM2o0+nkj5z4=;
        b=Q4kF17omhh17tUtVd3B0S4AJ23x8s0MbeXxWt6aIlEay/lqinXTCnNe+troWLoXLY4
         mP8zyvhYQwEse7uRnMRc/IByxdo0IXQXT5kn4jM6TnX6it2BG9lZ5QriFYCgnHDe9h1e
         O63uKoJPwWtyN6IlUsUimul/Dlf1bwHz6Yd0RJMjz066xOO6Tc3sI3iLSf1Gu1Kdnrgk
         waqgPOa79kefjFjaaI3v85RN9GqEd7fCxRGblKocC3jT16XxrUWJckiaAr9IsCSd71Ox
         y18a3S9i6GKobDG6D/OFOiKqE8r5jW+FJXBiEMrlQgm7oPGhOckBB5lZxX8XMxhM1xZK
         IJ7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788573162; x=1789177962; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHC93WnHgZ8Dku4rdXUYkGVO/HeKiiDgrDdPTJNxOKw=;
        b=XiaUz7xnerBLKp3FnHsA0tR4fYK6OnVBLJSL4Qm0gmYVzKVMygv2XfDVqzZMJyIAis
         TrxnEiRbo7kq1b1syqomuKcRtY1/E7XHAE6ckd8aOYzsPnf3/SGGUZq39GJsX90T8GVk
         7s6SBE83Wl4mMiOCk7VdABVVYGt3Oq1ExPWdhQTcu2V8Q7qpyIX6AxsdjCFyo+7wq5eI
         UdllKB4SeQoy8No1U4qVmWPTiS92u4CtRQgBMK6WRq7yUB7uV1qR6FXGsjRidqE6AwZ7
         z5CTeQpmATThRgVhqID8GGRm32RpPpu9+vtVI5HWJwoXfL14bdRfBM7KcRGqmhYDDapw
         /D7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788573162; x=1789177962;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yHC93WnHgZ8Dku4rdXUYkGVO/HeKiiDgrDdPTJNxOKw=;
        b=aidtHLDvBXD3W0auAmzw1JwH0FuXLx8iTy5Im9OALZC/DFF/ZGXohJQZAT9F1JIMTb
         uLf5FdbcKR7OTKbTRCv8WNe3TIOb+waI863K058QYl+UNo2cQ9KWlsKLexzYqfCiNqqo
         V1fs8T2GdyNRWtuJk7PfPxShKVCmSJa7eVa9MSxtfmVAvpmeho//At6CPfmqye0PqyRo
         XYrkvyUJfqd4AmHH+Xs+qSSA3w+CX+rcTzTOdh7Ojf0Gq6eRgW0KzWWZLdu1sQxlXn3l
         zI433+/1/0+nqlM+1DHeqY5TKJQ7T2IYIaq8jGO+2A98vxcDKJ6mAsPlZPYwtrbC8s1R
         RgEQ==
X-Forwarded-Encrypted: i=1; AKwUvByL/E4DgI1x5jIoTrBU6i+6B0j4ymoeQbDVV1oQT3nvj5faCGsmtXXhWuBgkKiDg8JavPXheeQ9++uS@vger.kernel.org
X-Gm-Message-State: AFuF++m8fK6QJNHIAnCgnDmjtWMNXlkPAyzLZaBhGGwykT0n/BfW90Zx
	CmKZhQFmNYtb6JKbAaCHyspPD1zDbAEG7iUbTUNbcb3tl9B9VUjnGOkgDjO3ah1DLhyq7iz5JXY
	sAjMb7fEecNrY3WEcp1YK+v4lMD8Z2WV5d/Onbdgblw36Rz3Vbul0gvI=
X-Gm-Gg: AYBFou0Jw4nBVJN71uyF/Ucm42blLEn0GJYae04w3oOGJNekDqonV3J5DNyEHOXe9nF
	ipIy+h1aiTxFsaj+XMA/i5Rj88Hp4lNZM56I0GXuIbcbhpg7+j6X7Sc06aho+Rrip8r5YIkwWAt
	XgPQcUsZCBqd/k9GaqMfB2C9QHwGUrFm6Z7tEc619ehuSMV+fHHWn3cYsGXqufgzVf7f9vQomg9
	+JzOpUgyAjbFOIP3TrnbNx4uUSHX7tDnQeXsSm2c6FoU8yPWnFT8zqYFRcd4zf9Y6eQ60BLAMFB
	re60+uQow6wBUnrF24itCBBTZSLbk1O1FFh16Mze1AS9G/4=
X-Received: by 2002:a17:907:3c8f:b0:c25:4b9c:5ed1 with SMTP id
 a640c23a62f3a-c260c9ab80emr402694966b.12.1788573162537; Fri, 04 Sep 2026
 18:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904150304.49104-1-max.kellermann@ionos.com> <20260904150304.49104-3-max.kellermann@ionos.com>
In-Reply-To: <20260904150304.49104-3-max.kellermann@ionos.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Fri, 4 Sep 2026 18:52:31 -0700
X-Gm-Features: AcwNN1VYV_bsyw2MRCUrfeCHlF3zc7lCehIidBhtYC3IhQAcHeY7tGhIM3OccVE
Message-ID: <CAOJNxRKM-vjeg-MKrNqarpn=HQb2gw1H3-FUxPR3a9E1=Ewy5w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] ceph: stop checking a stale MDS map after dropping mutex
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

LGTM.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

On Fri, 4 Sept 2026 at 08:03, Max Kellermann <max.kellermann@ionos.com> wrote:
>
> check_new_map() drops `mdsc->mutex` in several slow paths.  Another
> map handler can install a newer map and destroy the map being checked
> before the original invocation re-locks the mutex.  Continuing to
> dereference newmap after that results in a use-after-free.
>
> Use the `mdsmap->m_epoch` field to identify stale maps.
>
> Fixes: 2f2dc053404f ("ceph: MDS client")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/mds_client.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index d36a114747ae..86d592f06196 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -5844,6 +5844,7 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                           struct ceph_mdsmap *newmap,
>                           struct ceph_mdsmap *oldmap)
>  {
> +       u32 map_epoch = newmap->m_epoch;
>         int i, j, err;
>         int oldstate, newstate;
>         struct ceph_mds_session *s;
> @@ -5887,6 +5888,8 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                         ceph_put_mds_session(s);
>
>                         mutex_lock(&mdsc->mutex);
> +                       if (mdsc->mdsmap->m_epoch != map_epoch)
> +                               return;
>                         kick_requests(mdsc, i);
>                         continue;
>                 }
> @@ -5898,6 +5901,11 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                         mutex_unlock(&mdsc->mutex);
>                         mutex_lock(&s->s_mutex);
>                         mutex_lock(&mdsc->mutex);
> +                       if (mdsc->mdsmap->m_epoch != map_epoch) {
> +                               mutex_unlock(&s->s_mutex);
> +                               ceph_put_mds_session(s);
> +                               return;
> +                       }
>                         ceph_con_close(&s->s_con);
>                         mutex_unlock(&s->s_mutex);
>                         s->s_state = CEPH_MDS_SESSION_RESTARTING;
> @@ -5921,6 +5929,10 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                                                "mds%d reconnect failed: %d\n",
>                                                i, rc);
>                         mutex_lock(&mdsc->mutex);
> +                       if (mdsc->mdsmap->m_epoch != map_epoch) {
> +                               ceph_put_mds_session(s);
> +                               return;
> +                       }
>                 }
>
>                 /*
> @@ -5936,6 +5948,11 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                         mutex_unlock(&mdsc->mutex);
>                         mutex_lock(&s->s_mutex);
>                         mutex_lock(&mdsc->mutex);
> +                       if (mdsc->mdsmap->m_epoch != map_epoch) {
> +                               mutex_unlock(&s->s_mutex);
> +                               ceph_put_mds_session(s);
> +                               return;
> +                       }
>                         ceph_kick_flushing_caps(mdsc, s);
>                         mutex_unlock(&s->s_mutex);
>                         wake_up_session_caps(s, RECONNECT);
> @@ -5991,6 +6008,8 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                                        i, err);
>                 ceph_put_mds_session(s);
>                 mutex_lock(&mdsc->mutex);
> +               if (mdsc->mdsmap->m_epoch != map_epoch)
> +                       return;
>         }
>
>         for (i = 0; i < newmap->possible_max_rank && i < mdsc->max_sessions; i++) {
> --
> 2.47.3
>
