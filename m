From: Zack Cerza <zack.cerza@inktank.com>
Subject: Re: teuthology task waiting for machines (> 8h)
Date: Mon, 30 Jun 2014 08:10:52 -0600
Message-ID: <CAMfdg1M5JxNjeg=1KOaqe7MAVLtGq8Fd_oEd5exZKqauesY8KQ@mail.gmail.com>
References: <53AE987A.6080500@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:44694 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbaF3OKx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 10:10:53 -0400
Received: by mail-yh0-f51.google.com with SMTP id f10so4894649yha.38
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jun 2014 07:10:52 -0700 (PDT)
In-Reply-To: <53AE987A.6080500@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

At this point I don't really have a way to look back in time to see
what was going on, but in the future when jobs are blocked waiting for
machines for unreasonable periods it's useful to know what is holding
them:

teuthology-lock --brief -a --machine-type plana | sort -k +4

Thanks,
Zack

On Sat, Jun 28, 2014 at 4:27 AM, Loic Dachary <loic@dachary.org> wrote:
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
