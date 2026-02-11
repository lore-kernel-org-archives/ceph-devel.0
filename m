Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D5347FFA
	for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2026 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770833516; cv=pass; b=jRa9BR5Kr/tBBkK6AKwMeJnoBHAFy28TBw6WeI5iXJJBDMTRu5Xn6zcWha8G7wSI7rt+Qopj9cqZrapeU/Hth90q+23ksQ2DbGDt5C0pRpmY4vsJuPo0G6j9hi4pVRNcP8mNzPnMDQfirSfezQn5y7woWQGYqvJMSDkvcFrtUSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770833516; c=relaxed/simple;
	bh=eS8skp//KpkO9OaolvhoOiI5nqbUGHq6SrZeDua8WOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtrueqp0bEgK4Od6ms38EpXgnMZZeLoU2WuMZhDblqBEcN/7J86ZU+/iHMPUBYS953sVYaeo8rPTPjzIj6F4+KrLHTxhgI6W87mcN9T5hHCXJD/BOS0wzbf1EmKtkrPnVLuokRpOzzs8nrGNGTNLJpH77gN1s1fd53WLR/nrSPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzQCOfR5; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzQCOfR5"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12721cd256bso4282906c88.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2026 10:11:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770833514; cv=none;
        d=google.com; s=arc-20240605;
        b=bFL/1hjyemY7psPYPgVevVLVomXJtSae684AfD2utrx8d9Afu9AJIWMNjjX62kpaz/
         9810wsfvJJVw2gsO5q1itwMkZBxhlrugwO+qYL9BMrUXyXG6KUoj3KF5hXSGgByinR/S
         5QF2N7HyFij2l8j/gVREiEppwLRSuGrG3zCYezmldcc1E5sbZUxN1Bd8PUdBeFffpQJh
         /N+/3TMip5dY2tTEbNRn1Lrr7isQowD0JbTdiAefKK9/1ePiDEgGMpxrgS6v9OrlqwiF
         h2Qo8RQxn6PebAF2/Efqsihi28CIUVRURpXPgP+MFASBwaOhSkyYuXHNgLvhKEm62VXB
         UqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xRyiMSo/V6pjmrjTDgK7f4Vgm5migrisGEk0Ht9gzGI=;
        fh=3j2v2/IMv0z/sP1QquYCkhC1bO54wjl9Tr88xf/7DCc=;
        b=QGPDYzs6o/gr69fwqdcaQXILrA9Hsd7apk2t+uu+yJc448v8y10/N8oc0p/HyCQRgw
         YUHMib0NoxCZoBK7MRG7022PInCW2JqEJPyMtSm9ggGufiAN1Zbinj0I+Qtb02zbOBVs
         Z3EJG0+JdsWGS392kOBHsxqW5RVgmdqci4hIaW4xGA8aUejsvcIrdnJKOnig0acVQIk6
         DlygGn35C7rI23snHKRS5JpHslWAA5yrSs5q3tp/sZXbFNhN4u9FQBi7lCh3kUzHbhNc
         vKOftyTL40VKsBczXjmuntiYbN/KHO6nBQeJKeoi0v/niYWS3h6pzg2Les722V3djctp
         dd4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770833514; x=1771438314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRyiMSo/V6pjmrjTDgK7f4Vgm5migrisGEk0Ht9gzGI=;
        b=lzQCOfR5wp1rjR5W5HsziyGcJ+TI9FNRGBBzMp4YTlnms/L5KmHHCMgjWv9ONPKNmQ
         pVKMlfdaTvPE9QeBQ54kQGnC7/Anwaa5ZhPsG32JyNCYMjvXQpZbI1pLzfZWJmuf9PRj
         9wfUMwVT6htCXGI4hPpB1GlWleoCqzVlPGzEZTfWxmjZQ4hPRY7W+4gslNhjKTfU4YvE
         pufgZtITc0G7fzvgyV315vLziNrWd2RsgOWZLqGZgNUu8vOuHlx9HTQjDFIWkHypKyui
         hWM07kehYcji7EKLozN2dRDhxY80dHYVoEUyWwqwSKjq6adtqSX33baKlIY0lzTbGmhb
         IpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770833514; x=1771438314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xRyiMSo/V6pjmrjTDgK7f4Vgm5migrisGEk0Ht9gzGI=;
        b=A5ntR40mxrUu7DNB/tVo4ZCsoE94HA05l96QwjwY4kJlnWBT4bWi4SqWIjmuqd/TI/
         eUrriGS2HsCKQlzO0n2+dxqWRnQVU5/eBgxPSGDXp0XXimAt8H+uoV1yClkZFzPm6gsK
         cYSEM59cyoqexbhSqEHlmnRchzmB3ElVZGG+XItThhD7C4+C0TbjnKeSNpXHaoGIP4Mm
         Ih8yqv/ci4Cr8NA4o7R+vsC7x99i0MMYZW3zyQ4O8GHrY3E78CgfVt1zIzmIsUY60uYG
         MRMpISm0f3YNh6ivxscLfkYs5+5pTMe/7ARVXYUUNAztinoEJR7EMPfCOUkK/ZnfU8DJ
         PfqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzLd9WoEYBbSuTixEz0EtZ7mzN460SJxOEIG1qrpeeQ3TKwYqfB4dfuC41YeKYNvb3VUZ4CbTT8Cjh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywevj+RczZoPf56c0h7UslSMgoumubbrOR6xZcTEj9GKhvmoE+/
	xKaujDCS0a47RvMd4hboXYHR1QLXjlSmRwYgyb6NqWyenP1jn4O4mf+sbnzTRmKF8GkrmCha9AD
	k7mAyNyWQsidSc4cHGurFf1kclwZLa38=
X-Gm-Gg: AZuq6aLzLJ6h0Us6qdMQ0QlgyqBZNrFuOCxxt40CSvoqfybQaJlUaBaOAdcESzL9tqi
	zo7nuEBNnLaIiYpYou946dZ7UP7nwMRJig4/PwvO/2AuOiondwM/b+nK91yWy3PFu9SEnoj4lHx
	dsbzPjR5VVjHqsx8FEyjLBbF/SCdUaJpEqZJjNSmj9yJSl0zMbAGYz7clOjC91s3qES0hieye/i
	L0wreqN1+c71l+kofNmeHFupy5Hbn8Vgmshgvhwk4y7qyKNm0xZxBtt3688cAlkb+P77qeor0XY
	Y0AMrAY=
X-Received: by 2002:a05:7022:4192:b0:11a:4016:4491 with SMTP id
 a92af1059eb24-1272f78a713mr31926c88.24.1770833514299; Wed, 11 Feb 2026
 10:11:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126023055.405401-1-CFSworks@gmail.com>
In-Reply-To: <20260126023055.405401-1-CFSworks@gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 11 Feb 2026 19:11:42 +0100
X-Gm-Features: AZwV_QgaaLnhpf0EJQ5UPnuPY6yHBY5usdOKGdAH4zPzEeU-28z0igxgJK__hSw
Message-ID: <CAOi1vP-VeSJvEptVNB5_q5d3y47w5KDrrqDSU2E1iX6ExNNooQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] ceph: CephFS writeback correctness and performance fixes
To: Sam Edwards <cfsworks@gmail.com>
Cc: Xiubo Li <xiubli@redhat.com>, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	Christian Brauner <brauner@kernel.org>, Milind Changire <mchangir@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 3:31=E2=80=AFAM Sam Edwards <cfsworks@gmail.com> wr=
ote:
>
> Hello list,
>
> This is v2 of my series that addresses interrelated issues in CephFS writ=
eback,
> fixing crashes, improving robustness, and correcting performance behavior=
,
> particularly for fscrypted files. [1]
>
> Changes v2->v3:
> - Split out two patches ("ceph: free page array when ceph_submit_write() =
fails"
>   and "ceph: split out page-array discarding to a function") to a new ser=
ies
>   [2] since they are independent and had no outstanding review comments.
> - Lowercase the subject lines of commit messages, per subsystem-local sty=
le.
> - Update the commit message of ("ceph: fix write storm on fscrypted files=
") to
>   mention the explicit dependency on ("ceph: do not propagate page array
>   emplacement errors as batch errors") for correctness, to prevent the fo=
rmer
>   from being accidentally backported without the latter.
> - Reorder the series to make the aforementioned patches consecutive. The =
series
>   cadence is now: bugfix, bugfix, cleanup, cleanup
> - Add a clarification to ("ceph: remove error return from
>   ceph_process_folio_batch()") that "abort" logic is still possible, just=
 that
>   it is responsible for cleaning up after itself.
>
> Changes v1->v2:
> - Clarify patch #1's commit message to establish that failures on the fir=
st
>   folio are not possible.
> - Add another patch to move the "clean up page array on abort" logic to a=
 new
>   ceph_discard_page_array() function. (Thanks Slava!)
> - Change the wording "grossly degraded performance" to instead read
>   "correspondingly degraded performance." This makes the causal relations=
hip
>   clearer (that write throughput is limited much more significantly by wr=
ite
>   op/s due to the bug) without making any claims (qualitative or otherwis=
e)
>   about significance. (Thanks Slava!)
> - Reset locked_pages =3D 0 immediately when the page array is discarded,
>   simplifying patch #5 ("ceph: Assert writeback loop invariants")
> - Reword "as evidenced by the previous two patches which fix oopses" to
>   "as evidenced by two recent patches which fix oopses" and refer to the
>   patches by subject (being in the same series, I cannot refer to them by=
 hash)
>
> Warm regards,
> Sam
>
> [1] https://lore.kernel.org/all/20260107210139.40554-1-CFSworks@gmail.com=
/
> [2] https://lore.kernel.org/all/20260126022715.404984-1-CFSworks@gmail.co=
m/
>
> Sam Edwards (4):
>   ceph: do not propagate page array emplacement errors as batch errors
>   ceph: fix write storm on fscrypted files
>   ceph: remove error return from ceph_process_folio_batch()
>   ceph: assert writeback loop invariants
>
>  fs/ceph/addr.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>
> --
> 2.52.0
>

Applied.

Thanks,

                Ilya
