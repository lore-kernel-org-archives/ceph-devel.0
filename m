From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: some questions about ceph issues#15034 & 17379
Date: Fri, 13 Oct 2017 07:02:21 -0400
Message-ID: <CA+aFP1AWkVtvjQyu+_X4o5jTs0BU+Bi2PmpiMMc4H=SNjkks0A@mail.gmail.com>
References: <70cb8e99.4fe6.15f13c50151.Coremail.hs170779@163.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:50266 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbdJMLCW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Oct 2017 07:02:22 -0400
Received: by mail-qt0-f171.google.com with SMTP id f15so18817859qtf.7
        for <ceph-devel@vger.kernel.org>; Fri, 13 Oct 2017 04:02:21 -0700 (PDT)
In-Reply-To: <70cb8e99.4fe6.15f13c50151.Coremail.hs170779@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6YOd6LWP?= <hs170779@163.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

The possibility for inconsistent IO was already fixed under [1] a year
ago, but we left the "rbd_op_threads" hard-coded to 1 due to other
unrelated race conditions as you are discovering. Fixing those race
conditions is being tracked under a different ticket [2].

[1] http://tracker.ceph.com/issues/15034
[2] http://tracker.ceph.com/issues/17379

On Thu, Oct 12, 2017 at 11:26 PM, 郝赏 <hs170779@163.com> wrote:
> now i have also encountered the same problem as #15034 with 5
> rbd_op_threads, it caused some assert failures，why does this happen ？ and，
> how can we avoid this problem by guaranteeing that the data written in the
> client cache is written in the same order as in the journal log？
>
>
> 【网易自营】好吃到爆！鲜香弹滑加热即食，经典13香/麻辣小龙虾仅75元3斤>>



-- 
Jason
