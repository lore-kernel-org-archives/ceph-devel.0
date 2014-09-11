From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: do not return -ERANGE on auth failure
Date: Thu, 11 Sep 2014 11:43:44 -0500
Message-ID: <5411D140.6040807@ieee.org>
References: <1410448246-6635-1-git-send-email-ilya.dryomov@inktank.com>	<5411BE6F.1040202@ieee.org>	<CALFYKtAH_9nQWWyOEcEectWzWQxsNBVHRSPVt_QbU8rfG1_YFA@mail.gmail.com>	<5411CCA5.1070900@ieee.org> <CALFYKtAyR_hNMa92UL7v3bkHx6gCQ-O1G=98Ls08Cq8Ly_imbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:52712 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154AbaIKQnp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Sep 2014 12:43:45 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so1416714igb.2
        for <ceph-devel@vger.kernel.org>; Thu, 11 Sep 2014 09:43:44 -0700 (PDT)
In-Reply-To: <CALFYKtAyR_hNMa92UL7v3bkHx6gCQ-O1G=98Ls08Cq8Ly_imbg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 09/11/2014 11:27 AM, Ilya Dryomov wrote:
>> I should have asked this before.  Why is a permission error
>> > leading to ceph_extract_encoded_string() finding a short
>> > buffer?  I didn't take the time to trace the error path
>> > you're talking about here all the way back.
> rbd_obj_method_sync() returns -EPERM, which when compared with size_t
> from sizeof() ends up a big positive.  ceph_extract_encoded_string() is
> then called and the safe decode macro kicks in..

I somehow got lost along the way and thought rbd_obj_method_sync()
was returning -ERANGE.  The problem starts because rbd_obj_method_sync()
returns an error other than -ENOENT, and that led me astray I think.

Sorry for the confusion.

					-Alex

