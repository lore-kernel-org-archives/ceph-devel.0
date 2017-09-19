From: Abhishek <abhishek@suse.com>
Subject: Re: Status of luminous v12.2.1 QE validation
Date: Tue, 19 Sep 2017 22:45:21 +0200
Message-ID: <7c6b5e2490e374ec5cc5eeca46ce8299@suse.com>
References: <CAMMFjmF5OczC9Yg1F2S3EvPAZO4ZBefpuxNm-f70XG-dr6-31g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35869 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751925AbdISUrY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 19 Sep 2017 16:47:24 -0400
In-Reply-To: <CAMMFjmF5OczC9Yg1F2S3EvPAZO4ZBefpuxNm-f70XG-dr6-31g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, John Spray <jspray@redhat.com>, "gmeno@redhat.com" <gregory.meno@inktank.com>, "Durgin, Josh" <jdurgin@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Zheng Yan <zyan@redhat.com>, Vasu Kulkarni <vakulkar@redhat.com>, "Dreyer, Ken" <kdreyer@redhat.com>, Ilya Dryomov <idryomov@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>

On 2017-09-19 22:10, Yuri Weinstein wrote:
> Details of this release summarized here
> http://tracker.ceph.com/issues/21296#note-18
> 
> The following suites included:
> 
> rados
> rgw
> rbd
> fs
> krbd
> kceph
> knfs
> rest
> hadoop - EXCLUDED
> samba - EXCLUDED
> ceph-deploy
> ceph-disk
> upgrade/client-upgrade
> upgrade/jewel-x (luminous)
> upgrade/kraken-x (luminous)
> upgrade/luminous-x (master)
> powercycle
> ceph-ansible
> (please speak up if something is missing)
> 
> Issues:
> 
> rados.rbd
> http://tracker.ceph.com/issues/21428 (assume is a `must` to be 
> backported)
> 
> fs
> http://tracker.ceph.com/issues/21381 - known
> http://tracker.ceph.com/issues/20910 - known
> http://tracker.ceph.com/issues/20736 - known
> 
> kcephfs - needs analysis - Patrick, Zheng FYI
> knfs
> http://tracker.ceph.com/issues/21424
> 
> rest
> http://tracker.ceph.com/issues/21425
> 
> ceph-ansible related - per Vasu ceph-asible pass on master, PRs are to
> be backported:
> https://github.com/ceph/ceph/pull/17757
> https://github.com/ceph/ceph-ansible/issues/1834

This also probably can wait, but if we are going to do a rebuild we can 
add this to the queue
> RHEL 7.4 related PRs need to backported:
> https://github.com/ceph/ceph/pull/17776
> https://github.com/ceph/ceph/pull/17796
> https://github.com/ceph/ceph/pull/17777

For the RADOS PR, which I'll defer to Sage/Josh to take a call,
the RGW hadoop s3 suite doesn't probably warrant a rebuild + rerun on 
its own. (Yehuda/Matt thoughts?)

> Not all tests were completed yet.
> 
> I suggest to consider the list for fixing/backporting and then rerun
> all suites on a new sha1.
> 
> Thx
> YuriW

