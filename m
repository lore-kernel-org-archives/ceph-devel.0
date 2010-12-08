From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: installation: where do I start debugging this error?
Date: Tue, 7 Dec 2010 23:09:12 -0800
Message-ID: <AANLkTikKZup5Ar0vyC=5sO_+iOU8cNA_m7pE3Ny91K2x@mail.gmail.com>
References: <AANLkTinfNC1fXqynJ8abp8Ms8GpkLN806MgpCvGaJiCe@mail.gmail.com>
	<1291775597.1958.5.camel@cephhost>
	<Pine.LNX.4.64.1012072132010.5044@cobra.newdream.net>
	<AANLkTim2Mj2WnKbbFyFvXLh5xowAHzEc9gxVq5LX9h3_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61986 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab0LHHJN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Dec 2010 02:09:13 -0500
Received: by qwa26 with SMTP id 26so951677qwa.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Dec 2010 23:09:12 -0800 (PST)
In-Reply-To: <AANLkTim2Mj2WnKbbFyFvXLh5xowAHzEc9gxVq5LX9h3_@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Sorry, I screwed up... it was an iptables issue.  I thought I had it
permanently off but didn't.
The ceph filesystem mounts just fine.

10.200.98.111:/ on /mnt/ceph type ceph
(name=3Dadmin,secret=3DAQC63/5MEMaTLBAAuiYetlbkHBjj0WNtAjOsQg=3D=3D)

On Tue, Dec 7, 2010 at 10:55 PM, Brian Chrisman <brchrisman@gmail.com> =
wrote:
> On Tue, Dec 7, 2010 at 9:32 PM, Sage Weil <sage@newdream.net> wrote:
>> On Wed, 8 Dec 2010, Jeff Wu wrote:
>>> Hi ,i take the followng steps , fail to mount,too.
>>>
>>> ## save auth secret to a file:
>>> $cauthtool --print-key /etc/ceph/keyring.bin > /etc/ceph/secret
>>> chmod 600 /etc/ceph/secret
>>> ## future ,support,read a secret from a file
>>> $ mount -t ceph 172.16.50.10:6789:/foo /mnt/ceph
>>> =A0 =A0-o name=3Dadmin,secretfile=3Dsecret
>>>
>>> but ,the following steps ,mount ceph is successful.
>>>
>>>
>>> # enable cephx, add a user and secret
>>> =A0 =A0 $ mount -t ceph -o name=3Dadmin,secret=3D<secret>
>>> =A0 =A0 =A0 =A01.2.3.4:/ /mnt/ceph
>>> $ mount -t ceph 172.16.50.10:6791:/foo /mnt/ceph
>>> =A0 =A0 -o name=3Dadmin,secret=3D=FF=FFAQArWtdMiI1uDRAAVbNRMeiwsjK+=
DEMeB7ewLg=3D=3D=FF=FF
>>
>> The 'secretfile=3D' option only works if /sbin/mount.ceph is present=
=2E =A0Maybe
>> that didn't get installed by the rpm? =A0mount.ceph is also what let=
s you
>> specify a hostname instead of an ip.
>>
>> sage
>
> I have /sbin/mount.ceph there. =A0I have to imagine that this has
> something to do with the failed connections being reported between th=
e
> mons.
>
> [root@test10 ~]# /sbin/mount.ceph 10.200.98.111:/ /mnt/ceph -o
> name=3Dadmin,secret=3DAQC63/5MEMaTLBAAuiYetlbkHBjj0WNtAjOsQg=3D=3D
> mount error 5 =3D Input/output error
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
