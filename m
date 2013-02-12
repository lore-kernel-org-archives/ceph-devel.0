From: Isaac Otsiabah <zmoo76b@yahoo.com>
Subject: Re: osd down (for 2 about 2 minutes) error after adding a new host to my cluster
Date: Mon, 11 Feb 2013 17:39:55 -0800 (PST)
Message-ID: <1360633195.97665.YahooMailNeo@web121906.mail.ne1.yahoo.com>
References: <1359048283.79398.YahooMailNeo@web121906.mail.ne1.yahoo.com> <4428CF82A82E485B81CB865DFBE92465@inktank.com> <1359136273.17901.YahooMailNeo@web121903.mail.ne1.yahoo.com> <1359404261.7789.YahooMailNeo@web121901.mail.ne1.yahoo.com> <CAPYLRzjbs4FB54uTv+rmt8Rsc7wHTfKPhrpEEKd0tKU92jR2FA@mail.gmail.com>
Reply-To: Isaac Otsiabah <zmoo76b@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nm8-vm0.bullet.mail.ne1.yahoo.com ([98.138.91.23]:47346 "EHLO
	nm8-vm0.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932808Ab3BLBkF convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 11 Feb 2013 20:40:05 -0500
In-Reply-To: <CAPYLRzjbs4FB54uTv+rmt8Rsc7wHTfKPhrpEEKd0tKU92jR2FA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



Yes, there were osd daemons running on the same node that the monitor w=
as=20
running on.=A0 If that is the case then i will run a test case with the=
=20
monitor running on a different node where no osd is running and see wha=
t happens. Thank you.=20

Isaac

________________________________
=46rom: Gregory Farnum <greg@inktank.com>
To: Isaac Otsiabah <zmoo76b@yahoo.com>=20
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>=20
Sent: Monday, February 11, 2013 12:29 PM
Subject: Re: osd down (for 2 about 2 minutes) error after adding a new =
host to my cluster

jIsaac,
I'm sorry I haven't been able to wrangle any time to look into this
more yet, but Sage pointed out in a related thread that there might be
some buggy handling of things like this if the OSD and the monitor are
located on the same host. Am I correct in assuming that with your
small cluster, all your OSDs are co-located with a monitor daemon?
-Greg

On Mon, Jan 28, 2013 at 12:17 PM, Isaac Otsiabah <zmoo76b@yahoo.com> wr=
ote:
>
>
> Gregory, i recreated the osd down problem again this morning on two n=
odes (g13ct, g14ct). First, i created a 1-node cluster on g13ct (with o=
sd.0, 1 ,2) and then added host g14ct (osd3. 4, 5). osd.1 went down for=
 about 1 minute and half after adding osd 3, 4, 5 were adde4d. i have i=
ncluded the routing table of each node at the time osd.1 went down. cep=
h.conf and ceph-osd.1.log files are attached. The crush map was default=
=2E Also, it could be a timing issue because it does not always fail wh=
en=A0 using default crush map, it takes several trials before you see i=
t. Thank you.
>
>
> [root@g13ct ~]# netstat -r
> Kernel IP routing table
> Destination=A0 =A0=A0=A0Gateway=A0 =A0 =A0 =A0=A0=A0Genmask=A0 =A0 =A0=
 =A0=A0=A0Flags=A0=A0=A0MSS Window=A0 irtt Iface
> default=A0 =A0 =A0 =A0=A0=A0133.164.98.250 0.0.0.0=A0 =A0 =A0 =A0=A0=A0=
UG=A0 =A0 =A0 =A0 0 0=A0 =A0 =A0 =A0 =A0 0 eth2
> 133.164.98.0=A0 =A0 *=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.255.0=A0=
=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth2
> link-local=A0 =A0 =A0 *=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.0.0=A0=
 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth3
> link-local=A0 =A0 =A0 *=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.0.0=A0=
 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth0
> link-local=A0 =A0 =A0 *=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.0.0=A0=
 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth2
> 192.0.0.0=A0 =A0 =A0=A0=A0*=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.0.0.0=
=A0 =A0 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth3
> 192.0.0.0=A0 =A0 =A0=A0=A0*=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.0.0.0=
=A0 =A0 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth0
> 192.168.0.0=A0 =A0=A0=A0*=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.255=
=2E0=A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth3
> 192.168.1.0=A0 =A0=A0=A0*=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.255=
=2E0=A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth0
> [root@g13ct ~]# ceph osd tree
>
> # id=A0 =A0 weight=A0 type name=A0 =A0 =A0=A0=A0up/down reweight
> -1=A0 =A0 =A0 6=A0 =A0 =A0=A0=A0root default
> -3=A0 =A0 =A0 6=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0rack unknownrack
> -2=A0 =A0 =A0 3=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0host =
g13ct
> 0=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.0=A0=A0=A0up=A0 =A0 =A0 1
> 1=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.1=A0=A0=A0down=A0 =A0 1
> 2=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.2=A0=A0=A0up=A0 =A0 =A0 1
> -4=A0 =A0 =A0 3=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0host =
g14ct
> 3=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.3=A0=A0=A0up=A0 =A0 =A0 1
> 4=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.4=A0=A0=A0up=A0 =A0 =A0 1
> 5=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.5=A0=A0=A0up=A0 =A0 =A0 1
>
>
>
> [root@g14ct ~]# ceph osd tree
>
> # id=A0 =A0 weight=A0 type name=A0 =A0 =A0=A0=A0up/down reweight
> -1=A0 =A0 =A0 6=A0 =A0 =A0=A0=A0root default
> -3=A0 =A0 =A0 6=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0rack unknownrack
> -2=A0 =A0 =A0 3=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0host =
g13ct
> 0=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.0=A0=A0=A0up=A0 =A0 =A0 1
> 1=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.1=A0=A0=A0down=A0 =A0 1
> 2=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.2=A0=A0=A0up=A0 =A0 =A0 1
> -4=A0 =A0 =A0 3=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0host =
g14ct
> 3=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.3=A0=A0=A0up=A0 =A0 =A0 1
> 4=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.4=A0=A0=A0up=A0 =A0 =A0 1
> 5=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.5=A0=A0=A0up=A0 =A0 =A0 1
>
> [root@g14ct ~]# netstat -r
> Kernel IP routing table
> Destination=A0 =A0=A0=A0Gateway=A0 =A0 =A0 =A0=A0=A0Genmask=A0 =A0 =A0=
 =A0=A0=A0Flags=A0=A0=A0MSS Window=A0 irtt Iface
> default=A0 =A0 =A0 =A0=A0=A0133.164.98.250 0.0.0.0=A0 =A0 =A0 =A0=A0=A0=
UG=A0 =A0 =A0 =A0 0 0=A0 =A0 =A0 =A0 =A0 0 eth0
> 133.164.98.0=A0 =A0 *=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.255.0=A0=
=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth0
> link-local=A0 =A0 =A0 *=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.0.0=A0=
 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth3
> link-local=A0 =A0 =A0 *=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.0.0=A0=
 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth5
> link-local=A0 =A0 =A0 *=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.0.0=A0=
 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth0
> 192.0.0.0=A0 =A0 =A0=A0=A0*=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.0.0.0=
=A0 =A0 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth3
> 192.0.0.0=A0 =A0 =A0=A0=A0*=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.0.0.0=
=A0 =A0 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth5
> 192.168.0.0=A0 =A0=A0=A0*=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.255=
=2E0=A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth3
> 192.168.1.0=A0 =A0=A0=A0*=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.255=
=2E0=A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth5
> [root@g14ct ~]# ceph osd tree
>
> # id=A0 =A0 weight=A0 type name=A0 =A0 =A0=A0=A0up/down reweight
> -1=A0 =A0 =A0 6=A0 =A0 =A0=A0=A0root default
> -3=A0 =A0 =A0 6=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0rack unknownrack
> -2=A0 =A0 =A0 3=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0host =
g13ct
> 0=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.0=A0=A0=A0up=A0 =A0 =A0 1
> 1=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.1=A0=A0=A0down=A0 =A0 1
> 2=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.2=A0=A0=A0up=A0 =A0 =A0 1
> -4=A0 =A0 =A0 3=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0host =
g14ct
> 3=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.3=A0=A0=A0up=A0 =A0 =A0 1
> 4=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.4=A0=A0=A0up=A0 =A0 =A0 1
> 5=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.5=A0=A0=A0up=A0 =A0 =A0 1
>
>
>
>
>
> Isaac
>
>
>
>
>
>
>
>
>
>
> ----- Original Message -----
> From: Isaac Otsiabah <zmoo76b@yahoo.com>
> To: Gregory Farnum <greg@inktank.com>
> Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
> Sent: Friday, January 25, 2013 9:51 AM
> Subject: Re: osd down (for 2 about 2 minutes) error after adding a ne=
w host to my cluster
>
>
>
> Gregory, the network physical layout is simple, the two networks are
> separate. the 192.168.0 and the 192.168.1 are not subnets within a
> network.
>
> Isaac
>
>
>
>
> ----- Original Message -----
> From: Gregory Farnum <greg@inktank.com>
> To: Isaac Otsiabah <zmoo76b@yahoo.com>
> Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
> Sent: Thursday, January 24, 2013 1:28 PM
> Subject: Re: osd down (for 2 about 2 minutes) error after adding a ne=
w host to my cluster
>
> What's the physical layout of your networking? This additional log ma=
y prove helpful as well, but I really need a bit more context in evalua=
ting the messages I see from the first one. :)
> -Greg
>
>
> On Thursday, January 24, 2013 at 9:24 AM, Isaac Otsiabah wrote:
>
>>
>>
>> Gregory, i tried send the the attached debug output several times an=
d
>> the mail server rejected them all probably becauseof the file size s=
o i cut the log file size down and it is attached. You will see the
>> reconnection failures by the error message line below. The ceph vers=
ion
>> is 0.56
>>
>>
>> it appears to be a timing issue because with the flag (debug ms=3D1)=
 turned on, the system ran slower and became harder to fail.
>> I
>> ran it several times and finally got it to fail on (osd.0) using
>> default crush map. The attached tar file contains log files for all
>> components on g8ct plus the ceph.conf. By the way, the log file cont=
ain only the last 1384 lines where the error occurs.
>>
>>
>> I started with a 1-node cluster on host g8ct (osd.0, osd.1, osd.2) a=
nd then added host g13ct (osd.3, osd.4, osd.5)
>>
>>
>> id weight type name up/down reweight
>> -1 6 root default
>> -3 6 rack unknownrack
>> -2 3 host g8ct
>> 0 1 osd.0 down 1
>> 1 1 osd.1 up 1
>> 2 1 osd.2 up 1
>> -4 3 host g13ct
>> 3 1 osd.3 up 1
>> 4 1 osd.4 up 1
>> 5 1 osd.5 up 1
>>
>>
>>
>> The error messages are in ceph.log and ceph-osd.0.log:
>>
>> ceph.log:2013-01-08
>> 05:41:38.080470 osd.0 192.168.0.124:6801/25571 3 : [ERR] map e15 had
>> wrong cluster addr (192.168.0.124:6802/25571 !=3D my
>> 192.168.1.124:6802/25571)
>> ceph-osd.0.log:2013-01-08 05:41:38.080458 7f06757fa710 0 log [ERR] :=
 map e15 had wrong cluster addr
>> (192.168.0.124:6802/25571 !=3D my 192.168.1.124:6802/25571)
>>
>>
>>
>> [root@g8ct ceph]# ceph -v
>> ceph version 0.56 (1a32f0a0b42f169a7b55ed48ec3208f6d4edc1e8)
>>
>>
>> Isaac
>>
>>
>> ----- Original Message -----
>> From: Gregory Farnum <greg@inktank.com (mailto:greg@inktank.com)>
>> To: Isaac Otsiabah <zmoo76b@yahoo.com (mailto:zmoo76b@yahoo.com)>
>> Cc: "ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel.org)"=
 <ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel.org)>
>> Sent: Monday, January 7, 2013 1:27 PM
>> Subject: Re: osd down (for 2 about 2 minutes) error after adding a n=
ew host to my cluster
>>
>> On Monday, January 7, 2013 at 1:00 PM, Isaac Otsiabah wrote:
>>
>>
>> When i add a new host (with osd's) to my existing cluster, 1 or 2
>> previous osd(s) goes down for about 2 minutes and then they come bac=
k
>> up.
>> >
>> >
>> > [root@h1ct ~]# ceph osd tree
>> >
>> > # id weight type name up/down reweight
>> > -1
>> > 3 root default
>> > -3 3 rack unknownrack
>> > -2 3 host h1
>> > 0 1 osd.0 up 1
>> > 1 1 osd.1 up 1
>> > 2
>> > 1 osd.2 up 1
>>
>>
>> For example, after adding host h2 (with 3 new osd) to the above clus=
ter
>> and running the "ceph osd tree" command, i see this:
>> >
>> >
>> > [root@h1 ~]# ceph osd tree
>> >
>> > # id weight type name up/down reweight
>> > -1 6 root default
>> > -3
>> > 6 rack unknownrack
>> > -2 3 host h1
>> > 0 1 osd.0 up 1
>> > 1 1 osd.1 down 1
>> > 2
>> > 1 osd.2 up 1
>> > -4 3 host h2
>> > 3 1 osd.3 up 1
>> > 4 1 osd.4 up
>> > 1
>> > 5 1 osd.5 up 1
>>
>>
>> The down osd always come back up after 2 minutes or less andi see th=
e
>> following error message in the respective osd log file:
>> > 2013-01-07 04:40:17.613028 7fec7f092760 1 journal _open
>> > /ceph_journal/journals/journal_2 fd 26: 1073741824 bytes, block si=
ze
>> > 4096 bytes, directio =3D 1, aio =3D 0
>> > 2013-01-07 04:40:17.613122
>> > 7fec7f092760 1 journal _open /ceph_journal/journals/journal_2 fd 2=
6:
>> > 1073741824 bytes, block size 4096 bytes, directio =3D 1, aio =3D 0
>> > 2013-01-07
>> > 04:42:10.006533 7fec746f7710 0 -- 192.168.0.124:6808/19449 >>
>> > 192.168.1.123:6800/18287 pipe(0x7fec20000e10 sd=3D31 :6808 pgs=3D0=
 cs=3D0
>> > l=3D0).accept connect_seq 0 vs existing 0 state connecting
>> > 2013-01-07
>> > 04:45:29.834341 7fec743f4710 0 -- 192.168.1.124:6808/19449 >>
>> > 192.168.1.122:6800/20072 pipe(0x7fec5402f320 sd=3D28 :45438 pgs=3D=
7 cs=3D1
>> > l=3D0).fault, initiating reconnect
>> > 2013-01-07 04:45:29.835748
>> > 7fec743f4710 0 -- 192.168.1.124:6808/19449 >>
>> > 192.168.1.122:6800/20072 pipe(0x7fec5402f320 sd=3D28 :45439 pgs=3D=
15 cs=3D3
>> > l=3D0).fault, initiating reconnect
>> > 2013-01-07 04:45:30.835219 7fec743f4710 0 --
>> > 192.168.1.124:6808/19449 >> 192.168.1.122:6800/20072
>> > pipe(0x7fec5402f320 sd=3D28 :45894 pgs=3D482 cs=3D903 l=3D0).fault=
, initiating
>> > reconnect
>> > 2013-01-07 04:45:30.837318 7fec743f4710 0 --
>> > 192.168.1.124:6808/19449 >> 192.168.1.122:6800/20072
>> > pipe(0x7fec5402f320 sd=3D28 :45895 pgs=3D483 cs=3D905 l=3D0).fault=
, initiating
>> > reconnect
>> > 2013-01-07 04:45:30.851984 7fec637fe710 0 log [ERR] : map
>> > e27 had wrong cluster addr (192.168.0.124:6808/19449 !=3D my
>> > 192.168.1.124:6808/19449)
>> >
>> > Also, this only happens only when the cluster ip address and the p=
ublic ip address are different for example
>> > ....
>> > ....
>> > ....
>> > [osd.0]
>> > host =3D g8ct
>> > public address =3D 192.168.0.124
>> > cluster address =3D 192.168.1.124
>> > btrfs devs =3D /dev/sdb
>> >
>> > ....
>> > ....
>> >
>> > but does not happen when they are the same. Any idea what may be t=
he issue?
>> This isn't familiar to me at first glance. What version of Ceph are =
you using?
>>
>> If
>> this is easy to reproduce, can you pastebin your ceph.conf and then =
add
>> "debug ms =3D 1" to your global config and gather up the logs from e=
ach
>> daemon?
>> -Greg
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org (mailto:majordomo=
@vger.kernel.org)
>> More majordomo info at http://vger.kernel.org/majordomo
>>
>>
>> Attachments:
>> - ceph-osd.0.log.tar.gz
>>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html


On Mon, Jan 28, 2013 at 12:17 PM, Isaac Otsiabah <zmoo76b@yahoo.com> wr=
ote:
>
>
> Gregory, i recreated the osd down problem again this morning on two n=
odes (g13ct, g14ct). First, i created a 1-node cluster on g13ct (with o=
sd.0, 1 ,2) and then added host g14ct (osd3. 4, 5). osd.1 went down for=
 about 1 minute and half after adding osd 3, 4, 5 were adde4d. i have i=
ncluded the routing table of each node at the time osd.1 went down. cep=
h.conf and ceph-osd.1.log files are attached. The crush map was default=
=2E Also, it could be a timing issue because it does not always fail wh=
en=A0 using default crush map, it takes several trials before you see i=
t. Thank you.
>
>
> [root@g13ct ~]# netstat -r
> Kernel IP routing table
> Destination=A0 =A0=A0=A0Gateway=A0 =A0 =A0 =A0=A0=A0Genmask=A0 =A0 =A0=
 =A0=A0=A0Flags=A0=A0=A0MSS Window=A0 irtt Iface
> default=A0 =A0 =A0 =A0=A0=A0133.164.98.250 0.0.0.0=A0 =A0 =A0 =A0=A0=A0=
UG=A0 =A0 =A0 =A0 0 0=A0 =A0 =A0 =A0 =A0 0 eth2
> 133.164.98.0=A0 =A0 *=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.255.0=A0=
=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth2
> link-local=A0 =A0 =A0 *=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.0.0=A0=
 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth3
> link-local=A0 =A0 =A0 *=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.0.0=A0=
 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth0
> link-local=A0 =A0 =A0 *=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.0.0=A0=
 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth2
> 192.0.0.0=A0 =A0 =A0=A0=A0*=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.0.0.0=
=A0 =A0 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth3
> 192.0.0.0=A0 =A0 =A0=A0=A0*=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.0.0.0=
=A0 =A0 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth0
> 192.168.0.0=A0 =A0=A0=A0*=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.255=
=2E0=A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth3
> 192.168.1.0=A0 =A0=A0=A0*=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.255=
=2E0=A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth0
> [root@g13ct ~]# ceph osd tree
>
> # id=A0 =A0 weight=A0 type name=A0 =A0 =A0=A0=A0up/down reweight
> -1=A0 =A0 =A0 6=A0 =A0 =A0=A0=A0root default
> -3=A0 =A0 =A0 6=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0rack unknownrack
> -2=A0 =A0 =A0 3=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0host =
g13ct
> 0=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.0=A0=A0=A0up=A0 =A0 =A0 1
> 1=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.1=A0=A0=A0down=A0 =A0 1
> 2=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.2=A0=A0=A0up=A0 =A0 =A0 1
> -4=A0 =A0 =A0 3=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0host =
g14ct
> 3=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.3=A0=A0=A0up=A0 =A0 =A0 1
> 4=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.4=A0=A0=A0up=A0 =A0 =A0 1
> 5=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.5=A0=A0=A0up=A0 =A0 =A0 1
>
>
>
> [root@g14ct ~]# ceph osd tree
>
> # id=A0 =A0 weight=A0 type name=A0 =A0 =A0=A0=A0up/down reweight
> -1=A0 =A0 =A0 6=A0 =A0 =A0=A0=A0root default
> -3=A0 =A0 =A0 6=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0rack unknownrack
> -2=A0 =A0 =A0 3=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0host =
g13ct
> 0=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.0=A0=A0=A0up=A0 =A0 =A0 1
> 1=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.1=A0=A0=A0down=A0 =A0 1
> 2=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.2=A0=A0=A0up=A0 =A0 =A0 1
> -4=A0 =A0 =A0 3=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0host =
g14ct
> 3=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.3=A0=A0=A0up=A0 =A0 =A0 1
> 4=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.4=A0=A0=A0up=A0 =A0 =A0 1
> 5=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.5=A0=A0=A0up=A0 =A0 =A0 1
>
> [root@g14ct ~]# netstat -r
> Kernel IP routing table
> Destination=A0 =A0=A0=A0Gateway=A0 =A0 =A0 =A0=A0=A0Genmask=A0 =A0 =A0=
 =A0=A0=A0Flags=A0=A0=A0MSS Window=A0 irtt Iface
> default=A0 =A0 =A0 =A0=A0=A0133.164.98.250 0.0.0.0=A0 =A0 =A0 =A0=A0=A0=
UG=A0 =A0 =A0 =A0 0 0=A0 =A0 =A0 =A0 =A0 0 eth0
> 133.164.98.0=A0 =A0 *=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.255.0=A0=
=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth0
> link-local=A0 =A0 =A0 *=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.0.0=A0=
 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth3
> link-local=A0 =A0 =A0 *=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.0.0=A0=
 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth5
> link-local=A0 =A0 =A0 *=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.0.0=A0=
 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth0
> 192.0.0.0=A0 =A0 =A0=A0=A0*=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.0.0.0=
=A0 =A0 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth3
> 192.0.0.0=A0 =A0 =A0=A0=A0*=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.0.0.0=
=A0 =A0 =A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth5
> 192.168.0.0=A0 =A0=A0=A0*=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.255=
=2E0=A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth3
> 192.168.1.0=A0 =A0=A0=A0*=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0255.255.255=
=2E0=A0=A0=A0U=A0 =A0 =A0 =A0=A0=A00 0=A0 =A0 =A0 =A0 =A0 0 eth5
> [root@g14ct ~]# ceph osd tree
>
> # id=A0 =A0 weight=A0 type name=A0 =A0 =A0=A0=A0up/down reweight
> -1=A0 =A0 =A0 6=A0 =A0 =A0=A0=A0root default
> -3=A0 =A0 =A0 6=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0rack unknownrack
> -2=A0 =A0 =A0 3=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0host =
g13ct
> 0=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.0=A0=A0=A0up=A0 =A0 =A0 1
> 1=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.1=A0=A0=A0down=A0 =A0 1
> 2=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.2=A0=A0=A0up=A0 =A0 =A0 1
> -4=A0 =A0 =A0 3=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0host =
g14ct
> 3=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.3=A0=A0=A0up=A0 =A0 =A0 1
> 4=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.4=A0=A0=A0up=A0 =A0 =A0 1
> 5=A0 =A0 =A0=A0=A01=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0=A0osd.5=A0=A0=A0up=A0 =A0 =A0 1
>
>
>
>
>
> Isaac
>
>
>
>
>
>
>
>
>
>
> ----- Original Message -----
> From: Isaac Otsiabah <zmoo76b@yahoo.com>
> To: Gregory Farnum <greg@inktank.com>
> Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
> Sent: Friday, January 25, 2013 9:51 AM
> Subject: Re: osd down (for 2 about 2 minutes) error after adding a ne=
w host to my cluster
>
>
>
> Gregory, the network physical layout is simple, the two networks are
> separate. the 192.168.0 and the 192.168.1 are not subnets within a
> network.
>
> Isaac
>
>
>
>
> ----- Original Message -----
> From: Gregory Farnum <greg@inktank.com>
> To: Isaac Otsiabah <zmoo76b@yahoo.com>
> Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
> Sent: Thursday, January 24, 2013 1:28 PM
> Subject: Re: osd down (for 2 about 2 minutes) error after adding a ne=
w host to my cluster
>
> What's the physical layout of your networking? This additional log ma=
y prove helpful as well, but I really need a bit more context in evalua=
ting the messages I see from the first one. :)
> -Greg
>
>
> On Thursday, January 24, 2013 at 9:24 AM, Isaac Otsiabah wrote:
>
>>
>>
>> Gregory, i tried send the the attached debug output several times an=
d
>> the mail server rejected them all probably becauseof the file size s=
o i cut the log file size down and it is attached. You will see the
>> reconnection failures by the error message line below. The ceph vers=
ion
>> is 0.56
>>
>>
>> it appears to be a timing issue because with the flag (debug ms=3D1)=
 turned on, the system ran slower and became harder to fail.
>> I
>> ran it several times and finally got it to fail on (osd.0) using
>> default crush map. The attached tar file contains log files for all
>> components on g8ct plus the ceph.conf. By the way, the log file cont=
ain only the last 1384 lines where the error occurs.
>>
>>
>> I started with a 1-node cluster on host g8ct (osd.0, osd.1, osd.2) a=
nd then added host g13ct (osd.3, osd.4, osd.5)
>>
>>
>> id weight type name up/down reweight
>> -1 6 root default
>> -3 6 rack unknownrack
>> -2 3 host g8ct
>> 0 1 osd.0 down 1
>> 1 1 osd.1 up 1
>> 2 1 osd.2 up 1
>> -4 3 host g13ct
>> 3 1 osd.3 up 1
>> 4 1 osd.4 up 1
>> 5 1 osd.5 up 1
>>
>>
>>
>> The error messages are in ceph.log and ceph-osd.0.log:
>>
>> ceph.log:2013-01-08
>> 05:41:38.080470 osd.0 192.168.0.124:6801/25571 3 : [ERR] map e15 had
>> wrong cluster addr (192.168.0.124:6802/25571 !=3D my
>> 192.168.1.124:6802/25571)
>> ceph-osd.0.log:2013-01-08 05:41:38.080458 7f06757fa710 0 log [ERR] :=
 map e15 had wrong cluster addr
>> (192.168.0.124:6802/25571 !=3D my 192.168.1.124:6802/25571)
>>
>>
>>
>> [root@g8ct ceph]# ceph -v
>> ceph version 0.56 (1a32f0a0b42f169a7b55ed48ec3208f6d4edc1e8)
>>
>>
>> Isaac
>>
>>
>> ----- Original Message -----
>> From: Gregory Farnum <greg@inktank.com (mailto:greg@inktank.com)>
>> To: Isaac Otsiabah <zmoo76b@yahoo.com (mailto:zmoo76b@yahoo.com)>
>> Cc: "ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel.org)"=
 <ceph-devel@vger.kernel.org (mailto:ceph-devel@vger.kernel.org)>
>> Sent: Monday, January 7, 2013 1:27 PM
>> Subject: Re: osd down (for 2 about 2 minutes) error after adding a n=
ew host to my cluster
>>
>> On Monday, January 7, 2013 at 1:00 PM, Isaac Otsiabah wrote:
>>
>>
>> When i add a new host (with osd's) to my existing cluster, 1 or 2
>> previous osd(s) goes down for about 2 minutes and then they come bac=
k
>> up.
>> >
>> >
>> > [root@h1ct ~]# ceph osd tree
>> >
>> > # id weight type name up/down reweight
>> > -1
>> > 3 root default
>> > -3 3 rack unknownrack
>> > -2 3 host h1
>> > 0 1 osd.0 up 1
>> > 1 1 osd.1 up 1
>> > 2
>> > 1 osd.2 up 1
>>
>>
>> For example, after adding host h2 (with 3 new osd) to the above clus=
ter
>> and running the "ceph osd tree" command, i see this:
>> >
>> >
>> > [root@h1 ~]# ceph osd tree
>> >
>> > # id weight type name up/down reweight
>> > -1 6 root default
>> > -3
>> > 6 rack unknownrack
>> > -2 3 host h1
>> > 0 1 osd.0 up 1
>> > 1 1 osd.1 down 1
>> > 2
>> > 1 osd.2 up 1
>> > -4 3 host h2
>> > 3 1 osd.3 up 1
>> > 4 1 osd.4 up
>> > 1
>> > 5 1 osd.5 up 1
>>
>>
>> The down osd always come back up after 2 minutes or less andi see th=
e
>> following error message in the respective osd log file:
>> > 2013-01-07 04:40:17.613028 7fec7f092760 1 journal _open
>> > /ceph_journal/journals/journal_2 fd 26: 1073741824 bytes, block si=
ze
>> > 4096 bytes, directio =3D 1, aio =3D 0
>> > 2013-01-07 04:40:17.613122
>> > 7fec7f092760 1 journal _open /ceph_journal/journals/journal_2 fd 2=
6:
>> > 1073741824 bytes, block size 4096 bytes, directio =3D 1, aio =3D 0
>> > 2013-01-07
>> > 04:42:10.006533 7fec746f7710 0 -- 192.168.0.124:6808/19449 >>
>> > 192.168.1.123:6800/18287 pipe(0x7fec20000e10 sd=3D31 :6808 pgs=3D0=
 cs=3D0
>> > l=3D0).accept connect_seq 0 vs existing 0 state connecting
>> > 2013-01-07
>> > 04:45:29.834341 7fec743f4710 0 -- 192.168.1.124:6808/19449 >>
>> > 192.168.1.122:6800/20072 pipe(0x7fec5402f320 sd=3D28 :45438 pgs=3D=
7 cs=3D1
>> > l=3D0).fault, initiating reconnect
>> > 2013-01-07 04:45:29.835748
>> > 7fec743f4710 0 -- 192.168.1.124:6808/19449 >>
>> > 192.168.1.122:6800/20072 pipe(0x7fec5402f320 sd=3D28 :45439 pgs=3D=
15 cs=3D3
>> > l=3D0).fault, initiating reconnect
>> > 2013-01-07 04:45:30.835219 7fec743f4710 0 --
>> > 192.168.1.124:6808/19449 >> 192.168.1.122:6800/20072
>> > pipe(0x7fec5402f320 sd=3D28 :45894 pgs=3D482 cs=3D903 l=3D0).fault=
, initiating
>> > reconnect
>> > 2013-01-07 04:45:30.837318 7fec743f4710 0 --
>> > 192.168.1.124:6808/19449 >> 192.168.1.122:6800/20072
>> > pipe(0x7fec5402f320 sd=3D28 :45895 pgs=3D483 cs=3D905 l=3D0).fault=
, initiating
>> > reconnect
>> > 2013-01-07 04:45:30.851984 7fec637fe710 0 log [ERR] : map
>> > e27 had wrong cluster addr (192.168.0.124:6808/19449 !=3D my
>> > 192.168.1.124:6808/19449)
>> >
>> > Also, this only happens only when the cluster ip address and the p=
ublic ip address are different for example
>> > ....
>> > ....
>> > ....
>> > [osd.0]
>> > host =3D g8ct
>> > public address =3D 192.168.0.124
>> > cluster address =3D 192.168.1.124
>> > btrfs devs =3D /dev/sdb
>> >
>> > ....
>> > ....
>> >
>> > but does not happen when they are the same. Any idea what may be t=
he issue?
>> This isn't familiar to me at first glance. What version of Ceph are =
you using?
>>
>> If
>> this is easy to reproduce, can you pastebin your ceph.conf and then =
add
>> "debug ms =3D 1" to your global config and gather up the logs from e=
ach
>> daemon?
>> -Greg
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org (mailto:majordomo=
@vger.kernel.org)
>> More majordomo info at http://vger.kernel.org/majordomo
>>
>>
>> Attachments:
>> - ceph-osd.0.log.tar.gz
>>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
