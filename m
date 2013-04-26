From: Mike Dawson <mike.dawson-9dgm/EUDD3RBYT3KYJiKsA@public.gmane.org>
Subject: Re: cuttlefish countdown -- OSD doesn't get marked out
Date: Fri, 26 Apr 2013 09:55:57 -0400
Message-ID: <517A876D.2090909@scholarstack.com>
References: <alpine.DEB.2.00.1304241527220.2772@cobra.newdream.net>
	<51791C83.3010403@tuxadero.com>
	<alpine.DEB.2.00.1304250916430.4411@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1304250916430.4411-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Sage,

I confirm this issue. The requested info is listed below.

*Note that due to the pre-Cuttlefish monitor sync issues, this 
deployment has been running three monitors (mon.b and mon.c working 
properly in quorum. mon.a stuck forever synchronizing).

For the past two hours, no OSD processes have been running on any host, 
yet some OSDs are still marked as up.

http://www.gammacode.com/upload/ceph-osd-tree


The mon* sections of ceph.conf are:

[mon]
     debug mon = 20
     debug paxos = 20
     debug ms = 1

[mon.a]
     host = node2
     mon addr = 10.1.0.3:6789

[mon.b]
     host = node26
     mon addr = 10.1.0.67:6789

[mon.c]
     host = node49
     mon addr = 10.1.0.130:6789

root@controller1:~# ceph -s
    health HEALTH_WARN 43 pgs degraded; 13308 pgs peering; 27932 pgs 
stale; 13308 pgs stuck inactive; 27932 pgs stuck stale; 13582 pgs stuck 
unclean; recovery 7264/7986546 degraded (0.091%); 47/66 in osds are 
down; 1 mons down, quorum 1,2 b,c
    monmap e1: 3 mons at 
{a=10.1.0.3:6789/0,b=10.1.0.67:6789/0,c=10.1.0.130:6789/0}, election 
epoch 1428, quorum 1,2 b,c
    osdmap e1323: 66 osds: 19 up, 66 in
     pgmap v427324: 28864 pgs: 257 active+clean, 231 stale+active, 15025 
stale+active+clean, 675 peering, 12633 stale+peering, 43 
stale+active+degraded; 448 GB data, 1402 GB used, 178 TB / 180 TB avail; 
7264/7986546 degraded (0.091%)
    mdsmap e1: 0/0/1 up

For reference, this is ceph version 0.60-666-ga5cade1 
(a5cade1fe7338602fb2bbfa867433d825f337c87) from gitbuilder.

Thanks,
Mike

On 4/25/2013 12:17 PM, Sage Weil wrote:
> On Thu, 25 Apr 2013, Martin Mailand wrote:
>> Hi,
>>
>> if I shutdown an OSD, the OSD gets marked down after 20 seconds, after
>> 300 seconds the osd should get marked out, an the cluster should resync.
>> But that doesn't happened, the OSD stays in the status down/in forever,
>> therefore the cluster stays forever degraded.
>> I can reproduce it with a new installed cluster.
>>
>> If I manually set the osd out (ceph osd out 1), the cluster resync
>> starts immediately.
>>
>> I think thats a release critical bug, because the cluster health is not
>> automatically recovered.
>
> What is the output from 'ceph osd tree' and the contents of your
> [mon*] sections of ceph.conf?
>
> Thanks!
> sage
>
>
>>
>> And I reported this behavior a while ago
>> http://article.gmane.org/gmane.comp.file-systems.ceph.user/603/
>>
>> -martin
>>
>>
>> Log:
>>
>>
>> root@store1:~# ceph -s
>>     health HEALTH_OK
>>     monmap e1: 3 mons at
>> {a=192.168.195.31:6789/0,b=192.168.195.33:6789/0,c=192.168.195.35:6789/0},
>> election epoch 82, quorum 0,1,2 a,b,c
>>     osdmap e204: 24 osds: 24 up, 24 in
>>      pgmap v106709: 5056 pgs: 5056 active+clean; 526 GB data, 1068 GB
>> used, 173 TB / 174 TB avail
>>     mdsmap e1: 0/0/1 up
>>
>> root@store1:~# ceph --version
>> ceph version 0.60 (f26f7a39021dbf440c28d6375222e21c94fe8e5c)
>> root@store1:~# /etc/init.d/ceph stop osd.1
>> === osd.1 ===
>> Stopping Ceph osd.1 on store1...bash: warning: setlocale: LC_ALL: cannot
>> change locale (en_GB.utf8)
>> kill 5492...done
>> root@store1:~# ceph -s
>>     health HEALTH_OK
>>     monmap e1: 3 mons at
>> {a=192.168.195.31:6789/0,b=192.168.195.33:6789/0,c=192.168.195.35:6789/0},
>> election epoch 82, quorum 0,1,2 a,b,c
>>     osdmap e204: 24 osds: 24 up, 24 in
>>      pgmap v106709: 5056 pgs: 5056 active+clean; 526 GB data, 1068 GB
>> used, 173 TB / 174 TB avail
>>     mdsmap e1: 0/0/1 up
>>
>> root@store1:~# date -R
>> Thu, 25 Apr 2013 13:09:54 +0200
>>
>>
>>
>> root@store1:~# ceph -s && date -R
>>     health HEALTH_WARN 423 pgs degraded; 423 pgs stuck unclean; recovery
>> 10999/269486 degraded (4.081%); 1/24 in osds are down
>>     monmap e1: 3 mons at
>> {a=192.168.195.31:6789/0,b=192.168.195.33:6789/0,c=192.168.195.35:6789/0},
>> election epoch 82, quorum 0,1,2 a,b,c
>>     osdmap e206: 24 osds: 23 up, 24 in
>>      pgmap v106715: 5056 pgs: 4633 active+clean, 423 active+degraded; 526
>> GB data, 1068 GB used, 173 TB / 174 TB avail; 10999/269486 degraded (4.081%)
>>     mdsmap e1: 0/0/1 up
>>
>> Thu, 25 Apr 2013 13:10:14 +0200
>>
>>
>> root@store1:~# ceph -s && date -R
>>     health HEALTH_WARN 423 pgs degraded; 423 pgs stuck unclean; recovery
>> 10999/269486 degraded (4.081%); 1/24 in osds are down
>>     monmap e1: 3 mons at
>> {a=192.168.195.31:6789/0,b=192.168.195.33:6789/0,c=192.168.195.35:6789/0},
>> election epoch 82, quorum 0,1,2 a,b,c
>>     osdmap e206: 24 osds: 23 up, 24 in
>>      pgmap v106719: 5056 pgs: 4633 active+clean, 423 active+degraded; 526
>> GB data, 1068 GB used, 173 TB / 174 TB avail; 10999/269486 degraded (4.081%)
>>     mdsmap e1: 0/0/1 up
>>
>> Thu, 25 Apr 2013 13:23:01 +0200
>>
>> On 25.04.2013 01:46, Sage Weil wrote:
>>> Hi everyone-
>>>
>>> We are down to a handful of urgent bugs (3!) and a cuttlefish release date
>>> that is less than a week away.  Thank you to everyone who has been
>>> involved in coding, testing, and stabilizing this release.  We are close!
>>>
>>> If you would like to test the current release candidate, your efforts
>>> would be much appreciated!  For deb systems, you can do
>>>
>>>   wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/autobuild.asc' | sudo apt-key add -
>>>   echo deb http://gitbuilder.ceph.com/ceph-deb-$(lsb_release -sc)-x86_64-basic/ref/next $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
>>>
>>> For rpm users you can find packages at
>>>
>>>   http://gitbuilder.ceph.com/ceph-rpm-centos6-x86_64-basic/ref/next/
>>>   http://gitbuilder.ceph.com/ceph-rpm-fc17-x86_64-basic/ref/next/
>>>   http://gitbuilder.ceph.com/ceph-rpm-fc18-x86_64-basic/ref/next/
>>>
>>> A draft of the release notes is up at
>>>
>>>   http://ceph.com/docs/master/release-notes/#v0-61
>>>
>>> Let me know if I've missed anything!
>>>
>>> sage
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
