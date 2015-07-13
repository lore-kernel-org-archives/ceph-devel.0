From: Milosz Tanski <milosz@adfin.com>
Subject: Re: About Adding eventfd support for LibRBD
Date: Mon, 13 Jul 2015 14:16:40 -0400
Message-ID: <CANP1eJEcZYubsnrT7C7o=uqQjPsywZqRniNcGYUjb=frhijPGQ@mail.gmail.com>
References: <CACJqLyb5spgWuxAc-rLctp6RapKuWmmdNwg42CbRNOEcxW5XGw@mail.gmail.com>
	<559C9422.8010403@redhat.com>
	<CACJqLyaj4sxmN9R+m8xY6v=isdh53qGDotKAn_2QW0SVkmOeQg@mail.gmail.com>
	<CACJqLyaNuS0=9r9kg0M5m67xVO6nrzs1Dz6xsDij-yvs8-e0mQ@mail.gmail.com>
	<758467134.37486644.1436795528859.JavaMail.zimbra@redhat.com>
	<CACJqLya0KixGX3npT3nTRKD0Qbbj8xrWKmYLv4fPWjVG_K=hjA@mail.gmail.com>
	<1771808938.37680022.1436808765381.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34243 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbbGMSQl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jul 2015 14:16:41 -0400
Received: by oiab3 with SMTP id b3so141312961oia.1
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2015 11:16:40 -0700 (PDT)
In-Reply-To: <1771808938.37680022.1436808765381.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, Josh Durgin <jdurgin@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jul 13, 2015 at 1:32 PM, Jason Dillaman <dillaman@redhat.com> wrote:
>> Sorry, I'm not following. Even we have poll_io_events, we need to when
>> to call "poll_io_events".
>>
>> I guess you mean we could notify user's side "fd" in rbd callback.
>> Yes, we could do this. But a extra rbd callback could be omitted if we
>> embed standard notification methods, we can get performance benefits
>> via inline notify and maybe we can reduce internal completion
>> structures(maybe?).
>>
>
> Perhaps if you could provide a full example of how you seeing this be used, it would be helpful.  Are you proposing to just use eventfd (and its equivalents under other OSs) in-lieu of a mutex/condition variable. I.e. when an AioCompletion finishes, it would add itself to a (potentially lock-free) list of completed AIO ops to be returned by the next "poll_io_events" invocation -- which is signaled via the eventfd mechanism instead of the using a pipe or lock/condition variable.

A lock free list (SPSC) + an eventcount to prevent busy waiting is
probably the best balance between performance and not busy spinning in
the free / full case. But it doesn't provide an easily compassable way
of integrating waiting on other events in the application. eventfd is
easy to embed in your (e)pool loop or any kind of event library
(libev).

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
