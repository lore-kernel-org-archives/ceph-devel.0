From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Ignore O_SYNC for rbd cache
Date: Fri, 12 Oct 2012 09:54:00 -0700
Message-ID: <CADvuQRFLUsg9JJN5J1=LU4c8PBQGsxS20ev12mXpqtNZ55o=VQ@mail.gmail.com>
References: <CABYiri87Kni9+XkS2JWymxocJF9bCYpPswYFiBkeEOk6CSeMQw@mail.gmail.com>
 <alpine.DEB.2.00.1210100919020.8499@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:48686 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759896Ab2JLQyW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Oct 2012 12:54:22 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so606063qaa.19
        for <ceph-devel@vger.kernel.org>; Fri, 12 Oct 2012 09:54:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210100919020.8499@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Andrey Korolyov <andrey@xdel.ru>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Oct 10, 2012 at 9:23 AM, Sage Weil <sage@inktank.com> wrote:
> I certainly wouldn't recommend it, but there are probably use cases where
> it makes sense (i.e., the data isn't as important as the performance).

This would make a lot of sense for e.g. service orchestration-style
setups where you run an elastic pool of webapps. The persistent
storage is the database, not the local disk, but you might still e.g.
spool uploads to local disk first, or have a local cache a la varnish.
Crashing a machine in such a setup tends to mean deleting the image,
not trying to recover it.

Also, for anyone running virtualized mapreduce worker nodes.. Cephfs
plugged in as the FS, compute wanting local storage for the temporary
files, but crashes just mean the task is restarted elsewhere..

(Now, in both of the above, you might ask, why not use a local disk
for this then, why use RBD? Because a lot of people are interested in
running diskless compute servers, or ones booting off of a minimal
SSD/SD-card, with just the base OS, no vm images stored locally.
Tremendously helps with density, especially on low-power platforms
like ARM.)
