From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Upgrade/rollback
Date: Wed, 11 Feb 2015 07:17:28 -0800
Message-ID: <CAC6JEv_76meAsaRmCr9-qEiU0C0R4LGOx=ja9M5vxkW=6jSvcQ@mail.gmail.com>
References: <BLU175-W8D101EDE23DCDD591ADF6DF250@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36966 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbbBKPR3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Feb 2015 10:17:29 -0500
Received: by iecrl12 with SMTP id rl12so2227590iec.4
        for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2015 07:17:29 -0800 (PST)
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com. [209.85.213.173])
        by mx.google.com with ESMTPSA id yq1sm1484107igb.21.2015.02.11.07.17.28
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2015 07:17:28 -0800 (PST)
Received: by mail-ig0-f173.google.com with SMTP id a13so31293672igq.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2015 07:17:28 -0800 (PST)
In-Reply-To: <BLU175-W8D101EDE23DCDD591ADF6DF250@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Feb 11, 2015 at 4:09 AM, GuangYang <yguang11@outlook.com> wrote:
> Hi ceph-devel,
> Recently we are trying the upgrade from Firefly to Giant and it goes pretty smoothly, however, the problem is that it does not support rollback and seems like that is by design. For example, there is new feature flag / metadata [1] added in the new version and they are persisted. As a result, the old version of software does not recognize those values and will crash themselves.
>
> Ideally we never rollback, but for unknown reasons we couldn't fix in a timely manner, we might want to rollback first. Is that something we will consider to handle?

We are unlikely to ever do this. We've talked about rollback options,
but allowing rollback means either:
1) never adding information to the disk format which matters,
2) having a separate switchover point (besides the code upgrade) which
enables all the disk change bits and which doesn't allow you to roll
back.

The first option is obviously infeasible. The second one dramatically
increases the amount of code which can be buggy, increases the testing
version, and doesn't really solve the problem since you still have a
hard point of no return.
-Greg
