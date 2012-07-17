From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: osd/OSDMap.h: 330: FAILED assert(is_up(osd))
Date: Tue, 17 Jul 2012 15:54:04 -0600
Message-ID: <5005DEFC.7020701@sandia.gov>
References: <5005CFDE.5010100@sandia.gov>
 <CA+4uBUZ1j6dx3Z68_BG=eS+nas+mf75Dqf9qV+-0C_UFC=oDAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:36885 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754538Ab2GQVyb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jul 2012 17:54:31 -0400
In-Reply-To: <CA+4uBUZ1j6dx3Z68_BG=eS+nas+mf75Dqf9qV+-0C_UFC=oDAA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/17/2012 03:44 PM, Samuel Just wrote:
> Not quite.  OSDService::get_osdmap() returns the most recently
> published osdmap.  Generally, OSD::osdmap is safe to use when you are
> holding the osd lock.  Otherwise, OSDService::get_osdmap() should be
> used.  There are a few other things that should be fixed surrounding
> this issue as well, I'll put some time into it today.  The map_lock
> should probably be removed all together.

Thanks for taking a look.  Let me know when
you get something, and I'll take it for a spin.

Thanks -- Jim

> -Sam


