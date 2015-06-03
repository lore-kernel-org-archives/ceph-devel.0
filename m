From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Discuss: New default recovery config settings
Date: Wed, 3 Jun 2015 15:55:09 -0700
Message-ID: <CAC6JEv8MqKb0xtVodm8ViXBof-gqw_PcwTc-ULKZcPCrRsepNw@mail.gmail.com>
References: <1939533999.9756941.1432935747903.JavaMail.zimbra@redhat.com>
	<1394947829.9758745.1432936033017.JavaMail.zimbra@redhat.com>
	<CAC6JEv8LyM1SRsOszDCj6tLxhZ=hvrEkinDARW8BvyQHDCz+LQ@mail.gmail.com>
	<622F4407872BA447A16110F65453358C03DFB21C4B5F@FMSAMAIL.fmsa.local>
	<CAC6JEv-i6tOwPBDjP++EW4FxAKZ_X_prEZ8YZOpLq-RTP1ZguQ@mail.gmail.com>
	<alpine.DEB.2.00.1506031541200.26591@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36584 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbbFCWzL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jun 2015 18:55:11 -0400
Received: by qgep100 with SMTP id p100so10633059qge.3
        for <ceph-devel@vger.kernel.org>; Wed, 03 Jun 2015 15:55:10 -0700 (PDT)
Received: from mail-qk0-f180.google.com (mail-qk0-f180.google.com. [209.85.220.180])
        by mx.google.com with ESMTPSA id g15sm1269146qge.17.2015.06.03.15.55.09
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2015 15:55:09 -0700 (PDT)
Received: by qkhq76 with SMTP id q76so14757103qkh.2
        for <ceph-devel@vger.kernel.org>; Wed, 03 Jun 2015 15:55:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1506031541200.26591@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>, Samuel Just <sjust@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "'ceph-users@lists.ceph.com' (ceph-users@lists.ceph.com)" <ceph-users@lists.ceph.com>

On Wed, Jun 3, 2015 at 3:44 PM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 1 Jun 2015, Gregory Farnum wrote:
>> On Mon, Jun 1, 2015 at 6:39 PM, Paul Von-Stamwitz
>> <PVonStamwitz@us.fujitsu.com> wrote:
>> > On Fri, May 29, 2015 at 4:18 PM, Gregory Farnum <greg@gregs42.com> wrote:
>> >> On Fri, May 29, 2015 at 2:47 PM, Samuel Just <sjust@redhat.com> wrote:
>> >> > Many people have reported that they need to lower the osd recovery config options to minimize the impact of recovery on client io.  We are talking about changing the defaults as follows:
>> >> >
>> >> > osd_max_backfills to 1 (from 10)
>> >> > osd_recovery_max_active to 3 (from 15)
>> >> > osd_recovery_op_priority to 1 (from 10)
>> >> > osd_recovery_max_single_start to 1 (from 5)
>> >>
>> >> I'm under the (possibly erroneous) impression that reducing the number of max backfills doesn't actually reduce recovery speed much (but will reduce memory use), but that dropping the op priority can. I'd rather we make users manually adjust values which can have a material impact on their data safety, even if most of them choose to do so.
>> >>
>> >> After all, even under our worst behavior we're still doing a lot better than a resilvering RAID array. ;) -Greg
>> >> --
>> >
>> >
>> > Greg,
>> > When we set...
>> >
>> > osd recovery max active = 1
>> > osd max backfills = 1
>> >
>> > We see rebalance times go down by more than half and client write performance increase significantly while rebalancing. We initially played with these settings to improve client IO expecting recovery time to get worse, but we got a 2-for-1.
>> > This was with firefly using replication, downing an entire node with lots of SAS drives. We left osd_recovery_threads, osd_recovery_op_priority, and osd_recovery_max_single_start default.
>> >
>> > We dropped osd_recovery_max_active and osd_max_backfills together. If you're right, do you think osd_recovery_max_active=1 is primary reason for the improvement? (higher osd_max_backfills helps recovery time with erasure coding.)
>>
>> Well, recovery max active and max backfills are similar in many ways.
>> Both are about moving data into a new or outdated copy of the PG ? the
>> difference is that recovery refers to our log-based recovery (where we
>> compare the PG logs and move over the objects which have changed)
>> whereas backfill requires us to incrementally move through the entire
>> PG's hash space and compare.
>> I suspect dropping down max backfills is more important than reducing
>> max recovery (gathering recovery metadata happens largely in memory)
>> but I don't really know either way.
>>
>> My comment was meant to convey that I'd prefer we not reduce the
>> recovery op priority levels. :)
>
> We could make a less extreme move than to 1, but IMO we have to reduce it
> one way or another.  Every major operator I've talked to does this, our PS
> folks have been recommending it for years, and I've yet to see a single
> complaint about recovery times... meanwhile we're drowning in a sea of
> complaints about the impact on clients.
>
> How about
>
>  osd_max_backfills to 1 (from 10)
>  osd_recovery_max_active to 3 (from 15)
>  osd_recovery_op_priority to 3 (from 10)
>  osd_recovery_max_single_start to 1 (from 5)
>
> (same as above, but 1/3rd the recovery op prio instead of 1/10th)
> ?

Do we actually have numbers for these changes individually? We might,
but I have a suspicion that at some point there was just a "well, you
could turn them all down" comment and that state was preferred to our
defaults.

I mean, I have no real knowledge of how changing the op priority
impacts things, but I don't think many (any?) other people do either,
so I'd rather mutate slowly and see if that works better. :)
Especially given Paul's comment that just the recovery_max and
max_backfills values made a huge positive difference without any
change to priorities.
-Greg
