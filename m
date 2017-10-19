From: John Spray <jspray@redhat.com>
Subject: Re: Luminous: osd_crush_location_hook renamed to crush_location_hook
Date: Thu, 19 Oct 2017 13:22:14 +0100
Message-ID: <CALe9h7e3703iRKJo2ZzJs8YXpYz4xy4T_1ZEv-nfhdGpBRzEJg@mail.gmail.com>
References: <1406455169.3092.1508155374117@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:51670 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753054AbdJSMWf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Oct 2017 08:22:35 -0400
Received: by mail-wr0-f169.google.com with SMTP id j14so8129285wre.8
        for <ceph-devel@vger.kernel.org>; Thu, 19 Oct 2017 05:22:35 -0700 (PDT)
In-Reply-To: <1406455169.3092.1508155374117@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Oct 16, 2017 at 1:02 PM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> I completely overread this, but I just found out that osd_crush_location_hook was renamed to crush_location_hook in the new config style.
>
> When upgrading from Jewel to Luminous without touching your configuration OSDs will move to the default CRUSH location due to the hook not being executed.
>
> Was this an oversight with Luminous or was it intentional?

Hmm, that setting wasn't part of the existing schema config_opts.h
schema.  The init script was effectively treating it as a "magic"
value that ceph-conf would be able to read out of the text ceph.conf.
Not that that matters from a user POV!

It looks like the init-ceph.in is still referring to the old magic
config setting's name as well.

I would vote that we treat this as a bug and change the setting name
back to osd_crush_location_hook, even if the name isn't quite
descriptive any more -- Sage?

John

>
> Wido
