From: Gregory Farnum <greg@inktank.com>
Subject: Re: Paxos and long-lasting deleted data
Date: Thu, 31 Jan 2013 10:31:09 -0800
Message-ID: <CAPYLRzjwn4LxnzbX9SBJL7x7AtX6=pmv84HXBGykNGHn7zVLTA@mail.gmail.com>
References: <CABYiri8fbbpuhh0RguqdsmYEbEkYz_+PKO4UJqWqKb1TwDcc6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:42479 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922Ab3AaSbM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 13:31:12 -0500
Received: by mail-qc0-f176.google.com with SMTP id n41so1378764qco.7
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jan 2013 10:31:11 -0800 (PST)
In-Reply-To: <CABYiri8fbbpuhh0RguqdsmYEbEkYz_+PKO4UJqWqKb1TwDcc6A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Can you pastebin the output of "rados -p rbd ls"?

On Thu, Jan 31, 2013 at 10:17 AM, Andrey Korolyov <andrey@xdel.ru> wrote:
> Hi,
>
> Please take a look, this data remains for days and seems not to be
> deleted in future too:
>
> pool name       category                 KB      objects       clones
>    degraded      unfound           rd        rd KB           wr
> wr KB
> data            -                          0            0            0
>            0           0            0            0            0
>     0
> install         -                   15736833         3856            0
>            0           0           16            3       464648
> 60970390
> metadata        -                          0            0            0
>            0           0            0            0            0
>     0
> prod-rack0      -                  364027905        88895            0
>            0           0           32            0       267626
> 689034186
> rbd             -                    4194305         1027            0
>            0           0            4            1        11269
> 25165828
>   total used      6900914368        93778
>   total avail    18335469376
>   total space    25236383744
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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
