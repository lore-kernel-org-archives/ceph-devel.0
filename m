From: Alfredo Deza <adeza@redhat.com>
Subject: Re: Ceph installation packages on Ubuntu
Date: Tue, 3 Jan 2017 15:16:06 -0500
Message-ID: <CAC-Np1wLzXAPq6gdCGu_wY+safqGW0c6wGHCgm+-2Wxd-os5Sg@mail.gmail.com>
References: <CAOCf4An8SHRYgeKQ-t9h1TjGU9k8GCc0GGmZRCt0dikUG3Azeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35239 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752604AbdACUQl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jan 2017 15:16:41 -0500
Received: by mail-qk0-f179.google.com with SMTP id u25so375876517qki.2
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jan 2017 12:16:07 -0800 (PST)
In-Reply-To: <CAOCf4An8SHRYgeKQ-t9h1TjGU9k8GCc0GGmZRCt0dikUG3Azeg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tone Zhang <tone.zhang@linaro.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Dec 21, 2016 at 3:21 AM, Tone Zhang <tone.zhang@linaro.org> wrote:
> Hi Cephers,
>
> In recent, I tried to deploy Ceph cluster on Ubuntu 16.04 on ARM
> platform via "ceph-deploy".
>
> When I ran "ceph-deploy install" command, I got "cannot find ceph-osd"
> and "ceph-mon". I checked the ceph download center for Ubuntu on ARM
> (https://download.ceph.com/debian-jewel/pool/main/c/ceph/), it seems
> since Ceph 10.2.4, there is no deb packages for ARM any more. What's
> happened? Does it mean ceph jewel delivery on ARM platform will be
> stopped?

I don't recall why we didn't ship for 10.2.4. For regular releases we
put the priority on the non-arm
versions, so it is possible we had some temporary issue at the time of 10.2.4

I will get a build going for that version and arm64, and will update
this thread when that is complete (or if we find anything preventing a
build)
>
> If I want to deploy Ceph jewel 10.2.2 via ceph-deploy, how shall I do?
> Except download all the deb packaged for 10.2.2 and install ceph
> manually, is there an easier way?

There isn't a way to do this with a released Ceph version, because the
DEB repos will not allow to provide metadata information for multiple
versions of the same package (the deb tooling we use just ignores the
older versions).

If you can't wait, there is an unsigned repo for 10.2.2 available at:

https://chacra.ceph.com/r/ceph/jewel/ubuntu/xenial/

It contains the other DEB distros there as well (it isn't just xenial)

>
> Thanks a lot!
>
> Br,
> Tone
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
