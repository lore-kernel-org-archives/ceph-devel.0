From: Iago Abal <iari@itu.dk>
Subject: Fwd: Potential double mutex_lock bug in net/ceph/auth.c
Date: Mon, 27 Jun 2016 15:42:20 +0200
Message-ID: <CAGbDTvqLfpdb=iOL63WtpeXNRwUe8scgn0P77GBRmBUTQrukMw@mail.gmail.com>
References: <CAGbDTvo5zF_vO7KwG8frD7H0gf3fkJc_oTXiZ=tKbiD9GpPXmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-am1on0145.outbound.protection.outlook.com ([157.56.112.145]:19008
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751644AbcF0PQ3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Jun 2016 11:16:29 -0400
Received: by mail-wm0-f41.google.com with SMTP id a66so116102563wme.0
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jun 2016 06:43:02 -0700 (PDT)
In-Reply-To: <CAGbDTvo5zF_vO7KwG8frD7H0gf3fkJc_oTXiZ=tKbiD9GpPXmQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, zyan@redhat.com

Hi,

I'm testing a static bug finder (EBA) on Linux 4.7 release candidates
and I may have found a potential double lock:

  Double lock in net/ceph/auth.c
  second lock at 108: mutex_lock(& ac->mutex); [ceph_auth_build_hello]
  after calling from 263: ret = ceph_auth_build_hello(ac, msg_buf, msg_len);
  if ! ac->protocol -> true at 262
  first lock at 261: mutex_lock(& ac->mutex); [ceph_build_auth]

This seems to have been introduced by commit e9966076cdd9 ("libceph:
wrap auth methods in a mutex").

If that's in fact a bug then I can help with a patch.

Thanks,

-- iago
