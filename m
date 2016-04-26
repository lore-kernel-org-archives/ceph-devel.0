From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: cap mask differences for `Client::stat` vs `Client::fstat`
Date: Tue, 26 Apr 2016 14:41:04 -0500
Message-ID: <CAJ4mKGb49bFBXVTY9zjqJ1cGKoExF4EQj58wiUyYcLZDQfaEgg@mail.gmail.com>
References: <CAB2gnbUz9D9VWz6=PtDdAQ7u+hVWeHa3rz=5CypGAFLq-bSboA@mail.gmail.com>
	<CAAM7YA=+4wjN0TJFrrBovzkxLGJp1ngqC-Y-2fgV_mywaJx2Uw@mail.gmail.com>
	<CAB2gnbWUAdEWfwu2qYPYBNLdbVVa7PXwTsH9P8E5O2KU5hMu=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33463 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbcDZTlF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Apr 2016 15:41:05 -0400
Received: by mail-yw0-f174.google.com with SMTP id t10so33567080ywa.0
        for <ceph-devel@vger.kernel.org>; Tue, 26 Apr 2016 12:41:04 -0700 (PDT)
In-Reply-To: <CAB2gnbWUAdEWfwu2qYPYBNLdbVVa7PXwTsH9P8E5O2KU5hMu=g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Apr 23, 2016 at 6:48 PM, Noah Watkins <noahwatkins@gmail.com> w=
rote:
> I have a patch for this (below), but I see something that doesn't see=
m
> quite right.
>
> Here is a simple fs client. When its running by itself the fstat/sec
> rate is high. When a second client copy of this client starts, the
> first client slows down as expected, but the new client blocks. I
> would expect both clients to make progress, but until the first clien=
t
> exits, the second client is blocked.

Ugh. Clearly we have a cap release sequence bug =E2=80=94 probably the =
client
is spinning off new requests instead of blocking them on a cap
release. Can you create a tracker for it?
-Greg

>
> fd =3D cephfs.open('file-1', 'w', 0755)
> count =3D 0
> start =3D time.time()
> while True:
>     stat =3D cephfs.fstat(fd)
>     count +=3D 1
>     if time.time() > (start + 1):
>         print(count)
>         count =3D 0
>         start =3D time.time()
>
> - Noah
>
> Patch:
>
> 709840b - fsclient: fstat can take inode all cap (10 minutes ago) <No=
ah Watkins>
> diff --git a/src/client/Client.cc b/src/client/Client.cc
> index 7fcd907..94e4db5 100644
> --- a/src/client/Client.cc
> +++ b/src/client/Client.cc
> @@ -8668,16 +8668,16 @@ int Client::_fsync(Fh *f, bool syncdataonly)
>    return _fsync(f->inode.get(), syncdataonly);
>  }
>
> -int Client::fstat(int fd, struct stat *stbuf)
> +int Client::fstat(int fd, struct stat *stbuf, int mask)
>  {
>    Mutex::Locker lock(client_lock);
> -  tout(cct) << "fstat" << std::endl;
> +  tout(cct) << "fstat" << " mask " << mask << std::endl;
>    tout(cct) << fd << std::endl;
>
>    Fh *f =3D get_filehandle(fd);
>    if (!f)
>      return -EBADF;
> -  int r =3D _getattr(f->inode, -1);
> +  int r =3D _getattr(f->inode, mask);
>    if (r < 0)
>      return r;
>    fill_stat(f->inode, stbuf, NULL);
> diff --git a/src/client/Client.h b/src/client/Client.h
> index d912db0..860f28b 100644
> --- a/src/client/Client.h
> +++ b/src/client/Client.h
> @@ -981,7 +981,7 @@ public:
>    int fake_write_size(int fd, loff_t size);
>    int ftruncate(int fd, loff_t size);
>    int fsync(int fd, bool syncdataonly);
> -  int fstat(int fd, struct stat *stbuf);
> +  int fstat(int fd, struct stat *stbuf, int mask=3DCEPH_STAT_CAP_INO=
DE_ALL);
>    int fallocate(int fd, int mode, loff_t offset, loff_t length);
>
> On Wed, Apr 13, 2016 at 6:49 PM, Yan, Zheng <ukernel@gmail.com> wrote=
:
>> On Thu, Apr 14, 2016 at 1:26 AM, Noah Watkins <noahwatkins@gmail.com=
> wrote:
>>> In the libcephfs client it looks like both `Client::stat` and
>>> `Client::lstat` use a default mask of CEPH_STAT_CAP_INODE_ALL and a=
re
>>> able to return immediately from `Client::_getattr` without making a=
n
>>> MDS request. However, `Client::fstat` uses hard-coded -1 as the cap
>>> mask and always issues a MDS request. Is this the intended behavior=
,
>>> and if so, what are different semantics of fstat that make this a
>>> requirement?
>>
>> I think it's a bug, Client::fstat should use CEPH_STAT_CAP_INODE_ALL=
 too.
>>
>> Regards
>> Yan, Zheng
>>
>>>
>>> Thanks,
>>> Noah
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
