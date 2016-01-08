From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: cephfs (hammer) flips directory access bits
Date: Fri, 8 Jan 2016 16:54:34 +0800
Message-ID: <CAAM7YA=9RR5KS9dgU9o4viN+-sqf=ij6a6Cg-6J=kjSskFz=dg@mail.gmail.com>
References: <n6l67c$hu$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33673 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbcAHIyg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jan 2016 03:54:36 -0500
Received: by mail-lb0-f171.google.com with SMTP id sv6so213545598lbb.0
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jan 2016 00:54:35 -0800 (PST)
In-Reply-To: <n6l67c$hu$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: CSa <Christian.Salzmann@fu-berlin.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jan 7, 2016 at 4:05 PM, CSa <Christian.Salzmann@fu-berlin.de> wrote:
> Hi,
>
> we are using cephfs on a ceph cluster (V0.94.5, 3x MON, 1x MDS, ~50x OSD).
> Recently, we observed a spontaneous (and unwanted) change in the access
> rights of newly created directories:
>
> $ umask
> 0077
> $ mkdir test
> $ ls -ld test
> drwx------ 1 me me 0 Jan  6 14:59 test
> $ touch test/foo
> $ ls -ld test
> drwxrwxrwx 1 me me 0 Jan  6 14:59 test
> $

do you use kernel client? I remember an ACL related bug in old kernel
can cause this. mount cephfs with '-o noacl' option can avoid this
issue.

>
> I kindly would like to ask for help tracking down this issue.
>
> ciao
> Christian
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
