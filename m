From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: sysvinit script vs ceph-deploy, chef
Date: Fri, 3 May 2013 10:23:57 -0400
Message-ID: <CACkq2mrjUGLGHdmWAROLT9Bq6fX9NQXG8=_BxKL0P42iyUFDfw@mail.gmail.com>
References: <alpine.DEB.2.00.1305021754250.10494@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:52642 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762806Ab3ECOYT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 May 2013 10:24:19 -0400
Received: by mail-bk0-f50.google.com with SMTP id ik5so729849bkc.23
        for <ceph-devel@vger.kernel.org>; Fri, 03 May 2013 07:24:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1305021754250.10494@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Sage,

Is this referring to something like this in ceph.conf?

[osd.0]
        host = ceph1

[osd.1]
        host = ceph1
...


As long as legacy users use something like that, you are saying they
will be good?  That seems reasonable to me.

To be clear, with such a change to the init script, moving the OSD in
the CRUSH map would only happen if you built the cluster with
ceph-deploy, right?  I thought the information required for that is
added during the disk format/labeling done by ceph-deploy, such as the
Ceph-specific disk label/filesystem ID (probably using the wrong terms
there, haven't looked at it recently).

Regardless, I would be comfortable with a prominent warning on
upgrade, along with the regular notices in release notes, docs, etc.

 - Travis


On Thu, May 2, 2013 at 9:01 PM, Sage Weil <sage@inktank.com> wrote:
> The upstart scripts have also updated the OSD's position in the CRUSH map
> by default on startup.  This is part of the hotplugging capability that
> lets you move drives around between hosts, and also moves the burden away
> from chef and ceph-deploy when adding OSDs.
>
> We forgot to add the parallel capability to the sysvinit script, which is
> what legacy clusters use, and what is used on Debian and RHEL/CentOS.
> That prevents ceph-deploy from fully bringing up OSDs (they are added to
> the cluster but not the CRUSH map).
>
> wip-sysvinit makes it all match the upstart behavior, but old clusters
> will now have the osd position update to be under a node host=`hostname`
> on startup.  By default.  You can turn this off by setting 'osd crush
> update on start = false'.  it's always default to true, but never done
> anything for sysvinit (and legacy mkcephfs)-based clusters.
>
> Alternatively, we could maek ceph-deploy and chef users now enable that
> explicitly, and make the default false.  That means *thsoe* users have to
> change their configs.
>
> Or, we could make it try to magically detect what kind of user you are and
> behave accordingly.  This strikes me as dangerous.
>
> Right now I'm leaning toward a prominent warning that on upgrade, any
> legacy clusters that don't put the osds under a node host=`hostname` need
> to add that optoin to avoid having their CRUSH map modfiied.
>
> Thoughts?
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
