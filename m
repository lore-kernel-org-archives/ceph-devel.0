From: cang lin <fwdflywl@gmail.com>
Subject: Re: some questions about ceph deployment
Date: Thu, 23 Sep 2010 13:22:46 +0800
Message-ID: <AANLkTikMBOhpPz+DqjHX0Xr6WiCdKBOkBu6eUAMP8k=d@mail.gmail.com>
References: <000d01cb4c37$71fadf90$55f09eb0$@com>
	<Pine.LNX.4.64.1009171322440.29822@cobra.newdream.net>
	<AANLkTikLgvHVRnHC+ept0NZv7uGVpAL52hDdFH2wiN9L@mail.gmail.com>
	<Pine.LNX.4.64.1009220911290.6962@cobra.newdream.net>
	<Pine.LNX.4.64.1009221343090.3172@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36353 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702Ab0IWFWt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Sep 2010 01:22:49 -0400
Received: by wwb34 with SMTP id 34so281368wwb.1
        for <ceph-devel@vger.kernel.org>; Wed, 22 Sep 2010 22:22:47 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1009221343090.3172@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi  Sage,
2010/9/23 Sage Weil <sage@newdream.net>:
> On Wed, 22 Sep 2010, Sage Weil wrote:
>> On Wed, 22 Sep 2010, cang lin wrote:
>> > > =A0 =A0 =A0 =A0 =A0When I follow the instruction of
>> > > http://ceph.newdream.net/wiki/Monitor_cluster_expansion to expan=
d a
>> > > monitor to ceph02, the following error occurred:
>> > > >
>> > > > root@ceph02:~# =A0/etc/init.d/ceph start mon1
>> > > > [/etc/ceph/fetch_config/tmp/fetched.ceph.conf.14210] ceph.conf=
 100% =A02565
>> > > =A02.5KB/s =A000:00
>> > > > =3D=3D=3D mon.1 =3D=3D=3D
>> > > > Starting Ceph mon1 on ceph02...
>> > > > =A0** WARNING: Ceph is still under heavy development, and is o=
nly suitable
>> > > for **
>> > > > =A0** testing and review. =A0Do not trust it with important da=
ta. =A0**
>> > > > terminate called after throwing an instance of 'std::logic_err=
or'
>> > > > =A0 what(): =A0basic_string::_S_construct NULL not valid
>> > > > Aborted (core dumped)
>> > > > failed: ' /usr/bin/cmon -i 1 -c /tmp/fetched.ceph.conf.14210 '
>> > >
>> > > I haven't seen that crash, but it looks like a std::string const=
ructor is
>> > > being passed a NULL pointer. =A0Do you have a core dump (to get =
a
>> > > backtrace)? =A0Which version are you running (`cmon -v`)?
>> > >
>> >
>> > The cmon version is v0.21.1 when the crash happen and been updated=
 to
>> > v0.21.2.
>> >
>> > The following backtrace is from v0.21.2:
>>
>> Thanks, we'll see if we can reproduce and fix this one!
>
> Ok, this one is fixed by commit 79b6f2f9e9dd70704644338c968f9ad070e5a=
8f8
> in the testing branch. =A0It actually should be printing an error tha=
t the
> 'magic' file is missing from the mon data directory. =A0Maybe you ski=
pped
> step #3 on the monitor cluster expansion page?
>
> Thanks-
> sage
>

Yes, I understood wrong to the step 3 in the first test , not the host
name included in the path:
root@ceph01:/ # rsync -av /mnt/ceph/data/mon0/ /mnt/ceph/data/mon1
root@ceph01:/ # echo 1 > /mnt/ceph/data/mon1/whoami

After finding the mistake, I added the host name in the path:
root@ceph01:/ # rsync -av /mnt/ceph/data/mon0/ ceph02:/mnt/ceph/data/mo=
n1

I forget to do the following command on the ceph02:
root@ceph02:/ # echo 1 > /mnt/ceph/data/mon1/whoami

The third test was modified to:
root@ceph01:/ # rsync -av /mnt/ceph/data/mon0/ ceph02:/mnt/ceph/data/mo=
n1
root@ceph02:/ # echo 1 > /mnt/ceph/data/mon1/whoami

But still error. I do not know the practice, or the system to remember
the wrong path?

Thinks!
lin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
