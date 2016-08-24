From: Mykola Golub <to.my.trociny@gmail.com>
Subject: Re: rbd cannot enable mirroring in the current pool mirroring mode
Date: Wed, 24 Aug 2016 14:33:42 +0300
Message-ID: <20160824113341.GA2185@gmail.com>
References: <CAKZcxgcKKzt0G0wAj3NwoEY38nprmtSrfUKqFUvhbS3G9NMW5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35218 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755711AbcHXLdq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 07:33:46 -0400
Received: by mail-lf0-f51.google.com with SMTP id f93so9717897lfi.2
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 04:33:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKZcxgcKKzt0G0wAj3NwoEY38nprmtSrfUKqFUvhbS3G9NMW5w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jaze Lee <jazeltq@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Aug 24, 2016 at 06:06:05PM +0800, Jaze Lee wrote:
> Hi, all
>    I first test pool mode. After that, i want to try image mode.
> I first stop rbd-mirror, and then disable pool mode, but i can not set the mode
> to image.
> 
> [root@docker-0 ~]# rbd mirror pool disable rbd

rbd mirror pool enable rbd image

> [root@docker-0 ~]# rbd mirror image enable rbd/test
> 2016-08-24 12:23:27.578209 7f0d295b4d80 -1 librbd: cannot enable
> mirroring in the current pool mirroring mode

-- 
Mykola Golub
