From: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Subject: Re: [PATCH] mkcephfs: Don't transfer absolute path of mkcephfs to
 other hosts.
Date: Wed, 6 Nov 2013 10:20:22 +0800
Message-ID: <CAAb4LOzehV4BqqE0vNnSttin-JSMu=pRUrngyEEH9=BDKdkhSw@mail.gmail.com>
References: <201311060925048528111@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:46013 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050Ab3KFCUh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Nov 2013 21:20:37 -0500
Received: from mail-bk0-f44.google.com (mail-bk0-f44.google.com [209.85.214.44])
	by m53-178.qiye.163.com (HMail) with ESMTPSA id 25B7F1BF009B
	for <ceph-devel@vger.kernel.org>; Wed,  6 Nov 2013 10:20:25 +0800 (CST)
Received: by mail-bk0-f44.google.com with SMTP id mx11so1249538bkb.3
        for <ceph-devel@vger.kernel.org>; Tue, 05 Nov 2013 18:20:22 -0800 (PST)
In-Reply-To: <201311060925048528111@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: sage <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Li Wang <liwang@ubuntukylin.com>

Hi Jianpeng,
    I think this patch will work in the situation that 'mkcephfs' has
been added to the $PATH of other hosts, but what about that 'mkcephfs'
have been deployed to the same path in all cluster nodes, but NOT
added to $PATH, then the original version will work, but now it not
gotta work.
   So my suggestion is, first check if the path $0 is valid or not on
other hosts by using something like ' if [ -f $0 ]', if so, just go as
now it is. Otherwise, remove other name components of the path, and
try to use it.


2013/11/6 majianpeng <majianpeng@gmail.com>:
> When exec 'mkcephfs -a -c ceph.conf',it will transfer absolute path of
> mkcephfs to other hosts.But for different hosts, the path of mkcephfs
> may different.It will make the command error.The error message is
> "bash: ./mkcephfs: No such file or directory".
> So we should transfer the name mkcephfs to other hosts.It those hosts,it
> will automaicly search by PATH.
>
> Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
> ---
>  src/mkcephfs.in | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/src/mkcephfs.in b/src/mkcephfs.in
> index 2838568..c5e41d9 100644
> --- a/src/mkcephfs.in
> +++ b/src/mkcephfs.in
> @@ -455,6 +455,7 @@ fi
>  ### do everything via ssh ###
>
>  if [ $allhosts -eq 1 ]; then
> +    localhost=$hostname
>
>      verify_conf
>
> @@ -498,10 +499,18 @@ if [ $allhosts -eq 1 ]; then
>         fi
>
>         if [ $mkfs -eq 1 ] && [ "$type" = "osd" ]; then
> -           do_root_cmd "$0 -d $rdir --prepare-osdfs $name"
> +               if [ $localhost = $host ]; then
> +                   do_root_cmd "$0 -d $rdir --prepare-osdfs $name"
> +               else
> +                   do_root_cmd "$(basename $0) -d $rdir --prepare-osdfs $name"
> +               fi
>         fi
>
> -       do_root_cmd "$0 -d $rdir --init-daemon $name"
> +       if [ $localhost = $host ]; then
> +           do_root_cmd "$0 -d $rdir --init-daemon $name"
> +       else
> +           do_root_cmd "$(basename $0) -d $rdir --init-daemon $name"
> +       fi
>
>         # collect the key
>         if [ -n "$ssh" ]; then
> @@ -544,7 +553,11 @@ if [ $allhosts -eq 1 ]; then
>             fi
>         fi
>
> -       do_root_cmd "$0 -d $rdir --init-daemon $name"
> +       if [ $localhost = $host ]; then
> +           do_root_cmd "$0 -d $rdir --init-daemon $name"
> +       else
> +           do_root_cmd "$(basename $0) -d $rdir --init-daemon $name"
> +       fi
>
>         if [ -n "$ssh" ]; then
>             #cleanup no longer need rdir
> --
> 1.8.4
