From: Patrick McGarry <patrick@inktank.com>
Subject: Re: Bobtail vs Argonaut Performance Preview
Date: Sat, 22 Dec 2012 11:28:34 -0500
Message-ID: <CAP8Oy=KifMg_i_KZSGoUD8mM77Ybp8GAhHSYQVsx-FeXO38n7w@mail.gmail.com>
References: <CAP8Oy=J6kazDvT6woLZZ3v+XVrzhKbHgO1wgyoTU8OCKq2qDEg@mail.gmail.com>
	<20121222083200.GA1977@infradead.org>
	<50D5B769.4090104@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:32780 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab2LVQ2f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 22 Dec 2012 11:28:35 -0500
Received: by mail-pb0-f44.google.com with SMTP id uo1so3311258pbc.17
        for <ceph-devel@vger.kernel.org>; Sat, 22 Dec 2012 08:28:35 -0800 (PST)
In-Reply-To: <50D5B769.4090104@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Christoph Hellwig <hch@infradead.org>, Ceph Devel <ceph-devel@vger.kernel.org>

Actually one of the chief reasons is the shortened URLs give you
embedded tracking for how many people click through your link.  This
means we can see who clicks on the link from where and get a better
picture of stats w/o having to depend entirely on the imperfect
referrer information provided by google analytics.

On Sat, Dec 22, 2012 at 8:36 AM, Mark Nelson <mark.nelson@inktank.com> wrote:
> On 12/22/2012 02:32 AM, Christoph Hellwig wrote:
>>
>> On Thu, Dec 20, 2012 at 11:08:19AM -0500, Patrick McGarry wrote:
>>>
>>> Hey All,
>>>
>>> Inktank's Mark Nelson just posted a great performance preview of
>>> Bobtail with comparison to Argonaut.  Feel free to check it out:
>>>
>>> http://ow.ly/gg87B
>>
>>
>> What's the problem with using a proper link instead of these idiotic
>> shortening services?
>
>
> I think it's just the twitter world leaking out into other mediums. Some
> times it's slightly bewildering to me that in this day and age so much
> conversation seems to happen on a medium that only allows 140 characters at
> a time.  That's apparently the world we live in though.  :)
>
> Btw Christoph, thank you for taking the time to read my article.  If I've
> done anything dumb or suboptimal regarding xfs, please do let me know.  Soon
> I will be doing parametric sweeps over ceph parameter spaces to see how
> performance varies on different hardware configurations.  I want to make
> sure the tests are setup as optimally as possible.
>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> Mark
