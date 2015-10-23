From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: newstore direction
Date: Fri, 23 Oct 2015 11:59:54 -0700
Message-ID: <CAJ4mKGZ_Xg4hNrm-zjBCJwe4vV1CbALT+C_Ee7cmcpRf=VMKKA@mail.gmail.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
	<CALe9h7dUQcp6zOSFDfnXSQo4VOTObFCWj+HD-idwE1nNzQVsgA@mail.gmail.com>
	<alpine.DEB.2.00.1510201251140.16833@cobra.newdream.net>
	<CAJ4mKGY0=+isJhh4oF3kqtxEZ6HWSDZXJyM9sBHxc8s21M_y8g@mail.gmail.com>
	<alpine.DEB.2.00.1510201422450.16833@cobra.newdream.net>
	<5626BECA.7070306@redhat.com>
	<alpine.DEB.2.00.1510210616060.16833@cobra.newdream.net>
	<5627981B.2040409@redhat.com>
	<loom.20151023T081245-920@post.gmane.org>
	<562A14D3.4070509@redhat.com>
	<562A1E69.2050704@redhat.com>
	<562A4B58.1030407@symas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:32895 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbbJWS7z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Oct 2015 14:59:55 -0400
Received: by wijp11 with SMTP id p11so90202295wij.0
        for <ceph-devel@vger.kernel.org>; Fri, 23 Oct 2015 11:59:54 -0700 (PDT)
In-Reply-To: <562A4B58.1030407@symas.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Howard Chu <hyc@symas.com>
Cc: Ric Wheeler <rwheeler@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Oct 23, 2015 at 7:59 AM, Howard Chu <hyc@symas.com> wrote:
> If the stream of writes is large enough, you could omit fsync because
> everything is being forced out of the cache to disk anyway. In that
> scenario, the only thing that matters is that the writes get forced out in
> the order you intended, so that an interruption or crash leaves you in a
> known (or knowable) state vs unknown.

The RADOS storage semantics actually require that we know it's durable
on disk as well, unfortunately. But ordered writes would probably let
us batch up commit points in ways that are a lot friendlier for the
drives!
-Greg
