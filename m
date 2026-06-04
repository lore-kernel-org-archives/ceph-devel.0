Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFFA3C09E2
	for <ceph-devel@vger.kernel.org>; Thu,  4 Jun 2026 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602004; cv=none; b=Lwlc7NWDuHyQ81Jwe7u5rExdMtjXCFwvzOybQ4prJYkGsQLD6eIEzMg4oTjG0AikKGlR2EJNfZrUVv3rR4t/QKrwID3UWbzHXRA4QIz3doSwf5vBLm8g5/tqXXFcc5jhcrmczJUwzByeTBBRsy/uen7eQp7LzVti0vDREpWIcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602004; c=relaxed/simple;
	bh=8qEtAfPXFzrOiS3Nor1eRFsLcwkGirTWHx1OkNW/w0c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u/x1iCCv2Ca86smLX49/NXP/Wx6+BGDNW0jr0qzohmbYEeFvEDDvhNtzbVkoK/aZYeShH6+GCTL+eKj4/v+cHEc9VOoxxfK1+zzIaqn7tb+XeznomrR/8frFbZhZjU65Xd+BUmp2+tRp85SDPt90YK72a/XSBxTIACZAs6LTsiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=JODvaTMn; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="JODvaTMn"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7dc67a5e102so12904167b3.1
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jun 2026 12:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780602001; x=1781206801; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SRDNF4XRsMILyeqd8pnV5EZ+1ao3z9JQnVe7XDtSGA4=;
        b=JODvaTMn8TtbkSaHQ8oXNhena2H0/y0DT7nUklBbRl9DUENsKeE4QrXAz+HKM80EpZ
         EBdilWaqc28Yp1T4t1V61M1bNj2Ho7B3pG2jqBEKo/VW1Nmg8yEtOrXh0nhQY3kD2MsR
         KpznZuACjiAme0BIAzQSar/uIG7UZ/UopXx6FaiSuRdt1vAFdNGNMY0z4C32c6n+nap/
         4n8kRcN5k8HjgHo8+5oSjIyhL/5D5mUDdIbsVM4x1205kuS68s8d+ni30P7xRGpUMKMe
         8e3/9+U+Ke5aVPJlpGcPdpr29zZFaqbr5JlawbqOqBnTTFd3R+soXlFf4uDuMymu2R2S
         lxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780602001; x=1781206801;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRDNF4XRsMILyeqd8pnV5EZ+1ao3z9JQnVe7XDtSGA4=;
        b=Ma5kAOdoGN6bgpmZDiVw1ZXf4XTzWqwZhPXRpilCSwjwBsShDKYRYcYFGUQneFXNud
         Now34CsulsrVXJ6V/P4TxrhXHpxT+GqpM4vpKn/hjjZG0zJB6UsrCdeoin4j0v9XZn0i
         0MDYxP8eGbxuzOnTejIdBVmsJpVLvrBGxcelL1f9wN41gkyehwF1NuWcK0wDhAMUd02+
         U4w7m2jKfhgvglvuWwTGQMIvODiX0dv3iSxKLoYCjwGkBp73NtHnX0bVnAB07302836k
         xdUa6Ti6doozSTxm0S+m54EVQG1q3eibew7uFevwwLFdFmko66acMNVEBkhmtGOnp5tX
         AsIA==
X-Forwarded-Encrypted: i=1; AFNElJ9OhWUXUwSAF57urZQQ9eEwh2tzbhdPQr9t6baaADqbfogTlxGWBnhm7KvmPafPz+achQh+z8RAr5WG@vger.kernel.org
X-Gm-Message-State: AOJu0YwhiQAuRlOZeRp6C/VC1/qxyHHul4Es4noT+heJT/av74hZh3wL
	PSyEqOw3cH4RVarvWenXl6YBhKUOmXXQIr+NFKPiXSN+2kaQ0b1vSQQLyueQaP0IweE=
X-Gm-Gg: Acq92OGXCvACo10/Jxy/5wTyQ3UBkHcMR+w6c/LOEY/OiMl2gG/waFoDWYm2DkD4V8s
	SXfEZuJq0pF7H2HQ+U+7Qj1KcQZUNNE87eeSan9AAMmaU1coLvolzTLIxiLYb7L3HostOhY2WhD
	u9Om8q+VX/QHo72WTAecQam6HxO3g24ScCizOybiX5oBQ8j/uYSiaL8VZByQzTnzQkTH/JLJiLL
	xTtvBdDg1zOp7eoSeUU0w9ODxM/OXq5LkFJN7/1fJcPRpUc5RRBPtvmv1Rztiby8hcH9+QftV8G
	iZNX1MpZtRENJFa0ixzdWPy6KL51rtzxItcjVJegOKnRDbhLsqYXcqVLEEUT1IGH0PTZPqUmWvq
	KMJfZlrknF9YGqVoyGX+5ulvdr9ZcQIfdSn+TwpLKXniXAC9d8/birVNJTKjOYsg0iV1GKURRTm
	d+k/dykhbvHBGHnckKHeP8dbgMdpgj9oJ4AhzgZ0GLxg9pBBokZxNnt4AiVSb6sdUlorqlTMK22
	+9PmCDYgV1vUYEQgZ/8kNyJIrm3tkGnei4ThXBiIU/sTaFU15thdacbsdkBCwsgCIU8tjc=
X-Received: by 2002:a05:690c:6a8a:b0:7bd:7e01:8d53 with SMTP id 00721157ae682-7ed0d7b44acmr3408487b3.19.1780602001421;
        Thu, 04 Jun 2026 12:40:01 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:ae19:b6b2:5990:ed2a? ([2600:1700:6476:1430:ae19:b6b2:5990:ed2a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea2409db52sm38739517b3.44.2026.06.04.12.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:40:00 -0700 (PDT)
Message-ID: <d00df2ed85205662ba17a3f9a37b273277db8528.camel@dubeyko.com>
Subject: Re: [PATCH v4 1/2] libceph: reject zero bucket types in crush_decode
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Ren Wei <n05ec@lzu.edu.cn>, Viacheslav Dubeyko <vdubeyko@redhat.com>, 
	ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, amarkuze@redhat.com, sage@newdream.net, 
	Slava.Dubeyko@ibm.com, yuantan098@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, 	ldy3087146292@gmail.com
Date: Thu, 04 Jun 2026 12:39:59 -0700
In-Reply-To: <8fbe4d61ba313a26.1780473720.git.ldy3087146292@gmail.com>
References: <8fbe4d61ba313a26.1780473720.git.ldy3087146292@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-04 at 11:18 +0800, Ren Wei wrote:
> From: Douya Le <ldy3087146292@gmail.com>
>=20
> CRUSH bucket type 0 is reserved for devices.=C2=A0 The mapper relies on
> that invariant and uses type 0 to identify leaf devices.
>=20
> If crush_decode() accepts a bucket with type 0, a malformed CRUSH map
> can make the mapper treat a negative bucket ID as a device and pass
> it
> to is_out(), causing an out-of-bounds access when indexing the OSD
> weight array with a negative value.
>=20
> Reject zero bucket types while decoding the CRUSH map so the invalid
> state never reaches the mapper.
>=20
> Define the reserved device type as a standalone named constant
> instead
> of mixing it into the bucket algorithm enum.
>=20
> Fixes: f24e9980eb86 ("ceph: OSD client")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Douya Le <ldy3087146292@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>=20
> ---
> Changes in v4:
> - define CRUSH_ITEM_TYPE_DEVICE as a standalone constant instead of
> =C2=A0 putting it in the bucket algorithm enum
> - move the remaining type-0-to-constant cleanups into a separate
> patch
> - v3 Link:
> https://lore.kernel.org/all/d21e2f97dfe6f250.1780369814.git.ldy3087146292=
@gmail.com/
>=20
> Changes in v3:
> - use CRUSH_BUCKET_DEVICE instead of CRUSH_ITEM_TYPE_DEVICE
> - v2 Link:
> https://lore.kernel.org/all/3200151429f33554f06ced8a.1780197742.git.ldy30=
87146292@gmail.com/
>=20
> Changes in v2:
> - use CRUSH_ITEM_TYPE_DEVICE instead of hardcoded 0
> - v1 Link:
> https://lore.kernel.org/all/4ad15b49fbbae00d86dfe12348bf94d45aa60ac2.1779=
949116.git.ldy3087146292@gmail.com/
>=20
> ---
> =C2=A0include/linux/crush/crush.h | 4 +++-
> =C2=A0net/ceph/osdmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 2 ++
> =C2=A02 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/crush/crush.h
> b/include/linux/crush/crush.h
> index
> 30dba392b7302de3e14861f8b769242cd8cbac9e..76bd1fa036538df86d548b1c668
> 163035c30ade6 100644
> --- a/include/linux/crush/crush.h
> +++ b/include/linux/crush/crush.h
> @@ -110,6 +110,8 @@ struct crush_rule {
> =C2=A0 *=C2=A0 straw=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 O(n)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 better=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 better
> =C2=A0 *=C2=A0 straw2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 O(n)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 optimal=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 optimal
> =C2=A0 */
> +#define CRUSH_ITEM_TYPE_DEVICE 0

If I understood correctly, the b->type field encodes the CRUSH topology
type (host, rack, row, datacenter, etc.). So, I think to have enum will
be much better here.

Thanks,
Slava.

> +
> =C2=A0enum {
> =C2=A0	CRUSH_BUCKET_UNIFORM =3D 1,
> =C2=A0	CRUSH_BUCKET_LIST =3D 2,
> @@ -130,7 +132,7 @@ extern const char *crush_bucket_alg_name(int
> alg);
> =C2=A0
> =C2=A0struct crush_bucket {
> =C2=A0	__s32 id;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* this'll be =
negative */
> -	__u16 type;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* non-zero; type=3D0 is rese=
rved for devices
> */
> +	__u16 type;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* non-zero; CRUSH_ITEM_TYPE_=
DEVICE is
> reserved */
> =C2=A0	__u8 alg;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* one of CRUS=
H_BUCKET_* */
> =C2=A0	__u8 hash;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* which hash funct=
ion to use, CRUSH_HASH_*
> */
> =C2=A0	__u32 weight;=C2=A0=C2=A0=C2=A0 /* 16-bit fixed point */
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index
> 8b5b0587a0cfa2c437b76c8c87251199efe20291..21cdd33f2945e0c1f45277ac05f
> da373bf217586 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -518,6 +518,8 @@ static struct crush_map *crush_decode(void
> *pbyval, void *end)
> =C2=A0		ceph_decode_need(p, end, 4*sizeof(u32), bad);
> =C2=A0		b->id =3D ceph_decode_32(p);
> =C2=A0		b->type =3D ceph_decode_16(p);
> +		if (b->type =3D=3D CRUSH_ITEM_TYPE_DEVICE)
> +			goto bad;
> =C2=A0		b->alg =3D ceph_decode_8(p);
> =C2=A0		if (b->alg !=3D alg) {
> =C2=A0			b->alg =3D 0;
