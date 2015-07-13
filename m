From: Gregory Farnum <greg@gregs42.com>
Subject: Re: osd suicide timeout
Date: Mon, 13 Jul 2015 11:07:04 +0100
Message-ID: <CAC6JEv9GJFAyQBXU398Na=RfHROPoakbzcM6sFUCh_Cg6bE7Zw@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91669B3BFF@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37531 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbbGMKHG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jul 2015 06:07:06 -0400
Received: by igpy18 with SMTP id y18so52680525igp.0
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2015 03:07:05 -0700 (PDT)
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com. [209.85.223.169])
        by smtp.gmail.com with ESMTPSA id j20sm5393675igt.5.2015.07.13.03.07.05
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2015 03:07:05 -0700 (PDT)
Received: by ietj16 with SMTP id j16so58428675iet.0
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2015 03:07:04 -0700 (PDT)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF91669B3BFF@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jul 10, 2015 at 10:45 PM, Deneau, Tom <tom.deneau@amd.com> wrote:
> I have an osd log file from an osd that hit a suicide timeout (with the previous 10000 events logged).
> (On this node I have also seen this suicide timeout happen once before and also a sync_entry timeout.
>
> I can see that 6 minutes or so before that osd died, other osds on the same node were logging
> messages such as
>     heartbeat_check: no reply from osd.8
> so it appears that osd8 stopped responding quite some time before it died.

It does this deliberately when its disk threads look like they might be stuck.

>
> I'm wondering if there is enough information in the osd8 log file to deduce why osd 8 stopped responding?
> I don't know enough to figure it out myself.
>
> Is there any expert who would be willing to take a look at the log file?

The logs will have a backtrace in them; if you can include that and
the last hundred lines or so prior in a pastebin that you email the
list with several people can give you a pretty good idea of what's
going on.

In general though, it's just going to be that the disk can't keep up
with the load being applied to it. That could be because it's failing,
or because you're pushing too much work on to it in some fashion.
-Greg
