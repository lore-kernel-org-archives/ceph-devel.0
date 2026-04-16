Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360C23DE454
	for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2026 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776349302; cv=pass; b=JRqi3Ws8BP+U86/1dMI08oSAKzm2KW4zEtjC/Rq8tXazTPuRP7g8I+iox8r+OwJenQ6K6TexiSmcs+iKgeFXyOhBd5woMmQRptthgSj666WgAbmdBkENfkba+UJW2ku1uF0PSrtnWn+Yz56Ah5oD0NIFZ0Nnvox6sdbt05MgfxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776349302; c=relaxed/simple;
	bh=MPSStrB5WQZXjuD8LVCQJRe2/QVXDyCuUjmphyPyAE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GPqajYoGVz7/Ogw6B89TG6IBSzlzNtwkqZjowSQ4n7+9yjgPEx0ISv8RCP1i4mHSKNf2GJl0Mrd4uTzUbtJsZ1ovMM3zTWFL9UL2V4GqjOwbmThk4y2Y1Q7LDNAigfpdCTu5WeIwAO2pgr4aUVLVd1bD7WeRTZh5lhiMb5EUY44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+O+I06/; arc=pass smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+O+I06/"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56f6afbd205so371951e0c.0
        for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2026 07:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776349300; cv=none;
        d=google.com; s=arc-20240605;
        b=O8ed+YapY8CLM8RmXNkwOEebrSpb6Qv59OHuWlTB3uDhp4pWPMbnGg0lsoo6BdvgSs
         VOHHdU9i75QnkYOCa5nGcUNF1DRwcOFxecRCWSsHDIBUp/iu2CmdRyQbQ1/84cglyd/G
         fe//b8joLXsiS4kTzCh89uzetioq3Ym6qC5GbNQ/Yd/1kZ9A4+xjOx7nO8LDztLitNlv
         WGCAnPLgNAaVDA0ovDUqOTjLcvpk1QOq4UErjpcpRDPajf+YnhQHaXrC4JQ2PuClzcy7
         mhsL5lE5ShjEHouv6aqJHnDa1YrepkBxJXuEyGD/buY+rc0FFwCGV8JVphbRERGgkF/U
         U5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lO8+zS1qnuU0zyUegMfTKGfj9Y7WBTQIob4jJAeuR1I=;
        fh=nVhVPr7N8Mbuc3uz129r9uXlSNS6vxlMWSBc7uaPTds=;
        b=UaZbkkP+4yMDaP4I4Ks0NXI1J9D6GkjgJNvacpH1gpyU0VRsALPPbs3wdJFhIUGXzG
         8w/espiwY6Mtp2sID2MU6phYS8gaFyG5m0HaB+MULwUx6ZJRC23p8fZXI2OaapaInFoW
         BPaetan4QI8YoZx8y2JV9t8Bt+Q2BuVWf4CqOZ3co4SxufgqHIivSeGlTnrCmmfknQ7y
         xluY625VQZpZlnfdibi+ltANzvDblYFanVb6OBWG3SWcn4ZclNSHJdgzWw6WTknJes9u
         3u3u6+3hzTDgNg0fPO2JYKQR1F2wuoTsb95tgER1fbZ0MKkoJxohzk2rPkPHnbojbCn0
         D5ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776349300; x=1776954100; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lO8+zS1qnuU0zyUegMfTKGfj9Y7WBTQIob4jJAeuR1I=;
        b=S+O+I06/bsndk1ren2sbM0LafnTLke5s/YTY8d+xK85qFvLskc9abtgZQTAAGdHXkW
         gQ8OcqsAvXDSUsE/qTNg9RdNmoee/lFXrdR4ucPesp6PxtFUHBJnk2opxD4WhF7p39fM
         JbLJG4K9nLOk1IWPQT6/9UECkqMXhPWZBwfmOtBlB/tDpW5BKsMpvE9DTyB4a3Knto5N
         O6ngJcs5AXuxkhGkB6nfrl1OMvAfh3fOP4DF0wVQe0Q8EJ96obTWMCn/Ykaj1QnqTfbR
         Y28+pO3WR3EhH13uOiaw9rJINIUVvIgJe+Bk8hsVZpSq8xjX+CnPVc9rKipwxH98+XyE
         eXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776349300; x=1776954100;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lO8+zS1qnuU0zyUegMfTKGfj9Y7WBTQIob4jJAeuR1I=;
        b=Z1OTm0LBPHKtXXBoRuw052C6QRSr7KBzGZ3KzgX6OfRL1NRx2HVLxt+1Wvup4M9Rp7
         t0P/9Q79cgs17kitPR2je6Ffu/Y5DKp3RSqt8m6ubQ1v82S0KBQbC8idDKL2l/C6AqTk
         Snzw6V6qAFHAIgW1Y/LEg37WWyrnT3byb6clBW30dVxcJaA60sAwDE46qjDg6dGmBLq1
         EA+biSEvIJYf3dM1ylVrc11gahCZkobBxX8kLr085z0GxWEIyHx6E/lAaXUWVVY96Zqj
         4XUaRRH8uljMra9TPLTsnJe6XL4NVLuftXtIfERUyjcZgL9TV9UZCtisVibFD3/yfmb6
         n+/g==
X-Forwarded-Encrypted: i=1; AFNElJ8tgesqwFcV2xHq8CxNRCf5OwZfFvuGSeArRZlDKddlLjpnFAHpcif38i0TR4KCrcvldHmbZcXJBQR6@vger.kernel.org
X-Gm-Message-State: AOJu0YyNwBUb5+P5LUxa1N5WG1gpdkFlAbEADdt0k6YgNyvpv6sDd1Q1
	aSLGUrDA9bOrnCiwKWi024vswDd1+T7bql5lbNWh/JaMsJrqbt57jiY4Mx56+bbS+F2dUI+ITC2
	FBRyf4gAoiqlXaBsUauzbQGyNCNwVqf0=
X-Gm-Gg: AeBDieuNcFbo7zIrGUbruWmKpyapMysbWQ7NQTLRghgdZ1EAtsNW+DHXWM/8axKh98e
	ONxCVv1URds6mmDuW09Ix2v2nXucs3hZmM3a7jwhK2C7HPf6VaHGy+SO9jpntSXI8GizHJ4tbB4
	H++A8etMXggyN1kRjIzo+KPtCtiYnK9PdI1w7duDeKXQ+wOhsWVX4W7F4SShC0YnB+UlTrTtTb/
	cd8AfmUS/H7D0SGmYu+q1iECkIPHy6v9ddrLTFhivaEiuU71/zRyoY8T/sVRNQJIJsGB3OFRpXg
	KChFHKc1zeWFveuktBsWesKNYpYKHi4u7o5rHwhDnw==
X-Received: by 2002:a05:6122:608f:b0:56a:8f7c:49aa with SMTP id
 71dfb90a1353d-56f94725c32mr1843622e0c.4.1776349300022; Thu, 16 Apr 2026
 07:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <aeDpIgfDaIKEaBcL@lt-jori.localdomain>
In-Reply-To: <aeDpIgfDaIKEaBcL@lt-jori.localdomain>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 16 Apr 2026 20:21:28 +0600
X-Gm-Features: AQROBzCVSNvQ07toCtw3F1sHPLg5Z_-nre3iq90Dw0MflD8nQqdsL_RQ56rFZc0
Message-ID: <CAFfO_h6pkyX=uN5uoXda6toTtT6KsahfBNBLom9i21HdZ7JOmQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jori Koolstra <jkoolstra@xs4all.nl>, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, 
	smfrench@gmail.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, davem@davemloft.net, 
	andreas@gaisler.com, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	shuah@kernel.org, miklos@szeredi.hu, hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 7:52=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
> On Sat, Mar 28, 2026 at 11:22:22PM +0600, Dorjoy Chowdhury wrote:
> > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/u=
api/asm/fcntl.h
> > index 50bdc8e8a271..fe488bf7c18e 100644
> > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > @@ -34,6 +34,7 @@
> >
> >  #define O_PATH               040000000
> >  #define __O_TMPFILE  0100000000
> > +#define OPENAT2_REGULAR      0200000000
> >
>
> I don't quite understand why we are adding OPENAT2_REGULAR inside the
> O_* flag range. Wasn't this supposed to be only supported for openat2()?
> If so, I don't see the need to waste an O_* flag bit. But maybe I am
> missing something.
>

Yes, OPENAT2_REGULAR is only supported for openat2. I am not sure if I
got a specific review to not add OPENAT2_REGULAR in the O_* flag 32
bit range. But as far as I understand, for the old open system calls
we can't easily add new O_* flags as the older codepaths don't strip
off unknown bits which openat2 does. It's not easy to add new O_*
flags for the old open system calls since that could break userspace
programs. So I guess it's okay to add OPENAT2_REGULAR in the 32 bits
range anyway? (Also lots of code paths take 32bit flags param right
now and those would need changing to take uint64_t instead but this is
of course not a reason to not add the new flag outside of the 32
bits).

Regards,
Dorjoy
