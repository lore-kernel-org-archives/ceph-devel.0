Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08103FFF8E
	for <ceph-devel@vger.kernel.org>; Tue, 13 Oct 2026 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888270; cv=pass; b=KbaTSbalWq+MSsvWJTjGJVMwc11go+vqOtb3gbsQa+OP7rkkPYK1Z0kHKoAZGpQv95ITK9FyPoKzDtI6rJCNscT7K5PChGAkwxTica0zOGMpF7xHvY4Y1SoTR2kaQ+ve53UOm0lEdiybu98dP1za7fmQckmz11wOYtUThArP1qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888270; c=relaxed/simple;
	bh=PelTeFwd5ud7mnoUu0LqIyINYO9v9og7hyCKjE+gurc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIzGt7tBcx0xhTRO/2EYFVmGSBZpLVrB74uUbGE9lUWjQKnqc3dSSkqGe/Exfh0Fw5+ny5Mv93uhtEbRbzFGz26BLEgpPiUFNZbO7Lxj86140N+qeE2y4aeu2W7TBpaAZwqiC5EZIycqmP+ex+9RvGbE9jVb7FPTGObwpQTXFmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=gck7VaMl; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dneg.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b="gck7VaMl"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2533d83e3bso444134966b.2
        for <ceph-devel@vger.kernel.org>; Tue, 13 Oct 2026 03:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791888266; cv=none;
        d=google.com; s=arc-20260327;
        b=ELrHAl2r1mViXIMSnVrdj9taHoABeUl4WVTlUCUM0FJUPuf4zMiRWRqjVn+V7n0GXL
         6Gh0hTFZof5UCRYfFR9Jp7dk+5tKiJ0oCANbTcSJ40sDamdrcTfFraJR8VSSYKNE5eL1
         lpCCVJSeP2NsJ+bPXZ8BnUVvCzFIo1tEx4oe1nM/I7BNe+Gm6GYszRcxanIsLkyWdKnU
         tW5gZ69j/gbPfe9aIlSquRJC8W1T+ppL77cyLWiiB3LcuIQ5VHp2Mysf9UQStUEtZ9tP
         YEnSE8OlwH1yCCAVh2C64oHELdhKz/vwXhAWw6CMGz2Y/ltIw56Zc7qLC45M/VhKCqZp
         zTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VgQkjFUz0Kq5wc1rWCSsIQFYXBAR5PgY4WxoDpZtyJ0=;
        fh=TXKvTWjQ71CNrj2805ha/Q2lkeJ0m5AFDSqHebb9Mr8=;
        b=EJCJAiOW3TDZIkSpOxhKZjUOAVOI62XM8re8ddsOQD3KP0omZqfCQ4Ub4gG/0eF/hh
         KYrKOjrVXtRypw576+U4sUWFK05RxXRPUrgIzzMP1XRM2CU/DW9oa7ksTOQurKVSamy7
         W0LcEFJRmAVNmfP8LcMpPjGBqqMXOObWtN94GO5MG5VyR4qPbWJuNywO/pcN+r5EjSW+
         ewIDbF4uOtt9WUl3CaISYd6MGwpH4/MXEg6hkO/+ml/piJurJJqEV9qBzmn0NPWserSB
         L0o8dS6TE42h9e5Fci1X8BYyu+2Ayg0W3bJqtD4k1cbumciiX7GxDpOwFVvyzkiUrx1o
         OF0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1791888266; x=1792493066; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VgQkjFUz0Kq5wc1rWCSsIQFYXBAR5PgY4WxoDpZtyJ0=;
        b=gck7VaMl9gcL84eP8I+O7XFVaRMAXN6pEnxSTX8FKeidGYyKNMx+YcLwu0K7LxYoUK
         nDnK0G8M2FBftMiprV5VwHcjKTZHtjc5lpooiTAj5JJUwCxIIcldbHCZMj1Dz6Q0Ej/L
         ivD72FESyuIzPwwjlFbDSk2LA93s977Gx/5ouKQS90Dg8FT4/nWh2LrjVvu0NMJYVW92
         FnAQIGyXPq/yQ1ikVZUzn+KD1PITIxrYQAibQFChol5qm4oFPYIYgtZEkXC5OEOPSWQu
         rZvLUCvFpw40ktlZcHNaL5NK0LpEdEVkLBnyOywDjw5t806PBL8Vyk057kqOz/wHMrhw
         WmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791888266; x=1792493066;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VgQkjFUz0Kq5wc1rWCSsIQFYXBAR5PgY4WxoDpZtyJ0=;
        b=iyaFADlzDMFm+QC7rmJv2QLqZZ43EoNdgoOtDupm6ksBpQhFUxh7rMuuUjLetd6nvA
         vrpBGwR6kGMGAoOMp8vgiVcZCSOKFj3m8yGS/fnxQenLy2UrNDrqWYR+yOdFPRJnRQY6
         cLGWZzmz7acw5EAL4Z+4G0K2y779FtQkLwzLZdFWg8XhPW5iQDOUZfq+1oDjcd8RmxzQ
         Li+ZqYYkqOfslB4vphZUwfxDf+OYIX8VdRaunqECj1SNqTOhmDw+VtTkfv+p/iUkT54r
         0EWMZ6d22rv9wRlHmXxp9WOb6Pn6K+rignGxRbfxuBABJbJpKAPD/5QpqEqwXxKCfzcB
         7MtQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMmItIK67Lvq4qztM/b+JvSnBCtonCyMkyCN8RaA0Zhhl2K52G1KBDEXDvOrpB25CqNOwyF4udsWG2@vger.kernel.org
X-Gm-Message-State: AFq9FYKU/pxg1kfAe59JST8jK1tFy45Amxtks1Z0sLBsbIhtEtOjzCaO
	V2HBb3EIB2kjnp6e9o1kzeL5cLCastNw8ul4id+oLO5jBnli4KYGVjAlt6gW2CxhXI3H9MM+eKu
	GRiQI4Grxxj1UjqPSWrTE402K7qpfEWPFVFHQPVZjqQ==
X-Gm-Gg: AYBFou3oe+kkpGnIZpOQbMT56lPVChPgG1ba+o63HMi0F7Rpk2FvzJGvM4m/xoiKbnH
	mtQA2CLXRWDgEnFhXbipOGyn00Vm9mzGbD5vJ+vG2WdD7Y0K9I92Yir6F+fNyZde0H+DF6a0fcb
	R4UbSQBV7e75S0WNVetPXA9Twmu9QsY+//0jxOGY/q7gWhcxXJwE76bTqkmv6mFcayFCa9sApBV
	6Li661Z6cSRZeM9lw7Lc5LxZK7wXVZXsIPdMwc0QtKJ6AwKL7oWwzKhVbkVM9sgLYpCn1uaNDzu
	GrHaslrZzWgGv44Ky1N0y8YxnGjHBsVdI3Xwb8oFygeQlarTI7p9xelU+CG7Rrl/Gfbf57w8c8a
	3D8SNoSh2ne0=
X-Received: by 2002:a17:907:e158:b0:c34:e9fe:82ed with SMTP id
 a640c23a62f3a-c34e9fe8db4mr344907066b.28.1791888264638; Tue, 13 Oct 2026
 03:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910220242.2165023-1-dhowells@redhat.com> <20261011.cachefiles-seek-hole-walk.pchmelar@innovatrics.com>
 <1655915.1791879248@warthog.procyon.org.uk>
In-Reply-To: <1655915.1791879248@warthog.procyon.org.uk>
From: Daire Byrne <daire@dneg.com>
Date: Tue, 13 Oct 2026 11:43:48 +0100
X-Gm-Features: AclHuK_oVCRmnPd9NH08Wt-JPyd6g1EMor68YJAilUyzKCf7DPZ-awFW_Pr3mM8
Message-ID: <CAPt2mGPPYTv=mBo=ysFt49t9=6AVh=P4uvHh4EwZ4Xh=ZULo=Q@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] netfs, cachefiles: Changes for next, primarily
 occupancy tracking-related
To: David Howells <dhowells@redhat.com>
Cc: Petr Chmelar <petr.chmelar@innovatrics.com>, Christian Brauner <christian@brauner.io>, 
	Paulo Alcantara <pc@manguebit.org>, Matthew Wilcox <willy@infradead.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Marc Dionne <marc.dionne@auristor.com>, 
	Stefan Metzmacher <metze@samba.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I don't know if it's particularly useful (or relevant), but we set an
extent hint size of 8MB on the backing XFS filesystem for
fscache/cachefiles.

For our workloads (mostly larger files), this seems to work quite well
in keeping down the extent counts on the cachefiles objects. It's
perhaps not very space efficient at first, but it seems to improve
over time as more data is cached.

Also, compared to XFS, ext4 seems to do a better job of keeping the
extent counts lower even without an extent hint.

In terms of granularity, I think we'd be fine with something like 256k
(as we are with 8MB). But we would still want to be able to cache a
wide range of file sizes (4k -> TBs).

We also have a particularly horrible random IO 4k workload where the
files are MBs on disk but get read in random 4k chunks over a few
hours. We specifically detect these reads and have a (readahead)
daemon that goes and reads the entire file into cache rather than
waiting for it to grow organically (in 4k chunks).

Daire


On Tue, 13 Oct 2026 at 09:28, David Howells <dhowells@redhat.com> wrote:
>
> Petr Chmelar <petr.chmelar@innovatrics.com> wrote:
>
> > The cover letter leaves non-contiguous objects, which still use
> > SEEK_DATA/SEEK_HOLE, for a later series.  We hit that case badly in
> > production, so here are numbers in case they help with its priority.
>
> I know.  But it's a tricky problem to solve as I need to store a map of the
> content somewhere.  xattrs are painful as I can only read or write them
> atomically and as whole blobs - and also I'm not sure if I need to limit the
> size of any given xattr to 512 bytes.  Further, the xattr wangling interface
> inside the kernel assumes a flat virtual buffer rather than taking an I/O
> iterator.
>
> I have patches that store a bitmap in an xattr, with 1 bit per 256K block of
> cachefile, for a 512 byte xattr able to map up to 1G of file size.  I need to
> revisit this at some point soon.  It may be better to switch to storing an
> extent list, but:
>
> > On our NFS clients (Ubuntu, v6.8, cache on XFS), a sequential read of a
> > fully cached 184 GB object with 1,080,732 extents ran at 0.4 MB/s.
>
> Trying to store a million+ extent records in a single xattr would kind of
> suck.  Now, it might be possible to collapse that somewhat if a lot of the
> extents are virtually sequential within the file, since I don't care about
> physical sequentiality.
>
> Also, can you tell if you have a preferred cache granularity?  Would a 256K
> granularity, say, use too much space?
>
> > I expect the right fix is for cachefiles to track what it has written
> > itself, as CONTENT_ALL now does for contiguous files, rather than
> > something like the above.
>
> Indeed - as mentioned above.
>
> > I can send the workaround if it's useful as a reference,
>
> If you could, that would be great!
>
> > and I'm happy to test whatever you plan for this case on our workload.
>
> Thanks.  Now I just need to reproduce your bug.  Note that I posted another
> cachefiles patch that Christian hasn't picked up yet:
>
> https://lore.kernel.org/linux-fsdevel/1091807.1791483394@warthog.procyon.org.uk/T/#u
>
> David
>
>
