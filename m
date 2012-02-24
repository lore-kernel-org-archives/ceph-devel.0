From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Problems after crash yesterday
Date: Thu, 23 Feb 2012 21:14:31 -0800
Message-ID: <CAF3hT9DhHzr0Ho2Uv6f_1K4aieEnbjtfpKH1UCPpmm4BQHHJEw@mail.gmail.com>
References: <4F4370F9.5030807@filoo.de>
	<4F44BB25.10202@filoo.de>
	<406144037926269578@unknownmsgid>
	<4F454F4F.2080104@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47874 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab2BXFOb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Feb 2012 00:14:31 -0500
Received: by iacb35 with SMTP id b35so2544067iac.19
        for <ceph-devel@vger.kernel.org>; Thu, 23 Feb 2012 21:14:31 -0800 (PST)
In-Reply-To: <4F454F4F.2080104@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Jens_Rehp=F6hler?= <jens.rehpoehler@filoo.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "sage@newdream.net" <sage@newdream.net>

On Wed, Feb 22, 2012 at 12:25 PM, Jens Rehp=F6hler
<jens.rehpoehler@filoo.de> wrote:
> Hi Gregory,
>
>
> On 22.02.2012 18:12, Gregory Farnum wrote:
>> On Feb 22, 2012, at 1:53 AM, "Jens Rehp=F6hler" <jens.rehpoehler@fil=
oo.de> wrote:
>>
>>> Some Additios: meanwhile we are at the state:
>>>
>>> 2012-02-22 10:38:49.587403 =A0 =A0pg v1044553: 2046 pgs: 2036 activ=
e+clean,
>>> 10 active+clean+inconsistent; 2110 GB data, 4061 GB used, 25732 GB =
/
>>> 29794 GB avail
>>>
>>> The =A0active+recovering+remapped+backfill disappeared auf a restar=
t of a
>>> cashed OSD.
>>>
>>> The OSD crashed after issuing the command "ceph pg repair 106.3".
>>>
>>> The repeating message is also there:
>> Hmm. These messages indicate there are requests that came in that
>> never got answered -- or else that the tracking code isn't quite rig=
ht
>> (it's new functionality). What version are you running?
> We use:
>
> root@fcmsnode0:~# ceph -v
> ceph version 0.42-62-gd6de0bb
> (commit:d6de0bb83bcac238b3a6a376915e06fb7129b2c8)
>
> Kernel is 3.2.1
>
> i accidently updated one of our OSDs to 0.42 -> So we updated the who=
le
> cluster.
>
> The OSD repeated to crash while issuing =A0"repair" command. The
> inconsistent PGs
> are all on the same (newly added) node.

Oh, that's interesting. Are all the other nodes in the cluster up and i=
n?

In the next version or two we will have a lot more capability to look
into what's happening with stuck PGs like this, but for the moment we
need a log. If all the other nodes in the system are up, can you
restart this new OSD with "debug osd =3D 20" and "debug ms =3D 1" added=
 to
its config?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
