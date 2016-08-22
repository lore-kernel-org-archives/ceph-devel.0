From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: why rbd journaling first write journal to journal pool and then
 write data
Date: Mon, 22 Aug 2016 12:16:13 +0300
Message-ID: <20160822091612.GA32073@gmail.com>
References: <CAKZcxgdqLtdyLPF-dXczMu1hWjbtoF3i2iugDJH1ngtmqNLNNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:32785 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbcHVJQR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Aug 2016 05:16:17 -0400
Received: by mail-lf0-f41.google.com with SMTP id b199so73101722lfe.0
        for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2016 02:16:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKZcxgdqLtdyLPF-dXczMu1hWjbtoF3i2iugDJH1ngtmqNLNNA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jaze Lee <jazeltq@gmail.com>
Cc: ceph-devel@vger.kernel.org

Jaze,

On Mon, Aug 22, 2016 at 04:46:04PM +0800, Jaze Lee wrote:

>    I found that rbd journaling first write journal and then write data.
>    Why we not first write data and then write journal? Is there some
> considerration
>    for which is first ?

It looks like you already asked this question some time ago. Have you
missed Jason's response?

http://www.spinics.net/lists/ceph-devel/msg30167.html

Or are you unsatisfied with his answer?

-- 
Mykola Golub
