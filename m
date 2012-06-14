From: Tommi Virtanen <tv@inktank.com>
Subject: Re: rbd locking and handling broken clients
Date: Thu, 14 Jun 2012 11:06:53 -0700
Message-ID: <CADvuQRE3o166OFeNmJOyUivm6G+3L9U=B223TJfppUP2a6L3ag@mail.gmail.com>
References: <CAPYLRzhWkma7rrR=ATQTFmq_pwizeJ+SDi3efMEU9gTYPqAY3g@mail.gmail.com>
 <4FD8FA13.6070006@hastexo.com> <7BD677C5759B4061987311B2526E81D3@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54171 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912Ab2FNSHO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jun 2012 14:07:14 -0400
Received: by dady13 with SMTP id y13so2897241dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 14 Jun 2012 11:07:14 -0700 (PDT)
In-Reply-To: <7BD677C5759B4061987311B2526E81D3@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: Florian Haas <florian@hastexo.com>, ceph-devel@vger.kernel.org, mandell@pistoncloud.com

On Wed, Jun 13, 2012 at 4:41 PM, Greg Farnum <greg@inktank.com> wrote:
>> You know, I'd be really happy if this could be achieved by means of
>> removing cephx keys.
> Unfortunately, that wouldn't really solve the problem without dramatically decreasing the rotation interval for cluster access keys which cephx shares. Alternative (entirely theoretical) security schemes might, but they're well behind what's feasible for us to work on any time soon...

I wouldn't want to rely on timed rotation. Fencing triggering a
rotation on demand, then again.. that I do like.
