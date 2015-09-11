From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Failed on starting osd-daemon after upgrade giant-0.87.1 tohammer-0.94.3
Date: Fri, 11 Sep 2015 21:53:55 +0800
Message-ID: <CACJqLybVJ2o-x=VjDh2AV0ZTcjQU-Jgux0YRTdfLW06Mb1wSDA@mail.gmail.com>
References: <tencent_42C775740D2FE9D03D12EA84@qq.com>
	<alpine.DEB.2.00.1509090954410.12362@cobra.newdream.net>
	<tencent_7EDD2DF72EF83A9470528405@qq.com>
	<alpine.DEB.2.00.1509110554520.7527@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33511 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbbIKNx4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 09:53:56 -0400
Received: by vkgd64 with SMTP id d64so26782288vkg.0
        for <ceph-devel@vger.kernel.org>; Fri, 11 Sep 2015 06:53:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1509110554520.7527@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: =?UTF-8?B?546L6ZSQ?= <wangrui@tvmining.com>, ceph-devel <ceph-devel@vger.kernel.org>

Yesterday I have a chat with wangrui and the reason is "infos"(legacy
oid) is missing. I'm not sure why it's missing.

PS: resend again because of plain text

On Fri, Sep 11, 2015 at 8:56 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 11 Sep 2015, ?? wrote:
>> Thank Sage Weil:
>>
>> 1. I delete some testing pools in the past, but is was a long time ago (may be 2 months ago), in recently upgrade, do not delete pools.
>> 2.  ceph osd dump please see the (attachment file ceph.osd.dump.log)
>> 3. debug osd = 20' and 'debug filestore = 20  (attachment file ceph.osd.5.log.tar.gz)
>
> This one is failing on pool 54, which has been deleted.  In this case you
> can work around it by renaming current/54.* out of the way.
>
>> 4. i install the ceph-test, but output error
>> ceph-kvstore-tool /ceph/data5/current/db list
>> Invalid argument: /ceph/data5/current/db: does not exist (create_if_missing is false)
>
> Sorry, I should have said current/omap, not current/db.  I'm still curious
> to see the key dump.  I'm not sure why the leveldb key for these pgs is
> missing...
>
> Thanks!
> sage
>
>
>>
>> ls -l /ceph/data5/current/db
>> total 0
>> -rw-r--r-- 1 root root 0 Sep 11 09:41 LOCK
>> -rw-r--r-- 1 root root 0 Sep 11 09:54 LOG
>> -rw-r--r-- 1 root root 0 Sep 11 09:54 LOG.old
>>
>> Thanks very much!
>> Wang Rui
>>
>> ------------------ Original ------------------
>> From:  "Sage Weil"<sage@newdream.net>;
>> Date:  Fri, Sep 11, 2015 06:23 AM
>> To:  "??"<wangrui@tvmining.com>;
>> Cc:  "ceph-devel"<ceph-devel@vger.kernel.org>;
>> Subject:  Re: Failed on starting osd-daemon after upgrade giant-0.87.1 tohammer-0.94.3
>>
>> Hi!
>>
>> On Wed, 9 Sep 2015, ?? wrote:
>> > Hi all:
>> >
>> > I got on error after upgrade my ceph cluster from giant-0.87.2 to hammer-0.94.3, my local environment is:
>> > CentOS 6.7 x86_64
>> > Kernel 3.10.86-1.el6.elrepo.x86_64
>> > HDD: XFS, 2TB
>> > Install Package: ceph.com official RPMs x86_64
>> >
>> > step 1:
>> > Upgrade MON server from 0.87.1 to 0.94.3, all is fine!
>> >
>> > step 2:
>> > Upgrade OSD server from 0.87.1 to 0.94.3. i just upgrade two servers and noticed that some osds can not started!
>> > server-1 have 4 osds, all of them can not started;
>> > server-2 have 3 osds, 2 of them can not started, but 1 of them successfully started and work in good.
>> >
>> > Error log 1:
>> > service ceph start osd.4
>> > /var/log/ceph/ceph-osd.24.log
>> > (attachment file: ceph.24.log)
>> >
>> > Error log 2:
>> > /usr/bin/ceph-osd -c /etc/ceph/ceph.conf -i 4 -f
>> >  (attachment file: cli.24.log)
>>
>> This looks a lot like a problem with a stray directory that older versions
>> did not clean up (#11429)... but not quite.  Have you deleted pools in the
>> past? (Can you attach a 'ceph osd dump'?)?  Also, i fyou start the osd
>> with 'debug osd = 20' and 'debug filestore = 20' we can see which PG is
>> problematic.  If you install the 'ceph-test' package which contains
>> ceph-kvstore-tool, the output of
>>
>>  ceph-kvstore-tool /var/lib/ceph/osd/ceph-$id/current/db list
>>
>> would also be helpful.
>>
>> Thanks!
>> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
