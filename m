From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Can I use btrfs-restore to restore ceph osds?
Date: Thu, 10 May 2012 13:55:45 -0700
Message-ID: <CADvuQREPFrWEV+mPSxnW3ANiYh94SO62dSFY9ZQuz3JyWkjgMg@mail.gmail.com>
References: <8973610.uuSzCzFUvq@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61004 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757449Ab2EJU4G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 16:56:06 -0400
Received: by pbbrp8 with SMTP id rp8so2387232pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 May 2012 13:56:06 -0700 (PDT)
In-Reply-To: <8973610.uuSzCzFUvq@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

On Wed, May 9, 2012 at 10:15 AM, Guido Winkelmann
<guido-ceph@thisisnotatest.de> wrote:
> I'm currently trying to re-enable my experimental ceph cluster that has been
> offline for a few months. Unfortunately, it appears that, out of the six btrfs
> volumes involved, only one can still be mounted, the other five are broken
> somehow. (If I ever use Ceph in production, it's probably not going to be on
> btrfs after this... I cannot recall whether or not the servers were properly
> shut down the last time, but even if not, this is a bit ridiculous.)
>
> I cannot seem to repair the broken filesystem with btrfsck, but I can extract
> data from them with btrfs-restore.

OSD uses btrfs snapshots internally. Any restore operation would have
to bring the snapshots back exactly as they were, too. It seems
there's a -s option for that, but whether things will work out is hard
to predict.. since it was a test cluster, perhaps you're better off
scrapping the data and setting up a new cluster.
