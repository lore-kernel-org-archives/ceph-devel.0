From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: verbose logging for mount -t ceph or ceph-fuse problems
Date: Wed, 20 Jul 2016 20:14:40 -0600
Message-ID: <CALqRxCyH4uipdGEyPosmwcf0eGexYbkTZwwYQRpyOW4ELPHGfA@mail.gmail.com>
References: <DM3PR1201MB09250DDBE36361721995F79B9B360@DM3PR1201MB0925.namprd12.prod.outlook.com>
 <CALe9h7fxL54r014kJRz7tfXbGrcMpsT74Uh9PCjguMrkjydeiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34595 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbcGUCOm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jul 2016 22:14:42 -0400
Received: by mail-vk0-f49.google.com with SMTP id s189so94075221vkh.1
        for <ceph-devel@vger.kernel.org>; Wed, 20 Jul 2016 19:14:41 -0700 (PDT)
In-Reply-To: <CALe9h7fxL54r014kJRz7tfXbGrcMpsT74Uh9PCjguMrkjydeiQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: "Deneau, Tom" <tom.deneau@amd.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks John, I've captured that in the docs for the page Tom linked.

https://github.com/ceph/ceph/pull/10374

- Ken

On Tue, Jul 19, 2016 at 2:47 AM, John Spray <jspray@redhat.com> wrote:
> For ceph-fuse, try running in the foreground with logging to the
> console (-d) and enabling client debug (--debug-client=20), enabling
> prints for each message sent (--debug-ms=1) and debugging for the
> monitor client (--debug-monc=20).
>
> Cheers,
> John
>
> On Mon, Jul 18, 2016 at 11:41 PM, Deneau, Tom <tom.deneau@amd.com> wrote:
>> What debug option (from http://docs.ceph.com/docs/master/rados/troubleshooting/log-and-debug/) would be best to find errors coming from
>>    * mount -t ceph ...
>>    * or ceph-fuse
>>
>> My problems seem to be network-address-related because if I create the cluster with 1Gig addresses rather than 10Gig, both mount -t ceph and ceph-fuse work fine.
>>
>> -- Tom Deneau
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
