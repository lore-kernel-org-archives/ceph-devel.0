From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] rbd: don't zero-fill non-image object requests
Date: Wed, 27 Mar 2013 15:10:04 -0500
Message-ID: <5153521C.7000900@inktank.com>
References: <5153020B.7050403@inktank.com> <alpine.DEB.2.00.1303270909380.20593@cobra.newdream.net> <CABZ+qqkVnj3qrKyhOmOX=vAn67Xjq1oKUFcPyCruT591qthYYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:48035 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754316Ab3C0UKH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Mar 2013 16:10:07 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so6816146iec.41
        for <ceph-devel@vger.kernel.org>; Wed, 27 Mar 2013 13:10:06 -0700 (PDT)
In-Reply-To: <CABZ+qqkVnj3qrKyhOmOX=vAn67Xjq1oKUFcPyCruT591qthYYQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/27/2013 11:26 AM, Dan van der Ster wrote:
> On Wed, Mar 27, 2013 at 5:10 PM, Sage Weil <sage@inktank.com> wrote:
>> Does this only affect the current -rc or is this problem older than that?

The bug I found should affect only the new request code,
which if I am not mistaken got to sent to Linus during this
cycle (3.9-rcX).

> The BUG I reported that triggered this was on 3.8.4.

OK, now I'm trying to reproduce the problem with 3.8.4 and
I'm not seeing any crashes...

Hmm.  I'll look a little more closely.

					-Alex
> --
> Dan
> 

