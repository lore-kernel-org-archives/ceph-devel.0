From: Yuri Weinstein <yuri.weinstein@inktank.com>
Subject: Re: teuthology task waiting for machines (> 8h)
Date: Sat, 28 Jun 2014 08:47:26 -0700
Message-ID: <CAJBxG-v3u0PyJkbYv2zEwLJqBfUu4hAOwL3Pv0XhoNj+=0iPrQ@mail.gmail.com>
References: <53AE987A.6080500@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:43094 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbaF1Pr1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Jun 2014 11:47:27 -0400
Received: by mail-vc0-f177.google.com with SMTP id ij19so6017151vcb.36
        for <ceph-devel@vger.kernel.org>; Sat, 28 Jun 2014 08:47:26 -0700 (PDT)
In-Reply-To: <53AE987A.6080500@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Zack Cerza <zack.cerza@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

Technically yes.

If queue is busy - patience is needed.

Assuming that there are no runs in the queue which are hung.  Zack is
diligently looking and fixing to prevent hung tests.  If we see runs
older then say one day, we kill them (altho 'teuthology-kill' is not
working for me today :( )

Another option to speed up run - use PRIO (for priority) when
scheduling it and/or use not plana machines as they are in high
demand.

Thx
YuriW

On Sat, Jun 28, 2014 at 3:27 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Zack,
>
> http://pulpito.ceph.com/loic-2014-06-27_18:45:37-upgrade:firefly-x:st=
ress-split-wip-8475-testing-basic-plana/329515/
>
> seems to indicate that the tasks cannot obtain the machines it needs:
>
> 2014-06-27T17:55:19.072 INFO:teuthology.task.internal:Locking machine=
s...
> 2014-06-27T17:55:19.110 INFO:teuthology.task.internal:waiting for mor=
e machines to be free (need 3 see 5)...
> 2014-06-27T17:55:29.175 INFO:teuthology.task.internal:waiting for mor=
e machines to be free (need 3 see 5)...
> ...
> 2014-06-28T03:22:13.745 INFO:teuthology.task.internal:waiting for mor=
e machines to be free (need 3 see 0)...
> 2014-06-28T03:22:23.787 INFO:teuthology.task.internal:waiting for mor=
e machines to be free (need 3 see 0)...
>
> Is it something expected (for instance when tasks with a higher prior=
ty take precedence) ? If it is then all that's needed is patience right=
 ?
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
