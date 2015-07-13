From: Milosz Tanski <milosz@adfin.com>
Subject: Re: About Adding eventfd support for LibRBD
Date: Mon, 13 Jul 2015 15:36:56 -0400
Message-ID: <CANP1eJG1rZ6oiEperUZyPic6YpOzofWXBY60+o+1eoN8Uzqh+Q@mail.gmail.com>
References: <CACJqLyb5spgWuxAc-rLctp6RapKuWmmdNwg42CbRNOEcxW5XGw@mail.gmail.com>
	<559C9422.8010403@redhat.com>
	<CACJqLyaj4sxmN9R+m8xY6v=isdh53qGDotKAn_2QW0SVkmOeQg@mail.gmail.com>
	<CACJqLyaNuS0=9r9kg0M5m67xVO6nrzs1Dz6xsDij-yvs8-e0mQ@mail.gmail.com>
	<758467134.37486644.1436795528859.JavaMail.zimbra@redhat.com>
	<CACJqLya0KixGX3npT3nTRKD0Qbbj8xrWKmYLv4fPWjVG_K=hjA@mail.gmail.com>
	<1771808938.37680022.1436808765381.JavaMail.zimbra@redhat.com>
	<CANP1eJEcZYubsnrT7C7o=uqQjPsywZqRniNcGYUjb=frhijPGQ@mail.gmail.com>
	<694208947.37724099.1436812751415.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:35290 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbbGMTg5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jul 2015 15:36:57 -0400
Received: by obbop1 with SMTP id op1so235956909obb.2
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2015 12:36:57 -0700 (PDT)
In-Reply-To: <694208947.37724099.1436812751415.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, Josh Durgin <jdurgin@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jul 13, 2015 at 2:39 PM, Jason Dillaman <dillaman@redhat.com> wrote:
>> But it doesn't provide an easily compassable way
>> of integrating waiting on other events in the application. eventfd is
>> easy to embed in your (e)pool loop or any kind of event library
>> (libev).
>
> Agreed -- which is why I asked about the proposed design since it appears (to me) that everything is hidden behind the librbd API and thus not embeddable within a generic app event loop.  It might just be a misunderstanding on my part, which is why I asked for an example integration.
>

Provided that the user never uses the file descriptor for anything but
notification. As in, there's a separate (librbd) library function to
drain it that fd. You an use either a eventfd fd or the receiving fd
of a pipe() for non-Linux operating systems. The non eventfd case
might end up last optimal (due to a needing a drain loop) but the
notification mechanism will be both portable and transparent.

-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
