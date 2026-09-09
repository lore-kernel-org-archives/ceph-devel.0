Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC93752D2AE
	for <ceph-devel@vger.kernel.org>; Wed,  9 Sep 2026 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950673; cv=pass; b=P/2NBSH6Pa4wLQHGYWcVOQF3NF8KTNsbuXfD0GDtmlhWHWWAfbTdyYmJEsMjlUWRAY7WN+0vms9OJu/X1uC6EBoi+afp/M76PwiZ2Yxv3VyQOAqPTSio4NaptRaNasgiau1IHfoWA+d6w1G8Lye2ymAfzdyjZi7oGQvfNrFMoeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950673; c=relaxed/simple;
	bh=LchKmuqUsI3p1QNY3NzwfRuCCzAT1YDkX/qoa4sSKBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpXETSYqIDQOmEh3pQc54RWDddVEPHl553v4VaPtuVtnfutBWeoBcpq0GVPzx6pCk3WxKN83L80zc5nEtmy4CUccCx7A0TYlaK794HABDLnuTSuQQzX/xYvu7f7KUXJx2OZ/MktIst11iU4fEkIrYKR1mGf6/57XaIgjuhy6zPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=R/cOOltj; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="R/cOOltj"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c250c6a6a6eso779361166b.0
        for <ceph-devel@vger.kernel.org>; Wed, 09 Sep 2026 03:44:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788950670; cv=none;
        d=google.com; s=arc-20260327;
        b=SYeLl0VLgdSeARn6stVETl+qTlZGTgYjyHAiSpn7PxQriByMUyEOUqE2TNUNKMG0gK
         p99Dj8mhaUjfzwWdNrYbSgcQiheAzruWcam3CcWpmIucsJIeADNCY2O+G+ycwpL+7kxC
         jf0lI8i0YROPnH5wSTnq3nXUQCtTkDhA4GWEKnX37y8RbQDXgedFe9STEf+wROaQa7Xm
         ScE9ka5/XLSxCxUH6z5BBZPfbUV6iyfheziAlWA1qfr3l9QdERjZRwgB+p8t4ktgybYQ
         tZrKtr0odi944vwarclzU6MukJy7vHGLaGvooqk88FmzxK3HWry2LhMqIQQpkjkCRySn
         NXiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LchKmuqUsI3p1QNY3NzwfRuCCzAT1YDkX/qoa4sSKBA=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=SUIsTZQuANgjj/MQ8R+Yw/sNiHx0WVmZif2p3VObjRftPLv5BkURrttmnxorZlU9bf
         sdsI0VL8xXkOOiaZjYH4q981Dcf/esIszOHQrGht6o3lptwO4mea+lDr7y902O0UMWht
         Et9gwWUbRML6PLBlKK5no2IuR2gaiXjsNKggsrE9awV5e3Ppl0u8LoM+cGBDUmq3SvOT
         hA2f2xkFvrBOTHhGwKMLs+fzhyMQ104AedhWqc+RFnOPF6GAvdOOjvVuNnfy7AllnezS
         us6AzRjqrAeZyaelTj9eNwxO1G4F9jsUpeV9Go35JV8Y3lFAW7vYVZWB0qsP1hhPLtgS
         TEgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1788950670; x=1789555470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LchKmuqUsI3p1QNY3NzwfRuCCzAT1YDkX/qoa4sSKBA=;
        b=R/cOOltjs9+AUpZd7xLmrmDI+Dp03nrejsh3pF27jpBa8GsdouUriX+4dm0hdS6QHT
         ynH2Dj/GZRxo00j4clQ1zORCL3HQwp3pjXMxkqG2IBsShsQkyXPmC7he3F+mGomq+dyt
         5FckyEH7KP7fyXWpa0mRWih7kPV0HHnA38RF4v6trIgFKlCgFjPtyf69/JvLwitTuc9T
         nuuYzFZFZBd0mWWonL8egUqr4lm9DycDL/3YIEGXx1Lk05SFBlIFp4qMlWk3ECDzNV5M
         MGIgtBkg08lvOMfrQ9YLSY/KC5pwu0nKy2hbRiDVZUC2OB9aPIOVwVIlLLvx1BbqiSax
         gB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788950670; x=1789555470;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LchKmuqUsI3p1QNY3NzwfRuCCzAT1YDkX/qoa4sSKBA=;
        b=rA2iCUdsK6TRTFDAnsTI8MwQWd0GkKcYT1PKTmgo7KC3YWvcgUJnKuTwfexEdX7sOk
         of7XkUNlkmDzUu3ZXsmbQsNRvyzvE/p/pLUtgcQhkv7JZ+Sr+tQerQfvMCkOIeR/A3Sl
         dRhXa7i0/KBJa80LLJg9cH29EONxhToKfrfhS5WOj5MCKZOWozJyszgpFCiRg91WEyTm
         +K1XTRdqwilR0Sefsul3qSuJ52QDboj1R0a6/9nxtgVmL3gv397vwUdi4Ygk43sIV8ql
         wBr7s1HENHhBfDCuBQcMChGCRy1dPTIONPCnQO98pP2p+4ODs1taOm0lOSZmXlx6zf10
         N91A==
X-Gm-Message-State: AFuF++nArmZIjuKLURo5SezSv+yLhUEFjFx/rV+jb3iGQRpiAHl/9kb/
	G9t/nA96oBQg6pWK7ILFG/uB9YJMhX/AufFpX/d5estlrh97hi1yU2Vm17k4Y4a7RxQ++kMRIxL
	lKUlJuhbSCHHkef+moQkAAUBp8vkuOIYl0o3ablfSioxu5/xoN5oVZv0=
X-Gm-Gg: AYBFou1b9kei71a4wR5Vi4WQWx85Iykb5kaAimMpxzAgLJDtC0jyaw8YzJ/RoERXq6k
	CRrL8fn0WEmKFqskx/RAdowV+ZBFYOCPd6mKEf6PeJUfklsaxou5AAlkfyvZkODckO4f6edBnIx
	zBopi+IsQr7PkO5glb+s+LWSIp4yO84TdhYgChGR4218psX16omsTNQUYpkqPheMRaNur8I4peR
	PWaEPNyam4MjIuJvCfpiIDTfho6PQd6mIAJGXpRGbCpGSLaB4Z8fuAvjfD5fpbAUAUH24nln5m1
	bOy1tExHb34qMS8WB1SrJ30kOuJOXSthzcRCGXiJdVY4y/+oIZm68QxzNmsqLQ7rxQe+9r2eb3K
	/zWhqaYDn
X-Received: by 2002:a17:907:6088:b0:c20:f913:9337 with SMTP id
 a640c23a62f3a-c260ca3279fmr1363054266b.20.1788950669963; Wed, 09 Sep 2026
 03:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907212325.508739-1-max.kellermann@ionos.com> <20260909103845.3959496-1-amarkuze@redhat.com>
In-Reply-To: <20260909103845.3959496-1-amarkuze@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 9 Sep 2026 12:44:17 +0200
X-Gm-Features: AcwNN1WUBRH5C5WjsHvHebo2RZsR33VMKsVit9OLJCyz0bZbjGVZy3lxnagmUPg
Message-ID: <CAKPOu+-98n+EF7gGQNn2xLTf+uF-YiyP674+QUyninDEwP3QMQ@mail.gmail.com>
Subject: Re: ceph: skip alias lookup when trimming non-directory caps
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 12:38=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
>
> Hi Max,
>
> NACK. Please respin.
>
> The skip-alias idea is still worth doing. Please rebase it onto
> current trim_caps_cb (after 6b039a71d37a "ceph: keep the inode, not
> the name, when a dentry lease expires") and keep that later prune
> path intact.

I have no idea what that means. What is worth doing?

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
