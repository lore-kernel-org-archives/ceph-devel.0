From: Andrey Stepachev <octo47@gmail.com>
Subject: Re: How to remove lost objects.
Date: Thu, 19 Jan 2012 09:48:41 +0400
Message-ID: <CAADCt4JuNJqPuAOhpoQN4f56cW+krimjcz0fbB=BSPPxi1cN3w@mail.gmail.com>
References: <CAADCt4KfW7JS59ev_T4L3VMvmQm+OquD-8L7NTKS9u2RjNMPKg@mail.gmail.com>
 <CAORUGqAj-2k+8cvzxwVwDb32upEdv_FFAc96-05fiyVRF3qE6g@mail.gmail.com>
 <CAADCt4JEEjhmsKem2M0-7auyx5wh2UGd7YLAtDYhiofkFSkkoA@mail.gmail.com>
 <CAORUGqCmhjMh6YpsS_5uaKh9OxHjoqwWSXhnZTh2JD5vpixvPw@mail.gmail.com>
 <CAADCt4LJY5LTqCcSv2XegEUvoRFJmrVFbE9gZzyAUVkAWwdDpg@mail.gmail.com> <CAORUGqCXBZiADpz_y=dROMJRWn++Ae6g6eVJ6HCLdPpw0HmbRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:53792 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645Ab2ASFtD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jan 2012 00:49:03 -0500
Received: by wics10 with SMTP id s10so92676wic.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jan 2012 21:49:01 -0800 (PST)
In-Reply-To: <CAORUGqCXBZiADpz_y=dROMJRWn++Ae6g6eVJ6HCLdPpw0HmbRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

2012/1/19 Tommi Virtanen <tommi.virtanen@dreamhost.com>:
> On Wed, Jan 18, 2012 at 13:57, Andrey Stepachev <octo47@gmail.com> wrote:
>> Thanks for clarification. I don't dig yet, how data moved when osd
>> marked as out and how pg calculated for this data. (in other words,
>> how new place for missing replica calculated, and what happens,
>> when out osd returns back)
>
> That would be the CRUSH algorithm just getting a different cluster
> state as input, and thus deciding on a new location for (some of) the
> data. At that point, any data that needs to be migrated, would be
> migrated. If the same osd id returns (on new hardware or old), once
> it's marked "in", the CRUSH algorithm will again start placing data on
> it. Whether that's the same set of data or not depends on whether
> anything else changed in the cluster, in the meanwhile.
>
> Currently, CRUSH is best described in the academic papers about Ceph.
> There's a quick braindump/simplified explanation at
> http://ceph.newdream.net/docs/latest/dev/placement-group/

Thanks. I'll red that.

>
>> We don't try to use Ceph in true WAN. But we try to find some dfs, which will
>> operate well in our environment: multiple dc, relatively low latency
>> (<10ms as average),
>> irregular dc outages. And we need synchronous replication and we need
>> bigtable (hbase in case of ceph).
>> I believe, that ceph can be configured to operate in such environment, but
>> I can be completely wrong. And I try to check some boundary conditions.
>
> As long as you understand that network blip translates to storage
> blip, with Ceph. That is, we don't just write to master and hope that
> replication catches up at some later time.

Yes, but in case of dc outage with master, no writes possible at all.
So I try to trade some dfs perfomance for HA in several dc.

>
>> Yeah, it is good to see some progress (like mdadm shows), but it is not
>> critical. Can you point me, who does this job. MDS?
>
> This is answered in http://ceph.newdream.net/docs/latest/dev/delayed-delete/

Looks like this is a prime place, where to read. Not wiki. Thanks,
I'll read whole docs.


-- 
Andrey.
