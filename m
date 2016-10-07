From: Andrew Schoen <aschoen@redhat.com>
Subject: Re: new naming convention for building repos and binaries from branches
Date: Fri, 7 Oct 2016 09:27:20 -0500
Message-ID: <CAEPMp+7EyHBJSDoCZoTPvnd5bBKmsZ_D7UfZ5aYCvS6THLMqSg@mail.gmail.com>
References: <CAC-Np1wcBGRcFYtK8WsjfM-WR+H_S58XgH74D+dBiGxd=KwZUQ@mail.gmail.com>
 <CALe9h7da1Oz29q2pot1BZLNBcs1NJ51BRLE+Uj_3mVjnDGw6fQ@mail.gmail.com>
 <CAEPMp+7OJ+pX=mYbNGgm+HZMGOGDK3xiApw5OL03vsN9YApTGA@mail.gmail.com> <alpine.DEB.2.11.1610061633440.19850@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36349 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbcJGO1V (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Oct 2016 10:27:21 -0400
Received: by mail-vk0-f50.google.com with SMTP id 2so12485574vkb.3
        for <ceph-devel@vger.kernel.org>; Fri, 07 Oct 2016 07:27:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1610061633440.19850@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <jspray@redhat.com>, Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

> I think we need a "do not build" prefix and a "build this asap" prefix.
> Maybe nobuild-* and asap-*?
>

Is the 'asap-*' want here because of the typical long wait on the gitbuilders?

The way we're configured now we can build 10 branches at a time, all
of those branches building for 3 distros. I haven't seen a build take
longer than an hour or so. It'd be easy to scale that up as well, but
I don't see the queue ever being backed up at our current load.
