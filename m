From: cang lin <fwdflywl@gmail.com>
Subject: Re: some questions about ceph deployment
Date: Thu, 23 Sep 2010 01:57:01 +0800
Message-ID: <AANLkTikWfJEJd+dGWvvoG3nNAaqYeTDK+gjFb7Q=6M8h@mail.gmail.com>
References: <000d01cb4c37$71fadf90$55f09eb0$@com>
	<Pine.LNX.4.64.1009171322440.29822@cobra.newdream.net>
	<AANLkTikLgvHVRnHC+ept0NZv7uGVpAL52hDdFH2wiN9L@mail.gmail.com>
	<Pine.LNX.4.64.1009220911290.6962@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42168 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565Ab0IVR5E convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Sep 2010 13:57:04 -0400
Received: by wyb28 with SMTP id 28so98162wyb.19
        for <ceph-devel@vger.kernel.org>; Wed, 22 Sep 2010 10:57:02 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1009220911290.6962@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

2010/9/23 Sage Weil <sage@newdream.net>:
> On Wed, 22 Sep 2010, cang lin wrote:
>> =A0What confuse me is why the client can't access ceph?Even if the o=
sd was
>> down shouldn't affect the client.what is the reason for the client c=
an=FF=FFt
>> access or unmount ceph?
>
> It could be a number of things. =A0The output from
>
> =A0cat /sys/kernel/debug/ceph/*/mdsc
> =A0cat /sys/kernel/debug/ceph/*/osdc
>
> will tell you if it's waiting for a server request to respond. =A0Als=
o, if
> you know the hung pid, you can
>
> =A0cat /proc/$pid/stack
>
> and see where it is blocked. =A0Also,
>
> =A0dmesg | tail
>
> may have some relevant console messages.
>
>
>> > =A0 =A0 =A0 =A0 =A0When I follow the instruction of
>> > http://ceph.newdream.net/wiki/Monitor_cluster_expansion to expand =
a
>> > monitor to ceph02, the following error occurred:
>> > >
>> > > root@ceph02:~# =A0/etc/init.d/ceph start mon1
>> > > [/etc/ceph/fetch_config/tmp/fetched.ceph.conf.14210] ceph.conf 1=
00% =A02565
>> > =A02.5KB/s =A000:00
>> > > =3D=3D=3D mon.1 =3D=3D=3D
>> > > Starting Ceph mon1 on ceph02...
>> > > =A0** WARNING: Ceph is still under heavy development, and is onl=
y suitable
>> > for **
>> > > =A0** testing and review. =A0Do not trust it with important data=
=2E =A0**
>> > > terminate called after throwing an instance of 'std::logic_error=
'
>> > > =A0 what(): =A0basic_string::_S_construct NULL not valid
>> > > Aborted (core dumped)
>> > > failed: ' /usr/bin/cmon -i 1 -c /tmp/fetched.ceph.conf.14210 '
>> >
>> > I haven't seen that crash, but it looks like a std::string constru=
ctor is
>> > being passed a NULL pointer. =A0Do you have a core dump (to get a
>> > backtrace)? =A0Which version are you running (`cmon -v`)?
>> >
>>
>> The cmon version is v0.21.1 when the crash happen and been updated t=
o
>> v0.21.2.
>>
>> The following backtrace is from v0.21.2:
>
> Thanks, we'll see if we can reproduce and fix this one!
>
>> [...]
>> Thanks,I will wait for v0.22 and try to add mds then,but I want to i=
s my
>> config for mds is right.
>>
>>
>>
>> I set 2 mds in ceph.conf
>>
>> [mds]
>>
>> keyring =3D /etc/ceph/keyring.$name
>>
>> debug ms =3D 1
>>
>> [mds.ceph01]
>>
>>      host =3D ceph01
>>
>> [mds.ceph02]
>>
>> =A0 =A0 =A0 host =3D ceph02
>
> Looks right.
>
>
>> The result for 'ceph -s':
>>
>> 10.09.01_17:56:19.337895 =A0 mds e17: 1/1/1 up {0=3Dup:active}, 1 up=
:standby
>>
>> But now the result for 'ceph -s' is:
>>
>> 10.09.19_17:01:50.398809 =A0 mds e27: 1/1/1 up {0=3Dup:active}
>
> It looks like the second 'standby' cmds went away. =A0Is the daemon s=
till
> running?
>

I don't know if it was still running because both mds were down now.

>>
>>
>> If I make a partition for journal in a 500GB hdd,what is the proper =
size for
>> the partition?
>
> 1 GB should be sufficient.
>
> sage

thanks!
Lin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
