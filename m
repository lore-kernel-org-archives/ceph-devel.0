From: Gregory Farnum <greg@gregs42.com>
Subject: Re: ms_crc_data false
Date: Wed, 8 Apr 2015 16:26:03 -0700
Message-ID: <CAC6JEv92Z8JrwHwDbzB9xNpWa+tApJP7dJ6gs1PNzaN5w1UKQg@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9166416855@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36164 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbbDHX0E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Apr 2015 19:26:04 -0400
Received: by igblo3 with SMTP id lo3so53383864igb.1
        for <ceph-devel@vger.kernel.org>; Wed, 08 Apr 2015 16:26:03 -0700 (PDT)
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com. [209.85.213.173])
        by mx.google.com with ESMTPSA id w9sm7735299igp.3.2015.04.08.16.26.03
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2015 16:26:03 -0700 (PDT)
Received: by iget9 with SMTP id t9so38780560ige.1
        for <ceph-devel@vger.kernel.org>; Wed, 08 Apr 2015 16:26:03 -0700 (PDT)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9166416855@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Apr 8, 2015 at 3:38 PM, Deneau, Tom <tom.deneau@amd.com> wrote:
> With 0.93, I tried
>     ceph tell 'osd.*' injectargs '--ms_crc_data=false' '--ms_crc_header=false'
>
> and saw the changes reflected in ceph admin-daemon
>
> But having done that, perf top still shows time being spent in crc32 routines.
> Is there some other parameter that needs changing?

You can change this config value, but unfortunately it won't have any
effect on a running daemon. You'll need to specify it in a config and
restart.
-Greg
