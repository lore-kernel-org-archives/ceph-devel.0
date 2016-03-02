From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Interest in Implementing Cache layer on top of NVME Driver [GSoC]
Date: Tue, 1 Mar 2016 16:27:05 -0800
Message-ID: <56D63359.3090304@redhat.com>
References: <CAFjGuFTQ3P_GrcTuYBR5jRxXcZu4v1DeEH23NqfER-w=SB69-A@mail.gmail.com>
 <CACJqLyaAz7s6Yp2N0crYnO-c_WcE7kygze0x=4i9oHSiptvJ5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34592 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932228AbcCBA1H (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Mar 2016 19:27:07 -0500
In-Reply-To: <CACJqLyaAz7s6Yp2N0crYnO-c_WcE7kygze0x=4i9oHSiptvJ5g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>, Rajath Shashidhara <rajath.shashidhara@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/01/2016 06:01 AM, Haomai Wang wrote:
> I think it's a initial idea background, but since we also have
> ObjectCacher in client side, if we can unify this it will be good. But
> obviously ObjectCacher is complexity now, you may not take care of it
> at first...

I'd suggest ignoring ObjectCacher, since it's got ordering and buffer
assumptions you probably don't need, plus a single global lock. I'd
expect a read-focused cache to be pretty different.

Josh
