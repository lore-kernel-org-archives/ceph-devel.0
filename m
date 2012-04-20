From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Best practice - upgrade ceph cluster
Date: Fri, 20 Apr 2012 12:34:58 -0700
Message-ID: <12410AE5386441BAAE2D0996C7D025AD@dreamhost.com>
References: <5934003767531706998@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48029 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab2DTTfC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Apr 2012 15:35:02 -0400
Received: by obbta14 with SMTP id ta14so9944193obb.19
        for <ceph-devel@vger.kernel.org>; Fri, 20 Apr 2012 12:35:01 -0700 (PDT)
In-Reply-To: <5934003767531706998@unknownmsgid>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?S=C5=82awomir_Skowron?= <szibis@gmail.com>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Friday, April 20, 2012 at 12:00 PM, S=C5=82awomir Skowron wrote:
> Maybe it's a lame question, but is anybody knows simplest procedure,
> for most non-disrubtive upgrade of ceph cluster with real workload on
> it ??

Unfortunate though it is, non-disruptive upgrades aren't a great idea t=
o attempt right now. We've architected the system to make it possible, =
and we *try* to keep things forward-compatible, but we don't currently =
do any of the testing necessary to promise something like that.
It will be possible Very Soon in one form or another, but for now you s=
houldn't count on it. When you can, you'll hear about it =E2=80=94 we'l=
l be proudly sharing that we're testing it, it works, whether it's on o=
ur main branch or a new long-term stable, etc etc. ;)

> It's most important if we want semi-automate this process with some
> tools. Maybe there is a cookbook for this operation ?? I know that
> automate this is not simple, and dangerous, but even in manual upgrad=
e
> it's important to know what can we expect.

So, for now what we recommend is shutting down the cluster, upgrading e=
verything all at once, and then starting up the monitors, OSDs, and MDS=
 (in that order). Handling disk changes is a lot easier to write and te=
st than making sure that things are wire-compatible, and has been worki=
ng well for a long time. If for some reason it makes you feel better yo=
u should also be able to upgrade the monitors as a group, then the OSDs=
 as a group, then the MDS. Things will start back up and the OSDs will =
go through a brief peering period, but since nobody will have extra dat=
a or anything it should be fast.
-Greg


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
