From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: Storing cls and erasure code plugins in a pool
Date: Sun, 7 Sep 2014 12:42:07 -0700
Message-ID: <CABBk=J9UZRUfp+Mj7gU_6O0cCP4Pg+W42HiC+7o4TZ_YWpBapg@mail.gmail.com>
References: <540C169C.9030603@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:59811 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbaIGTmI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 7 Sep 2014 15:42:08 -0400
Received: by mail-ig0-f177.google.com with SMTP id h18so1520784igc.16
        for <ceph-devel@vger.kernel.org>; Sun, 07 Sep 2014 12:42:07 -0700 (PDT)
In-Reply-To: <540C169C.9030603@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Sep 7, 2014 at 1:26 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ceph,
>
> There is a need for a cluster to share code such as cls https://github.com/ceph/ceph/tree/master/src/cls or erasure code plugins https://github.com/ceph/ceph/tree/master/src/erasure-code/.
>
> These plugins could have a life cycle independent of Ceph, as long as they comply to the supported API ( https://github.com/ceph/ceph/blob/master/src/erasure-code/ErasureCodeInterface.h ). For erasure code plugins it currently works this way (or it will as soon as https://github.com/ceph/ceph/pull/2397 is merged):
>
> a) upgrade from Hammer to I* half the OSD nodes. The new I* have new erasure code plugins
> b) the MON will refuse to create an erasure coded pool using the new I* plugins, otherwise the Hammer nodes will find themselves unable to participate in the pool
>
> Instead it could work this way:
>
> a) upgrade from Hammer to I* half the OSD nodes. The new I* have new erasure code plugins
> b) the new erasure code plugins are uploaded to a "plugins" pool
> c) an erasure coded pool is created using a new plugin from I*
> d) the Hammer OSD downloads the plugin from the pool and can participate in the pool
>
> It is easier said than done and there are a lot of details to consider. However it not different from maintaining an Operating System that includes shared libraries and the path to do so properly is well known.
>
> Thoughts ?

And here we go (almost) full circle. Originally the objclass (cls)
mechanism worked somewhat similar. The code would be injected to the
monitors, and it was then distributed to the osds. When uploading the
objects we'd also specify the architecture, and there's an embedded
version in each so that it was possible to disable one version and
enable another.
The problem is that this specific method is very problematic when
dealing with heterogeneous environments, where each osd can run on a
different architecture, or different distribution. Also need to
maintain a very well contained api for the objclasses to use (which we
don't have), and be very careful about versioning. In other words, it
doesn't work, and the trouble doesn't worth the benefits.
I'm not too familiar with the erasure code plugins, but it seems to me
that they need to be versioned. Then you could have multiple plugins
with different versions installed, and then you could specify which
version to use. You could have a tool that would make sure that all
the osds have access to the appropriate plugin version. But the actual
installation of the plugin wouldn't be part of ceph's internal task.
It might be that the erasure code plugins are more contained than the
objclasses, and something like you suggested might actually work.
Though I'm having trouble seeing that happening having a compiled
shared object as the resource that needs to be distributed. The first
objclass implementation actually pushed python code to the nodes (it
really did!), maybe having something like that for erasure code could
work, given the appropriate environment and tools.

Yehuda
