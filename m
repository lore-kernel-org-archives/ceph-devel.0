From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Best insertion point for storage shim
Date: Fri, 24 Aug 2012 09:28:43 -0700
Message-ID: <CADvuQRGfvNACdY2zMaGx29-w4ENCYCOTQXK4fz2K3zaTBCzzdQ@mail.gmail.com>
References: <00b201cd8210$077de070$1679a150$@netmass.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:35492 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964841Ab2HXQ3E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Aug 2012 12:29:04 -0400
Received: by vbbff1 with SMTP id ff1so2273754vbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 24 Aug 2012 09:29:03 -0700 (PDT)
In-Reply-To: <00b201cd8210$077de070$1679a150$@netmass.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stephen Perkins <perkins@netmass.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Aug 24, 2012 at 8:49 AM, Stephen Perkins <perkins@netmass.com> wrote:
> I'd like to get feedback from folks as to where the best place would be to
> insert a "shim" into the RADOS object storage.
...
> I would assume that it is "possible" to configure RADOS to store only 1 copy
> of a file (bear with me here).

RADOS stores objects, not files.

The Ceph File System stores file metadata in mds journals and
directory objects, and file data striped over several objects.

> I'd like to see where it may be possible to insert a "shim" in the storage
> such that I can take the file to be stored and apply some erasure coding to
> it. Therefore, the file now becomes multiple files that are handed off to
> RADOS.
>
> The shim would also have to take read file requests and read some small
> portion of the fragments and recombine.

Sounds like you want a client library on top of RADOS.

Getting that even remotely performant is going to be a huge
engineering challenge. Zooko will tell you that Tahoe-LAFS ain't a
filesystem, largely for that reason (and if you do run into him, say
hi from Tv!).

Good luck!
