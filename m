From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: ceph-fuse is working on FreeBSD
Date: Wed, 29 Mar 2017 09:12:56 -0700
Message-ID: <CAJ4mKGbvc9fiFxbrnFpCm13-QsUNR8FF_Ka6N4eFtbD9xKk=NQ@mail.gmail.com>
References: <2133312b-b225-0060-bad8-f8aab4f4fcf7@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:35890 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbdC2QM7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Mar 2017 12:12:59 -0400
Received: by mail-it0-f48.google.com with SMTP id e75so96641286itd.1
        for <ceph-devel@vger.kernel.org>; Wed, 29 Mar 2017 09:12:58 -0700 (PDT)
In-Reply-To: <2133312b-b225-0060-bad8-f8aab4f4fcf7@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Sweet! Try pjd yet? ;)

On Wed, Mar 29, 2017 at 9:08 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> I needed some more skills to actually get everythingin place to get it
> working. But in essence I have ceph-fuse running...
>
> wjw# df | grep fuse
> /dev/fuse 9168256790 203540395 8964716395 2%    /zfs/home/wjw/mnt/zfs
> /dev/fuse 8241876992  60174336 8181702656 1%    /zfs/home/wjw/mnt/cephf
>
> wjw# ls ~/mnt/cephfs/
> wjw# touch ~/mnt/cephfs//test
> wjw# ~/mnt/cephfs/
> test
>
> So we are slowly getting there....
>
> --WjW
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
