From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: BUG at fs/inode.c
Date: Mon, 24 Oct 2011 09:51:20 -0700
Message-ID: <CAC-hyiEcNcJGsMLWa6WVhM6gABYKgeKo2aFMvOEtuu7kQqN9ow@mail.gmail.com>
References: <201110241239.13157.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58677 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755283Ab1JXQvW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Oct 2011 12:51:22 -0400
Received: by bkbzt19 with SMTP id zt19so8417148bkb.19
        for <ceph-devel@vger.kernel.org>; Mon, 24 Oct 2011 09:51:21 -0700 (PDT)
In-Reply-To: <201110241239.13157.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Oct 24, 2011 at 3:39 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> Hi folks,
>
> we have hit a kernel bug with current ceph-client master (commit
> a2742a09568f81315e0f30021f29f14e7cd3924b), which I assume to be a Cep=
h bug.

Is it easily reproducible? What's the scenario?

>
> Kernel is x86-32, Ceph is running on a two node cluster over ext4. Th=
e kernel
> traces are attached, the system dies shortly after these messages. Th=
e bug is
> reproducable. I have not found anything useful in ceph bug tracker wh=
en
> searching for "fs/inode.c".

How many mds servers?

>
> Around fs/inode.c line 1375 mentioned in the trace is the iput() func=
tion:
> void iput(struct inode *inode)
> {
> =A0 =A0 =A0 =A0if (inode) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BUG_ON(inode->i_state & I_CLEAR);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (atomic_dec_and_lock(&inode->i_coun=
t, &inode->i_lock))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iput_final(inode);
> =A0 =A0 =A0 =A0}
> }
>
> So inode->i_state seems to be incorrect when iput() is called, maybe =
a double
> call to iput() or a missing iget() somewhere. Is this really a Ceph b=
ug or
> have I messed up our kernel code when merging patches?
>

What patches?

Also, the client logs could help shedding a light on the issue. You
should have dynamic debugging turned on (CONFIG_DYNAMIC_DEBUG), and
something along the lines of:

# mount -t debugfs none /sys/kernel/debug
# echo 'module ceph +p' > /sys/kernel/debug/dynamic_debug/control
# echo 'module libceph +p' > /sys/kernel/debug/dynamic_debug/control

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
