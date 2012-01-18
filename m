From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: How to remove lost objects.
Date: Wed, 18 Jan 2012 14:18:57 -0800
Message-ID: <CAORUGqCXBZiADpz_y=dROMJRWn++Ae6g6eVJ6HCLdPpw0HmbRQ@mail.gmail.com>
References: <CAADCt4KfW7JS59ev_T4L3VMvmQm+OquD-8L7NTKS9u2RjNMPKg@mail.gmail.com>
 <CAORUGqAj-2k+8cvzxwVwDb32upEdv_FFAc96-05fiyVRF3qE6g@mail.gmail.com>
 <CAADCt4JEEjhmsKem2M0-7auyx5wh2UGd7YLAtDYhiofkFSkkoA@mail.gmail.com>
 <CAORUGqCmhjMh6YpsS_5uaKh9OxHjoqwWSXhnZTh2JD5vpixvPw@mail.gmail.com> <CAADCt4LJY5LTqCcSv2XegEUvoRFJmrVFbE9gZzyAUVkAWwdDpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:34682 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775Ab2ARWTT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jan 2012 17:19:19 -0500
Received: by werb13 with SMTP id b13so764826wer.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jan 2012 14:19:18 -0800 (PST)
In-Reply-To: <CAADCt4LJY5LTqCcSv2XegEUvoRFJmrVFbE9gZzyAUVkAWwdDpg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Stepachev <octo47@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jan 18, 2012 at 13:57, Andrey Stepachev <octo47@gmail.com> wrote:
> Thanks for clarification. I don't dig yet, how data moved when osd
> marked as out and how pg calculated for this data. (in other words,
> how new place for missing replica calculated, and what happens,
> when out osd returns back)

That would be the CRUSH algorithm just getting a different cluster
state as input, and thus deciding on a new location for (some of) the
data. At that point, any data that needs to be migrated, would be
migrated. If the same osd id returns (on new hardware or old), once
it's marked "in", the CRUSH algorithm will again start placing data on
it. Whether that's the same set of data or not depends on whether
anything else changed in the cluster, in the meanwhile.

Currently, CRUSH is best described in the academic papers about Ceph.
There's a quick braindump/simplified explanation at
http://ceph.newdream.net/docs/latest/dev/placement-group/

> We don't try to use Ceph in true WAN. But we try to find some dfs, which will
> operate well in our environment: multiple dc, relatively low latency
> (<10ms as average),
> irregular dc outages. And we need synchronous replication and we need
> bigtable (hbase in case of ceph).
> I believe, that ceph can be configured to operate in such environment, but
> I can be completely wrong. And I try to check some boundary conditions.

As long as you understand that network blip translates to storage
blip, with Ceph. That is, we don't just write to master and hope that
replication catches up at some later time.

> Yeah, it is good to see some progress (like mdadm shows), but it is not
> critical. Can you point me, who does this job. MDS?

This is answered in http://ceph.newdream.net/docs/latest/dev/delayed-delete/
