From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Need some help in setting up rbd image with kvm
Date: Tue, 14 Feb 2012 09:24:23 -0800
Message-ID: <CAORUGqBnTbhR0LF4CGa3tXT31HhhobabnwSKt5peVqhUZX37rA@mail.gmail.com>
References: <CAHbZLqR9FxoTLmLvEMBxtsvzb_jfGDBw8pdCnH_S12FQCifVLg@mail.gmail.com>
 <CAHbZLqQXSbsW2zUeDFwvXSr-+siY35sBy5xDye+9TNUbOVHxDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39970 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab2BNRYo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2012 12:24:44 -0500
Received: by wgbdt10 with SMTP id dt10so154840wgb.1
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2012 09:24:43 -0800 (PST)
In-Reply-To: <CAHbZLqQXSbsW2zUeDFwvXSr-+siY35sBy5xDye+9TNUbOVHxDw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Upendra Moturi <upendra.m@hexagrid.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Feb 14, 2012 at 04:47, Upendra Moturi <upendra.m@hexagrid.com> wrote:
> What does mkcepfs do? (A per my understanding from your post ,it is
> used to to initialize filesystem/object store)

Sets up the whole distributed system, including the object store and
if configured, the distributed filesystem metadata servers.

http://ceph.newdream.net/docs/latest/man/8/mkcephfs/

> When we trigger mount ,it is like having a file system ?

If you mount the filesystem, it is like having a filesystem mounted.
I'm not sure what the real question here is.

> Is it correct to create a rbd device on top of this filesystem.(I am
> confused about this.)Bock device is something which we have instead of
> filesystem.

RBD lives on top of the object store, unrelated to the distributed filesystem.

http://ceph.newdream.net/docs/latest/
http://ceph.newdream.net/docs/latest/start/block/

> Can we create a rbd device without filesystem mounted and can it be a
> shared device.

Yes. Yes.
