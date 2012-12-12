From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph osd create XX
Date: Wed, 12 Dec 2012 13:36:28 -0800
Message-ID: <CAPYLRzjntgh+CHXbtoRvLHhvjo1wqT9F16vshsiBhLcYebUB-Q@mail.gmail.com>
References: <50C8F7AC.9070600@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:50925 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319Ab2LLVg3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 16:36:29 -0500
Received: by mail-ie0-f179.google.com with SMTP id k14so2821763iea.10
        for <ceph-devel@vger.kernel.org>; Wed, 12 Dec 2012 13:36:28 -0800 (PST)
In-Reply-To: <50C8F7AC.9070600@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Dec 12, 2012 at 1:31 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> Hello List,
>
> ceph osd create $NUM
>
> does not seem to work anymore ;-(
>
> # ceph osd createosd. 62
> unknown command createosd

Read those two lines again. Very slowly. :)

The correct syntax is
ceph osd create <uuid>

The uuid is optional, but you don't specify IDs; it gives you an ID back.
-Greg

>
> Crushmap is already changed and imported ceph.conf is altered and reloaded.
>
> Greets
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
