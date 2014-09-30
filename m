From: Sheldon Mustard <sheldon.mustard@inktank.com>
Subject: Re: FileJournal bug : additional information request
Date: Tue, 30 Sep 2014 11:06:14 -0400
Message-ID: <CAGW2oNw+ZVDi40SkzdyR1-Dx1kcOxq045hqtbHC6EzcUTqBZVA@mail.gmail.com>
References: <542ABE45.5030808@dachary.org>
Reply-To: sjm@inktank.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:49598 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbaI3PGP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Sep 2014 11:06:15 -0400
Received: by mail-ie0-f173.google.com with SMTP id lx4so6640565iec.32
        for <ceph-devel@vger.kernel.org>; Tue, 30 Sep 2014 08:06:14 -0700 (PDT)
In-Reply-To: <542ABE45.5030808@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hey Loic,

Thanks for looking into it, I have attached the one small log file we
have to the tracker now. Unfortunately I don't have much else to add
at this point, it was a one off thing so we can't reproduce it with
debugging turned on.

SJM

On Tue, Sep 30, 2014 at 10:29 AM, Loic Dachary <loic@dachary.org> wrote=
:
> Hi Sheldon,
>
> I would be greatfull if you could add as much information as possible=
 to http://tracker.ceph.com/issues/9570 . In particular the logs of the=
 failed OSD would be great. Hunting the problem is a nice journey (I di=
d not know this part of the code before) and I'm eager to discover the =
reason for this seemingly impossible event :-)
>
> Thanks for your help !
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
