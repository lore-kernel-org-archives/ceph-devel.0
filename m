From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: [PATCH 0/3] WIP-8112 radosgw usage & man update
Date: Thu, 24 Jul 2014 13:15:24 -0700
Message-ID: <CABBk=J8ceLh4i_DiGRS4yq1rhdNr5ssookFu8__c5ohxyTjqpg@mail.gmail.com>
References: <1406214043-23730-1-git-send-email-abhishek.lekshmanan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:49066 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934512AbaGXUP0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 16:15:26 -0400
Received: by mail-vc0-f172.google.com with SMTP id im17so5732566vcb.31
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 13:15:25 -0700 (PDT)
In-Reply-To: <1406214043-23730-1-git-send-email-abhishek.lekshmanan@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek.lekshmanan@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Applied (with very slight modifications).

Thanks,
Yehuda

On Thu, Jul 24, 2014 at 8:00 AM, Abhishek Lekshmanan
<abhishek.lekshmanan@gmail.com> wrote:
> Hi,
>
> This is a series of patches to update radosgw usage and man pages with
> all the available help options. 1/3 is a minor format fix to display
> the options in the same line.
>
> Abhishek Lekshmanan (3):
>   rgw: format help options to align with the rest
>   rgw: list all available options during help()
>   doc: update radosgw man page with available opts
>
>  doc/man/8/radosgw.rst | 28 ++++++++++++++++++++++++++++
>  src/rgw/rgw_main.cc   | 10 ++++++++--
>  2 files changed, 36 insertions(+), 2 deletions(-)
>
> --
> 1.9.1
>
> Thanks,
>          Abhishek
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
