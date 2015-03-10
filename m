From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: teuthology-lock and choosing a kernel
Date: Tue, 10 Mar 2015 10:19:01 +0300
Message-ID: <CAOi1vP8T+JY1v9fnSAvK3UMr2MnzN+KJTWMY26k6zD5p_HCP_Q@mail.gmail.com>
References: <54FC459D.2090703@dachary.org>
	<6E9B72C6-1FA0-46D3-873E-EA99A52BE669@redhat.com>
	<54FE1F73.9060703@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:46504 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbbCJHTD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Mar 2015 03:19:03 -0400
Received: by wesk11 with SMTP id k11so10201465wes.13
        for <ceph-devel@vger.kernel.org>; Tue, 10 Mar 2015 00:19:01 -0700 (PDT)
In-Reply-To: <54FE1F73.9060703@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Andrew Schoen <aschoen@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Mar 10, 2015 at 1:32 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Andrew,
>
> I successfully installed a 3.19 kernel (details at http://dachary.org/?p=3594). It turns out that the loop module is compiled in and defaults to having zero partitions allowed by default. Since I was looking for a solution to have /dev/loop useable for tests, I rebooted with /boot/grub/grub.conf as
>
> [ubuntu@vpm083 src]$ cat /boot/grub/grub.conf
> default=0
> timeout=5
> splashimage=(hd0,0)/boot/grub/splash.xpm.gz
> hiddenmenu
> title rhel-6.5-cloudinit (3.19.0-ceph-00029-gaf5b96e)
>         root (hd0,0)
>         kernel /boot/vmlinuz-3.19.0-ceph-00029-gaf5b96e ro root=LABEL=79d3d2d4  loop.max_part=16
>         initrd /boot/initramfs-3.19.0-ceph-00029-gaf5b96e.img
>
>
> and that works fine. Do you know if I could do that from the yaml file directly ? Alternatively I could use a kernel that does not have the loop module compiled in and modprobe it with loop.max_part=16, but it's unclear to me what kernels are available and what their names are.

I think you can run a set of commands from yaml (see "exec" stanza), so
you can sort of script it (GRUB_CMDLINE_LINUX=, etc), but that's never
going to be reliable.

Basically the only kernel available right now is the testing flavor.
debug flavor is some random config and has been unused for a while.
I can try changing testing config to do CONFIG_BLK_DEV_LOOP=m if you
don't find a good way to workaround it.

https://lists.ubuntu.com/archives/kernel-team/2009-September/007364.html
is apparently the reason it's compiled in (our config is a somewhat old
and slightly stripped down Ubuntu config).

Thanks,

                Ilya
