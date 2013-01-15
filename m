From: Gregory Farnum <greg@inktank.com>
Subject: Re: Grid data placement
Date: Tue, 15 Jan 2013 11:05:41 -0800
Message-ID: <CAPYLRzikyW47f_OmePZES=7rcAjWLFFcBHJ2Lyk6fFY-7-YcbA@mail.gmail.com>
References: <50F59431.3000401@bmrb.wisc.edu>
	<CAPYLRzhZdP6ehio9MgOZ7VnPSnMa05NUPmaRG3D_+tmWhe+oYA@mail.gmail.com>
	<50F5A116.4090607@bmrb.wisc.edu>
	<CAPYLRzgP8iKxD69+D_S7TtWUsre=y5JF51yWJDoMFHSUufJNQg@mail.gmail.com>
	<50F5A747.2060404@bmrb.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:41499 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757584Ab3AOTFm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 14:05:42 -0500
Received: by mail-qa0-f43.google.com with SMTP id cr7so2699049qab.9
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 11:05:41 -0800 (PST)
In-Reply-To: <50F5A747.2060404@bmrb.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jan 15, 2013 at 11:00 AM, Dimitri Maziuk <dmaziuk@bmrb.wisc.edu> wrote:
> On 01/15/2013 12:36 PM, Gregory Farnum wrote:
>> On Tue, Jan 15, 2013 at 10:33 AM, Dimitri Maziuk <dmaziuk@bmrb.wisc.edu> wrote:
>
>>> At the start of the batch #cores-in-the-cluster processes try to mmap
>>> the same 2GB and start reading it from SEEK_SET at the same time. I
>>> won't know until I try but I suspect it won't like that.
>>
>> Well, it'll be #servers-in-cluster serving up 4MB chunks out of cache.
>> It's possible you could overwhelm their networking but my bet is
>> they'll just get spread out slightly on the first block and then not
>> contend in the future.
>
> In the future the application spreads out the reads as well: running
> instances go through the data at different speed, and when one's
> finished, the next one starts on the same core & it mmap's the first
> chunk again.
>
>> Just as long as you're thinking of it as a test system that would make
>> us very happy. :)
>
> Well, IRL this is throw-away data generated at the start of a batch, and
> we're good if one batch a month runs to completion. So if it doesn't
> crash all the time every time, that actually should be good enough for
> me. However, not all of the nodes have spare disk slots, so I couldn't
> do a full-scale deployment anyway, not without rebuilding half the nodes.

In that case you are my favorite kind of user and you should install
and try it out right away! :D
