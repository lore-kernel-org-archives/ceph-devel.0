From: Dan van der Ster <dan@vanderster.com>
Subject: Re: scrub randomization and load threshold
Date: Mon, 16 Nov 2015 16:58:12 +0100
Message-ID: <CABZ+qqnkJVFtV3c=9PYgEWU2__uGmxXQxdymaLyfzkeB+MSjvw@mail.gmail.com>
References: <CABZ+qq=7izv5o-5ACygqZyr=ho58nLoKb7XmRKT2yyTqKFwrZQ@mail.gmail.com>
 <alpine.DEB.2.00.1511120526390.7964@cobra.newdream.net> <CABZ+qqnj81gQDe6mApNdGa-HK2LbeKJwHH-7Lj9ovq2+ci1MgA@mail.gmail.com>
 <alpine.DEB.2.00.1511120705240.614@cobra.newdream.net> <CABZ+qq=hEkD1QwqoYeytOGKanbSKVBodQmmsb_sXSTsGwDKimA@mail.gmail.com>
 <CABZ+qqma+-bOPcPr3K_9mZaDHE54pvNtWw0OmiAFCYH1zX3Ysw@mail.gmail.com>
 <alpine.DEB.2.00.1511160717510.7964@cobra.newdream.net> <CABZ+qqnezk0=D1rArOogctrjpsAU7n_wOdLRPJ0HkhwzRbQSpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35972 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbbKPP6z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Nov 2015 10:58:55 -0500
Received: by lfs39 with SMTP id 39so89477938lfs.3
        for <ceph-devel@vger.kernel.org>; Mon, 16 Nov 2015 07:58:53 -0800 (PST)
Received: from mail-lf0-f43.google.com (mail-lf0-f43.google.com. [209.85.215.43])
        by smtp.gmail.com with ESMTPSA id oi5sm5578524lbb.13.2015.11.16.07.58.52
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2015 07:58:53 -0800 (PST)
Received: by lfaz4 with SMTP id z4so25849345lfa.0
        for <ceph-devel@vger.kernel.org>; Mon, 16 Nov 2015 07:58:52 -0800 (PST)
In-Reply-To: <CABZ+qqnezk0=D1rArOogctrjpsAU7n_wOdLRPJ0HkhwzRbQSpQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Herve Rousseau <herve.rousseau@cern.ch>

On Mon, Nov 16, 2015 at 4:32 PM, Dan van der Ster <dan@vanderster.com> wrote:
> On Mon, Nov 16, 2015 at 4:20 PM, Sage Weil <sage@newdream.net> wrote:
>> On Mon, 16 Nov 2015, Dan van der Ster wrote:
>>> Instead of keeping a 24hr loadavg, how about we allow scrubs whenever
>>> the loadavg is decreasing (or below the threshold)? As long as the
>>> 1min loadavg is less than the 15min loadavg, we should be ok to allow
>>> new scrubs. If you agree I'll add the patch below to my PR.
>>
>> I like the simplicity of that, I'm afraid its going to just trigger a
>> feedback loop and oscillations on the host.  I.e., as soo as we see *any*
>> decrease, all osds on the host will start to scrub, which will push the
>> load up.  Once that round of PGs finish, the load will start to drop
>> again, triggering another round.  This'll happen regardless of whether
>> we're in the peak hours or not, and the high-level goal (IMO at least) is
>> to do scrubbing in non-peak hours.
>
> We checked our OSDs' 24hr loadavg plots today and found that the
> original idea of 0.8 * 24hr loadavg wouldn't leave many chances for
> scrubs to run. So maybe if we used 0.9 or 1.0 it would be doable.
>
> BTW, I realized there was a silly error in that earlier patch, and we
> anyway need an upper bound, say # cpus. So until your response came I
> was working with this idea:
> https://stikked.web.cern.ch/stikked/view/raw/5586a912

Sorry for SSO. Here:

https://gist.github.com/dvanders/f3b08373af0f5957f589
