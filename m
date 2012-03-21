From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Problem about writing configuration file
Date: Wed, 21 Mar 2012 10:36:32 +0100
Message-ID: <4F69A120.6000101@widodh.nl>
References: <CALwGbPKkq0Dj=SiYAaJjNeA6zme_DwbiL_e-dVMjD_HcRsAxGA@mail.gmail.com> <4F699F7D.8010602@widodh.nl> <CALwGbPL2vNfMvhJmEt5pkpowF7tWh1Xigjxjw1CrLv8h+xF23w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:45068 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002Ab2CUJge (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 05:36:34 -0400
In-Reply-To: <CALwGbPL2vNfMvhJmEt5pkpowF7tWh1Xigjxjw1CrLv8h+xF23w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

On 03/21/2012 10:31 AM, =E8=83=A1=E7=80=9A=E6=A3=AE wrote:
> for example I have an ext4 partition /dev/sdb1
> what should I write in the configuration file?
> I have trouble getting to know the format of the config file.

=46or example:

* /etc/fstab *
/dev/sdb1   /var/lib/ceph/osd.0    ext4   rw,user_xattr 0 0

* /etc/ceph/ceph.conf *
[osd.0]
    osd data =3D /var/lib/ceph/osd.0

Wido

>
> On Wed, Mar 21, 2012 at 5:29 PM, Wido den Hollander<wido@widodh.nl>  =
wrote:
>> Hi,
>>
>>
>> On 03/21/2012 10:26 AM, =E8=83=A1=E7=80=9A=E6=A3=AE wrote:
>>>
>>> I created my own configuration file.
>>> Unfortunately for some reason, I cannot use BTRFS at the moment.
>>>
>>> In that case, if I want to use ext4 as OSD FS, what should I write =
in
>>> my configuration file?
>>>
>>> And are there any official guide about the configuration file?
>>
>>
>> Just make sure your "osd data" points to the right direction for sto=
ring the
>> OSD data.
>>
>> Also, make sure that you enable user_xattr for the ext4 fileystem.
>>
>> Wido
>>
>>>
>>> Thanks.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
