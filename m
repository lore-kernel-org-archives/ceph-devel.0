From: Tommi Virtanen <tv@inktank.com>
Subject: Re: mds dump
Date: Fri, 8 Jun 2012 08:52:51 -0700
Message-ID: <CADvuQRF5-hEhHtA_VoyuV0VhpTZ_YY_md4Mc=0-82Cb6D2EvLw@mail.gmail.com>
References: <9CFDA4F85EA1425B888F7F62DA77038E@inktank.com> <a1cf1173-9a9c-49b9-8f76-6a8267c692b3@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61476 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755122Ab2FHPxM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 11:53:12 -0400
Received: by dady13 with SMTP id y13so2518330dad.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jun 2012 08:53:11 -0700 (PDT)
In-Reply-To: <a1cf1173-9a9c-49b9-8f76-6a8267c692b3@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Wilderoth <martin.wilderoth@linserv.se>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jun 8, 2012 at 12:35 AM, Martin Wilderoth
<martin.wilderoth@linserv.se> wrote:
> And if i just want to mkfs or similar in mds is that possible. Or or my rbd will
> also be removed ? Or how should I recover if I don't care of the data in
> the POSIX file system ?

By default, the Ceph Distributed File System puts file metadata in the
pool "metadata", and file contents in the pool "data". RBD images, by
default, are stored in the pool "rbd". This means you can empty/remove
the pools "metadata" and "data" without affecting RBD.
