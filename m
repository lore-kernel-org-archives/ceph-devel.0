From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Upgrade/rollback
Date: Thu, 12 Feb 2015 06:57:19 -0800
Message-ID: <CAC6JEv9JAEw+JT5yrgiW_k74X4uatrTSttj1nMUPFRiQEbmeng@mail.gmail.com>
References: <BLU175-W8D101EDE23DCDD591ADF6DF250@phx.gbl>
	<CAC6JEv_76meAsaRmCr9-qEiU0C0R4LGOx=ja9M5vxkW=6jSvcQ@mail.gmail.com>
	<alpine.DEB.2.00.1502110923250.3035@cobra.newdream.net>
	<BLU175-W18F0FC1C0DF61C25BEFCEDF220@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:42553 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512AbbBLO5U convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Feb 2015 09:57:20 -0500
Received: by iery20 with SMTP id y20so12348281ier.9
        for <ceph-devel@vger.kernel.org>; Thu, 12 Feb 2015 06:57:20 -0800 (PST)
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com. [209.85.213.174])
        by mx.google.com with ESMTPSA id j6sm1328595igv.4.2015.02.12.06.57.19
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2015 06:57:19 -0800 (PST)
Received: by mail-ig0-f174.google.com with SMTP id b16so4171587igk.1
        for <ceph-devel@vger.kernel.org>; Thu, 12 Feb 2015 06:57:19 -0800 (PST)
In-Reply-To: <BLU175-W18F0FC1C0DF61C25BEFCEDF220@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Feb 12, 2015 at 12:48 AM, GuangYang <yguang11@outlook.com> wrote:
> Thanks Sage and Greg for the response.
>
>> 2) having a separate switchover point (besides the code upgrade) which
>>  enables all the disk change bits and which doesn't allow you to roll
>>  back.
> Let me give two examples which prevent us rollback from Giant to Firefly.
>
> Example #1:
> In Giant, there is a new feature flag 'CEPH_FEATURE_ERASURE_CODE_PLUGINS_V2' added/persisted, and monitor would  check the persisted list against the list released along with the software version upon starting, it refuse to start if the list mismatch. However, although the feature is added in Giant, it is not being used until we create a new pool with the profile, which is very unlikely to happen.
> 1) is it possible to persist the new feature bit when the feature is being used (this looks like complicated to implement). 2) When loading the persisted bit, is it possible to check if it is actually used by someone?
>
> Example #2:
> Patch [1] added a new k/v to the PG log which cannot be recognized by old version of binary (PGLog::read_log), as a result, it takes the newly added entry as a pg_log_entry.
> Is it possible to recognize pg_log_entry with a concrete pattern and just ignore those that the binary cannot recognize?
>
>
> For there two cases, we may be able to erase the newly added entries and then roll back (correct me if I am wrong here), but I think there might be more complicated cases which make the rollback impossible. And accept that risk for upgrading.

For these two specific cases, maybe. But you're missing more
fundamental things: often changes to data structures are about
behavior changes that the daemon needs to understand in order to make
any sense of the data. For instance, any upgrades to CRUSH need to be
understood by everybody participating in the cluster. We could
narrowly have the parsing code ignore anything it doesn't understand,
but then when it does calculations about past_intervals or current
mappings it would be wrong!

Or in the example #2 you have, the extra data is a bug fix that
prevents the OSD doing extra work. But what if it was actually about
changing the shared PG state? In that case you might have OSDs with
their PG in different states depending on how far they'd gotten when
rolled back to the old code.

It's just not a feasible problem, because while there are plenty of
things that we could route around, we still face the inevitable
collision point I described when we do add data of shared import. :(
-Greg
