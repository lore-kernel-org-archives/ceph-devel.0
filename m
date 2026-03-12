Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B7377016
	for <ceph-devel@vger.kernel.org>; Thu, 12 Mar 2026 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773359605; cv=none; b=e7aorVGH3PcSwydVb6u0pxubW8xZpDfPQgPhrR0PZ7BWKmw4Ut+0Eav50DvcmuM/gISr13V1KJgMU1nZ4U9op7MPzXMwmwgqXfuRMkeQ1v4lRJh/5ITOxm49aCTJnqJlffnUgIKJU/zGZgaO2W43Q4ldqezp0wQGk5upn3dtoAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773359605; c=relaxed/simple;
	bh=wOUC16WI4/reo5GvoZO5ESmt8rfD7PE3++Xf9novjKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0qTii/isjsIwqJ2vbV5u1v6OxiZpkc53pv6A6OJ7Z+TnsBnXM/xwbGtVu1cJW1GMVmVCNSX5qfazZh0nd11mqyq/kGFMyKnQKEp1UGGxXKUa/dZfMyiJUk5n2Etc9Ov06/M8LtGmoryRXR+hAcZC4KzwV+PGQYa3hBhmP5YbCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=evAwiimS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="evAwiimS"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-662a1855af2so2635263a12.3
        for <ceph-devel@vger.kernel.org>; Thu, 12 Mar 2026 16:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1773359602; x=1773964402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pkgvHL0resGmXTqRBi16uC1NxLEncxIx9i+VLjGIXAo=;
        b=evAwiimSAPJAsab6pwOzUhKFLi7xiPwZHJPSkAuehfFrDDfPKG635yr3YueuRazZkr
         tkH1bTMbrhgGivUwEVjaip/4AeqhP8KHQmtHv+GmnSWfXTO6l5u5I7ms2BNKK9UM7C6V
         5IKG+5PijEYthsspUSdrP835oBOX/ertWyk1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773359602; x=1773964402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkgvHL0resGmXTqRBi16uC1NxLEncxIx9i+VLjGIXAo=;
        b=EjP1/b4e/HkhfMQsvnaxXFa3Kf+r/cTlQU0Hcy2q0TBhSpYWoYLmwLpNa1wAefiXpw
         PsHfLmY+pMiniTEOABVkChLXfbWQofZW10FtDFrKANY6gzU8N1iVI5Yk5leoq4yBdsfu
         aw6JwoHnjg1lOK0B3EXFWxFxLEysbL9ZKg1BwfsnUcHtyvZNodbMrIjoxOvMWOd+laYI
         d4jk+OXfMC60ikv4UidZXYbR/n7Ocv77w+2yQu9b2euNh2xta7oDwIIZpoNIxhcAF/6w
         2cIFUGQQ3jOANXYzw1PagsobPlDbIaS7xPlM5HOHpFkxoZmmxtwhr5+LhkerQKhTks3L
         LHow==
X-Forwarded-Encrypted: i=1; AJvYcCWrgzvRnQBfqAPSI3EKiwfB/djgn/2rBnqvPU1YsUkRfgxZ1D7WFT+wwLoQfiK83uN+BYsz0I6fYlJi@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp7ZJdOLRdyttCU4Y6SakkxO0FSryeENnCI9E9BYVj1ommxnuG
	jAGCPSA8Ec7+MoKhZWoF6/ZQvGT+jvSsZXnYgAXylik4qgPWhpsvP2kXTpnbt28unIrCokMNTh0
	Hp6ZSQyg=
X-Gm-Gg: ATEYQzwKfOwFey0lc96hSydStReQ4Bn5LV9J85vUOrrV366S/2SFxUXYcbUex/s8fPg
	piMbhzh03Rpwjwf/HKzwBlnZgfnDWyIXS6zfkdB3bCZfMOHD2FgNpdXNo4fifmDauudMy+0B0lY
	GfZZy83ZAa+fbyy3Bg+jO+Slqtbw6FqRJA58u3Po+Lhg91EsBD8wYe3K8KwJjZV7YKfuLvhGylJ
	2siaOne5QABMM3ExH3YW0JxLUB0b3mucGYrdWIxK2/OAIw1iIRAskaZj0jrbEYS+CXQLU2iKB4V
	B2YX1e8WCEhbL7bxruXvlzjNgD4Dx4sJVA1M0qKPVlOJlshsU/l5xP6lKDwdhXM0VoZ1AXMAEWy
	msuhBcS+D0t0fZkOsfsERFvAsreerYQ9wUUo63OzRJ9K7aCWCbgxl9yIwyDfihK/O3JIuEfT56y
	JS/Urpt8wLocrpy6WZTTTi0YwWA+xG5Xz+gRMQEBQ/R1krG1I54gXpNUnZMLyNWlKkg/2/ZIxAq
	Z0DBxI97hc=
X-Received: by 2002:a05:6402:1473:b0:662:a5b0:2548 with SMTP id 4fb4d7f45d1cf-663babc80ecmr708509a12.14.1773359602478;
        Thu, 12 Mar 2026 16:53:22 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-663509919c9sm949097a12.23.2026.03.12.16.53.22
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 16:53:22 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b976e181895so2744666b.1
        for <ceph-devel@vger.kernel.org>; Thu, 12 Mar 2026 16:53:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRxMFg3gG88xFFl5gjZgsI/9NVDCiFAy/9h6GBfoZI6KFtEGjBdLHyztDY7Gg0+N3FcP7TCE0PPwWH@vger.kernel.org
X-Received: by 2002:a17:907:c5c9:b0:b96:d802:8b41 with SMTP id
 a640c23a62f3a-b9764fd8722mr66207066b.15.1773359215961; Thu, 12 Mar 2026
 16:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312214330.3885211-1-neilb@ownmail.net>
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Mar 2026 16:46:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh92deXvH5iXCo9mThXCBYt-jRcVu=z4kiH-f3+wZQOHA@mail.gmail.com>
X-Gm-Features: AaiRm503fTaccEgKNbxF9h_dDHM9fUsSr52XJuxzTwCI0G9L03uDq8g5di1zchk
Message-ID: <CAHk-=wh92deXvH5iXCo9mThXCBYt-jRcVu=z4kiH-f3+wZQOHA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/53] lift lookup out of exclive lock for dir ops
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Carlos Maiolino <cem@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Steve French <sfrench@samba.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, Tyler Hicks <code@tyhicks.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, coda@cs.cmu.edu, linux-mm@kvack.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	ecryptfs@vger.kernel.org, gfs2@lists.linux.dev, linux-um@lists.infradead.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Mar 2026 at 14:44, NeilBrown <neilb@ownmail.net> wrote:
>
> This patch set progresses my effort to improve concurrency of
> directory operations and specifically to allow concurrent updates
> in a given directory.

I only got about half the patches, but the ones I did get didn't raise
my hackles.

HOWEVER.

This is very much a "absolutely requires ACKs from Al" series. Al?

Also, because I only got about half the patches, and there's 53 of
them total, I'd really like to see a git branch for something like
this. It makes it easier to review for me, and I suspect it makes it
easier for some of the test robots too.

But again - this needs Al to look at it. Iirc he had some fundamental
concern with the last version - hopefully now fixed, but ...

                 Linus
