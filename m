From: Haomai Wang <haomai@xsky.com>
Subject: Re: AsyncMessenger maturity
Date: Thu, 16 Jun 2016 09:45:32 +0800
Message-ID: <CACJqLyYuTDKobwLjSCEmY4Kk+AsiAaX06AX1M6dieBfObBbAuw@mail.gmail.com>
References: <DB5PR05MB160725A2A9228123780F67CFA9550@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <alpine.DEB.2.11.1606151412450.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pu1apc01on0114.outbound.protection.outlook.com ([104.47.126.114]:20608
	"EHLO APC01-PU1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753224AbcFPBpq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 15 Jun 2016 21:45:46 -0400
Received: by mail-yw0-f181.google.com with SMTP id c72so30277925ywb.1
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jun 2016 18:45:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606151412450.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Avner Ben Hanoch <avnerb@mellanox.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jun 16, 2016 at 2:16 AM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 15 Jun 2016, Avner Ben Hanoch wrote:
>> Hi All,
>>
>> I tried to evaluate AsyncMessenger (together with its sub classes) and I
>> found its code great in my eyes. Still, when using it at runtime, Ceph
>> will warn you that this module is dangerous.
>
> In jewel we've removed the 'experimental' flag.  Upgrade!
>
>> *I have two questions:*
>> 1. Considering pros and cons, are there any cons when using
>> AsyncMessenger instead of SimpleMessenger (like stability, or cpu/memory
>> consumption, .)
>
> Less CPU, fewer threads, nicer code.
>
>> 2. I am considering a variant of AsyncMessenger that might require that
>> both sides will be same messenger, I wonder, is it possible to use
>> AsyncMessenger for private network between OSDs only and to remain with
>> SimpleMessenger for all other messengers (for example, by just changing
>> the lines that creates the 6 Messengers in ceph_osd.cc::main)
>
> It's the same protocol as SimpleMessenger, so there is no need to run
> SimpleMessenger at all.  (You can't currently use two types in the same
> process, but I don't think there's any need to.)

Recently we tested on a ~70 osds cluster used as rgw case. We can
obverse ~20% performance improvement compared to simple while do
cosbench benchmark. I'm not sure the actual reason now, but I guess in
a resource-limited env, async behavior much better.

>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
