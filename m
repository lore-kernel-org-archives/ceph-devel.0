Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2744D35DA60
	for <ceph-devel@vger.kernel.org>; Wed, 11 Mar 2026 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245422; cv=pass; b=sdvhoru0SjxgKyR5MygzqGIV5kh71VTjX37NHSvjgmvYr7346KmEnOoxUJxC4hNqljq4YjLms+XKhPByGFkCEnGMpgUnCTgiKIIV9OrDWVgPTv+aaB2nCAgMYrkpperU0+E4c4bTmeBrh2V8okIIXE5oxdAyj+TcJ63vPWflT6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245422; c=relaxed/simple;
	bh=RINC3OxukObTWwNgLj8cUCMQfmLKMyUKoc5ifoxu7lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3i+/3tlXO7Vm1K9F8zhAhOSib9N87YGciM53Z6DnwO2AxC+Uqbqk8uyiOC6BB9O9FxbSuPv/CrzjRUd2vGihx1XIrHaFAd0m/Wv2TWylRTOEozaUMXu0a85RZKhZX9CuFVWwNvoc8+ucsMberGZOOp0y5QFI/qpON5AnWWHscA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=DQI1cRxa; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="DQI1cRxa"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a1330ac6c3so131076e87.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 Mar 2026 09:10:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773245418; cv=none;
        d=google.com; s=arc-20240605;
        b=ADqpYHchV2ppkQRmYaQcF7Wu0Vq7Dy1fXE9lE8GE0ZrnVFrzt3t4D9NW1BrPhBepIK
         MU4SNtt5l231+D+gxsIz8NMNbodojUm5D5uclv96Nu6xDU8sQzEtO/aLlHLOwfjvKkQJ
         6SWFBlArNRFQhLCeSa6jVXplkZN5ofsSbOzdmVMSrRUghZogw1DwsXEsJLKaqEa78OH5
         BCFips3N3cHvJpGRUdr2ZabbWgtyYq+ImvThAkjRPoHeBSLSH0U5HYxBu9CUBfNeFQUi
         KvZiQxG288OELvl4ecPuxF1Ngghuq9yk68GeoR0FK6Cnr9fsvqYXzLGz6/tbOFJ4sltp
         ASyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zQf3bqKM0prJaYagyzgzwBy7UALOn5Wa6w4qvhYX8FU=;
        fh=ADW8jfl0cIFS14mLJWUTJhFsnAs3vq+UHPoAeDLrlQA=;
        b=UfvB8BPk1jvFl23kCpC3kE5zpFenRJNYzlY00Hd5toqBvoadpfz7tC45+taC41yUag
         ozfSUUDMmuylwE/ROY8VRRM8kEwDPoituBqrSw+GyXLnytWSurFzeJvyHTS61YB/vybr
         NhFDOkQVoiGOAKZKzYsLk33C9amIRb6FjENU/O6b0qteZw2qj2p+MnBm7GLEnL1IrIrq
         QZTCRh2NkY1yNzJZUBdZTCEisf/HrzzApA6JiHO3pfHfAKQrOf3LPWoUVysdHCO11o/j
         kYhhSLtFXFP8PkhSg3Oswo2O5HGO+TylDVJD0YHLnoOFZZ+4UDhKEtlSHDNrK8r6tJ4U
         sDqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1773245418; x=1773850218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQf3bqKM0prJaYagyzgzwBy7UALOn5Wa6w4qvhYX8FU=;
        b=DQI1cRxaYaxsZCMcyoPsKK9oceAAMF2Z/4ka0wFpZB8+XmCfMpWDiiF7wWVvKTnenh
         fLiq0/4041WV6SUN9UIAUOBG/CMSj6vFuAOInXJ4NveJurk01cGbF8fRy51alCQzW54O
         UmWAXgDLBXidwZi/zen/FyMiT4+9QZH++ETKQNT+c0cTD2imeB9je4SnL8TKcC48glED
         ooRh8mXUApVARqvWJDY7zkjpZo16/2+cEhSB1AU7m2IZ8+56OmAYPqCj9CJqISqpRtn0
         +Gzbol7v857u1b5Km8cgfWLXwWaOdvanog3a0ycMGHtle6ytBjRh/50KWHHrh5a7Q75q
         +ZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245418; x=1773850218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zQf3bqKM0prJaYagyzgzwBy7UALOn5Wa6w4qvhYX8FU=;
        b=C6QXYQA3kq/kl/fTdBOmrykI1r50ER1yv5AGMNCVWo7QRlkyY7h16cUi/0DcSOF1uB
         v9qEq0VM5H0fGJn2oVMaN4KC04R+x23SOp0LTOFuUS+7UvMPx9XiD/flQOYoQisjjb0C
         FzUi0X8YpMkRpULi2CYt6Q40PzAxczKHfJyUOlMOBsI+jtv3D52AG/NZoK4ZhHv2yl37
         eix1nbT7D/usRR6M90cl4ZNAyh44dPFwYEmDZX9uWFRpzfUdVjkMPsW8J9Q7WDE5r8Vg
         AvvKjo6Z1eoVi54JvIhdtdER/KV05rdBGp1/ruViCRyaiKOFOIArX9zz7ixyuBVvZnUL
         RqFw==
X-Forwarded-Encrypted: i=1; AJvYcCUP0UZKQV7kIjoCvusat4OwXb8s2TzZMy36xqxXqX/qR7SaM5fyqXnlceXy1p+UKYyPV9bp2qw+hgim@vger.kernel.org
X-Gm-Message-State: AOJu0YzO15zYMATh+MBUvxYhYxREPwnhX/ophhAgAz5l1s6NtSAUXMPX
	QHPTT1LeO7ApyoM7YPI2NPH+7jXga67LJdSXhnX1pFtv6HGbBnDF7smKUtt3xgYyMrQ1HArr1M9
	axxfxlDTKcaVYQ0eh4cDJzPVOVQN017veit6dq5yf
X-Gm-Gg: ATEYQzya99x/U+2NpUssb4wdtkEmIoLtgdI3ViyZU+R5QBwh7WdWFahpSUkI9cMWe4A
	rN4x7cBLz1zqRP0p17q9eQvN8q691WQYMFWz+aIk5U0FI9pKufTLDl7sRi7gZ/LUaPsCV9PIYX8
	4faNPVlWBQj2g+tIz4ui3oEJ+gzVMa7/ldbCml6FTTtqnGWxFWkAUiC9cze1SMk8U7A8fPYhpwI
	eyHmITBzhY4JxZwEUCOmgNKidAtri7dUjbBoUMeF/pU3vFIr/LXFpK5IrPgKjHdys18WWpqLLXc
	IVa1
X-Received: by 2002:a05:6512:712:b0:5a1:4835:306f with SMTP id
 2adb3069b0e04-5a156baf0a8mr762062e87.19.1773245418128; Wed, 11 Mar 2026
 09:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
 <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
 <CALCETrVt7o+7JCMfTX3Vu9PANJJgR8hB5Z2THcXzam61kG9Gig@mail.gmail.com>
 <20260309-umsturz-herfallen-067eb2df7ec2@brauner> <2026-03-11-regular-sore-census-shops-DqYcUT@cyphar.com>
In-Reply-To: <2026-03-11-regular-sore-census-shops-DqYcUT@cyphar.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 11 Mar 2026 09:10:05 -0700
X-Gm-Features: AaiRm51EXHFpn1BAVpxsTY5E2VQC7PD0Lwp6wdRjddj9MKMq4N9OfHTiuPJrR94
Message-ID: <CALCETrVMF3VBr0cuEYOg-M_u+hX77Jfdujv3ZMtLGCzHgOcsGA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Dorjoy Chowdhury <dorjoychy111@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 9:49=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2026-03-09, Christian Brauner <brauner@kernel.org> wrote:
> > > > On Sat, 2026-03-07 at 10:56 -0800, Andy Lutomirski wrote:
> > > > > I think this needs more clarification as to what "regular" means,
> > > > > since S_IFREG may not be sufficient.  The UAPI group page says:
> > > > >
> > > > > Use-Case: this would be very useful to write secure programs that=
 want
> > > > > to avoid being tricked into opening device nodes with special
> > > > > semantics while thinking they operate on regular files. This is
> > > > > particularly relevant as many device nodes (or even FIFOs) come w=
ith
> > > > > blocking I/O (or even blocking open()!) by default, which is not
> > > > > expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk=
 I/O. Consider
> > > > > implementation of a naive web browser which is pointed to
> > > > > file://dev/zero, not expecting an endless amount of data to read.
> > > > >
> > > > > What about procfs?  What about sysfs?  What about /proc/self/fd/1=
7
> > > > > where that fd is a memfd?  What about files backed by non-"fast" =
disk
> > > > > I/O like something on a flaky USB stick or a network mount or FUS=
E?
> > > > >
> > > > > Are we concerned about blocking open?  (open blocks as a matter o=
f
> > > > > course.)  Are we concerned about open having strange side effects=
?
> > > > > Are we concerned about write having strange side effects?  Are we
> > > > > concerned about cases where opening the file as root results in
> > > > > elevated privilege beyond merely gaining the ability to write to =
that
> > > > > specific path on an ordinary filesystem?
> >
> > I think this is opening up a barrage of question that I'm not sure are
> > all that useful. The ability to only open regular file isn't intended t=
o
> > defend against hung FUSE or NFS servers or other random Linux
> > special-sauce murder-suicide file descriptor traps. For a lot of those
> > we have O_PATH which can easily function with the new extension. A lot
> > of the other special-sauce files (most anonymous inode fds) cannot even
> > be reopened via e.g., /proc.
>
> Indeed, I see OPENAT2_REGULAR as a way of optimising the tedious checks
> that userspace does using O_PATH+/proc/self/fd/$n re-opening when
> dealing with regular files.

Can you give a brief decription or a link to what these checks are and
what problem they solve?

--Andy
