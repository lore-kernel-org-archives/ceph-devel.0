From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: libcephfs-java bindings built but not showing up in debian repository
Date: Thu, 9 Jun 2016 17:50:10 -0700
Message-ID: <CAJ4mKGZk_W2d-ZGZSsdV0kHv8QVjpq4Ev98dRPL+o=RZoQ-8=A@mail.gmail.com>
References: <CAB2gnbXwbVghGQac9N_s820iG+M19xucvLi7DJOAaZrNjhoCyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:36027 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbcFJAuM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jun 2016 20:50:12 -0400
Received: by mail-vk0-f49.google.com with SMTP id g67so78073318vkb.3
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jun 2016 17:50:11 -0700 (PDT)
In-Reply-To: <CAB2gnbXwbVghGQac9N_s820iG+M19xucvLi7DJOAaZrNjhoCyA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>, Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Dan Mick <dmick@redhat.com>, Beocat KSU <mozes@ksu.edu>

On Thu, Jun 9, 2016 at 4:29 PM, Noah Watkins <noahwatkins@gmail.com> wrote:
> I'm trying to track down why the Java Debian packages are not showing
> up in the Jewel repository:
>
> Looking in the repository for jewel I see the JNI bindings deb:
>
>    http://download.ceph.com/debian-jewel/pool/main/c/ceph/
>    libcephfs-jni_10.2.1-1trusty_amd64.deb 13-May-2016 23:53 20368086
>
> but not the deb file containing the Java bits (libcephfs-java).

Hmm, that's the official release packages, which I think aren't
produced using all the same stuff as the gitbuilders. Does
libcephfs-java get built the same way as the JNI bindings? I know we
have a separate gitbuilder for Hadoop JARs...

-Greg

> However, it looks like the gitbuilder is producing them:
>
>    http://gitbuilder.ceph.com/ceph-deb-trusty-x86_64-basic/ref/jewel/pool/main/c/ceph/
>    ===> libcephfs-java_10.2.1-135-g50143ed-1trusty_all.deb2016-06-09 15:191.0M
>    libcephfs-jni_10.2.1-135-g50143ed-1trusty_amd64.deb2016-06-09 15:1919M
>
> I grepped around the autobuilders and don't see any special cases for
> Java. Any clues?
>
> Thanks,
> Noah
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
