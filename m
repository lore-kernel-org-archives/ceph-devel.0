From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: About Adding eventfd support for LibRBD
Date: Mon, 13 Jul 2015 13:32:45 -0400 (EDT)
Message-ID: <1771808938.37680022.1436808765381.JavaMail.zimbra@redhat.com>
References: <CACJqLyb5spgWuxAc-rLctp6RapKuWmmdNwg42CbRNOEcxW5XGw@mail.gmail.com> <559C9422.8010403@redhat.com> <CACJqLyaj4sxmN9R+m8xY6v=isdh53qGDotKAn_2QW0SVkmOeQg@mail.gmail.com> <CACJqLyaNuS0=9r9kg0M5m67xVO6nrzs1Dz6xsDij-yvs8-e0mQ@mail.gmail.com> <758467134.37486644.1436795528859.JavaMail.zimbra@redhat.com> <CACJqLya0KixGX3npT3nTRKD0Qbbj8xrWKmYLv4fPWjVG_K=hjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:43031 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbbGMRcs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jul 2015 13:32:48 -0400
In-Reply-To: <CACJqLya0KixGX3npT3nTRKD0Qbbj8xrWKmYLv4fPWjVG_K=hjA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Josh Durgin <jdurgin@redhat.com>, ceph-devel@vger.kernel.org

> Sorry, I'm not following. Even we have poll_io_events, we need to when
> to call "poll_io_events".
> 
> I guess you mean we could notify user's side "fd" in rbd callback.
> Yes, we could do this. But a extra rbd callback could be omitted if we
> embed standard notification methods, we can get performance benefits
> via inline notify and maybe we can reduce internal completion
> structures(maybe?).
> 

Perhaps if you could provide a full example of how you seeing this be used, it would be helpful.  Are you proposing to just use eventfd (and its equivalents under other OSs) in-lieu of a mutex/condition variable. I.e. when an AioCompletion finishes, it would add itself to a (potentially lock-free) list of completed AIO ops to be returned by the next "poll_io_events" invocation -- which is signaled via the eventfd mechanism instead of the using a pipe or lock/condition variable.
