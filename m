From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: RE: A problem when restarting OSD
Date: Fri, 22 Aug 2014 02:57:58 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C5348936F58@SHSMSX101.ccr.corp.intel.com>
References: <06E7D85B3BA36C4DB207FEDE871C5348936F36@SHSMSX101.ccr.corp.intel.com>
 <D01C1AB1.1B410%dmsimard@iweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:61658 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753562AbaHVC6D convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Aug 2014 22:58:03 -0400
In-Reply-To: <D01C1AB1.1B410%dmsimard@iweb.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Moreau Simard <dmsimard@iweb.com>, Sage Weil <sweil@redhat.com>
Cc: "'ceph-devel@vger.kernel.org'" <ceph-devel@vger.kernel.org>

Hi David,

Yes, I think adding a hook in your ceph.conf can solve your problem. At=
 least this is what I did, and it solves the problem.

=46or example:

[osd.3]
osd crush location =3D "host=3Dosd02 root=3Ddefault disktype=3Dosd02_ss=
d"

You need to add this for every osd.

-----Original Message-----
=46rom: David Moreau Simard [mailto:dmsimard@iweb.com]=20
Sent: Friday, August 22, 2014 10:34 AM
To: Wang, Zhiqiang; Sage Weil
Cc: 'ceph-devel@vger.kernel.org'
Subject: Re: A problem when restarting OSD

I=B9m glad you mention this because I=B9ve also been running into the s=
ame issue and this took me a while to figure out too.

Is this new behaviour ? I don=B9t remember running into this before...

Sage does mention multiple trees but I=B9ve had this happen with a sing=
le root.
It is definitely not my expectation that restarting an OSD would move t=
hings around in the crush map.

I=B9m in the process of developing a crush map, looks like this (note:
unfinished and does not make much sense as is):
http://pastebin.com/6vBUQTCk
This results in this tree:
# id	weight	type name	up/down	reweight
-1	18	root default
-2	9		host osd02
-4	2			disktype osd02_ssd
3	1				osd.3	up	1
9	1				osd.9	up	1
-5	7			disktype osd02_spinning
8	1				osd.8	up	1
17	1				osd.17	up	1
5	1				osd.5	up	1
11	1				osd.11	up	1
1	1				osd.1	up	1
13	1				osd.13	up	1
15	1				osd.15	up	1
-3	9		host osd01
-6	2			disktype osd01_ssd
2	1				osd.2	up	1
7	1				osd.7	up	1
-7	7			disktype osd01_spinning
0	1				osd.0	up	1
4	1				osd.4	up	1
12	1				osd.12	up	1
6	1				osd.6	up	1
14	1				osd.14	up	1
10	1				osd.10	up	1
16	1				osd.16	up	1

Only restarting the OSDs on both hosts modifies the crush map:
http://pastebin.com/rP8Y8qcH
With the resulting tree:
# id	weight	type name	up/down	reweight
-1	18	root default
-2	9		host osd02
-4	0			disktype osd02_ssd
-5	0			disktype osd02_spinning
13	1			osd.13	up	1
3	1			osd.3	up	1
5	1			osd.5	up	1
1	1			osd.1	up	1
11	1			osd.11	up	1
15	1			osd.15	up	1
17	1			osd.17	up	1
8	1			osd.8	up	1
9	1			osd.9	up	1
-3	9		host osd01
-6	0			disktype osd01_ssd
-7	0			disktype osd01_spinning
0	1			osd.0	up	1
10	1			osd.10	up	1
12	1			osd.12	up	1
14	1			osd.14	up	1
16	1			osd.16	up	1
2	1			osd.2	up	1
4	1			osd.4	up	1
7	1			osd.7	up	1
6	1			osd.6	up	1

Would a hook really be the solution I need ?
--
David Moreau Simard

Le 2014-08-21, 9:36 PM, =AB Wang, Zhiqiang =BB <zhiqiang.wang@intel.com=
> a =E9crit :

>Hi Sage,
>
>Yes, I understand that we can customize the crush location hook to let=
=20
>the OSD go to the right location. But does the ceph user have the idea=
=20
>of this if he/she has more than 1 root in the crush map? At least I=20
>don't know this at the beginning. We need to either emphasize this or=20
>do it in some ways for the user.
>
>One question for the hot-swapping support of moving an OSD to another=20
>host. What if the journal is not located at the same disk of the OSD?=20
>Is the OSD still able to be available in the cluster?
>
>-----Original Message-----
>From: Sage Weil [mailto:sweil@redhat.com]
>Sent: Thursday, August 21, 2014 11:28 PM
>To: Wang, Zhiqiang
>Cc: 'ceph-devel@vger.kernel.org'
>Subject: Re: A problem when restarting OSD
>
>On Thu, 21 Aug 2014, Wang, Zhiqiang wrote:
>> Hi all,
>>=20
>> I ran into a problem when restarting an OSD.
>>=20
>> Here is my OSD tree before restarting the OSD:
>>=20
>> # id    weight  type name       up/down reweight
>> -6      8       root ssd
>> -4      4               host zqw-s1-ssd
>> 16      1                       osd.16  up      1
>> 17      1                       osd.17  up      1
>> 18      1                       osd.18  up      1
>> 19      1                       osd.19  up      1
>> -5      4               host zqw-s2-ssd
>> 20      1                       osd.20  up      1
>> 21      1                       osd.21  up      1
>> 22      1                       osd.22  up      1
>> 23      1                       osd.23  up      1
>> -1      14.56   root default
>> -2      7.28            host zqw-s1
>> 0       0.91                    osd.0   up      1
>> 1       0.91                    osd.1   up      1
>> 2       0.91                    osd.2   up      1
>> 3       0.91                    osd.3   up      1
>> 4       0.91                    osd.4   up      1
>> 5       0.91                    osd.5   up      1
>> 6       0.91                    osd.6   up      1
>> 7       0.91                    osd.7   up      1
>> -3      7.28            host zqw-s2
>> 8       0.91                    osd.8   up      1
>> 9       0.91                    osd.9   up      1
>> 10      0.91                    osd.10  up      1
>> 11      0.91                    osd.11  up      1
>> 12      0.91                    osd.12  up      1
>> 13      0.91                    osd.13  up      1
>> 14      0.91                    osd.14  up      1
>> 15      0.91                    osd.15  up      1
>>=20
>> After I restart one of the OSD with id from 16 to 23, say restarting=
=20
>>osd.16, osd.16 goes to 'root default' and 'host zqw-s1', and ceph=20
>>cluster begins to do rebalance. This surely is not what I want.
>>=20
>> # id    weight  type name       up/down reweight
>> -6      7       root ssd
>> -4      3               host zqw-s1-ssd
>> 17      1                       osd.17  up      1
>> 18      1                       osd.18  up      1
>> 19      1                       osd.19  up      1
>> -5      4               host zqw-s2-ssd
>> 20      1                       osd.20  up      1
>> 21      1                       osd.21  up      1
>> 22      1                       osd.22  up      1
>> 23      1                       osd.23  up      1
>> -1      15.56   root default
>> -2      8.28            host zqw-s1
>> 0       0.91                    osd.0   up      1
>> 1       0.91                    osd.1   up      1
>> 2       0.91                    osd.2   up      1
>> 3       0.91                    osd.3   up      1
>> 4       0.91                    osd.4   up      1
>> 5       0.91                    osd.5   up      1
>> 6       0.91                    osd.6   up      1
>> 7       0.91                    osd.7   up      1
>> 16      1                       osd.16  up      1
>> -3      7.28            host zqw-s2
>> 8       0.91                    osd.8   up      1
>> 9       0.91                    osd.9   up      1
>> 10      0.91                    osd.10  up      1
>> 11      0.91                    osd.11  up      1
>> 12      0.91                    osd.12  up      1
>> 13      0.91                    osd.13  up      1
>> 14      0.91                    osd.14  up      1
>> 15      0.91                    osd.15  up      1
>>=20
>> After digging into the problem, I find it's because in the ceph init=
=20
>>script, we change the OSD's crush location in some way. It uses the=20
>>script 'ceph-crush-location' to get the crush location from the=20
>>ceph.conf file for the restarting OSD. If there isn't such an entry i=
n=20
>>ceph.conf, it uses the default one 'host=3D$(hostname -s) root=3Ddefa=
ult'.
>>Since I don't have the crush location configuration in my ceph.conf (=
I=20
>>guess most of people don't have this in their ceph.conf), when I=20
>>restarting osd.16, it goes to 'root default' and 'host zqw-s1'.
>>=20
>> Here is a fix for this:
>> When the ceph init script uses 'ceph osd crush create-or-move' to=20
>> change the OSD's crush location, do a check first, if this OSD is=20
>> already existing in the crush map, return without making the locatio=
n=20
>> change. This change is at:
>> https://github.com/wonzhq/ceph/commit/efdfa23664caa531390d141bd15398=
7
>> 8
>> 761412fe
>>=20
>> What do you think?
>
>The goal of this behavior is to allow hot-swapping of devices.  You ca=
n=20
>pull disks out of one host and put them in another and the udev=20
>machinery will start up the daemon, update the crush location, and the=
=20
>disk and data will become available.  It's not 'ideal' in the sense=20
>that there will be rebalancing, but it does make the data available to=
=20
>the cluster to preserve data safety.
>
>We haven't come up with a great scheme yet to managing multiple trees=20
>yet.
>The idea is that the ceph-crush-location hook can be customized to do=20
>whatever is necessary, for example by putting root=3Dssd if the device=
=20
>type appears to be an ssd (maybe look at the sysfs metadata, or put a=20
>marker file in the osd data directory?).  You can point to your own=20
>hook for your environment with
>
>  osd crush location hook =3D /path/to/my/script
>
>sage
>
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe ceph-devel"=20
>in the body of a message to majordomo@vger.kernel.org More majordomo=20
>info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
