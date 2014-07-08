From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 11/14] rbd: add rbd_obj_watch_request_helper() helper
Date: Tue, 8 Jul 2014 15:18:43 +0400
Message-ID: <CALFYKtBaUD9ppPWH2MzuVX5TSpvSrppjVzv3WF+jx=CjhZAwLA@mail.gmail.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
	<1403716607-13535-12-git-send-email-ilya.dryomov@inktank.com>
	<53BB20EC.2090403@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:37192 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364AbaGHLSo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jul 2014 07:18:44 -0400
Received: by mail-qc0-f174.google.com with SMTP id x13so4926404qcv.5
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jul 2014 04:18:43 -0700 (PDT)
In-Reply-To: <53BB20EC.2090403@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jul 8, 2014 at 2:36 AM, Alex Elder <elder@ieee.org> wrote:
> On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
>> In the past, rbd_dev_header_watch_sync() used to handle both watch and
>> unwatch requests and was entangled and leaky.  Commit b30a01f2a307
>> ("rbd: fix osd_request memory leak in __rbd_dev_header_watch_sync()")
>> split it into two separate functions.  This commit cleanly abstracts
>> the common bits, relying on the fixed rbd_obj_request_wait().
>
> Adding this without calling it leads to an unused function
> warning in the build, I'm sure.
>
> You could probably squash this into the next patch.

It used to be a single patch in the previous version of this series,
but it was too hard to review even for myself, so I had to split it.

Thanks,

                Ilya
