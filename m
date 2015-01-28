From: Marcel Lauhoff <ml@irq0.org>
Subject: Re: Article about Object Store API
Date: Wed, 28 Jan 2015 15:27:46 +0100
Message-ID: <87y4onugil.fsf@irq0.org>
References: <871tmgvtje.fsf@irq0.org> <CAC6JEv8qv-tTiJW4Rdu_bd-fJSZuwdKd_UC_KJyHzb06n9t9Ww@mail.gmail.com> <54C80E62.5030300@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cpu0.net ([37.187.2.217]:34396 "EHLO cpu0.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757169AbbA1UYr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Jan 2015 15:24:47 -0500
Received: from janelane.irq0.org (pdbn-5d827e29.pool.mediaWays.net [93.130.126.41])
	by ks3366964.kimsufi.com (Postfix) with ESMTPSA id 24EA7800BF
	for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2015 14:27:35 +0000 (UTC)
In-reply-to: <54C80E62.5030300@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>


Hi,
thanks!


Well, maybe, but probably not :) I'm at this point going through a list of
cold storage system ideas for my thesis. Part of that is evaluating how
one /could/ implement them in Ceph. A special object store that accesses
an archive system is one of them. I'll later plan to implement something, but I
haven't yet decided on what ;)

~marcel

Loic Dachary <loic@dachary.org> writes:

> Hi Marcel,
>
> I'll bookmark this: useful high level view to get oriented when going back to this part of the code. I have the same question as Greg actually. It looks like you're tempted to try a new objectstore backend, that's my bet :-)
>
> Cheers
>
> On 27/01/2015 22:03, Gregory Farnum wrote:
>> Nifty; it's good to have that sort of blog-style documentation about
>> the interface. Are you planning to do some work with it that you can
>> show off as well? :)
>> -Greg
>>
>> On Tue, Jan 27, 2015 at 12:48 PM, Marcel Lauhoff <ml@irq0.org> wrote:
>>>
>>> Hi,
>>>
>>> I wrote an article about the object store API - How it works and looks
>>> like with a focus on how to add something new.
>>>
>>> http://irq0.org/articles/ceph/objectstore
>>>
>>> Maybe its useful for somebody.. Feedback is greatly appreciated!
>>>
>>>
>>>
>>> [ I'm working on a Master's Thesis about Cold Storage / Archives using Ceph
>>> and will probably write something more about other parts of Ceph
>>> crossing my way in the near future :) ]
>>>
>>>
>>> ~marcel
