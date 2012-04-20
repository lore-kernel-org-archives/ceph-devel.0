From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Best practice - upgrade ceph cluster
Date: Fri, 20 Apr 2012 22:18:57 +0200
Message-ID: <1364130642661991879@unknownmsgid>
References: <5934003767531706998@unknownmsgid> <12410AE5386441BAAE2D0996C7D025AD@dreamhost.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36655 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab2DTUS7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Apr 2012 16:18:59 -0400
Received: by wibhq7 with SMTP id hq7so1040394wib.1
        for <ceph-devel@vger.kernel.org>; Fri, 20 Apr 2012 13:18:58 -0700 (PDT)
In-Reply-To: <12410AE5386441BAAE2D0996C7D025AD@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 20 kwi 2012, at 21:35, Greg Farnum <gregory.farnum@dreamhost.com> wr=
ote:

> On Friday, April 20, 2012 at 12:00 PM, S=C5=82awomir Skowron wrote:
>> Maybe it's a lame question, but is anybody knows simplest procedure,
>> for most non-disrubtive upgrade of ceph cluster with real workload o=
n
>> it ??
>
> Unfortunate though it is, non-disruptive upgrades aren't a great idea=
 to attempt right now. We've architected the system to make it possible=
, and we *try* to keep things forward-compatible, but we don't currentl=
y do any of the testing necessary to promise something like that.
> It will be possible Very Soon in one form or another, but for now you=
 shouldn't count on it. When you can, you'll hear about it =E2=80=94 we=
'll be proudly sharing that we're testing it, it works, whether it's on=
 our main branch or a new long-term stable, etc etc. ;)
>

I am waiting impatiently :)

>> It's most important if we want semi-automate this process with some
>> tools. Maybe there is a cookbook for this operation ?? I know that
>> automate this is not simple, and dangerous, but even in manual upgra=
de
>> it's important to know what can we expect.
>
> So, for now what we recommend is shutting down the cluster, upgrading=
 everything all at once, and then starting up the monitors, OSDs, and M=
DS (in that order). Handling disk changes is a lot easier to write and =
test than making sure that things are wire-compatible, and has been wor=
king well for a long time. If for some reason it makes you feel better =
you should also be able to upgrade the monitors as a group, then the OS=
Ds as a group, then the MDS. Things will start back up and the OSDs wil=
l go through a brief peering period, but since nobody will have extra d=
ata or anything it should be fast.
> -Greg
>
>

Ok thanks.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
