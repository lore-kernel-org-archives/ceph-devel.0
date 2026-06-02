Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447A3C3C13
	for <ceph-devel@vger.kernel.org>; Tue,  2 Jun 2026 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411080; cv=none; b=UU5KIi30p2uTxRdY2EIfi4BbCchMLb8/lJxyKjJm7mUx4hC+l+Ydf/bsZ1+3jfXCbYGxHwMbPStbsyE+bbP16v0lIiIjtIUFI1jgoIcEwDOmBlS4f7xNrz97vpVrNbNy3xidkRBrX66YlCFh1nj9BNmx9yxKt9SR5RXPbq8RMgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411080; c=relaxed/simple;
	bh=Vws0mWly5atirpe7ZiXO3BUQGuTcxaNpJXBdGfAGFc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/2tZr7i44+PR6xpRWdK5FWF+Mcb8QClJKU5BkwAycjPP5ki5hPHZPFSWmyVY5UEhd+UtKYwKYdfcDTeD6cvF/Q0KzlLH67gNesRbCz50wu/Bjr87r8KLY0WmpDRKuPu4srIFXByBtI+uRaZVfVUFN7hd+esdXV7Sg7QJ91Fvzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=nwq2K/N9; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="nwq2K/N9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1780411070; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=Vws0mWly5atirpe7ZiXO3BUQGuTcxaNpJXBdGfAGFc4=;
 b=nwq2K/N9YUAth433Alm4g6neQiNrDzGsVK3Vgmxymbv7v8yKVWzOhY062JZG7zeJ8blGc
 2KF2qLz49FTROzbVuht4renbBSn9Ejpdc9lsUM/yndkF7sdOXM1LCgN8cZLULbUZgYOyHYC
 fpYuGlpIAo8ObIZ2owo7Clj2I3KY6/2wSGhy5td+bY/NfGLpHCPtKKwU8NiEkRn4icjnYBi
 VihPA0/JgGpZ9HtE8En8Y/IzJvENkCMmP8Ry1hxIpKg/i8uOYNZhAE3Z++3Rbn9gOzac7n+
 rFpgtqTzYv/gFmjwwa2JKoHeaXPDRO/OuSRjyKHGpCePKG3YES6Jsk7namhg==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id F3B3B5FB1A
	for <ceph-devel@vger.kernel.org>; Tue,  2 Jun 2026 16:37:49 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 376FB5FC82;
	Tue,  2 Jun 2026 16:37:39 +0200 (CEST)
Message-ID: <80dbf895-2406-4695-a89a-6d0201c948ac@tu-ilmenau.de>
Date: Tue, 2 Jun 2026 16:37:39 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] libceph: reject zero bucket types in crush_decode
To: Ren Wei <n05ec@lzu.edu.cn>, Viacheslav Dubeyko <vdubeyko@redhat.com>,
 ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com,
 sage@newdream.net, yuantan098@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, ldy3087146292@gmail.com
References: <d21e2f97dfe6f250.1780369814.git.ldy3087146292@gmail.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 xsJuBGbf7WYRCAC13DYHSN7ycNggRRKRCt984XSwMykhmw+BxsUfkZiDfWoSimWx5VZB1a4L
 7Tx20uE8iJKiTKZjBZyehk1sly3pbR7/Uqdx43vql2ZRVKYSJSoh9sKlfM178INqc2Vfwm7z
 ObExfJ5WZYAnxVKISBEt1c9q416E8gGYIrVwhMMTBrUF0iNTSoagIcVwJF5gY8LChqcW9S7p
 NQI1k5ISXul9QCEAZxd5bLU5BEx3SFZHvwOv9HN1OPkCBYf5FR3vDt/j8aIhVcHBVR5pbbvw
 5qqsN6/5W8f1nofCF5qu4xv1KRIvbWV4KhRN2e/G1zy3aWP0Eet+YZTFQtOMEVVePSGfAQCS
 +Zvxf1BPEjd+NdDK5N63ITc1bfSF9OdglK/6kpopLQf/YD9p9OE+smNAHrvnGnLBELtXdT+3
 SH7uKzvoeP3YKYRANzzwZt3GP/LugM+YJiyWbNCIEgDvMuEX+UGvsMtlc9ORL01idE6RwbYO
 Z9vvIfUjLr4iUfhmWBb3+9Lzp7xC5XmjxLFMTvxOSjf9jSSsHsk0nmYFLJ1lvb4BvlexQHJm
 voIn9d9eeDFb416HK81rvF0dkHsvAT37pOxlglZnsPei34R6OTVTtbxKi84nL7gCHa5PI73r
 5SZUYZB4SioPJhvtHzeUNzJn15VBnhthD8VpkQCOhrXAUpP9A0SB7BCcx6J08ZjTQo4kiio3
 Ve4xm5Y6rmEX+9TZSi5XAyJ4SAf+PIhfjkXrEpbaYzh8wcPE5gB6Fbbe/0bpjt4+e8uxHz5A
 N3yvrQZtcVca7Zh5LaT6/1aJl6w+2h4D8gP23PMSMrdAMRhmUvjUzwdePupj1/TB1QDaIDM2
 8QCrgBFQk3ToU0pEl5veQ8vqgxWNxQZT95aIN6WR2I4hxREG+QBdyP2XLKY/NGnXJsr+CF0u
 wd863H0ES1AJzy5d9BkcVujcvYDgTW8iEoU4FxJncvUASuyB1sTDrr/gvpVbEe4vl19/Dr9U
 VQ2LLCu2vZvKYGpgUJfcmE1NdDlothLnXmJBNyt8pNYGUDRbuwQ87wMGHCtrFEwJ4pOthi89
 dCr1DaxlC80tUmFwaGFlbCBaaW1tZXIgPHJhcGhhZWwuemltbWVyQHR1LWlsbWVuYXUuZGU+
 wpAEExEIADgWIQR22ZuMUxbN1mZz71M9DZlLGW5CZQUCZt/tZgIbAwULCQgHAgYVCgkICwIE
 FgIDAQIeAQIXgAAKCRA9DZlLGW5CZcxJAP0auhPMmCHeBGIYKaN9ZiWIz6+Y/H78jslypEJ4
 KXaCVAD9HerY+wwfFSNqtomWBZNiy6fp9pmep7ge70HIoKs0PRXOwU0EZt/tZhAIAM5w4a4O
 rFIYXDKuTYct59SYNR48lFL71ENNfbMV7ulu8Xa1GXcgTnZGrMkc6LiNSeki4hV+zIkHClEE
 ESyWytIfTu1xqNJJ73AeWqHPLc3u1Jk9NYQIrCTD5yM+E+xdu5ugT4I7oBRaSd2o10ichv0s
 Z/N3D5RMFYHOMOWawCSBE1vhaaVgNbtmcWZVzVltXeXKwpgNucsBLC0KBlBYfrO2bxbUJOGl
 2/E0EmXfoV7nia6EiW0v/R5KdUufdob8jzNNCWl9Vp10PiQ5EjfQuDNdZ61wjLyte3K4Vbm8
 cWECU/fCGrg33uN4N8NXsYo9ZfW5sNdhnRk8EzXao149axMAAwUH/2/25sC5qo0+6p27N74W
 QggRrmVJgiewT58qSB8ygzSBLROUrRCiseOKPek/T2JdcW6g6zRz+QGHDCh9wW8JDin0RkxP
 5jt8Xg5PPwahybAGY1YNPEbQnVTtqQoBo3eCtDAfezitHlY6NFsqNBoyTV00Ex1N7lh+SQwK
 4aRaQLzGBak/Z8M+tXrr/YSy003vA2nMwtrtw/eDtmPwrf0k+d0pHxcA4uzA8P2HMvtsBboG
 Fxn9/+UcEoQDDG7gdsMWl3pKQUAC9VLoos+zoqdV+ZUuWgOQvmF6bSEHaSPqQtSlRFrMZrk2
 34trtXRwZ01FMY+gDNJ2mNbGaVFEMtc93pfCeAQYEQgAIBYhBHbZm4xTFs3WZnPvUz0NmUsZ
 bkJlBQJm3+1mAhsMAAoJED0NmUsZbkJlG4EA/2mxLyHTXwvYnXfwm5Pz0DkpSaGFkPK8i1fU
 ZE1wCR13AP9CWbNf5w1p7sE4muaP2NRCQaG9mdOWsCM7mRnNmH6MiA==
In-Reply-To: <d21e2f97dfe6f250.1780369814.git.ldy3087146292@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02.06.26 10:01 AM, Ren Wei wrote:
> From: Douya Le <ldy3087146292@gmail.com>
> 
> CRUSH bucket type 0 is reserved for devices.  The mapper relies on
> that invariant and uses type 0 to identify leaf devices.
> 
> If crush_decode() accepts a bucket with type 0, a malformed CRUSH map
> can make the mapper treat a negative bucket ID as a device and pass it
> to is_out(), which then indexes the OSD weight array with a negative
> value.
> 
> Reject zero bucket types while decoding the CRUSH map so the invalid
> state never reaches the mapper.
> 
> Fixes: f24e9980eb86 ("ceph: OSD client")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Douya Le <ldy3087146292@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> 
> ---
> Changes in v3:
> - use CRUSH_BUCKET_DEVICE instead of CRUSH_ITEM_TYPE_DEVICE
> - v2 Link: https://lore.kernel.org/all/3200151429f33554f06ced8a.1780197742.git.ldy3087146292@gmail.com/
> 
> Changes in v2:
> - use CRUSH_ITEM_TYPE_DEVICE instead of hardcoded 0
> - v1 Link: https://lore.kernel.org/all/4ad15b49fbbae00d86dfe12348bf94d45aa60ac2.1779949116.git.ldy3087146292@gmail.com/
> 
> ---
>  include/linux/crush/crush.h | 1 +
>  net/ceph/osdmap.c           | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
> index 30dba392b7302de3e14861f8b769242cd8cbac9e..ea0b1de2902585ba9a63566cfbb2b0569846a00b 100644
> --- a/include/linux/crush/crush.h
> +++ b/include/linux/crush/crush.h
> @@ -111,6 +111,7 @@ struct crush_rule {
>   *  straw2          O(n)       optimal      optimal
>   */
>  enum {
> +	CRUSH_BUCKET_DEVICE = 0,
>  	CRUSH_BUCKET_UNIFORM = 1,
>  	CRUSH_BUCKET_LIST = 2,
>  	CRUSH_BUCKET_TREE = 3,

Hi,

this enum contains all existing bucket algorithms. Type and algorithm
are different things and should not be mixed up. Therefore, this is the
wrong place for this definition. If necessary, I would instead suggest
defining it as a single new named constant. The previous name from v2 of
the patch would also be more appropriate for this as CRUSH_BUCKET_*
currently refers exclusively to bucket algorithms.

Also, when creating this constant, it would be good to use it
consistently rather than only for one occurrence of type 0. However, I
wouldn't say that this has to be done in this specific bugfix patch.

Best regards,
Raphael

> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 8b5b0587a0cfa2c437b76c8c87251199efe20291..f6cc93939907bc61943069c462cb752d13c8b3ed 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -518,6 +518,8 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
>  		ceph_decode_need(p, end, 4*sizeof(u32), bad);
>  		b->id = ceph_decode_32(p);
>  		b->type = ceph_decode_16(p);
> +		if (b->type == CRUSH_BUCKET_DEVICE)
> +			goto bad;
>  		b->alg = ceph_decode_8(p);
>  		if (b->alg != alg) {
>  			b->alg = 0;
> --
> 2.47.3
> 
> 

