From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Moving away from Yum/DNF repo priorities for Ceph and ceph-deploy
Date: Fri, 24 Jul 2015 21:44:46 -0500
Message-ID: <55B2F81E.8020808@redhat.com>
References: <0FA51B40-C040-4A64-A2BF-266083E740B6@redhat.com>	<55B2D316.9020204@redhat.com> <CAFdRU7088uo6s6v6DrBr7aRzGjvmqi6V1ye5Mvb_6m4dq0+AjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59359 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964814AbbGYCot (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Jul 2015 22:44:49 -0400
In-Reply-To: <CAFdRU7088uo6s6v6DrBr7aRzGjvmqi6V1ye5Mvb_6m4dq0+AjQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: skinjo@redhat.com
Cc: Travis Rhoden <trhoden@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, yum@lists.baseurl.org

Haha, yes.  I still use yum for everything. :D

Mark

On 07/24/2015 08:18 PM, Shinobu Kinjo wrote:
>
>     If there's really no better way around this, I think we need to
>     communicate to the Yum/DMF team(s) what the problem is and that we
>     need to come up with some better way to control the priorities.
>     Given that DMF is fairly new, it seems like a prime time to work
>     with them no?
>
>
> I agree. But remember not DMF but DNF -;
>
>   - Shinobu
>
>
>            - Travis
>
>
>         [1]
>         http://wiki.centos.org/PackageManagement/Yum/Priorities#head-38b91468cc607d0243f463489c2334bf40bfaaee
>         [2]
>         http://wiki.centos.org/PackageManagement/Yum/Priorities#head-6601a4937d4b099e6d46eea0bdb54241d51c7277--
>         To unsubscribe from this list: send the line "unsubscribe
>         ceph-devel" in
>         the body of a message to majordomo@vger.kernel.org
>         <mailto:majordomo@vger.kernel.org>
>         More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>     --
>     To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>     the body of a message to majordomo@vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>     More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>
>
>
> --
> Email:
> shinobu@linux.com <mailto:shinobu@linux.com>
> skinjo@redhat.com <mailto:skinjo@redhat.com>
>
>   Life w/ Linux <http://i-shinobu.hatenablog.com/>
