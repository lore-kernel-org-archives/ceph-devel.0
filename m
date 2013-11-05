From: Alphe Salas Michels <asalas@kepler.cl>
Subject: Re: writing a ceph cliente for MS windows
Date: Tue, 05 Nov 2013 19:31:41 -0300
Message-ID: <527971CD.1010705@kepler.cl>
References: <52780140.6090409@kepler.cl>	<alpine.DEB.2.00.1311050608020.17874@cobra.newdream.net>	<52792D7F.20500@kepler.cl>	<527967FD.1010205@kepler.cl> <CABBk=J8gfR0CDQ4fuHmXtkH5Fe3kKOGTi7YgixB7ZSL1JHkYXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:54319 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755589Ab3KEWbp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Nov 2013 17:31:45 -0500
Received: by mail-qa0-f48.google.com with SMTP id w8so1473505qac.7
        for <ceph-devel@vger.kernel.org>; Tue, 05 Nov 2013 14:31:44 -0800 (PST)
In-Reply-To: <CABBk=J8gfR0CDQ4fuHmXtkH5Fe3kKOGTi7YgixB7ZSL1JHkYXg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hello sage and Yehuda,
yes nwat told me that u64 was an alias for unsigned long which is=20
default C compiler data type.
I wasn't cautious.

I read some other things like the cygwin mount.cc /mount.h files ...=20
they include cifs and nfs filetype things like samba too. We could=20
integrate a new data type in it with our ceph-win32-client.

Obviously everyone would prefere something with a nice point and click=20
window to setup their ceph-win32-client. But as a starter... maybe we=20
could understand better the way windows handle file systems starting=20
from cygwin/mount files.

Regards,
signature

*Alph=E9 Salas*
Ingeniero T.I

asalas@kepler.cl*<http://www.kepler.cl>*

On 11/05/13 18:59, Yehuda Sadeh wrote:
> On Tue, Nov 5, 2013 at 1:49 PM, Alphe Salas Michels<asalas@kepler.cl>=
  wrote:
>> Hello sage,
>> I followed your lead and went a bit further in my source code readin=
g and I
>> notice serveral problems:
>> first most of the id use in ceph osd_clients, mds_clients, mon_clien=
t use
>> the data type u64 which will be a problem
>> as most of the windows in use are windows XP or Windows server 2003 =
in 32
>> bits. As they are used for id tag for
>> things like snapshot pages (if I understand well) that can be a prob=
lem for
>> a port no?
>>
>> What I read so far was
>> mount.ceph files > kernel/fs/ceph files which contains the mds_clien=
t files
>> and the kernel ioctl interface ... >  include / linux / ceph  files =
which
>> integrates libcephfs.h. and all the needed files
>>
>> there is three clients, there is auth.h a messenger, a msgpool, buff=
er,
>> rados that depends on msgr that include in every aspect of the messa=
ges
>> formation  one or more __le64 message.
>>
>> I m far from understanding the whole code and the interactions betwi=
n all
>> the files and which we can skip and which we can keep.
>>
>> how can we translate those data type into 32bit in order for ceph cl=
uster to
>> understand them and ceph-windows-client to transmit them?
> It is possible to define 64 bit variables on 32 bit architectures. Th=
e
> compiler handles it for you.
>
> Yehuda
>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
