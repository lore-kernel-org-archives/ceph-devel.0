From: Jean-Daniel BUSSY <silversurfer972@gmail.com>
Subject: Re: Reduce log verbosity
Date: Fri, 9 Aug 2013 18:33:06 +0900
Message-ID: <CANB=HGjD3-Q=Gmu_vwmJ+arsNeFOheTGa5aCywCmyrqkw73CyA@mail.gmail.com>
References: <CANB=HGgxw3fzcDhn7JKQA00eO4SfZHBptPi7Y=UxVQwUWny8yA@mail.gmail.com>
 <alpine.DEB.2.00.1308070811140.3006@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:57271 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965763Ab3HIJd1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Aug 2013 05:33:27 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so6308774obb.29
        for <ceph-devel@vger.kernel.org>; Fri, 09 Aug 2013 02:33:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1308070811140.3006@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Thanks for the info!

I now got these settings in my ceph.conf

  mon_cluster_log_file = /dev/null
  mon_cluster_log_to_syslog = true
  clog_to_syslog = true
  log_to_syslog = true
  err_to_syslog = true
  clog_to_syslog_level = "warn"
  mon_cluster_log_to_syslog_level = "warn"

I have the cluster log disabled and much less output (some options
might be unnecessary here).

I still can't find a way to take these out of the ceph-mon.{hostip}.log:

  mon.172-23-45-21@0(leader).data_health(754) update_stats avail 92%
total 138319904 used 2795168 avail 128498408

And during daily scrub there pgmap log messages appears:

  0 log [INF] : pgmap v428062: 3216 pgs: 3216 active+clean; 78649 MB
data, 154 GB used, 1429 GB / 1584 GB avail

but I suppose that will be fixed in future "mon_cluster_log_level"
option implementation.

Also, when ceph bench is running the stats are not filtered and still
appears in the mon log. That is not really important though.

BUSSY Jean-Daniel
Cloud Engineer


On Thu, Aug 8, 2013 at 12:12 AM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 7 Aug 2013, Jean-Daniel BUSSY wrote:
>> Hi all,
>>
>> We have log aggregation on our ceph cluster and verbosity is a problem
>> on the cluster log file at /etc/ceph/ceph.conf
>> I got advice from some nice folk on IRC and I tried to use syslog and
>> setup the log level to WARN but the INF logs are still pouring.
>> I confirmed settings are changed in the admin socked and got these:
>>
>>   "clog_to_syslog_level": "warn",
>>   "clog_to_syslog_facility": "daemon",
>>   "mon_cluster_log_to_syslog": "true",
>>   "mon_cluster_log_to_syslog_level": "warn",
>>   "mon_cluster_log_to_syslog_facility": "daemon",
>>   "mon_cluster_log_file": "\/var\/log\/ceph\/ceph.log",
>>
>> I guess I am missing some option flag or something. Any hint?
>
> Currently the ceph.log gets the log messages unconditionally.  You can set
> mon_cluster_log_file to /dev/null so that only warn and higher goes to
> syslog?
>
> And we should add a mon_cluster_log_level option :)
>
> sage
>
