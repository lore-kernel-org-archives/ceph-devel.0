From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Remote Ceph Install
Date: Mon, 03 Dec 2012 13:22:48 -0800
Message-ID: <50BD1828.40503@inktank.com>
References: <A2F373745D229246AD96986D5DDC5D3B4F970796@MLBMXUS22.cs.myharris.net> <50AAFD43.7000203@inktank.com> <A2F373745D229246AD96986D5DDC5D3B4F97A5C1@MLBMXUS22.cs.myharris.net> <50BD0D67.7070803@inktank.com> <A2F373745D229246AD96986D5DDC5D3B4F97A66D@MLBMXUS22.cs.myharris.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35156 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab2LCVWw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 16:22:52 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so2296397pbc.19
        for <ceph-devel@vger.kernel.org>; Mon, 03 Dec 2012 13:22:52 -0800 (PST)
In-Reply-To: <A2F373745D229246AD96986D5DDC5D3B4F97A66D@MLBMXUS22.cs.myharris.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Blackwell, Edward" <eblack04@harris.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm reading README.rst in the ceph-deploy sources, and I've executed th=
e=20
command, but didn't really analyze what it did when I did; I just=20
assumed from that doc that it would be necessary.  It's possible your=20
instructions obviate the need for that step, but I'd have to look at th=
e=20
instructions you were given, I guess...


On 12/03/2012 01:14 PM, Blackwell, Edward wrote:
> Hi Dan,
>
> In the version of the Ceph installation instructions I was given, I d=
on't have a "ceph-deploy gatherkeys" step.  Is there a newer version, o=
r can you briefly describe the use of this command?
>
> Thanks,
>
> Todd
>
> Todd Blackwell
> HARRIS Corporation
>    321-984-6911
> =EF=83=88 954-817-3662
>    eblack04@harris.com
>
>
> -----Original Message-----
> From: Dan Mick [mailto:dan.mick@inktank.com]
> Sent: Monday, December 03, 2012 3:37 PM
> To: Blackwell, Edward
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Remote Ceph Install
>
>
>
> On 12/03/2012 10:53 AM, Blackwell, Edward wrote:
>> Hi Dan,
>>
>> Thanks for the welcome and the advice.  There indeed was a problem w=
ith the host name and capitalization as you described, but once I corre=
cted that, a new issue began to occur when I ran the "ceph-deploy mon" =
command.  The command appears to run successfully (no output from the c=
ommand is generated), but when I check the status on one of the servers=
 in the cluster (ceph04 and ELSCEPH01) as recommended by the directions=
, I get the following:
>>
>> root@cephclient01:~/my-admin-sandbox# ceph-deploy mon
>> root@cephclient01:~/my-admin-sandbox# ssh ceph04 ceph -s
>> 2012-12-03 13:26:30.031854 7fc353d60780 -1 auth: failed to open keyr=
ing from /etc/ceph/ceph.client.admin.keyring,/etc/ceph/ceph.keyring,/et=
c/ceph/keyring,/etc/ceph/keyring.bin
>> 2012-12-03 13:26:30.031963 7fc353d60780 -1 monclient(hunting): faile=
d to open keyring: (2) No such file or directory
>> 2012-12-03 13:26:30.032042 7fc353d60780 -1 ceph_tool_common_init fai=
led.
>> root@cephclient01:~/my-admin-sandbox#
>
> Yeah, looks like the keys didn't get distributed correctly.  Did you =
do
> the ceph-deploy gatherkeys step?
>
>>
>> Behind the scenes, is the "ceph-deploy mon" command executing the mk=
cephfs command, which creates the keyring file?  If so, could that comm=
and be failing somehow, and hence the status command is not able to ret=
urn the status of the Ceph installation?
>>
>> I even tried executing the "ceph-deploy mon" command using the -v op=
tion, and got the following, so it seems to be working correctly:
>>
>> root@cephclient01:~/my-admin-sandbox# ceph-deploy -v mon
>> DEBUG:ceph_deploy.mon:Deploying mon, cluster ceph hosts ceph04 ELSCE=
PH01
>> DEBUG:ceph_deploy.mon:Deploying mon to ceph04
>> DEBUG:ceph_deploy.mon:Deploying mon to ELSCEPH01
>> root@cephclient01:~/my-admin-sandbox#
>>
>> I'm at a loss as to what to check or what do next to get past this s=
ituation.  Any help would be greatly appreciated.
>>
>> Thanks,
>>
>> Todd
>>
>> Todd Blackwell
>> HARRIS Corporation
>>     321-984-6911
>> =EF=83=88 954-817-3662
>>     eblack04@harris.com
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger=
=2Ekernel.org] On Behalf Of Dan Mick
>> Sent: Monday, November 19, 2012 10:47 PM
>> To: Blackwell, Edward
>> Cc: ceph-devel@vger.kernel.org
>> Subject: Re: Remote Ceph Install
>>
>>
>>
>> On 11/19/2012 11:42 AM, Blackwell, Edward wrote:
>>> Hi,
>>> I work for Harris Corporation, and we are investigating Ceph as a p=
otential solution to a storage problem that one of our government custo=
mers is currently having.  I've already created a two-node cluster on a=
 couple of VMs with another VM acting as an administrative client.  The=
 cluster was created using some installation instructions supplied to u=
s via Inktank, and through the use of the ceph-deploy script.  Aside fr=
om a couple of quirky discrepancies between the installation instructio=
ns and my environment, everything went well.  My issue has cropped up o=
n the second cluster I'm trying to create, which is using a VM and a no=
n-VM server for the nodes in the cluster.  Eventually, both nodes in th=
is cluster will be non-VMs, but we're still waiting on the hardware for=
 the second node, so I'm using a VM in the meantime just to get this se=
cond cluster up and going.  Of course, the administrative client node i=
s still a VM.
>>
>> Hi Ed.  Welcome.
>>
>>> The problem that I'm having with this second cluster concerns the n=
on-VM server (elsceph01 for the sake of the commands mentioned from her=
e on out).  In particular, the issue crops up with the ceph-deploy inst=
all elsceph01 command I'm executing on my client VM (cephclient01) to i=
nstall Ceph on the non-VM server. The installation doesn't appear to be=
 working as the command does not return the OK message that it should w=
hen it completes successfully.  I've tried using the verbose option on =
the command to see if that sheds any light on the subject, but alas, it=
 does not:
>>>
>>>
>>> root@cephclient01:~/my-admin-sandbox# ceph-deploy -v install elscep=
h01
>>> DEBUG:ceph_deploy.install:Installing stable version argonaut on clu=
ster ceph hosts elsceph01
>>> DEBUG:ceph_deploy.install:Detecting platform for host elsceph01 ...
>>> DEBUG:ceph_deploy.install:Installing for Ubuntu 12.04 on host elsce=
ph01 ...
>>> root@cephclient01:~/my-admin-sandbox#
>>>
>>>
>>> Would you happen to have a breakdown of the commands being executed=
 by the ceph-deploy script behind the scenes so I can maybe execute the=
m one-by-one to see where the error is?  I have confirmed that it looks=
 like the installation of the software has succeeded as I did a which c=
eph command on elsceph01, and it reported back /usr/bin/ceph.  Also, /e=
tc/ceph/ceph.conf is there, and it matches the file created by the ceph=
-deploy new ... command on the client.  Does the install command do a m=
kcephfs behind the scenes?  The reason I ask is that when I do the ceph=
-deploy mon command from the client, which is the next command listed i=
n the instructions to do, I get this output:
>>
>> Basically install just runs the appropriate debian package commands =
to
>> get the requested release of Ceph installed on the target host (in t=
his
>> case, defaulting to argonaut).  The command normally doesn't issue a=
ny
>> output.
>>
>>> root@cephclient01:~/my-admin-sandbox# ceph-deploy mon
>>> creating /var/lib/ceph/tmp/ceph-ELSCEPH01.mon.keyring
>>
>> This looks like there may be confusion about case in the hostname.  =
What
>> does "hostname" on elsceph01 report?  If it's ELSCEPH01, that's prob=
ably
>> the problem; the pathnames etc. are all case-sensitive.
>> Could be that /etc/hosts has the wrong case, or both cases, of the
>> hostname in it?
>>
>>> 2012-11-15 11:35:38.954261 7f7a6c274780 -1 asok(0x260b000) AdminSoc=
ketConfigObs::init: failed: AdminSocket::bind_and_listen: failed to bin=
d the UNIX domain socket to '/var/run/ceph/ceph-mon.ELSCEPH01.asok': (2=
) No such file or directory
>>> Traceback (most recent call last):
>>>      File "/usr/local/bin/ceph-deploy", line 9, in <module>
>>>        load_entry_point('ceph-deploy=3D=3D0.0.1', 'console_scripts'=
, 'ceph-deploy')()
>>>      File "/root/ceph-deploy/ceph_deploy/cli.py", line 80, in main
>>> added entity mon. auth auth(auid =3D 18446744073709551615 key=3DAQB=
WDj5QAP6LHhAAskVBnUkYHJ7eYREmKo5qKA=3D=3D with 0 caps)
>>>        return args.func(args)
>>> mon/MonMap.h: In function 'void MonMap::add(const string&, const en=
tity_addr_t&)' thread 7f7a6c274780 time 2012-11-15 11:35:38.955024
>>> mon/MonMap.h: 97: FAILED assert(addr_name.count(addr) =3D=3D 0)
>>> ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1=
beb780bfe)
>>> 1: (MonMap::build_from_host_list(std::string, std::string)+0x738) [=
0x5988b8]
>>> 2: (MonMap::build_initial(CephContext*, std::ostream&)+0x113) [0x59=
bd53]
>>> 3: (main()+0x12bb) [0x45ffab]
>>> 4: (__libc_start_main()+0xed) [0x7f7a6a6d776d]
>>> 5: ceph-mon() [0x462a19]
>>> NOTE: a copy of the executable, or `objdump -rdS <executable>` is n=
eeded to interpret this.
>>> 2012-11-15 11:35:38.955924 7f7a6c274780 -1 mon/MonMap.h: In functio=
n 'void MonMap::add(const string&, const entity_addr_t&)' thread 7f7a6c=
274780 time 2012-11-15 11:35:38.955024
>>> mon/MonMap.h: 97: FAILED assert(addr_name.count(addr) =3D=3D 0)
>>>
>>> ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1=
beb780bfe)
>>> 1: (MonMap::build_from_host_list(std::string, std::string)+0x738) [=
0x5988b8]
>>> 2: (MonMap::build_initial(CephContext*, std::ostream&)+0x113) [0x59=
bd53]
>>> 3: (main()+0x12bb) [0x45ffab]
>>> 4: (__libc_start_main()+0xed) [0x7f7a6a6d776d]
>>> 5: ceph-mon() [0x462a19]
>>> NOTE: a copy of the executable, or `objdump -rdS <executable>` is n=
eeded to interpret this.
>>>
>>>        -1> 2012-11-15 11:35:38.954261 7f7a6c274780 -1 asok(0x260b00=
0) AdminSocketConfigObs::init: failed: AdminSocket::bind_and_listen: fa=
iled to bind the UNIX domain socket to '/var/run/ceph/ceph-mon.ELSCEPH0=
1.asok': (2) No such file or directory
>>>         0> 2012-11-15 11:35:38.955924 7f7a6c274780 -1 mon/MonMap.h:=
 In function 'void MonMap::add(const string&, const entity_addr_t&)' th=
read 7f7a6c274780 time 2012-11-15 11:35:38.955024
>>> mon/MonMap.h: 97: FAILED assert(addr_name.count(addr) =3D=3D 0)
>>>
>>> ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1=
beb780bfe)
>>> 1: (MonMap::build_from_host_list(std::string, std::string)+0x738) [=
0x5988b8]
>>> 2: (MonMap::build_initial(CephContext*, std::ostream&)+0x113) [0x59=
bd53]
>>> 3: (main()+0x12bb) [0x45ffab]
>>> 4: (__libc_start_main()+0xed) [0x7f7a6a6d776d]
>>> 5: ceph-mon() [0x462a19]
>>> NOTE: a copy of the executable, or `objdump -rdS <executable>` is n=
eeded to interpret this.
>>>
>>> terminate called after throwing an instance of 'ceph::FailedAsserti=
on'
>>> *** Caught signal (Aborted) **
>>> in thread 7f7a6c274780
>>> ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1=
beb780bfe)
>>> 1: ceph-mon() [0x52569a]
>>> 2: (()+0xfcb0) [0x7f7a6b910cb0]
>>> 3: (gsignal()+0x35) [0x7f7a6a6ec425]
>>> 4: (abort()+0x17b) [0x7f7a6a6efb8b]
>>> 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f7a6b03e69d=
]
>>> 6: (()+0xb5846) [0x7f7a6b03c846]
>>> 7: (()+0xb5873) [0x7f7a6b03c873]
>>> 8: (()+0xb596e) [0x7f7a6b03c96e]
>>> 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char co=
nst*)+0x1de) [0x5deb9e]
>>> 10: (MonMap::build_from_host_list(std::string, std::string)+0x738) =
[0x5988b8]
>>> 11: (MonMap::build_initial(CephContext*, std::ostream&)+0x113) [0x5=
9bd53]
>>> 12: (main()+0x12bb) [0x45ffab]
>>> 13: (__libc_start_main()+0xed) [0x7f7a6a6d776d]
>>> 14: ceph-mon() [0x462a19]
>>> 2012-11-15 11:35:38.957723 7f7a6c274780 -1 *** Caught signal (Abort=
ed) **
>>> in thread 7f7a6c274780
>>>
>>> ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1=
beb780bfe)
>>> 1: ceph-mon() [0x52569a]
>>> 2: (()+0xfcb0) [0x7f7a6b910cb0]
>>> 3: (gsignal()+0x35) [0x7f7a6a6ec425]
>>> 4: (abort()+0x17b) [0x7f7a6a6efb8b]
>>> 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f7a6b03e69d=
]
>>> 6: (()+0xb5846) [0x7f7a6b03c846]
>>> 7: (()+0xb5873) [0x7f7a6b03c873]
>>> 8: (()+0xb596e) [0x7f7a6b03c96e]
>>> 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char co=
nst*)+0x1de) [0x5deb9e]
>>> 10: (MonMap::build_from_host_list(std::string, std::string)+0x738) =
[0x5988b8]
>>> 11: (MonMap::build_initial(CephContext*, std::ostream&)+0x113) [0x5=
9bd53]
>>> 12: (main()+0x12bb) [0x45ffab]
>>> 13: (__libc_start_main()+0xed) [0x7f7a6a6d776d]
>>> 14: ceph-mon() [0x462a19]
>>> NOTE: a copy of the executable, or `objdump -rdS <executable>` is n=
eeded to interpret this.
>>>
>>>         0> 2012-11-15 11:35:38.957723 7f7a6c274780 -1 *** Caught si=
gnal (Aborted) **
>>> in thread 7f7a6c274780
>>>
>>> ceph version 0.48.2argonaut (commit:3e02b2fad88c2a95d9c0c86878f10d1=
beb780bfe)
>>> 1: ceph-mon() [0x52569a]
>>> 2: (()+0xfcb0) [0x7f7a6b910cb0]
>>> 3: (gsignal()+0x35) [0x7f7a6a6ec425]
>>> 4: (abort()+0x17b) [0x7f7a6a6efb8b]
>>> 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f7a6b03e69d=
]
>>> 6: (()+0xb5846) [0x7f7a6b03c846]
>>> 7: (()+0xb5873) [0x7f7a6b03c873]
>>> 8: (()+0xb596e) [0x7f7a6b03c96e]
>>> 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char co=
nst*)+0x1de) [0x5deb9e]
>>> 10: (MonMap::build_from_host_list(std::string, std::string)+0x738) =
[0x5988b8]
>>> 11: (MonMap::build_initial(CephContext*, std::ostream&)+0x113) [0x5=
9bd53]
>>> 12: (main()+0x12bb) [0x45ffab]
>>> 13: (__libc_start_main()+0xed) [0x7f7a6a6d776d]
>>> 14: ceph-mon() [0x462a19]
>>> NOTE: a copy of the executable, or `objdump -rdS <executable>` is n=
eeded to interpret this.
>>>
>>>      File "/root/ceph-deploy/ceph_deploy/mon.py", line 125, in mon
>>>        get_monitor_secret=3Dget_monitor_secret,
>>>      File "/root/ceph-deploy/virtualenv/local/lib/python2.7/site-pa=
ckages/pushy-0.5.1-py2.7.egg/pushy/protocol/proxy.py", line 255, in <la=
mbda>
>>>        (conn.operator(type_, self, args, kwargs))
>>>      File "/root/ceph-deploy/virtualenv/local/lib/python2.7/site-pa=
ckages/pushy-0.5.1-py2.7.egg/pushy/protocol/connection.py", line 66, in=
 operator
>>>        return self.send_request(type_, (object, args, kwargs))
>>>      File "/root/ceph-deploy/virtualenv/local/lib/python2.7/site-pa=
ckages/pushy-0.5.1-py2.7.egg/pushy/protocol/baseconnection.py", line 32=
3, in send_request
>>>        return self.__handle(m)
>>>      File "/root/ceph-deploy/virtualenv/local/lib/python2.7/site-pa=
ckages/pushy-0.5.1-py2.7.egg/pushy/protocol/baseconnection.py", line 63=
9, in __handle
>>>        raise e
>>> pushy.protocol.proxy.ExceptionProxy: Command '['ceph-mon', '--clust=
er', 'ceph', '--mkfs', '-i', 'ELSCEPH01', '--keyring', '/var/lib/ceph/t=
mp/ceph-ELSCEPH01.mon.keyring']' returned non-zero exit status -6
>>>
>>>
>>> Which seems to indicate that the creation of the admin socket on th=
e elsceph01 server didn't work.  I've verified that the /var/run/ceph/c=
eph-mon.ELSCEPH01.asok file does not exist on the elsceph01 server.  An=
y help on this issue would be greatly appreciated.
>>>
>>> On a side note, I think the ceph-deploy command's verbose setting m=
ight be a little more helpful if it is a little more clear on the comma=
nds that are being executed for the installation of the software on the=
 remote server, and their results.  Also, it might be a good idea to al=
ter the exit status of the ceph-deploy command when an error occurs to =
a number that can be looked up in a map which indicates what went wrong=
=2E  This way even the non-verbose use of the command could still be he=
lpful in figuring out what went wrong if something did go wrong.  Right=
 now, ceph-deploy returns 0 for my failed installation.  It'd be really=
 cool if it returned something like 14, which could be traced back to s=
omething like, mkcephfs failed on the remote server.  It's just a thoug=
ht.
>>>
>>> Thanks,
>>>
>>> Todd
>>>
>>> Todd Blackwell
>>> HARRIS Corporation
>>> Work: 321-984-6911
>>> Cell: 954-817-3662
>>> eblack04@harris.com
>>>
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
