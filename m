From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: About Adding eventfd support for LibRBD
Date: Mon, 13 Jul 2015 14:39:11 -0400 (EDT)
Message-ID: <694208947.37724099.1436812751415.JavaMail.zimbra@redhat.com>
References: <CACJqLyb5spgWuxAc-rLctp6RapKuWmmdNwg42CbRNOEcxW5XGw@mail.gmail.com> <559C9422.8010403@redhat.com> <CACJqLyaj4sxmN9R+m8xY6v=isdh53qGDotKAn_2QW0SVkmOeQg@mail.gmail.com> <CACJqLyaNuS0=9r9kg0M5m67xVO6nrzs1Dz6xsDij-yvs8-e0mQ@mail.gmail.com> <758467134.37486644.1436795528859.JavaMail.zimbra@redhat.com> <CACJqLya0KixGX3npT3nTRKD0Qbbj8xrWKmYLv4fPWjVG_K=hjA@mail.gmail.com> <1771808938.37680022.1436808765381.JavaMail.zimbra@redhat.com> <CANP1eJEcZYubsnrT7C7o=uqQjPsywZqRniNcGYUjb=frhijPGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:52917 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbbGMSjO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jul 2015 14:39:14 -0400
In-Reply-To: <CANP1eJEcZYubsnrT7C7o=uqQjPsywZqRniNcGYUjb=frhijPGQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, Josh Durgin <jdurgin@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

> But it doesn't provide an easily compassable way
> of integrating waiting on other events in the application. eventfd is
> easy to embed in your (e)pool loop or any kind of event library
> (libev).

Agreed -- which is why I asked about the proposed design since it appears (to me) that everything is hidden behind the librbd API and thus not embeddable within a generic app event loop.  It might just be a misunderstanding on my part, which is why I asked for an example integration.

Jason
