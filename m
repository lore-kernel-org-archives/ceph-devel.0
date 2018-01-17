From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: REST API Client
Date: Wed, 17 Jan 2018 09:17:31 -0500
Message-ID: <CA+aFP1Dd1t3oNiME0wmF4bnAHGMqEuC+1AfBWGMDe1=J34HaUg@mail.gmail.com>
References: <CAD-gW==8X416nALGMunjXdjxsWCE+qRDm9+YfYUZ047mT4FrQw@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f178.google.com ([209.85.213.178]:34469 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbeAQORc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jan 2018 09:17:32 -0500
Received: by mail-yb0-f178.google.com with SMTP id u35so2601080ybi.1
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jan 2018 06:17:32 -0800 (PST)
In-Reply-To: <CAD-gW==8X416nALGMunjXdjxsWCE+qRDm9+YfYUZ047mT4FrQw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Huamin Chen <hchen@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jan 17, 2018 at 8:47 AM, Huamin Chen <hchen@redhat.com> wrote:
> Hi,
>
> I am thinking of using Ceph REST API tclient o remove rbd cli
> dependency from Kubernetes and rbd CSI driver.
>
> The potential work flow is
> - for rbd map, use sysfs

Why re-implement the wheel? I think the rbd CLI is a good fit for this
use-case. Especially when you consider that the CSI driver should
eventually support not only krbd, but nbd and tcmu-based block device
drivers. These are all being unified via new "rbd device map
--device-type <XYZ>" / "rbd device unmap" CLI commands to provide a
unified interface [1].

> - use REST API client for rbd status, rbd create and rm
>
> Questions: Does current Ceph REST server support these rbd calls? Has
> anybody already worked on Golang client?

Not to my knowledge. Assuming you keep the rbd CLI which will bring
with it the librados2 and librbd1 shared libraries, any reason to not
just directly use / expand the Ceph golang API [2]?

> I found some early work on python client [1] but so far no work on
> golang client. If I missed it, please let me know.
>
>
> 1. https://github.com/dmsimard/python-cephclient
>
> Thanks
>
> Huamin
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

[1] https://github.com/ceph/ceph/pull/19711
[2] https://github.com/ceph/go-ceph

-- 
Jason
