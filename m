From: Abhishek Varshney <abhishek.varshney@flipkart.com>
Subject: Re: Preparing hammer v0.94.5
Date: Sat, 3 Oct 2015 23:17:53 +0530
Message-ID: <CAP3mxSxnwS=3uNEFJTHGYYqo6FkQaFkENMmWzg9jyOniBDpN6w@mail.gmail.com>
References: <560F9426.80208@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:32878 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbbJCRry convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Oct 2015 13:47:54 -0400
Received: by igbkq10 with SMTP id kq10so38680464igb.0
        for <ceph-devel@vger.kernel.org>; Sat, 03 Oct 2015 10:47:53 -0700 (PDT)
In-Reply-To: <560F9426.80208@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,


On Sat, Oct 3, 2015 at 2:09 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Abhishek,
>
> The v0.94.5 version was added to the list of versions and you should =
now be able to create the issue to track its progress. Since v0.94.4 is=
 in the process of being tested, most of the ~50 backports in flight[1]=
 will actually be for v0.94.5 and we can start testing them. The worst =
that can happen is that a few of them shift to v0.94.4 because they are=
 needed after all. From the point of view of v0.94.5 that's all the sam=
e.
>
> The next step is to create the issue[2] and you should have all the c=
redentials you need to do so.

I have created a new issue to keep track of hammer v0.94.5 (
http://tracker.ceph.com/issues/13356 ). I would next prepare an
integration branch with all the in-flight backports and update the
tracker for v0.94.5.

>
> This will be your first time driving a point release but there should=
 be no surprises: you already know all about the process :-)

I guess I know the process well now, but, I am sure I will need your
support and motivation in getting it through :)

>
> Cheers
>
> [1] https://github.com/ceph/ceph/pulls?q=3Dis%3Aopen+is%3Apr+mileston=
e%3Ahammer
> [2] http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_start_w=
orking_on_a_new_point_release#Create-new-task
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
