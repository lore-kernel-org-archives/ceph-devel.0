From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Paxos and long-lasting deleted data
Date: Thu, 31 Jan 2013 18:41:19 +0000
Message-ID: <510ABACF.7040703@inktank.com>
References: <CABYiri8fbbpuhh0RguqdsmYEbEkYz_+PKO4UJqWqKb1TwDcc6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:55667 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877Ab3AaSls (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 13:41:48 -0500
Received: by mail-we0-f172.google.com with SMTP id x10so2317958wey.31
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jan 2013 10:41:46 -0800 (PST)
In-Reply-To: <CABYiri8fbbpuhh0RguqdsmYEbEkYz_+PKO4UJqWqKb1TwDcc6A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 01/31/2013 06:17 PM, Andrey Korolyov wrote:
> Hi,
>
> Please take a look, this data remains for days and seems not to be
> deleted in future too:
>
> pool name       category                 KB      objects       clones
>     degraded      unfound           rd        rd KB           wr
> wr KB
> data            -                          0            0            0
>             0           0            0            0            0
>      0
> install         -                   15736833         3856            0
>             0           0           16            3       464648
> 60970390
> metadata        -                          0            0            0
>             0           0            0            0            0
>      0
> prod-rack0      -                  364027905        88895            0
>             0           0           32            0       267626
> 689034186
> rbd             -                    4194305         1027            0
>             0           0            4            1        11269
> 25165828
>    total used      6900914368        93778
>    total avail    18335469376
>    total space    25236383744
>
> for pool in $(rados lspools) ; do rbd ls -l $pool ; done | grep -v
> SIZE | awk '{ sum += $2} END { print sum }'
> rbd: pool data doesn't contain rbd images
> rbd: pool metadata doesn't contain rbd images
> 526360
>
> I have same thing before, but not so contrast as there. Cluster was
> put on moderate failure test, dropping one or two osds at once under
> I/O pressure with replication factor three.

Just wondering if there was something else you wanted to discuss on your 
email given the email subject. Wanted by any chance discuss anything 
regarding Paxos?

   -Joao

