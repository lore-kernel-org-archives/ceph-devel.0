From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 0/8] rbd: layering (mostly) error path fixes
Date: Mon, 19 Sep 2016 12:06:24 -0500
Message-ID: <493ebcd0-c7b9-49cc-3f62-12e2d53741f0@ieee.org>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:38613 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbcISRG0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2016 13:06:26 -0400
Received: by mail-it0-f45.google.com with SMTP id n143so77197022ita.1
        for <ceph-devel@vger.kernel.org>; Mon, 19 Sep 2016 10:06:26 -0700 (PDT)
In-Reply-To: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

On 09/19/2016 12:03 PM, Ilya Dryomov wrote:
> This is what came out of looking at David's rbd_img_obj_exists_submit()
> patches.  Alex, I'd appreciate it if you could take look, at patch 4 in
> particular.

I will.  You probably should have copied David on your posting...

					-Alex
