From: Alyona Kiselyova <akiselyova@mirantis.com>
Subject: Re: Standardization of perf counters comments
Date: Thu, 12 Feb 2015 14:09:57 +0400
Message-ID: <CAONhiy6T2OGNDL03vR321HQ8tniTqcCPrO0LeRO9OBfjDOB-vw@mail.gmail.com>
References: <loom.20150211T183150-492@post.gmane.org>
	<CAC6JEv-YDNstmoGBFG0yNhgw5DOkTCDY2=2bKK1z-5Az4hqfKQ@mail.gmail.com>
	<CAGd4Wr2MD0JYK0xa_P4E4K6gv47K0RusRrmnaPT-RZh00j=OKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:39993 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbbBLKJ6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Feb 2015 05:09:58 -0500
Received: by mail-qg0-f54.google.com with SMTP id z60so7035013qgd.13
        for <ceph-devel@vger.kernel.org>; Thu, 12 Feb 2015 02:09:58 -0800 (PST)
In-Reply-To: <CAGd4Wr2MD0JYK0xa_P4E4K6gv47K0RusRrmnaPT-RZh00j=OKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: Gregory Farnum <greg@gregs42.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I think, it is a good idea to have both detailed and short description
with link in second.
But, may be, it isn't bad to start with a simple way - adding
functionality to extend schema, and continue with improving it with
detailed description in docs.

Yes, I agree, that required parameter is better, but if we will be
feeling not very conscientious, this required string may contain
something useless too :)
-------------------------------
Best regards,
Alyona Kiseleva


On Wed, Feb 11, 2015 at 9:39 PM, John Spray <john.spray@redhat.com> wrote:
> On Wed, Feb 11, 2015 at 6:02 PM, Gregory Farnum <greg@gregs42.com> wrote:
>> On Wed, Feb 11, 2015 at 9:33 AM, Alyona Kiseleva
>> <akiselyova@mirantis.com> wrote:
>>> Hi,
>>> I would like to propose something.
>>>
>>> There are a lot of perf counters in different places in code, but the most
>>> of them are undocumented. I found only one commented counter in OSD.cc code,
>>> but not for all metrics. Name of counter is not very clear as it's
>>> description, sometimes isn't at all.
>>>
>>> So, I have an idea, that it would be great, if perf schema would contain not
>>> only the counter type, but some description too. It can be added in
>>> PerfCountersBuilder methods - at first as optional parameter with empty
>>> string by default, later, may be, as required parameter. This short
>>> description could be saved in perf_counter_data_any_d struct together with
>>> other counter properties and appear in perf schema as the second counter
>>> property.
>
> There will be lots of counters that aren't usefully describable in a
> single sentence.  That doesn't excuse them from being documented, but
> we should be careful to avoid generating useless tautological strings
> like num_strays_delayed -> "Number of strays currently that are
> currently delayed".  For lots of things, an understandable definition
> will require some level of introduction of terms and concepts -- in my
> example, what's a stray?  what does it mean for it to be delayed?
>
> While we shouldn't hold up the descriptions waiting for documentation
> that explains all the needed concepts, we should think about how that
> will fit together.  Perhaps, rather than having a single string in the
> code, we should look to create a separate metadata file that allows
> richer RST docs for each setting, and verify that all settings are
> described during the docs build (i.e. a gitbuilder fail will tell us
> if someone added a setting without the associated documentation).
> That way, the short perfcounter descriptions could include hyperlinks
> to related concepts elsewhere in the docs.
>
> John
