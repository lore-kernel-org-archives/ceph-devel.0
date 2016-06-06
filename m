From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Bluestore crash in mkfs
Date: Mon, 6 Jun 2016 11:34:50 -0500
Message-ID: <6545776f-0836-3199-c6f7-4625113f5d75@redhat.com>
References: <BL2PR02MB21151DAE1DAF64B6CC74D01FF45A0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <CAB=cV2Tp9ASRHxLSw5H3K=4PbrxrFkF4sARsfDRxDVqJpQ8ZHg@mail.gmail.com>
 <BL2PR02MB2115840732283AC0927974AEF45A0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1606042235220.6221@cpach.fuggernut.com>
 <A1E209ED-AE9D-4C72-AFA9-B80AF9CDA280@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50101 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752220AbcFFQey (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 6 Jun 2016 12:34:54 -0400
In-Reply-To: <A1E209ED-AE9D-4C72-AFA9-B80AF9CDA280@sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sage@newdream.net>
Cc: Jianjian Huo <samuel.huo@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

I'm hitting this after upgrading to master.  Probably something that go=
t=20
merged on the 2nd or 3rd.  I'll see if I can track it down.

Mark

On 06/04/2016 09:41 PM, Somnath Roy wrote:
> Here is the steps I did..
> 1. Git pull
> 2. Make clean
> 3. Do_autogen -j o3
> 4. Make install
> 5. Mkcephfs to install, I still prefer it=F0=9F=98=8A
>
> I will debug more and update
>
> Thanks & Regards
> Somnath
>
> Sent from my iPhone
>
>> On Jun 4, 2016, at 7:35 PM, Sage Weil <sage@newdream.net> wrote:
>>
>>> On Sat, 4 Jun 2016, Somnath Roy wrote:
>>> Same conf file worked for me sometimes back. I think db path/wal pa=
th is optional and if you don't mention anything, it will coexist on th=
e block partition.
>>> Not sure if this is something changed recently though..
>>> The trace is also not complaining about db path , it is getting a s=
eg fault while parsing rocksdb option.
>>
>> Hmm, I haven't seen this.
>>
>> Note that you don't need 'devs'.  And you're right that just specify=
ing
>> the block path is enough.  If you're doing a manual build, is it
>> possible you're dynamically linking rocksdb or something?
>>
>> sage
>>
>>>
>>> Thanks & Regards
>>> Somnath
>>>
>>> -----Original Message-----
>>> From: Jianjian Huo [mailto:samuel.huo@gmail.com]
>>> Sent: Friday, June 03, 2016 9:29 PM
>>> To: Somnath Roy
>>> Cc: Sage Weil (sage@newdream.net); ceph-devel
>>> Subject: Re: Bluestore crash in mkfs
>>>
>>>> On Fri, Jun 3, 2016 at 7:16 PM, Somnath Roy <Somnath.Roy@sandisk.c=
om> wrote:
>>>> Sage,
>>>> Latest code in Bluestore is crashing on me during mkfs. Here is th=
e dump.
>>>>
>>>> ceph version 10.2.0-1809-gac8c40f
>>>> (ac8c40f3e3257517f71d2af8bd26dcd264887b7f)
>>>> 1: (()+0x99e65e) [0x55cf5263565e]
>>>> 2: (()+0x113d0) [0x7f323526f3d0]
>>>> 3:
>>>> (rocksdb::ColumnFamilyOptions::ColumnFamilyOptions(rocksdb::Option=
s
>>>> const&)+0x59) [0x55cf525d4ce9]
>>>> 4: (rocksdb::GetOptionsFromString(rocksdb::Options const&,
>>>> std::__cxx11::basic_string<char, std::char_traits<char>,
>>>> std::allocator<char> > const&, rocksdb::Options*)+0x15a)
>>>> [0x55cf525dc74a]
>>>> 5:
>>>> (RocksDBStore::ParseOptionsFromString(std::__cxx11::basic_string<c=
har,
>>>> std::char_traits<char>, std::allocator<char> >,
>>>> rocksdb::Options&)+0x22e) [0x55cf524f58be]
>>>> 6: (RocksDBStore::init(std::__cxx11::basic_string<char,
>>>> std::char_traits<char>, std::allocator<char> >)+0x77) [0x55cf524f5=
f17]
>>>> 7: (BlueStore::_open_db(bool)+0x274) [0x55cf5234b9e4]
>>>> 8: (BlueStore::mkfs()+0x899) [0x55cf52361ad9]
>>>> 9: (OSD::mkfs(CephContext*, ObjectStore*,
>>>> std::__cxx11::basic_string<char, std::char_traits<char>,
>>>> std::allocator<char> > const&, uuid_d, int)+0x117) [0x55cf52001427=
]
>>>> 10: (main()+0x1003) [0x55cf51f9f2e3]
>>>> 11: (__libc_start_main()+0xf0) [0x7f32331fa830]
>>>> 12: (_start()+0x29) [0x55cf51fe2719]
>>>> NOTE: a copy of the executable, or `objdump -rdS <executable>` is =
needed to interpret this.
>>>>
>>>>
>>>> I am using the following option :
>>>>
>>>>       devs =3D /dev/sdb1
>>>>       bluestore_block_path =3D /dev/sdb2
>>>>
>>>> Am I missing anything ?
>>>
>>> This is what Mark posted last time, you forgot db path?
>>> https://github.com/ceph/cbt/blob/master/example/bluestore/ceph.conf=
=2Ebluestore_example
>>>>
>>>> Thanks & Regards
>>>> Somnath
>>>> PLEASE NOTE: The information contained in this electronic mail mes=
sage is intended only for the use of the designated recipient(s) named =
above. If the reader of this message is not the intended recipient, you=
 are hereby notified that you have received this message in error and t=
hat any review, dissemination, distribution, or copying of this message=
 is strictly prohibited. If you have received this communication in err=
or, please notify the sender by telephone or e-mail (as shown above) im=
mediately and destroy any and all copies of this message in your posses=
sion (whether hard copies or electronically stored copies).
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"
>>>> in the body of a message to majordomo@vger.kernel.org More majordo=
mo
>>>> info at  http://vger.kernel.org/majordomo-info.html
>>> N?????r??y??????X??=C7=A7v???)=DE=BA{.n?????z?]z????ay? =CA=87=DA=99=
??j ??f???h????? ?w??? ???j:+v???w???????? ????zZ+???????j"????i
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=
=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=
=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BD=
j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
