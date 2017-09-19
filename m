From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Status of luminous v12.2.1 QE validation
Date: Tue, 19 Sep 2017 16:54:22 -0700
Message-ID: <f68e9558-12f4-6513-8039-c8221102ca0d@redhat.com>
References: <CAMMFjmF5OczC9Yg1F2S3EvPAZO4ZBefpuxNm-f70XG-dr6-31g@mail.gmail.com>
 <7c6b5e2490e374ec5cc5eeca46ce8299@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751074AbdISXyh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 19 Sep 2017 19:54:37 -0400
In-Reply-To: <7c6b5e2490e374ec5cc5eeca46ce8299@suse.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek <abhishek@suse.com>, Yuri Weinstein <yweinste@redhat.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, "gmeno@redhat.com" <gregory.meno@inktank.com>, Nathan Cutler <ncutler@suse.cz>, Zheng Yan <zyan@redhat.com>, Vasu Kulkarni <vakulkar@redhat.com>, "Dreyer, Ken" <kdreyer@redhat.com>, Ilya Dryomov <idryomov@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>

On 09/19/2017 01:45 PM, Abhishek wrote:
> On 2017-09-19 22:10, Yuri Weinstein wrote:
>> Details of this release summarized here
>> http://tracker.ceph.com/issues/21296#note-18
>>
>> The following suites included:
>>
>> rados
>> rgw
>> rbd
>> fs
>> krbd
>> kceph
>> knfs
>> rest
>> hadoop - EXCLUDED
>> samba - EXCLUDED
>> ceph-deploy
>> ceph-disk
>> upgrade/client-upgrade
>> upgrade/jewel-x (luminous)
>> upgrade/kraken-x (luminous)
>> upgrade/luminous-x (master)
>> powercycle
>> ceph-ansible
>> (please speak up if something is missing)
>>
>> Issues:
>>
>> rados.rbd
>> http://tracker.ceph.com/issues/21428 (assume is a `must` to be 
>> backported)
>>
>> fs
>> http://tracker.ceph.com/issues/21381 - known
>> http://tracker.ceph.com/issues/20910 - known
>> http://tracker.ceph.com/issues/20736 - known
>>
>> kcephfs - needs analysis - Patrick, Zheng FYI
>> knfs
>> http://tracker.ceph.com/issues/21424
>>
>> rest
>> http://tracker.ceph.com/issues/21425
>>
>> ceph-ansible related - per Vasu ceph-asible pass on master, PRs are to
>> be backported:
>> https://github.com/ceph/ceph/pull/17757
>> https://github.com/ceph/ceph-ansible/issues/1834
> 
> This also probably can wait, but if we are going to do a rebuild we can 
> add this to the queue
>> RHEL 7.4 related PRs need to backported:
>> https://github.com/ceph/ceph/pull/17776
>> https://github.com/ceph/ceph/pull/17796
>> https://github.com/ceph/ceph/pull/17777
> 
> For the RADOS PR, which I'll defer to Sage/Josh to take a call,

This one got through testing today, with runs almost entirely devoid of 
noise. If there are odd hangs in other suites that may have been caused
by this, you may want to try re-running. rados and rbd suites look good
at this point though.
