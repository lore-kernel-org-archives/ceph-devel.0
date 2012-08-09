From: Tommi Virtanen <tv@inktank.com>
Subject: Re: [PATCH] make mkcephfs and init-ceph osd filesystem handling more flexible
Date: Thu, 9 Aug 2012 10:12:14 -0700
Message-ID: <CADvuQRHf=_nQetqmghUp7Mbe-QtcfOYfkdRkTJQhbBpzSGXDRg@mail.gmail.com>
References: <1344526971-17035-1-git-send-email-danny.kukawka@bisect.de>
 <CADvuQRGLUpPT=RxYqptGq+9Ku2dNiKLsdY8a=KjjfoquucBc7w@mail.gmail.com>
 <5023E96E.30209@sandia.gov> <CADvuQRG9DrG6irjuD8ZZcAz_grgS=9i6M6GDV0-gYWfAyje4uw@mail.gmail.com>
 <5023ED56.9070102@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:58450 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab2HIRMg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Aug 2012 13:12:36 -0400
Received: by vbbff1 with SMTP id ff1so183735vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 09 Aug 2012 10:12:35 -0700 (PDT)
In-Reply-To: <5023ED56.9070102@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Kukawka <danny.kukawka@bisect.de>
Cc: ceph-devel@vger.kernel.org, Jim Schutt <jaschut@sandia.gov>

On Thu, Aug 9, 2012 at 10:03 AM, Danny Kukawka <danny.kukawka@bisect.de> wrote:
> So you mean chef?! Will there be an alternative to simply setup a
> cluster from console?
>
> We (SUSE) are already working on an own chef ceph cookbook. But from
> what I've seen till now it's really hard and more laborious to initially
> setup a cluster with chef than with mkcephfs.

I've written about this on the mailing list several times. We see a
lot of demand for Chef, but don't want to tie our hands -- Canonical
is working on Juju Charms, and I would like to see a mkcephfs
replacement that relies on just SSH connections from a workstation
node. We've made an explicit effort to improve the product as a whole,
and to make the Chef cookbook as thin as possible.

For some reason, the threading is broken on the archive, but this is a
fragment of the most recent thread that talked about this:

http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/8263/focus=8265
