From: Gregory Farnum <greg@gregs42.com>
Subject: Re: experimental features
Date: Fri, 5 Dec 2014 09:39:23 -0800
Message-ID: <CAC6JEv8LVviFoNXB72gKBQ+seNVYphvpwm0QZeOwccPHr7Qatg@mail.gmail.com>
References: <alpine.DEB.2.00.1412050927150.24079@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:43654 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbaLERjZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Dec 2014 12:39:25 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so1146735iec.15
        for <ceph-devel@vger.kernel.org>; Fri, 05 Dec 2014 09:39:24 -0800 (PST)
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com. [209.85.213.180])
        by mx.google.com with ESMTPSA id z71sm16281711iod.23.2014.12.05.09.39.23
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 05 Dec 2014 09:39:23 -0800 (PST)
Received: by mail-ig0-f180.google.com with SMTP id h15so1109559igd.13
        for <ceph-devel@vger.kernel.org>; Fri, 05 Dec 2014 09:39:23 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1412050927150.24079@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

On Fri, Dec 5, 2014 at 9:36 AM, Sage Weil <sweil@redhat.com> wrote:
> A while back we merged Haomai's experimental OSD backend KeyValueStore.
> We named the config option 'keyvaluestore_dev', hoping to make it clear to
> users that it was still under development, not fully tested, and not yet
> ready for production.  In retrospect, I don't think '_dev' was
> sufficiently scary because many users tried it and ran into
> unexpectd trouble.
>
> There are several other features we've recently added or are considering
> adding that fall into this category.  Having them in the tree is great
> because it streamlines QA and testing, but I want to make sure that
> users are not able to enable the features without being aware of the
> risks.
>
> A few possible suggestions:
>
> - scarier option names, like
>
>   osd objectstore = keyvaluestore_experimental_danger_danger
>   ms type = async_experimental_danger_danger
>   ms type = xio_experimental_danger_danger
>
>   Once the feature becomes stable, they'll have to adjust their
> config, or we'll need to support both names going forward.
>
> - a separate config option that allows any experimental option
>
>   allow experimental features danger danger = true
>   osd objectstore = keyvaluestore
>   ms type = xio
>
>   This runs the risk that the user will enable experimental features to
> get X, and later start using Y without realizing Y is also
> experiemental.
>
> - enumerate experiemntal options we want to enable
>
>   allow experimental features danger danger = keyvaluestore, xio
>   ms type = xio
>   osd objectstore = keyvaluestore
>
>   This has the property that no config change is necessary when the
> feature drops its experimental status.
>
> In all of these cases, we can also make a point of sending something to
> the log on daemon startup.  I don't think too many people will notice
> this, but it is better than nothing.
>
> Other ideas?

I don't think these should even be going into release packages for
users to work with. We can build them on the dev gitbuilders for QA
and testing without them ever reaching the hands of users grabbing our
production packages. ;)
-Greg
