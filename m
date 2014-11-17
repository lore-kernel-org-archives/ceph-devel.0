From: Zack Cerza <zack@redhat.com>
Subject: Re: teuthology gevent version
Date: Mon, 17 Nov 2014 10:21:31 -0700
Message-ID: <CAMfdg1OXa4RrmMmY8KJZRyxwuhNrRoLwq+LVZaCDZ3gOajWWMA@mail.gmail.com>
References: <546892C4.1080205@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f46.google.com ([209.85.213.46]:43589 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbaKQRVc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Nov 2014 12:21:32 -0500
Received: by mail-yh0-f46.google.com with SMTP id t59so5324308yho.33
        for <ceph-devel@vger.kernel.org>; Mon, 17 Nov 2014 09:21:31 -0800 (PST)
In-Reply-To: <546892C4.1080205@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hey Loic,

I actually don't know if it would cause problems or not. It would be
useful to do some testing with the new version: maybe create a branch
with a patch to requirements.txt to bump the version, run the unit
tests and then some jobs to see if things break?

Thanks,
Zack

On Sun, Nov 16, 2014 at 5:04 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Zack,
>
> At the moment teuthology requires gevent =3D=3D 0.13.6 ( https://gith=
ub.com/ceph/teuthology/blob/master/requirements.txt#L2 ). Would it be a=
 problem to upgrade to a more recent version ? I'd like to use https://=
github.com/gevent/gevent/blob/master/gevent/threadpool.py which was int=
roduced in 1.0b1 http://gevent.org/changelog.html#release-1-0b1-jan-10-=
2012
>
> Cheers
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
