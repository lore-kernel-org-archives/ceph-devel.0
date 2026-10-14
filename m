Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD4A4825C5
	for <ceph-devel@vger.kernel.org>; Wed, 14 Oct 2026 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971449; cv=pass; b=ASWPVaerTRpxbh35e9nqGHo541zGLqHFDTLk3Op1R38B377kzM+3WL4gveusV6oVodqBkPFd7dicJX0ErsGhTIdCrzXC0KsFVSM+z/bWN3eyE7SsoFL129Ubmiyr3MfgNj0bnFEu/8+vjoREDxeTe7rjLy/yF+b/2zMDt2CEMtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971449; c=relaxed/simple;
	bh=JOFHPvWsRG3wmqBn8lmIc1oL/Mz/lZXZ2O+Zs1GbznQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOWvXIlWE4SOiQTt8X2sake1YGxjEcLPht148LFT70DjilFBNsa2fjjdWeu8QQ5ElQx2t7dujWZFqJevGHrL3OJsi4XgSG/hYfoWQXP5QNrPzGAby+Q3+CuUerVBth3UYrzNwudJ2SWZKAm7s+zpPdeKDhVlku2VnHoIjKVwc88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=C5yncZu7; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="C5yncZu7"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso6156678a12.0
        for <ceph-devel@vger.kernel.org>; Wed, 14 Oct 2026 02:50:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791971445; cv=none;
        d=google.com; s=arc-20260327;
        b=PT66ltt0UiODGoxhAt6o3f8zwQrU/hmxmrWXUk93rcNXBWlJyK8CslUNUKxYcJFMs2
         4gKPWFeFQROZDEZArqIeV4KTbZhZYIWDe2RataBdGJfdf1tk8Whzh3MPHitd58S/VjuS
         B4ZBrr14zhgwx6LQTe8boM+ii+TrRuCTEDf1GEgO1T9IlyN+w+uoqGdJ4bDmOuJCJcVt
         hsh7rYql9K21sr90qxwWmue4wPRGKdT3ZCKSot52bNbSVmSEV/vQzhgxjHV5NWScVcOU
         jV66ZCQQfFmvkF72x+OtYh2AzXh23/wYA1gqa6NzYYjUjfmBM0u9//1fhYXq+hEhR1gC
         EFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JOFHPvWsRG3wmqBn8lmIc1oL/Mz/lZXZ2O+Zs1GbznQ=;
        fh=NHSa4nlb15zs9zQBWFeDakKUrgPdh8mODKU7NBcYlX4=;
        b=XCU0HTVmGUWn9VA1OWPNSI9OqhuiPEAfow/S8IiXEjilPIm9XLNvLoHl4tju6z9308
         eFlS3D647hmsxkBzra2/kM4ZJGVfQUVN6Jsxwd8bR8lLML7PzZdlk/F6BLxuUJObCy8b
         4/fCNsvBzrBt9yU/OHpNl7CNXvWC4w7N4Og7YhBOXms7NBl2EsROuXhdJrLALjbTzFvf
         PLUt095SM27E3XfZFIRrIjoKyMp3+fMH2Z6H7kUtBKQKV9giQZ9GQ2ZOpP2k3WKozvir
         JFGtGAlKCm6V2d02fJCtA5IHLGucjNTjNumyyjiNc5Ct0JQsTlDzfzeXnAvNEBzwIFcg
         skiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1791971445; x=1792576245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JOFHPvWsRG3wmqBn8lmIc1oL/Mz/lZXZ2O+Zs1GbznQ=;
        b=C5yncZu7xt5wUiP8Kxjx6LxG+nuszB0GoKnti3yItAyyWq5xGHrVBz4nJqj/Z50HHl
         7ZmdWa3H6F6SRt0IenFN8+0MkMIUpahpEV0C/LBjxnWDxVnXOyfbkGd0h10HWMiojJ7b
         Vmk/hPLAFvlajT5RSb3I7kSgQ7t3op8FMqhEOuj9L4rcdyLFvCE6Z/hn6zOVvNKpCy8L
         2V01FCBLW1MpqzCBQviNh9wefcqSnjpTWvxLJakfLxF8u5hPqx4Wpceqoy6vuO0XgoUT
         8YzI5O9umpjw42HMDBmZUQgTpcGhqpNnePnBrPePS4jpMSS8CDbbdkaPAaJ7L8Ekf0SQ
         9zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971445; x=1792576245;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JOFHPvWsRG3wmqBn8lmIc1oL/Mz/lZXZ2O+Zs1GbznQ=;
        b=k0dSUzFR51XKWIIMQhtCWqAvYS/XhN0isZ+9TiOBheTiM6n6aefSC4dttQjtWgQ4UB
         i+bKhdgHwKRG09lvEmrl2qYF5pRKSdnZbW0a+PbuxgX5hHbaY4T/AMCgEArsnZjL98E+
         osLtVLWzxElqtlXblu7qRmf91KQBoK6oiaUmaKObi/JYfiu3bvczw4Ne6JQ7j4EoSLon
         Y+2nQ/svcUn+fY1pT+FoctB4xNs2fywWI6FuHdSiM8ixkXPfNsS6RkeGlyNRQWjNXOg3
         jqiRKlLtJtqW5Dj5fg29H4I98TSok9EkpaBXT8EDJDYIdGqkhipjCm4rwGSbXOSg2D70
         gM3w==
X-Forwarded-Encrypted: i=1; AKwUvBz6NaBhgU2n+ryr8Il9qdBHXVq/y/dS2UjzNHs2FtPlt8huNZFdLTK53WtzaDkws98DWO4gqOTff4xf@vger.kernel.org
X-Gm-Message-State: AFq9FYIPy487r9VEjbjFpVVU/NiQlhl0tHuYPDiaQfXXFAlGLbHGzTUx
	ff+1Ycfc7xbuR6WhcWMQ55/iq1wkVUbiPeb4IN7EnmzIsdZrstMuf9CHQ21lcXMumblMXvTFRjF
	3pNdqPArCYAbZ1P7pYSY530r5EL8RGf42zUcKHX53Ew==
X-Gm-Gg: AYBFou17DuwOg8X16G4c71e9ZkU5U8M7ZunJx4IcQl6HGChqzh9GLtAdZJJ+CVCSA0+
	nlI5MkurFxNKkMuuhQxSfJN7/o9LMCG6fcY5nAt6y72S8OFrnJEVQxw6mldYMOy0NoJRS2hevBi
	Z7ZyzF2GN0wmXzf3BcWvSjoQFN78y3n3nGzgdA+X18anJjzNcksFcafVUWEkP4J5Xw0GfD3b1pv
	P5gxEKybrvvcgGiLsr0ap7ahjt/FsIp26rlDsoNpanhPtXGEhH+f7z1EX7CKTUtiC6G7qJbuS3P
	v1k0w+VAaGnyx6Uokk9DC4vOIVM+nsjPpotSN4EhHzVqWQz0G+OogFr1vh2HcpyDGUd6y/RROXB
	Cu7644ujl
X-Received: by 2002:a17:907:a713:b0:c2e:3f49:df04 with SMTP id
 a640c23a62f3a-c31a9a3404emr1486426166b.1.1791971445323; Wed, 14 Oct 2026
 02:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904150304.49104-1-max.kellermann@ionos.com> <b8c135bf-927e-454e-8bca-cbdbae133d51@huawei.com>
In-Reply-To: <b8c135bf-927e-454e-8bca-cbdbae133d51@huawei.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 14 Oct 2026 11:50:32 +0200
X-Gm-Features: AclHuK9JVWGiWM8FmQyij5Uq_o4DbHcHp83pKj6XgJqn1gj8jANGfBFN5Ru_lJ0
Message-ID: <CAKPOu+_Msno=mux+FUc-oV1-ywRFujJcnKS2HNv0sjtRVtUP3A@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] ceph: don't unregister an MDS session before
 removing its caps
To: "chenyuxi (D)" <chenyuxi19@huawei.com>
Cc: amarkuze@redhat.com, ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-kernel@vger.kernel.org, xiubo.li@clyso.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 11:15=E2=80=AFAM chenyuxi (D) <chenyuxi19@huawei.co=
m> wrote:
> Do you have any plans to move this series forward?
[...]
> Is there anything still holding the series back that we could
> help with?

It was rejected by Alex Markuze, and he never replied to me after I
questioned the two reviews. That's what's holding this back.

As for my plans - I have more Ceph unpublished fixes in our internal
Linux kernel fork, but I'm not submitting them, see
https://lore.kernel.org/ceph-devel/CAKPOu+8SiwxT_44e63-EZ4T_4d-tGjwmk_Lx8i4=
KgZOL5JnMtQ@mail.gmail.com/
for why.
I just looked it up: the stack of Ceph patches in our fork has grown
to 67 patches. They were either rejected or ignored. One of the
rejected patches fixes a security vulnerability.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
