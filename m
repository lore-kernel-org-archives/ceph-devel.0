From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Unable to Add Monitor
Date: Mon, 9 May 2011 16:33:07 -0700
Message-ID: <BANLkTim9qp_pgi0H9a93vQtUWrp4eY0H2g@mail.gmail.com>
References: <B828A4C02BE12543ACDFCF7EB0C693C67885FC7D23@NC-SVR-09.netelligent.com>
	<BANLkTik5FbaysoFYV-XzKX1T+K8gPAsWzQ@mail.gmail.com>
	<B828A4C02BE12543ACDFCF7EB0C693C67885FC7DC9@NC-SVR-09.netelligent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:57916 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129Ab1EIXdJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 May 2011 19:33:09 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 65F8CC066
	for <ceph-devel@vger.kernel.org>; Mon,  9 May 2011 16:33:09 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id E07F0C064
	for <ceph-devel@vger.kernel.org>; Mon,  9 May 2011 16:33:08 -0700 (PDT)
Received: by eyx24 with SMTP id 24so1685375eyx.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 May 2011 16:33:07 -0700 (PDT)
In-Reply-To: <B828A4C02BE12543ACDFCF7EB0C693C67885FC7DC9@NC-SVR-09.netelligent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nigh <mnigh@netelligent.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Ah, yeah, it sounds like you broke your mon map by trying to change
the name of your active monitor. I'm pretty sure to make that work you
would need to add the monitor under the new name and then remove the
old name!

Let us know if you run into any other trouble, you're probably
touching a lot of failure conditions here that we don't normally run
into. :)
-Greg

On Mon, May 9, 2011 at 11:27 AM, Mark Nigh <mnigh@netelligent.com> wrot=
e:
>
> On Mon, May 9, 2011 at 7:22 AM, Mark Nigh <mnigh@netelligent.com> wro=
te:
>> I have been testing Ceph for several months now but with only 2 mds =
and 1 mon. I would like to test failover between mon so I am trying to =
add the first (1st) of two (2) mon on the other mds in the cluster.
>>
>> I also noticed that the mon naming has been changed from numerics to=
 names so I am trying to change that also.
>>
>> My Process:
>>
>> On the first mon, I get an error when issuing this command "ceph mon=
 add beta 10.6.1.91:6789"
>>
>> I receive the following error as it repeats:
>>
>> 2011-05-09 09:17:05.500353 7f9248ab0700 -- :/28272 >> 10.6.1.91:6789=
/0 pipe(0x2167010 sd=3D3 pgs=3D0 cs=3D0 l=3D0).fault first fault
> This error generally means that the daemon can't communicate with its
> target -- in this case, 10.6.1.91:6789. Do you already have mon.beta
> in your ceph.conf? It looks like ceph tool is trying to issue its
> commands to that monitor.
> You can specify which monitor to connect to using the -m switch:
> ceph -m 10.6.1.90:6789 mon add beta 10.6.1.91:6789
> (assuming there that mon.alpha is using address 10.6.1.90:6789).
>
> When I run this command on the original monitor it just hangs. If I r=
un the command, "ceph mon add msd1 10.6.1.91:6789, I receive the follow=
ing message:
>
> Mds1 is the hostname of the second monitor.
>
> 2011-05-09 12:28:01.823280 7ff64926d700 -- 10.6.1.90:0/26252 >> 10.6.=
1.91:6789/0 pipe(0x16168f0 sd=3D3 pgs=3D0 cs=3D0 l=3D0).fault first fau=
lt
> 2011-05-09 12:28:07.823488 7ff64d242700 -- 10.6.1.90:0/26252 >> 10.6.=
1.91:6789/0 pipe(0x16168f0 sd=3D3 pgs=3D0 cs=3D0 l=3D0).fault first fau=
lt
>
> When I try to run the service ceph start mon.1 command on the 2nd mon=
itor:
>
> mon.1 does not exist in monmap
>
>> When I try to start the monitor service on beta I get the following =
error:
>>
>> =3D=3D=3D mon.beta =3D=3D=3D
>> Starting Ceph mon.beta on mds1...
>> =A0** WARNING: Ceph is still under heavy development, and is only su=
itable for **
>> =A0** =A0 =A0 =A0 =A0 =A0testing and review. =A0Do not trust it with=
 important data. =A0 =A0 =A0 **
>> unable to read magic from mon data.. did you run mkcephfs?
>> failed: ' /usr/bin/cmon -i beta -c /etc/ceph/ceph.conf '
> Did you follow the directions at
> http://ceph.newdream.net/wiki/Monitor_cluster_expansion?
>
> Yes, I believe it maybe that I tried to change the ceph.conf file fro=
m mon.0 and mon.1 to mon.alpha and mon.beta as the wiki states. For now=
, I thought I would revert back to the mon.0 and mon.1 naming conventio=
n to eliminate the number of changes.
>
> -Greg
>
> This transmission and any attached files are privileged, confidential=
 or otherwise the exclusive property of the intended recipient or Netel=
ligent Corporation. If you are not the intended recipient, any disclosu=
re, copying, distribution or use of any of the information contained in=
 or attached to this transmission is strictly prohibited. If you have r=
eceived this transmission in error, please contact us immediately by re=
sponding to this message or by telephone (314-392-6900) and promptly de=
stroy the original transmission and its attachments.
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
