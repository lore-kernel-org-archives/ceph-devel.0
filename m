From: Samuel Just <sjust@redhat.com>
Subject: Re: [ceph-users] Is it safe to increase pg number in a production environment
Date: Tue, 4 Aug 2015 09:46:26 -0700
Message-ID: <CAN=+7FVjixrHHUZ01-5HaLd19SbjLkhqpKdKN1jDqPCk1UoR0A@mail.gmail.com>
References: <CALAOqpNhquUYW5YqNDZQh4K927Xumw8GcPPoYRsmyEhSHBY-Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:36256 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbbHDQq1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 12:46:27 -0400
Received: by ioeg141 with SMTP id g141so22827596ioe.3
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2015 09:46:26 -0700 (PDT)
In-Reply-To: <CALAOqpNhquUYW5YqNDZQh4K927Xumw8GcPPoYRsmyEhSHBY-Xw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5LmU5bu65bOw?= <scaleqiao@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, cbt@ceph.com

It will cause a large amount of data movement.  Each new pg after the
split will relocate.  It might be ok if you do it slowly.  Experiment
on a test cluster.
-Sam

On Mon, Aug 3, 2015 at 12:57 AM, =E4=B9=94=E5=BB=BA=E5=B3=B0 <scaleqiao=
@gmail.com> wrote:
> Hi Cephers,
>
> This is a greeting from Jevon. Currently, I'm experiencing an issue w=
hich
> suffers me a lot, so I'm writing to ask for your comments/help/sugges=
tions.
> More details are provided bellow.
>
> Issue:
> I set up a cluster having 24 OSDs and created one pool with 1024 plac=
ement
> groups on it for a small startup company. The number 1024 was calcula=
ted per
> the equation 'OSDs * 100'/pool size. The cluster have been running qu=
ite
> well for a long time. But recently, our monitoring system always comp=
lains
> that some disks' usage exceed 85%. I log into the system and find out=
 that
> some disks' usage are really very high, but some are not(less than 60=
%).
> Each time when the issue happens, I have to manually re-balance the
> distribution. This is a short-term solution, I'm not willing to do it=
 all
> the time.
>
> Two long-term solutions come in my mind,
> 1) Ask the customers to expand their clusters by adding more OSDs. Bu=
t I
> think they will ask me to explain the reason of the imbalance data
> distribution. We've already done some analysis on the environment, we
> learned that the most imbalance part in the CRUSH is the mapping betw=
een
> object and pg. The biggest pg has 613 objects, while the smallest pg =
only
> has 226 objects.
>
> 2) Increase the number of placement groups. It can be of great help f=
or
> statistically uniform data distribution, but it can also incur signif=
icant
> data movement as PGs are effective being split. I just cannot do it i=
n our
> customers' environment before we 100% understand the consequence. So =
anyone
> did this under a production environment? How much does this operation=
 affect
> the performance of Clients?
>
> Any comments/help/suggestions will be highly appreciated.
>
> --
> Best Regards
> Jevon
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
