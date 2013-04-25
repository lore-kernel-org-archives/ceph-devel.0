From: Wido den Hollander <wido@42on.com>
Subject: Re: cuttlefish countdown -- OSD doesn't get marked out
Date: Thu, 25 Apr 2013 14:56:06 +0200
Message-ID: <517927E6.2000903@42on.com>
References: <alpine.DEB.2.00.1304241527220.2772@cobra.newdream.net> <51791C83.3010403@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:33293 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756155Ab3DYM4K (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Apr 2013 08:56:10 -0400
In-Reply-To: <51791C83.3010403@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On 04/25/2013 02:07 PM, Martin Mailand wrote:
> Hi,
>
> if I shutdown an OSD, the OSD gets marked down after 20 seconds, after
> 300 seconds the osd should get marked out, an the cluster should resync.
> But that doesn't happened, the OSD stays in the status down/in forever,
> therefore the cluster stays forever degraded.
> I can reproduce it with a new installed cluster.
>
> If I manually set the osd out (ceph osd out 1), the cluster resync
> starts immediately.
>

Could you dump your osdmap? The first 10 lines would be interesting. 
There is a flag where you say "noosdout", could it be that the flag is set?

Wido

> I think thats a release critical bug, because the cluster health is not
> automatically recovered.
>
> And I reported this behavior a while ago
> http://article.gmane.org/gmane.comp.file-systems.ceph.user/603/
>
> -martin
>
>
> Log:
>
>
> root@store1:~# ceph -s
>     health HEALTH_OK
>     monmap e1: 3 mons at
> {a=192.168.195.31:6789/0,b=192.168.195.33:6789/0,c=192.168.195.35:6789/0},
> election epoch 82, quorum 0,1,2 a,b,c
>     osdmap e204: 24 osds: 24 up, 24 in
>      pgmap v106709: 5056 pgs: 5056 active+clean; 526 GB data, 1068 GB
> used, 173 TB / 174 TB avail
>     mdsmap e1: 0/0/1 up
>
> root@store1:~# ceph --version
> ceph version 0.60 (f26f7a39021dbf440c28d6375222e21c94fe8e5c)
> root@store1:~# /etc/init.d/ceph stop osd.1
> === osd.1 ===
> Stopping Ceph osd.1 on store1...bash: warning: setlocale: LC_ALL: cannot
> change locale (en_GB.utf8)
> kill 5492...done
> root@store1:~# ceph -s
>     health HEALTH_OK
>     monmap e1: 3 mons at
> {a=192.168.195.31:6789/0,b=192.168.195.33:6789/0,c=192.168.195.35:6789/0},
> election epoch 82, quorum 0,1,2 a,b,c
>     osdmap e204: 24 osds: 24 up, 24 in
>      pgmap v106709: 5056 pgs: 5056 active+clean; 526 GB data, 1068 GB
> used, 173 TB / 174 TB avail
>     mdsmap e1: 0/0/1 up
>
> root@store1:~# date -R
> Thu, 25 Apr 2013 13:09:54 +0200
>
>
>
> root@store1:~# ceph -s && date -R
>     health HEALTH_WARN 423 pgs degraded; 423 pgs stuck unclean; recovery
> 10999/269486 degraded (4.081%); 1/24 in osds are down
>     monmap e1: 3 mons at
> {a=192.168.195.31:6789/0,b=192.168.195.33:6789/0,c=192.168.195.35:6789/0},
> election epoch 82, quorum 0,1,2 a,b,c
>     osdmap e206: 24 osds: 23 up, 24 in
>      pgmap v106715: 5056 pgs: 4633 active+clean, 423 active+degraded; 526
> GB data, 1068 GB used, 173 TB / 174 TB avail; 10999/269486 degraded (4.081%)
>     mdsmap e1: 0/0/1 up
>
> Thu, 25 Apr 2013 13:10:14 +0200
>
>
> root@store1:~# ceph -s && date -R
>     health HEALTH_WARN 423 pgs degraded; 423 pgs stuck unclean; recovery
> 10999/269486 degraded (4.081%); 1/24 in osds are down
>     monmap e1: 3 mons at
> {a=192.168.195.31:6789/0,b=192.168.195.33:6789/0,c=192.168.195.35:6789/0},
> election epoch 82, quorum 0,1,2 a,b,c
>     osdmap e206: 24 osds: 23 up, 24 in
>      pgmap v106719: 5056 pgs: 4633 active+clean, 423 active+degraded; 526
> GB data, 1068 GB used, 173 TB / 174 TB avail; 10999/269486 degraded (4.081%)
>     mdsmap e1: 0/0/1 up
>
> Thu, 25 Apr 2013 13:23:01 +0200
>
> On 25.04.2013 01:46, Sage Weil wrote:
>> Hi everyone-
>>
>> We are down to a handful of urgent bugs (3!) and a cuttlefish release date
>> that is less than a week away.  Thank you to everyone who has been
>> involved in coding, testing, and stabilizing this release.  We are close!
>>
>> If you would like to test the current release candidate, your efforts
>> would be much appreciated!  For deb systems, you can do
>>
>>   wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/autobuild.asc' | sudo apt-key add -
>>   echo deb http://gitbuilder.ceph.com/ceph-deb-$(lsb_release -sc)-x86_64-basic/ref/next $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
>>
>> For rpm users you can find packages at
>>
>>   http://gitbuilder.ceph.com/ceph-rpm-centos6-x86_64-basic/ref/next/
>>   http://gitbuilder.ceph.com/ceph-rpm-fc17-x86_64-basic/ref/next/
>>   http://gitbuilder.ceph.com/ceph-rpm-fc18-x86_64-basic/ref/next/
>>
>> A draft of the release notes is up at
>>
>>   http://ceph.com/docs/master/release-notes/#v0-61
>>
>> Let me know if I've missed anything!
>>
>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
