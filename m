From: Yuri Weinstein <yuri.weinstein@inktank.com>
Subject: Re: Recommended teuthology upgrade test
Date: Fri, 27 Jun 2014 09:17:10 -0700
Message-ID: <CAJBxG-uBrfRUs42Meheo0gEhaH_KquYcjQ8Jwa5AaG2mO6Cx0A@mail.gmail.com>
References: <53AD8AD9.8030809@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170]:52714 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbaF0QRL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jun 2014 12:17:11 -0400
Received: by mail-ve0-f170.google.com with SMTP id i13so5512789veh.15
        for <ceph-devel@vger.kernel.org>; Fri, 27 Jun 2014 09:17:10 -0700 (PDT)
In-Reply-To: <53AD8AD9.8030809@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Samuel Just <sam.just@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

Loic

I don't intent to answer all questions, but some info, see inline

On Fri, Jun 27, 2014 at 8:16 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Sam,
>
> TL;DR: what oneliner do you recommend to run upgrade tests for https:=
//github.com/ceph/ceph/pull/1890 ?
>
> Running the rados suite can be done with :
>
>    ./schedule_suite.sh rados wip-8071 testing loic@dachary.org basic =
master plana
>

It was replaced with teuthology-suite, see --help for more info

> or something else since ./schedule_suite.sh was recently obsoleted ( =
http://tracker.ceph.com/issues/8678 ). Running something similar for up=
grade will presumably run all of https://github.com/ceph/ceph-qa-suite/=
tree/master/suites/upgrade
>
> Is there a way to run minimal tests by limiting the upgrade suite so =
that it only focuses on a firefly cluster that upgrades to https://gith=
ub.com/ceph/ceph/pull/1890 so that it checks the behavior when running =
a mixed cluster (firefly + master with the change) ?

You can run specifying argument with smaller suite, like this:
dumpling-x/parallel

>
> It looks like http://pulpito.ceph.com/?suite=3Dupgrade was never run =
( at least that's what appears to cause http://tracker.ceph.com/issues/=
8681 ) Is http://pulpito.ceph.com/?suite=3Dupgrade-rados a good fit ? I=
f so is there a way to figure out how it was created ?
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
