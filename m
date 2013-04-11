From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph-users] pool-info error in version 0.60
Date: Thu, 11 Apr 2013 07:58:34 -0700
Message-ID: <CAPYLRziTiU=eW_kyTSezuQX6=8_xyGG95DGnd12OEUoVoCrGww@mail.gmail.com>
References: <CAMVugGyeNXSW_C3H7PvP5bB4X+i2vXVgHob6BQmkQ2s-7SR10Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:62742 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933975Ab3DKO6f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Apr 2013 10:58:35 -0400
Received: by mail-qa0-f48.google.com with SMTP id hu16so324952qab.7
        for <ceph-devel@vger.kernel.org>; Thu, 11 Apr 2013 07:58:34 -0700 (PDT)
In-Reply-To: <CAMVugGyeNXSW_C3H7PvP5bB4X+i2vXVgHob6BQmkQ2s-7SR10Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dawn li <defence986@gmail.com>
Cc: ceph-users <ceph-users@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It's more or less a Ceph bug; the patch fixing this is in the 3.9-rc's
(although it should backport trivially if you're willing to build a
kernel: 92a49fb0f79f3300e6e50ddf56238e70678e4202). You can look at
http://tracker.ceph.com/issues/3793 if you want details.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Tue, Apr 9, 2013 at 6:51 PM, dawn li <defence986@gmail.com> wrote:
> Hello everyone,
>     I have used the latest version 0.60 ceph in the ceph-server and the
> latest linux kernel 3.8.6 in the ceph-client.
> Howerver, the problem  still exists in my ceph client. As follows.
>     I have mounted the ceph path to my ceph client with the command "mount
> -t ceph * *".
> The allocation size is normal when viewed through the command "df -h",
> however,
>  the allocation size become very large and the capacity size become too
> small
> when viewed through the command "pool-info" in the tool "virsh".
>     Is it the bug of the ceph? Any help would be grateful. Thanks for your
> help.
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
