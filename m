From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: 'rbd map' asynchronous behavior
Date: Tue, 15 May 2012 08:40:03 -0700
Message-ID: <4FB278D3.1020908@inktank.com>
References: <CABYiri-Whv7tGLVb-AcwMKcA1=iMTyguOYokg2xKt9r6hzKRuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53924 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965252Ab2EOPkG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 May 2012 11:40:06 -0400
Received: by obbtb18 with SMTP id tb18so9057936obb.19
        for <ceph-devel@vger.kernel.org>; Tue, 15 May 2012 08:40:05 -0700 (PDT)
In-Reply-To: <CABYiri-Whv7tGLVb-AcwMKcA1=iMTyguOYokg2xKt9r6hzKRuQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel@vger.kernel.org

On 05/15/2012 04:49 AM, Andrey Korolyov wrote:
> Hi,
>
> There are strange bug when I tried to map excessive amounts of block
> devices inside the pool, like following
>
> for vol in $(rbd ls); do rbd map $vol; [some-microsleep]; [some
> operation or nothing, I have stubbed guestfs mount here] ;
> [some-microsleep];  unmap /dev/rbd/rbd/$vol ; [some-microsleep]; done,
>
> udev or rbd seems to be somehow late and mapping fails. There is no
> real-world harm at all, and such case can be easily avoided, but on
> busy cluster timeout increases and I was able to catch same thing on
> two-osd config in recovering state. For 0.1 second on healthy cluster,
> all works okay, for 0.05 it may fail with following trace(just for me,
> because I am testing on relatively old and crappy hardware, so others
> may catch that on smaller intervals):

udev is asynchronous by nature. The rbd tool itself doesn't wait for
/dev to be populated because you may not be using the default udev rule
(or not using udev at all). Our test framework polls for the device to
make sure 'rbd map' and udev completed:

https://github.com/ceph/teuthology/blob/d6b9bd8b63c8c6c1181ece1f6941829d8d1d5152/teuthology/task/rbd.py#L190

Josh
