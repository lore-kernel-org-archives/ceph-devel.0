From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Ceph setup on single node : prob with "
Date: Tue, 14 Aug 2012 09:11:12 -0700
Message-ID: <CADvuQRFzjzKO4OC20jvKZMKUx29o5sKmjxVFAm2vqAc2eufiMw@mail.gmail.com>
References: <CAGfy=6mCWNY4mn2_H3b=8FENmY=2SGXUB78RObprSdvzye_h1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:38122 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab2HNQLd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Aug 2012 12:11:33 -0400
Received: by vcbfk26 with SMTP id fk26so498511vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 14 Aug 2012 09:11:32 -0700 (PDT)
In-Reply-To: <CAGfy=6mCWNY4mn2_H3b=8FENmY=2SGXUB78RObprSdvzye_h1g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Aug 14, 2012 at 3:13 AM, hemant surale <hemant.surale@gmail.com> wrote:
> 2012-08-14 14:31:29.390410 7fe3b920e780  ** ERROR: error creating
> empty object store in /ceph_data/osd.0: (2) No such file or directory
> failed: '/sbin/mkcephfs -d /tmp/mkcephfs.n6zx4y4y33 --init-daemon osd.0'

Sounds like /ceph_data/osd.0 does not exist. You need mkdir it, and
you probably want to mount a disk there.
