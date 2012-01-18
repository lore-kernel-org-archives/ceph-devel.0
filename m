From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: How to remove lost objects.
Date: Wed, 18 Jan 2012 08:50:36 -0800
Message-ID: <CAORUGqAj-2k+8cvzxwVwDb32upEdv_FFAc96-05fiyVRF3qE6g@mail.gmail.com>
References: <CAADCt4KfW7JS59ev_T4L3VMvmQm+OquD-8L7NTKS9u2RjNMPKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:41293 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111Ab2ARQu6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jan 2012 11:50:58 -0500
Received: by wibhm6 with SMTP id hm6so2365288wib.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jan 2012 08:50:57 -0800 (PST)
In-Reply-To: <CAADCt4KfW7JS59ev_T4L3VMvmQm+OquD-8L7NTKS9u2RjNMPKg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Stepachev <octo47@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jan 18, 2012 at 07:37, Andrey Stepachev <octo47@gmail.com> wrote:
> I've test ceph against laggy network. (0ms-400ms delays).

400ms? Are you circling the Earth once with every packet? For
reference, west coast of US <-> Europe is less than 200ms.

Ceph is not suitable for a WAN / satellite / etc setups. It assumes
the cluster is co-located, and just honestly is aimed at network
speeds upwards from 1Gbps. Anything else would require completely
different caching and replication mechanisms. You can't maintain cache
coherency across such huge latencies, without making the user
experience slow (as you observed).

> After such strange hangouts i found, that rm -rf on filesystem
> (mounted via kernel),
> fs shows, that 210Gb still in use. Looking at /data/osd.x i found many
> objects inside.
> So:
> a) looks like some errors lead us to orphaned objects in rados
> b) i can't find utility, which can check that orpaned data (and cleanup it)

Object removal is done in the background. Give it some time, and good
networking, and you should get the free space back.
