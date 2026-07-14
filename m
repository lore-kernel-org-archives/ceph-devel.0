Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBFB3DF001
	for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013560; cv=none; b=DVcPvQDMQYd6/nFqNEKUKPxYtxye3MsPSuuCYqSP/zcMmuILNKcDaIkazHqXYeYmg2BLp7vaA/v/Et5Bm9cob7/zhyY+iZIp4XGOsUs57cor0OtsLvmOBhyqPXQAO2v7NzADp37vkhtwDLIZ1QQeuo4+mZwamcHO8WBf1ULBVG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013560; c=relaxed/simple;
	bh=kIERie8dbqx2+eAvdsr037DRwXWzmtXALWanJlNJzi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7ubf4miLvLUW9dwUDe8i0410DS8jHSJiOjmWj3BxEd+/KYdib2vjYdZyINkQ4JWmX4Gi6FelYwvGjQFyXZ9RE1zuWRq6jARP9fPfoz20FXM8Ab2/MGf10B+NQpTuN779pyp7lYEuYnepe26gPaBqEtXKf1vUj5FIngmv6KSbD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9Ty8bRM; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9Ty8bRM"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6a37b2643e2so440037eaf.0
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 00:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784013558; x=1784618358; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/lycI0z8Y1t9+PubOdFL76Fa/oKSxmR3LtUe6RN9X5A=;
        b=l9Ty8bRMZ40fguL72C53R45aZma+3XUfdp1+oyWyLdLSpl6D4C19CO5zGNDenqXBA6
         BJFBTqlnwiQDe2FZZQEI+7POWvE/QpgaJ1FVcxqoR5JwpKq4hpWIMgDL2RVl5NTZwQtD
         FhySSE6dSng+C2FsveUkpRjryk2W9p523f9Jf2s2GtNcV8i6NxDR1dbviFrnE4dCc6uV
         EAONsTw/CJyvOfMrS2OOF2uzbr3/uCExtYIplMQ8/CLOknMYtaZHhBBmcSriFVVDvHgZ
         W8rkDjs7oieEilvbNCfz+YasMoZrTdAGQlerxfioFmE7PTPKHf5kelbKLHDbF8yXQO32
         UiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784013558; x=1784618358;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/lycI0z8Y1t9+PubOdFL76Fa/oKSxmR3LtUe6RN9X5A=;
        b=MY123tc7npw/N20nxaGNRzdXe4Ke1+DmKcyajAMAmbPWW0Ni/A64tAqYjzoKh5UfX4
         D+1bszkMUhLP5AznWDZz3I0KERARWj+Mqt2CVQXFpfUyiqSH5d87Yv30I76k0+SO8pCs
         aWp7WQj0C9FzpKxSrPLtRIkfYHHRMHs7mF7viXnjYbYdXhKlKm6vOJfG5MJp665eBU97
         AzdJ4TJ3o9rxKCU8P+bV+00+TPe06XdtFZJSQV8OqOEspTmx+Aa53jSIlNOTqOwGqA1W
         ZOF/HQvw9HwyVs4adyR+MlMM8YG3RRDy9jcnL8Br9xWoXutfusXywNO/E+Q3vvYdJ1yC
         ks6w==
X-Forwarded-Encrypted: i=1; AFNElJ/l7s+NVmbPmTe0sA2JFH/d5vmNNz+B2J1Gu0BHT7DN/495NyyaxZFn6P8jm20KetryV/e1hMxYmhKg@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZESiQLwRsVMmDeTTZbINzS8xZ9rK64a8/uXDYHOnjCa4s+qG
	rxfyEDhmoaZGKtg01e70DcxNFoVJT7Ek2dAJFR8UyaNDlifw1tpJPf+8
X-Gm-Gg: AfdE7ck3MpdbnLtd++frjvmrdZH9xtvK3FZOel/wegI7dPpO+4Lwsl+pBJ4VZ4ejbJw
	DoosJssHpzyRo9tipb4kLWFNviMaP9Evi4dZqFBfXg1y7LSXS3MQKmFqwGECYlZIVx7tpxqn8rk
	sZkdd1IwQ+mumrgyaVKmUY1mBK6XP/pWoIcoJFCeigNeB9j0sszxcnsO1Rh6Kjytzf98iBsfdSI
	tdBG2d/J3tjZzFSsznEYXUefFh3/DWtGNgcGpaFg71QB6nXZ+3fIqsy8/UxzJK88BHeX47HBUiJ
	baYYYlI6xvWWQLm9e89Z9gqgIV4l8ZugyP7dwGKL1cTb4ZVIBYzyH0x+RDELbsUylAlCT7HSHkq
	wlDmmZV0XFcDI4j2tZ0unjO3DNXbvjK6K5/bCgPQAUzzp0II1FVP2Tm7V6lWcyKgyQil1DPNlJD
	fXZUPL
X-Received: by 2002:a05:6820:4cc1:b0:6a3:916a:1d26 with SMTP id 006d021491bc7-6a39a8561bemr7965231eaf.61.1784013557982;
        Tue, 14 Jul 2026 00:19:17 -0700 (PDT)
Received: from localhost ([74.80.182.78])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ec14489139sm6783167a34.5.2026.07.14.00.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:19:16 -0700 (PDT)
Date: Tue, 14 Jul 2026 10:19:11 +0300
From: Dan Carpenter <error27@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, ceph-devel@vger.kernel.org,
	Alex Markuze <amarkuze@redhat.com>, Helge Deller <deller@gmx.de>,
	Ilya Dryomov <idryomov@gmail.com>, Kees Cook <kees@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ceph: Move a variable assignment behind a condition
 check in __ceph_remove_cap()
Message-ID: <alXi78mFuDLaVQ4b@stanley.mountain>
References: <5010d7d4-e321-4999-aca6-1caa040f3037@web.de>
 <bd15b4d5ccdcf01a8730380c4d974afaab2c782a.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd15b4d5ccdcf01a8730380c4d974afaab2c782a.camel@dubeyko.com>

On Mon, Jul 13, 2026 at 03:10:40PM -0700, Viacheslav Dubeyko wrote:
> On Mon, 2026-07-13 at 13:35 +0200, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Mon, 13 Jul 2026 13:21:29 +0200
> > 
> > The address of a data structure member was determined before
> > a corresponding null pointer check in the implementation of
> > the function “__ceph_remove_cap”.
> > 
> > Thus avoid the risk for undefined behaviour by moving the assignment
> > for the variable “inode” behind a condition check.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Fixes: 38d46409c4639a1d659ebfa70e27a8bed6b8ee1d ("ceph: print cluster
> > fsid and client global_id in all debug logs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

I have explained to Markus many times that these are not dereferences,
they are just pointer math.  So the original code works fine and does
not need a Fixes tag or a CC to stable.

And then Markus responds, "the C standard says we are not allowed to
dereference NULL pointers"...  Which is true, but again, it's not a
dereference.

regards,
dan carpenter

