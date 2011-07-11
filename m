From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: problem of operation "rm -rf "
Date: Mon, 11 Jul 2011 08:24:55 -0700
Message-ID: <CAORUGqCSWpO6A9dj94VUZqf4mjVo_xai8EDvzUKV3577s3wrkw@mail.gmail.com>
References: <CABAwU-ZLw2GTGb4pHUxMttnO23fpwDT_uHWoUE8OVoAaYmpoKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54135 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757922Ab1GKPZQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jul 2011 11:25:16 -0400
Received: by ewy4 with SMTP id 4so1396410ewy.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jul 2011 08:25:15 -0700 (PDT)
In-Reply-To: <CABAwU-ZLw2GTGb4pHUxMttnO23fpwDT_uHWoUE8OVoAaYmpoKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jul 11, 2011 at 03:21, huang jun <hjwsm1989@gmail.com> wrote:
> hi, developers
> we use ceph v0.30, kernel client 2.6.37
> mount ceph on /mnt
> $ mkdir /mnt/a
> $ cd a
> $ seq 10 | xargs -i =C2=A0mkdir {}
> $ cd ..
> $ rm -rf a
> from the debug log of mds.we find
> if we want remove one subdirectory in "a", we must execute readdir " =
a
> " operation each time
> so we need read dir "a" 10 times.
> but in normal way, it should readdir "a" once, and remove all the
> subdirectories if we use "rm -rf a".
>
> we'd like to know how did =C2=A0ceph parse command "rm -rf " ?

Was there an actual error from "rm -rf a"? What was the message? What
did the mds debug log say? Please provide more detail.

Ceph does not parse "rm -rf"; rm does a
opendir(3)/readdir(3)/closedir(3) loop and within it, unlink(2)s the
files (or recurses into subdirectories); Ceph receives these
filesystem manipulation system calls via the Linux kernel's VFS
subsystem.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
