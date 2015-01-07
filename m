From: Dong Yuan <yuandong1222@gmail.com>
Subject: Re: [Ceph-Dokan] A Windows CephFS Client Project
Date: Wed, 7 Jan 2015 14:18:54 +0800
Message-ID: <CAMm-wcJr596fuhjA07fX3X3dU2X_FQMKEJ3BL_tgO1oQwJEHAg@mail.gmail.com>
References: <CAM9_UU_4bnWVVf3bC8wnggNmF5O+HUshZn_xP-_ELiW3kqt=+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:50017 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbbAGGSz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Jan 2015 01:18:55 -0500
Received: by mail-vc0-f178.google.com with SMTP id hq11so257117vcb.37
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jan 2015 22:18:54 -0800 (PST)
In-Reply-To: <CAM9_UU_4bnWVVf3bC8wnggNmF5O+HUshZn_xP-_ELiW3kqt=+Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ketor D <d.ketor@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It is awesome!

I think CephFS may be the next Big Thing of ceph, since many many
companies are about to use NAS on cloud.

On 7 January 2015 at 12:09, Ketor D <d.ketor@gmail.com> wrote:
> Hi everyone,
>
> A new project ceph-dokan (https://github.com/ceph/ceph-dokan) is
> open-source to all now.
> You can access the cephfs on Windows directly using ceph-dokan, not by
> smb or whatever.
> And you will get the full experience and performance of cephfs on Windows now.
>
> Here is something about this project you may want to know.
>
>      Overview.
>          ceph-dokan is build on MinGW. It will provide ceph-dokan.exe
> and libcephfs.dll.
>          ceph-dokan.exe makes you use CephFS as a volume like your [C:] or [D:].
>          libcephfs.dll is a lib you can write your own application using CephFS.
>
>       Features:
>          Support almost windows filesystem api's.
>          Support ACL from Linux.
>          Support CreateFile of temp file.
>          Support Microsoft Office file edit and save.
>          etc.
>
>       Internal:
>          ceph-dokan is ported from upstream Ceph. It was first ported
> as a standalone Ceph Client and then portd to Cygwin. But Cygwin is
> too slowly and not native code so it was ported to MinGW later. And
> with dokan(like fuse), now ceph-dokan map cephfs as a volume on
> windows.
>          ceph-dokan is fully native win32 code and compiled by gcc. So
> its performace is very good. Also it use winsock2 instead of linux
> socket and select() instead of poll(). And etc....
>
> Everyone who have experience on dokan, mingw, win32 can help to
> improve ceph-dokan by pull request or using ceph-devel mailing list.
>
> Thanks!
>  Ketor
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Dong Yuan
Email:yuandong1222@gmail.com
