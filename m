Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A013F880E
	for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2026 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774799; cv=pass; b=Aal2alGe4RIkwDpnXHST+3ClQ4a75pcaCOLzs15TizIpJ9SnGQ8htQmFrnptZmRJrj76/WeXYXjEE/y1ZUtJRqscHPF7Hnkg4SOgSu37knW1ROgfNUkK6rx7OYAXiTa7tcTybCpW2Wtb8yetVLSMcNzuM++wRdH7do5TaSVFSxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774799; c=relaxed/simple;
	bh=JC3f9lB8/LjpJm9zQETEG5UdDrX51WYqap7UJguFQJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ik+aDxHt856bXcD/x8KHo6JQeO97eV35OND/Ais5JIRt5lgHkZGGQYNff1kD5HxUy8l9Y5zQUj0nIY3k8qGLx3JKbj3HPBZhJjH1l1poVsyqKWseDnHTkx0QoPZ2fo5DYWBqvGbYL6BCZDJgdx1jg+Y/MFgDxorkaVscAcd3+iY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfXId05t; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfXId05t"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48535a0ef86so51068035e9.1
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2026 12:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773774796; cv=none;
        d=google.com; s=arc-20240605;
        b=DRoqSnKktMA0gthdI0gnKO8/ZJE9wLNpXJ3kyoBucn9qx0EC93c8nL4umBTzQouNSR
         IYTm/mj9rIa7nMoUkPxQAJPure0m2E3zn6pNsSaQcj0IjYlxXR2n0MWGfazQo/Jc7R4S
         w/hm0NFyPDePhKyR+EngpTL4+FHrlQtFR4TqVx5f2ADKTt++ZSN3KlJhzDrtRz0amCD6
         qZ9aBF0/GkP4eBbEXdgdumTs0o2zM+cd0UmL4xTdsJ4J1hckO06z2FUUIUNbthYz2og+
         h09KwWoQwp0EoeGBnO93EkRCtvLPRTIAmh31zMDh/sohnvB15LZ+BU2Z2EvPG4q9oAs0
         CARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2k4s6/CmkjZ75LYxsdScXZSeV9lyVeFo9dEaaWin0XM=;
        fh=miwEAzLJTZ1yptBK7J8QhvaImOJm2Vh3FXEjOTwmKFA=;
        b=PnesrpMOigMuMTFS83ErsmBTbe02V3LGxnY6+v9U+ZXV9dW3xE33BMHIBCkIhZR6SR
         I1jvcterVV6NIf2xOcqese4lxbmF3mwxMhvnued4JTXunLQHeBpV3dz4cPBh+KWVPEQX
         0BZ9DDDKrC7/6BtXsUMFT5wEkGyeccQJx4iRz4GuQXFMqegQUh5u5u8OXe2KAbZLe64E
         0nX+EgD4N6h8kjkPC1A7a+ormsLcNF1tMwcDCAgwNclNICdaXfbIavOzYcE4SGSNRf7B
         hXTZQFAMOAw+VAtfVRRLnLhdWMIiX1lzgvrQHTrFD1OOONbynjQlb7lB4g3hw5r5xVZm
         fKpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773774796; x=1774379596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2k4s6/CmkjZ75LYxsdScXZSeV9lyVeFo9dEaaWin0XM=;
        b=dfXId05tBjwD1wSCnk/2eS1YCI4YiFyAaEICpmckVISmJGFdtRJT8kuw4UyGfctwn2
         0jHzrn5zbmSlYHyuaG6I3OYL+ok4LopCTKgD2eO70vCPTmZYyxvaZrwOmhLU5Z9X4s6q
         i7UmfL29AjWOpqY8v8jFkVcE+dG038VzqqMJ1r/TD9BiphWLFwiJ+dGFK/MC8ZqVXTJ8
         0w0XY37OqQwcDH30mw5CzBCIPD8iqEJYC/nxC4fkBrQekn2/kYsdxnv8O1i9AQ3U9l3j
         vTH2Er/C+WYWmn4YiuE0zxQ9ykvHl8YajUbCU2H9BFzcStOvi6R1dMXGLsKBC35Nie6K
         K3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773774796; x=1774379596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2k4s6/CmkjZ75LYxsdScXZSeV9lyVeFo9dEaaWin0XM=;
        b=eVuqurQmZIo0SwgnTZUG80t6zk+AVZu59W0Fr7CQIEbIljiSK8H3AylOFmdzEFikDk
         x17Ss5FkQZi3PgTT2IEBEmGyaQn1oS/HPYe7eBgtQ1pYDMWr+4yaWaohdrTuA705j1Mv
         T4mtwdakiGFIImruYa54GyCS95TSNDxip4HfeU4eYlvUtN7rIenRIyyoDIaTwpSRCv+P
         Isiqb5o0PL1Ct/YeX35Lq9bzhi0oRvDVxywk9LX+kBt+unFIlSCVtte7LXNsbWzD89ue
         +k+P7tE634eiexebY2vwMinEkwbNdJ80E91ztgcg8Zv4nNHI+JvwWjAq0SBXUnA4jLqr
         nrNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUohyWea8vgGqDWB3y3K5gjI3td/nDXxq9b8gkQPt1Eg6Hq0iY/liB8zLGPdrJZOQZdJLQG/A8tmuR@vger.kernel.org
X-Gm-Message-State: AOJu0YxBbQLV+Wc3ga+Hel3Mg6SX8xGQZmbkirCoPCcfH4vcswhgunOk
	YZJfrRtxZi9NLC4bEhbVDbAdkokh6uVyH79b+5qNcIGDTLkyTAfvAPbQsad1jZCGNDBNP6JMagW
	tctXsvW1y/veFcrjbPD8sEGpDdrHdRk0=
X-Gm-Gg: ATEYQzxi6oVLIHZIYmiycApuOedEC8FoVYZwqiEvCOMH59qHeoLbFAymyvOqeCgFsL7
	9EB+K+U/UEdZmp1eSxPBsIRMiVuPl1FXzBNYcnQVBaxYGZcJeuiita+hGLxcLPahs1liAGbJeY2
	DMUzQbVapJb98XJry1KfXF5gWU9UyfhHRZK8QoFYf+IoFcYUo/9LsrnfMclTJlLzTzyC2qiNcwc
	/r6lsIfD65xHmwENCBFsEInOf6h98DxwRoHE4jfDpzhRBeS7e+FO7H2BIWRa8nIZAMnPSqEfgXd
	+0WwET1u5rMv+y4wNtAczxb9IwakK80=
X-Received: by 2002:a05:600c:b8a:b0:485:a4de:f4f9 with SMTP id
 5b1f17b1804b1-486f456fdb7mr12311325e9.27.1773774795851; Tue, 17 Mar 2026
 12:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315232500.251088-1-CFSworks@gmail.com> <bbc55ded3e226cee35e04a071400981e2069eb3e.camel@ibm.com>
 <CAH5Ym4j6gPCR9UhM1ywkDmvcDAccNrL72LFLy468T4PfPTxU7Q@mail.gmail.com> <cebd075d8e2e7e926fbcb56b19ec43fe7dec6ef1.camel@ibm.com>
In-Reply-To: <cebd075d8e2e7e926fbcb56b19ec43fe7dec6ef1.camel@ibm.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Tue, 17 Mar 2026 12:13:02 -0700
X-Gm-Features: AaiRm52lMPb1yDfUF-9yK0AWVPwFZVXbgUkp4HGLVQdzn1TsQzW879X02HrYKMI
Message-ID: <CAH5Ym4hjSxtVG1v58Yd83FYeU+8+S_1M2_5pPJmMs=_fHb7orA@mail.gmail.com>
Subject: Re: [REGRESSION] [PATCH] ceph: fix num_ops OBOE when crypto
 allocation fails
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Xiubo Li <xiubli@redhat.com>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, Milind Changire <mchangir@redhat.com>, 
	"idryomov@gmail.com" <idryomov@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 11:51=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
> > If this is just a general question about the patch, then I don't know
> > of a way to trigger the issue in a short timeframe, but something like
> > this ought to work:
> > 1. Create a reasonably-sized (e.g. 4GiB) fscrypt-protected file in Ceph=
FS
> > 2. Put the CephFS client system under heavy memory pressure, so that
> > bounce page allocation is more likely to fail
> > 3. Repeatedly write to the file in a 4KiB-written/4KiB-skipped
> > pattern, starting over upon getting to the end of the file
> > 4. Wait for the system to panic, gradually ramping up the memory
> > pressure until it does
> >
> > I run a workload that performs fairly random I/O atop CephFS+fscrypt.
> > Before this patch, I'd get a panic after about a day. After this
> > patch, I've been running for 4+ days without this particular issue
> > reappearing.
> >
>
> I think this is good enough description how the issue can be triggered. A=
nd I
> believe that the commit message deserve to have this description.

Very well, I'll try to condense it in a way that makes it clear to
those trying to repro the crash without being overly verbose.

> Frankly speaking, I am trying to reproduce the issue [1]. Do you think th=
at it
> could be the same issue?

Please double-check; the link you sent is to bug #74156, reported last
year. This regression was only introduced last month, so it couldn't
be the same issue. Did you send the wrong link?

> > > >     BUG_ON(ceph_wbc->op_idx + 1 !=3D req->r_num_ops);
>
> I believe that it will be great to have the link to the particular locati=
on of
> this code in the commit message.

I strongly disagree: The location of the code changes with every
commit that adds/removes lines above it (including this patch) so such
a link would be rendered stale immediately. What is your reason for
believing the link is useful?

> > > I don't quite follow. We decrement ceph_wbc->num_ops but BUG_ON() ope=
rates by
> > > req->r_num_ops. How req->r_num_ops receives the value of ceph_wbc->nu=
m_ops?
> >
> > ceph_submit_write() passes ceph_wbc->num_ops to ceph_osdc_new_request()=
...
>
> I think it makes sense to mention it in the commit message.

NACK, that relationship is already memorialized in addr.c. But again
I'm interested to learn your reasoning.

> I think that it makes sense to create the issue in Ceph tracker and to ad=
d
> Closes to the fix.

I don't currently have a Ceph tracker account and don't think I can
add anything of substance to an issue report. Feel free to create the
issue on my behalf if it's important for Ceph's processes, and I can
Closes: tag it in v2.

Cheers,
Sam
