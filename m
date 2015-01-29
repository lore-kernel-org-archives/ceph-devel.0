From: Marcel Lauhoff <ml@irq0.org>
Subject: Re: Article about Object Store API
Date: Fri, 30 Jan 2015 00:22:44 +0100
Message-ID: <87d25xnpdn.fsf@simstim.irq0.org>
References: <871tmgvtje.fsf@irq0.org> <CA+U0gViEieTP0vL+NYSBL7iHkOgBR1jnu_SsbZtQv8-Ci+BBgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cpu0.net ([37.187.2.217]:53257 "EHLO cpu0.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946AbbA2XWr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Jan 2015 18:22:47 -0500
Received: from simstim.irq0.org (hackerspace.c3pb.de [94.79.177.226])
	by ks3366964.kimsufi.com (Postfix) with ESMTPSA id 43A8B800BF
	for <ceph-devel@vger.kernel.org>; Thu, 29 Jan 2015 23:22:45 +0000 (UTC)
In-reply-to: <CA+U0gViEieTP0vL+NYSBL7iHkOgBR1jnu_SsbZtQv8-Ci+BBgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dennis Chen <kernel.org.gnu@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


Hello Dennis,

I haven't dived into librados code yet, but as far as I can see it is a
couple of layers above what I wrote about. :/

Can you please concretize your question a bit?

~marcel

Dennis Chen <kernel.org.gnu@gmail.com> writes:

> Hello marcel,
>
> Very good article though I am still reading it. Do you have a clear
> picture of the relationship between class and
> librados API - rados_exec()?
>
> On Wed, Jan 28, 2015 at 4:48 AM, Marcel Lauhoff <ml@irq0.org> wrote:
>>
>> Hi,
>>
>> I wrote an article about the object store API - How it works and looks
>> like with a focus on how to add something new.
>>
>> http://irq0.org/articles/ceph/objectstore
>>
>> Maybe its useful for somebody.. Feedback is greatly appreciated!
>>
>>
>>
>> [ I'm working on a Master's Thesis about Cold Storage / Archives using Ceph
>> and will probably write something more about other parts of Ceph
>> crossing my way in the near future :) ]
>>
>>
>> ~marcel
>>
>>
>> --
>> Marcel Lauhoff
>> Mail/XMPP: ml@irq0.org
>> http://irq0.org
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
Marcel Lauhoff
Mail/XMPP: ml@irq0.org
http://irq0.org etq
