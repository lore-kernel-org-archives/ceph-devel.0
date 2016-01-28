From: huang jun <hjwsm1989@gmail.com>
Subject: Re: how to debug librados/librbd in logfile
Date: Thu, 28 Jan 2016 22:45:42 +0800
Message-ID: <CABAwU-Zhxz1j5jgZ2po34PD_D5qC6=h0oVo0jD-38gh014Qs0Q@mail.gmail.com>
References: <CABAwU-YLhiSdD8cbZWHC=8cBeNi_UM2rp3XpJefwWsiszwv6ww@mail.gmail.com>
	<56AA288E.1010205@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33961 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965016AbcA1Opo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jan 2016 09:45:44 -0500
Received: by mail-lf0-f68.google.com with SMTP id n70so2209069lfn.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jan 2016 06:45:43 -0800 (PST)
In-Reply-To: <56AA288E.1010205@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

we run ceph version 0.94.5, and use the root.
The use case is tgt + librbd,
i want to record all operations used by tgt during format, write, read, delete.


2016-01-28 22:41 GMT+08:00 Wido den Hollander <wido@42on.com>:
>
>
> On 28-01-16 15:33, huang jun wrote:
>> hi,all
>> I want to get debug log when using librados/librbd,
>> set client section in ceph.conf:
>> [client]
>> debug_rbd = 20
>> debug_objecter = 20
>> log_file = /var/log/ceph/ceph.rbd.log
>>
>> that not work, file "/var/log/ceph/ceph.rbd.log" does not exist at all.
>> Any ideas?
>>
>
> Does the user under which you run the client have access to /var/log/ceph?
>
> You might want to try /tmp for a test.
>
> Wido



-- 
thanks
huangjun
