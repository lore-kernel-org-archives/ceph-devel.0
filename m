From: John Spray <jspray@redhat.com>
Subject: Re: verbose logging for mount -t ceph or ceph-fuse problems
Date: Tue, 19 Jul 2016 09:47:28 +0100
Message-ID: <CALe9h7fxL54r014kJRz7tfXbGrcMpsT74Uh9PCjguMrkjydeiQ@mail.gmail.com>
References: <DM3PR1201MB09250DDBE36361721995F79B9B360@DM3PR1201MB0925.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35536 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbcGSIrs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jul 2016 04:47:48 -0400
Received: by mail-qk0-f180.google.com with SMTP id s63so9657390qkb.2
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2016 01:47:48 -0700 (PDT)
In-Reply-To: <DM3PR1201MB09250DDBE36361721995F79B9B360@DM3PR1201MB0925.namprd12.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

For ceph-fuse, try running in the foreground with logging to the
console (-d) and enabling client debug (--debug-client=20), enabling
prints for each message sent (--debug-ms=1) and debugging for the
monitor client (--debug-monc=20).

Cheers,
John

On Mon, Jul 18, 2016 at 11:41 PM, Deneau, Tom <tom.deneau@amd.com> wrote:
> What debug option (from http://docs.ceph.com/docs/master/rados/troubleshooting/log-and-debug/) would be best to find errors coming from
>    * mount -t ceph ...
>    * or ceph-fuse
>
> My problems seem to be network-address-related because if I create the cluster with 1Gig addresses rather than 10Gig, both mount -t ceph and ceph-fuse work fine.
>
> -- Tom Deneau
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
