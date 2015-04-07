From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: RGW rados handles
Date: Tue, 7 Apr 2015 13:22:58 -0400 (EDT)
Message-ID: <2024043038.8779749.1428427378183.JavaMail.zimbra@redhat.com>
References: <68A06213B74F1742A2C48216AE1BB6B8087B4697@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:53136 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895AbbDGRXC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Apr 2015 13:23:02 -0400
In-Reply-To: <68A06213B74F1742A2C48216AE1BB6B8087B4697@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>



----- Original Message -----
> From: "Pavan Rallabhandi" <Pavan.Rallabhandi@sandisk.com>
> To: "Ceph Development" <ceph-devel@vger.kernel.org>
> Cc: yehuda@redhat.com
> Sent: Tuesday, April 7, 2015 7:03:37 AM
> Subject: RGW rados handles
> 
> Hi,
> 
> As part of characterizing RGW read performance, have observed that there is a
> single RADOS connection that is consumed by so many RGW worker threads,
> resulting in some amount of serialization at that level. Making the RADOS
> handles multiple, and shared across the worker threads in a RR fashion, have
> yielded a factor of ~50% improvement (for read requests) in throughput and
> with much better response times on my setup (will share the configuration
> and results in due course).
> 
> Wanted to understand if there is a constraint in having single RADOS instance
> per RGW, that could otherwise be a configurable option, for which I have a
> PR in pipeline.

We discussed this a while back, and iirc, the main issue that was brought was that we'd end up creating multiple sockets to the backend, which might be problematic both to the client itself, but also to the osds. A similar effect would potentially be achieved by adding more gateways.
I'm not aware of any other issues. I'm having trouble coming up with what would go wrong. Having multiple rados connection means that certain ordering guarantees are lost, but I'm not too sure if and where we rely on these, and it will also depend on the way you implemented it. We'd love to see the code.

Yehuda
