From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: librados::ObjectIterator segfault
Date: Sun, 2 Mar 2014 21:12:56 +0200
Message-ID: <CALFYKtAR7uOxqjtQcTCbiwA=+Z3wGv-vP0tmkx9sGKs4knb2_w@mail.gmail.com>
References: <CA+Hcz58=sbXMpKAGZGvkmZXGFBFbP1FyST2UJ4RM9yex1bM-3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:44210 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbaCBTM5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 2 Mar 2014 14:12:57 -0500
Received: by mail-ob0-f177.google.com with SMTP id wo20so3641496obc.36
        for <ceph-devel@vger.kernel.org>; Sun, 02 Mar 2014 11:12:56 -0800 (PST)
In-Reply-To: <CA+Hcz58=sbXMpKAGZGvkmZXGFBFbP1FyST2UJ4RM9yex1bM-3Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Mar 2, 2014 at 8:38 PM, Noah Watkins <noah.watkins@inktank.com> wrote:
> This is a segfault occuring in the latest master listing objects with
> `rados -p data ls`
>
> Full trace: http://pastebin.com/3JG9cX0Z
>
> nwatkins@kyoto:~/ceph2/src$ CEPH_CONF=ceph.conf ./rados lspools
> data
> metadata
> rbd
> nwatkins@kyoto:~/ceph2/src$ CEPH_CONF=ceph.conf ./rados -p data ls
> *** Caught signal (Segmentation fault) **
>  in thread 7f84f02ce7c0
>  ceph version 0.77-620-gf3976c1 (f3976c16531096b9979842fc4445d40d6e889932)
>  1: /home/nwatkins/ceph2/src/.libs/lt-rados() [0x43e2df]
>  2: (()+0xfbb0) [0x7f84eef6bbb0]
>  3: (librados::ObjectIterator::operator=(librados::ObjectIterator
> const&)+0x27) [0x7f84ef31f807]
>  4: (librados::ObjectIterator::ObjectIterator(librados::ObjectIterator
> const&)+0x30) [0x7f84ef31fb10]
>  5: (main()+0x1bff) [0x41274f]
>  6: (__libc_start_main()+0xf5) [0x7f84ee193de5]
>  7: /home/nwatkins/ceph2/src/.libs/lt-rados() [0x41b967]
> 2014-03-02 10:35:57.471206 7f84f02ce7c0 -1 *** Caught signal
> (Segmentation fault) **
>  in thread 7f84f02ce7c0

I ran into it a couple days ago.  I think Josh has it fixed.

https://github.com/ceph/ceph/pull/1322

Thanks,

                Ilya
