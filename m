From: Tommi Virtanen <tv@inktank.com>
Subject: Re: OSD per disk.
Date: Tue, 29 May 2012 09:24:46 -0700
Message-ID: <CADvuQREXJ7bDGLNZ+FU2sdCHRwQFt2Lfzy4XLQMTVWbLupWYJg@mail.gmail.com>
References: <loom.20120528T111434-469@post.gmane.org> <7b7fb8cc-28f2-4504-80a8-67678f70aa7d@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51510 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524Ab2E2QZH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 12:25:07 -0400
Received: by pbbrp8 with SMTP id rp8so6162970pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 29 May 2012 09:25:07 -0700 (PDT)
In-Reply-To: <7b7fb8cc-28f2-4504-80a8-67678f70aa7d@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: chandrashekhar <chandubigc@gmail.com>, ceph-devel@vger.kernel.org

On Mon, May 28, 2012 at 2:34 AM, Alexandre DERUMIER <aderumier@odiso.com> wrote:
> maybe try
>
> [osd.0]
> host = testnode
> osd data = /data/osd0
> osd journal = /data/osd0/osd0journal
> osd journal size = 1000

That shouldn't be needed. osd.0 will happily read the [osd] section in
the config file.
