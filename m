From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: [ceph-users] "ceph-installer" in GitHub
Date: Thu, 25 Feb 2016 15:01:36 -0800
Message-ID: <CAMMFjmFJYWdzqZ--F740cVHedaWvGe44K1M0hzhZj-sdfjd5Cg@mail.gmail.com>
References: <CALqRxCwLvXtGDb3t0eg5-4c27eTO=PLSx1zkv+g7MR9+8oMfMA@mail.gmail.com>
	<722555143.53556042.1456441041302.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:35400 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbcBYXBh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Feb 2016 18:01:37 -0500
Received: by mail-io0-f181.google.com with SMTP id g203so104822835iof.2
        for <ceph-devel@vger.kernel.org>; Thu, 25 Feb 2016 15:01:37 -0800 (PST)
In-Reply-To: <722555143.53556042.1456441041302.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shinobu Kinjo <skinjo@redhat.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

The code is here https://github.com/ceph/ceph-installer

Thx
YuriW

On Thu, Feb 25, 2016 at 2:57 PM, Shinobu Kinjo <skinjo@redhat.com> wrote:
> Where should I go to get "ceph-installer" source code?
>
> Rgds,
> Shinobu
>
> ----- Original Message -----
> From: "Ken Dreyer" <kdreyer@redhat.com>
> To: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ceph-users@lists.ceph.com>
> Sent: Friday, February 26, 2016 6:07:54 AM
> Subject: [ceph-users] "ceph-installer" in GitHub
>
> Hi folks,
>
> A few of us at RH are working on a project called "ceph-installer",
> which is a Pecan web app that exposes endpoints for running
> ceph-ansible under the hood.
>
> The idea is that other applications will be able to consume this REST
> API in order to orchestrate Ceph installations.
>
> Another team within Red Hat is also working on a GUI component that
> will interact with the ceph-installer web service, and that is
> https://github.com/skyrings
>
> These are all nascent projects that are very much works-in-progress,
> and so the workflows are very rough and there are a hundred things we
> could do to improve the experience and integration, etc. We welcome
> feedback from the rest of the community :)
>
> - Ken
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
