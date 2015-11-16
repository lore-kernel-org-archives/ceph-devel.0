From: Dan van der Ster <dan@vanderster.com>
Subject: Re: scrub randomization and load threshold
Date: Mon, 16 Nov 2015 18:30:43 +0100
Message-ID: <CABZ+qqmSv+D2==bPdexHowbEA4fuTBneNWQ5CkbB1_bPr+W2HQ@mail.gmail.com>
References: <CABZ+qq=7izv5o-5ACygqZyr=ho58nLoKb7XmRKT2yyTqKFwrZQ@mail.gmail.com>
 <alpine.DEB.2.00.1511120526390.7964@cobra.newdream.net> <CABZ+qqnj81gQDe6mApNdGa-HK2LbeKJwHH-7Lj9ovq2+ci1MgA@mail.gmail.com>
 <alpine.DEB.2.00.1511120705240.614@cobra.newdream.net> <CABZ+qq=hEkD1QwqoYeytOGKanbSKVBodQmmsb_sXSTsGwDKimA@mail.gmail.com>
 <CABZ+qqma+-bOPcPr3K_9mZaDHE54pvNtWw0OmiAFCYH1zX3Ysw@mail.gmail.com>
 <alpine.DEB.2.00.1511160717510.7964@cobra.newdream.net> <CABZ+qqnezk0=D1rArOogctrjpsAU7n_wOdLRPJ0HkhwzRbQSpQ@mail.gmail.com>
 <CABZ+qqnkJVFtV3c=9PYgEWU2__uGmxXQxdymaLyfzkeB+MSjvw@mail.gmail.com>
 <CABZ+qqkkGDvfc4arSKdUyWG-_p_Ona71bENNEsgxCCVqQAK5kg@mail.gmail.com> <alpine.DEB.2.00.1511160910440.7964@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35070 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbbKPRb2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Nov 2015 12:31:28 -0500
Received: by lfdo63 with SMTP id o63so90971348lfd.2
        for <ceph-devel@vger.kernel.org>; Mon, 16 Nov 2015 09:31:26 -0800 (PST)
Received: from mail-lb0-f172.google.com (mail-lb0-f172.google.com. [209.85.217.172])
        by smtp.gmail.com with ESMTPSA id d2sm4344900lbc.11.2015.11.16.09.31.24
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2015 09:31:24 -0800 (PST)
Received: by lbblt2 with SMTP id lt2so93221457lbb.3
        for <ceph-devel@vger.kernel.org>; Mon, 16 Nov 2015 09:31:24 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1511160910440.7964@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Herve Rousseau <herve.rousseau@cern.ch>

On Mon, Nov 16, 2015 at 6:13 PM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 16 Nov 2015, Dan van der Ster wrote:
>> On Mon, Nov 16, 2015 at 4:58 PM, Dan van der Ster <dan@vanderster.com> wrote:
>> > On Mon, Nov 16, 2015 at 4:32 PM, Dan van der Ster <dan@vanderster.com> wrote:
>> >> On Mon, Nov 16, 2015 at 4:20 PM, Sage Weil <sage@newdream.net> wrote:
>> >>> On Mon, 16 Nov 2015, Dan van der Ster wrote:
>> >>>> Instead of keeping a 24hr loadavg, how about we allow scrubs whenever
>> >>>> the loadavg is decreasing (or below the threshold)? As long as the
>> >>>> 1min loadavg is less than the 15min loadavg, we should be ok to allow
>> >>>> new scrubs. If you agree I'll add the patch below to my PR.
>> >>>
>> >>> I like the simplicity of that, I'm afraid its going to just trigger a
>> >>> feedback loop and oscillations on the host.  I.e., as soo as we see *any*
>> >>> decrease, all osds on the host will start to scrub, which will push the
>> >>> load up.  Once that round of PGs finish, the load will start to drop
>> >>> again, triggering another round.  This'll happen regardless of whether
>> >>> we're in the peak hours or not, and the high-level goal (IMO at least) is
>> >>> to do scrubbing in non-peak hours.
>> >>
>> >> We checked our OSDs' 24hr loadavg plots today and found that the
>> >> original idea of 0.8 * 24hr loadavg wouldn't leave many chances for
>> >> scrubs to run. So maybe if we used 0.9 or 1.0 it would be doable.
>> >>
>> >> BTW, I realized there was a silly error in that earlier patch, and we
>> >> anyway need an upper bound, say # cpus. So until your response came I
>> >> was working with this idea:
>> >> https://stikked.web.cern.ch/stikked/view/raw/5586a912
>> >
>> > Sorry for SSO. Here:
>> >
>> > https://gist.github.com/dvanders/f3b08373af0f5957f589
>>
>> Hi again. Here's a first shot at a daily loadavg heuristic:
>> https://github.com/ceph/ceph/commit/15474124a183c7e92f457f836f7008a2813aa672
>> I had to guess where it would be best to store the daily_loadavg
>> member and where to initialize it... please advise.
>>
>> I took the conservative approach of triggering scrubs when either:
>>    1m loadavg < osd_scrub_load_threshold, or
>>    1m loadavg < 24hr loadavg && 1m loadavg < 15m loadavg
>>
>> The whole PR would become this:
>> https://github.com/ceph/ceph/compare/master...cernceph:wip-deepscrub-daily
>
> Looks reasonable to me!
>
> I'm still a bit worried that the 1m < 15m thing will mean that on the
> completion of every scrub we have to wait ~1m before the next scrub
> starts.  Maybe that's okay, though... I'd say let's try this and adjust
> that later if it seems problematic (conservative == better).
>
> sage

Great. I've updated the PR:  https://github.com/ceph/ceph/pull/6550

Cheers, Dan
