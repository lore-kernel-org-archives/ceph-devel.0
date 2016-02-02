From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: zero-copy questions
Date: Tue, 2 Feb 2016 10:23:35 -0800
Message-ID: <CAJ4mKGZuYkCV2W+-H9Qi--i3JAUraBjtyA52LVd5h02+AkJcxQ@mail.gmail.com>
References: <4EE3C658-7FFB-4BE8-9BDD-F0543D24196A@ebay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34307 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755953AbcBBSXh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Feb 2016 13:23:37 -0500
Received: by mail-wm0-f46.google.com with SMTP id 128so131231404wmz.1
        for <ceph-devel@vger.kernel.org>; Tue, 02 Feb 2016 10:23:36 -0800 (PST)
In-Reply-To: <4EE3C658-7FFB-4BE8-9BDD-F0543D24196A@ebay.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Snyder, Emile" <emsnyder@ebay.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Feb 2, 2016 at 10:06 AM, Snyder, Emile <emsnyder@ebay.com> wrot=
e:
> Hi all,
>
> I was wondering if anyone had any insights as to the status of http:/=
/tracker.ceph.com/projects/ceph/wiki/Zero-copy_bufferlists? Poking arou=
nd in the buffer code I see that there is some code there to handle zer=
o copy with buffer::raw, but that it's disabled (the if (false && read_=
fd_zero_copy(fd, len) =3D=3D 0) in buffer::list::read_fd), and that the=
 read path for osd's using FileStore doesn't appear to go through buffe=
r anyway (FileStore::read uses safe_pread)
>
>
>
> Was this direction determined to not be worth it, or is it just that =
no one has had the time to keep pursuing it?

I didn't do any of this work, but I think there ended up being (a) not
enough time available, and (b) some issue with using pipes as
described there =E2=80=94 the overhead was too high for the typical amo=
unt of
memory we use in a buffer, maybe? Or we were just trying to allocate
too many pipes for the kernel to handle well, or for us to handle, or
something.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
