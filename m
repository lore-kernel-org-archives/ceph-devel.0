From: Sage Weil <sage@newdream.net>
Subject: Re: packaging compressor plugins
Date: Thu, 25 Feb 2016 14:57:00 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602251456300.28476@cpach.fuggernut.com>
References: <CALqRxCzD9kQKFGJeHYYU+Fvk0_BxNx3k1292mO_P5onngO5Rzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37933 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933658AbcBYT5a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Feb 2016 14:57:30 -0500
In-Reply-To: <CALqRxCzD9kQKFGJeHYYU+Fvk0_BxNx3k1292mO_P5onngO5Rzg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 25 Feb 2016, Ken Dreyer wrote:
> There are some compressor plugins in Jewel. Should these plugins (eg.
> libceph_example.so, libceph_zlib.so, libceph_snappy.so) go into the
> ceph-osd package, or the ceph-base package, or the ceph-test package?
> 
> I'm not sure what they are used for?

Nothing, yet, but they will eventually be used on both the client and 
server side, so they probably belong in ceph-common.

sage
