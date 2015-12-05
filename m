From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: CephFS and single threaded RBD read performance
Date: Sat, 5 Dec 2015 15:17:29 +1100
Message-ID: <CA+z5Dszo2TgzBcydD+0YnB-2xjV7enCfhfON2BqVgAOBUs2gUQ@mail.gmail.com>
References: <loom.20151204T201858-143@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:32979 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbbLEERt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Dec 2015 23:17:49 -0500
Received: by obbww6 with SMTP id ww6so86192591obb.0
        for <ceph-devel@vger.kernel.org>; Fri, 04 Dec 2015 20:17:49 -0800 (PST)
In-Reply-To: <loom.20151204T201858-143@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilja Slepnev <islepnev@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Ilja,

On 5 December 2015 at 07:16, Ilja Slepnev <islepnev@gmail.com> wrote:
> fio shows 70 MB/s seq read with 4M blocks, libaio, 1 thread, direct.
> fio seq write 200 MB/s

The fio numbers are from fio running on a CephFS mount I take it?

> # rados bench -t 1 -p test 60 write --no-cleanup

I don't see an rbd test anywhere here...?

I suggest comparing fio on CephFS with fio on rbd (as in using fio's
rbd ioengine), then at least the application side of your tests is
constant.

Cheers,
~Blairo
