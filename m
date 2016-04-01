From: Dan van der Ster <dan@vanderster.com>
Subject: Re: [PATCH] ceph-disk: s/prefered/preferred/
Date: Fri, 1 Apr 2016 09:22:27 +0200
Message-ID: <CABZ+qq=aGVr+vvCwnE6oRRyeN165K3TrpR4PdKnGRramhPFX-Q@mail.gmail.com>
References: <56FE1B91.2080108@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35062 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758482AbcDAHXL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Apr 2016 03:23:11 -0400
Received: by mail-lf0-f54.google.com with SMTP id k79so75590404lfb.2
        for <ceph-devel@vger.kernel.org>; Fri, 01 Apr 2016 00:23:10 -0700 (PDT)
Received: from mail-lf0-f42.google.com (mail-lf0-f42.google.com. [209.85.215.42])
        by smtp.gmail.com with ESMTPSA id y7sm1951777lba.3.2016.04.01.00.23.07
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Apr 2016 00:23:08 -0700 (PDT)
Received: by mail-lf0-f42.google.com with SMTP id c62so75560712lfc.1
        for <ceph-devel@vger.kernel.org>; Fri, 01 Apr 2016 00:23:07 -0700 (PDT)
In-Reply-To: <56FE1B91.2080108@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Good catch ;)

Tested-by: Dan van der Ster <daniel.vanderster@cern.ch>


On Fri, Apr 1, 2016 at 8:56 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hi,
>
> Please pull the following Ceph updates from this mail.
>
> There is not much here, just some overdue proofreading.
>
> This patch is based on a recent merge of the jewel tree to avoid conflicts
> with a recent refactor.
>
> Sincerely
>
> Signed-off-by: Nathan Cutler <ncutler@suse.cz>
> ---
>  src/ceph-disk/ceph_disk/main.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/ceph-disk/ceph_disk/main.py
> b/src/ceph-disk/ceph_disk/main.py
> index d0ec596..a137967 100755
> --- a/src/ceph-disk/ceph_disk/main.py
> +++ b/src/ceph-disk/ceph_disk/main.py
> @@ -406,7 +406,7 @@ def command(arguments, **kwargs):
>      executable exists and raising a helpful error message
>      if it does not.
>
> -    .. note:: This should be the prefered way of calling
> ``subprocess.Popen``
> +    .. note:: This should be the preferred way of calling
> ``subprocess.Popen``
>      since it provides the caller with the safety net of making sure that
>      executables *will* be found and will error nicely otherwise.
>
> @@ -429,7 +429,7 @@ def command_check_call(arguments):
>      Safely execute a ``subprocess.check_call`` call making sure that the
>      executable exists and raising a helpful error message if it does not.
>
> -    .. note:: This should be the prefered way of calling
> +    .. note:: This should be the preferred way of calling
>      ``subprocess.check_call`` since it provides the caller with the safety
> net
>      of making sure that executables *will* be found and will error nicely
>      otherwise.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
