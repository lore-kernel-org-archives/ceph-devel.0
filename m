From: Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>
Subject: Re: Conflict with libgoogle-perftools4 in ubuntu12.04(precise)
Date: Thu, 6 Nov 2014 11:09:43 +0800
Message-ID: <CABF_e-GMM=xSx5WHxS2OZTW3EN3PQ0PpKwOQF_VTET42R11ydg@mail.gmail.com>
References: <CABF_e-Fv1V8ACFFOYuiKWe8gy133P-eJuY0u8t4Nf3V_AWODrA@mail.gmail.com>
	<alpine.DEB.2.00.1411040109430.15135@cobra.newdream.net>
	<CABF_e-E33_e29-N7TK9+Gd14+N-2_da8HyZN4KkMNOMKvdsXuA@mail.gmail.com>
	<alpine.DEB.2.00.1411050056030.15135@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:62455 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbaKFDJo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Nov 2014 22:09:44 -0500
Received: by mail-oi0-f48.google.com with SMTP id x69so146517oia.7
        for <ceph-devel@vger.kernel.org>; Wed, 05 Nov 2014 19:09:43 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1411050056030.15135@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2014-11-05 17:00 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Wed, 5 Nov 2014, Wei-Chung Cheng wrote:
>> 2014-11-04 17:11 GMT+08:00 Sage Weil <sage@newdream.net>:
>> > On Tue, 4 Nov 2014, Cheng Wei-Chung wrote:
>> >> Dear all:
>> >>
>> >> I know that the default precise repo did not have libgoogle-perftools4.
>> >> It should only have libgoogle-perftools0.
>> >> In the situation that we add the Ubuntu Cloud Archive will bring
>> >> libgoogle-perftools4 with havana icehouse, juno and later version.
>> >> It will make conflict with ceph if we have other softwares like
>> >> mongodb that depends on libgoogle-perftools4.
>> >>
>> >> I found the following feature:
>> >> http://tracker.ceph.com/issues/8039
>> >> Is this feature still haven't done, right?
>> >
>> > Right, it's not done yet.
>>
>> OK, could I help to complete it?
>
> 1- Patches to update ceph.spec.in and debian/control
>    - make sure it is available and builds on all of the supported
>      platforms (precise, trusty, el6, el7, fc20)
> 2- QA
> 3- Test upgrade path
>

OK, I will do precise and trusty first.

>> >> I try to build the ceph version 0.87 with libgoogle-perftools4 and
>> >> upgrade from firefly in my test environment.
>> >>
>> >> It looks work normally. I think ceph can work on
>> >> libgoogle-perftools0/libgoogle-perftools4.
>> >
>> > Great!  It just needs patches to the packaging files, to go through
>> > testing, and then we need to make backported packages (possibly/probably)
>> > for a few older distros.
>> >
>> > It will be a bit awkward to to changed this for a stable release like
>> > firefly, though.  How disruptive will that be?
>> >
>> > sage
>>
>> I also have simple I/O tests with openstack in my environment this weekend.
>> If these tests are OK, I think we could make backported packages and
>> test it again?
>>
>> for change from a stable relase:
>> In my solution, I make sure the other ceph nodes and OSD processes are alive.
>> Upgrade only one node in the same time, because it will make some osd down for
>> a while due to removing ceph with libgoogle-perftools0.
>> In this stage, we need to remove libgoogle-perftools0 and install
>> libgoogle-perftools4
>> and its releated package.
>>
>> After that, install a new ceph package and OSDs will resume working normally.
>
> I don't think there should be a problem with the upgrade itself.. the 0
> and 4 versions are different files and IIRC you can even have multiple
> versions install simultaneously.  Mostly I'm worried about issues with the
> package management during upgrade.  I don't think it should be a problem
> but it needs to be tested.

I think version 0 and 4 would conflict. I try to have multiple version install.
In my experience, it could not work.
We need to consider that the issue with package management dring upgrade.
I will test first with precise, trusty and looks what issue we may meet.

>
> The bigger issue is that for a stable release like firefly or dumpilng,
> this is potentially a "big" change in a stable series that is supposed to
> be getting minimal fixes.  Any opinions here?
>
> sage

I will test dumpling and firefly after I have done the task about
packaging and testing the upgrade.
The best case is that let user upgrade by apt/yum right?
If we can use apt/yum upgrade, I think that can make the downtime minimal.
Maybe we need to change the dependency to version 4 and build with the
stable version like firefly and dumpling.
Then If it work normally, we can try to use the apt/yum upgrade.
In brief, I will test dumpling and firefly with version 4 first.

Thanks

vicente
