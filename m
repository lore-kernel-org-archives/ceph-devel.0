From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: About Adding eventfd support for LibRBD
Date: Mon, 13 Jul 2015 12:58:05 -0700
Message-ID: <55A4184D.8020505@redhat.com>
References: <CACJqLyb5spgWuxAc-rLctp6RapKuWmmdNwg42CbRNOEcxW5XGw@mail.gmail.com> <559C9422.8010403@redhat.com> <CACJqLyaj4sxmN9R+m8xY6v=isdh53qGDotKAn_2QW0SVkmOeQg@mail.gmail.com> <CACJqLyaNuS0=9r9kg0M5m67xVO6nrzs1Dz6xsDij-yvs8-e0mQ@mail.gmail.com> <758467134.37486644.1436795528859.JavaMail.zimbra@redhat.com> <CACJqLya0KixGX3npT3nTRKD0Qbbj8xrWKmYLv4fPWjVG_K=hjA@mail.gmail.com> <1771808938.37680022.1436808765381.JavaMail.zimbra@redhat.com> <CANP1eJEcZYubsnrT7C7o=uqQjPsywZqRniNcGYUjb=frhijPGQ@mail.gmail.com> <694208947.37724099.1436812751415.JavaMail.zimbra@redhat.com> <alpine.DEB.2.00.1507131140480.8878@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38623 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678AbbGMT6A (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 Jul 2015 15:58:00 -0400
In-Reply-To: <alpine.DEB.2.00.1507131140480.8878@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Jason Dillaman <dillaman@redhat.com>
Cc: Milosz Tanski <milosz@adfin.com>, Haomai Wang <haomaiwang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 07/13/2015 11:42 AM, Sage Weil wrote:
> On Mon, 13 Jul 2015, Jason Dillaman wrote:
>>> But it doesn't provide an easily compassable way
>>> of integrating waiting on other events in the application. eventfd is
>>> easy to embed in your (e)pool loop or any kind of event library
>>> (libev).
>>
>> Agreed -- which is why I asked about the proposed design since it
>> appears (to me) that everything is hidden behind the librbd API and thus
>> not embeddable within a generic app event loop.  It might just be a
>> misunderstanding on my part, which is why I asked for an example
>> integration.
>
> Bonus points if this helps out the qemu librbd usage, which (if memory
> serves) does some annoying stuff with a pipe in the callback to notify
> qemu of IO completion.  Perhaps qemu can work with an eventfd more
> directly?

This was fixed a little while back when qemu was converted to using
coroutines and more than one thread, but it would make usage in other
applications with simpler threading models easier.

IIRC the xen blktap driver for rbd used the same pipe workaround to
deal with librbd's current callback api.
