From: Nathan Cutler <ncutler@suse.cz>
Subject: Jewel 10.2.8 UNBLOCKED (was Re: jewel 10.2.8 status - blocked)
Date: Thu, 22 Jun 2017 08:26:30 +0200
Message-ID: <aefed8a3-b22c-3955-6f95-1af414770acb@suse.cz>
References: <5b7336d6-e7ee-d36d-5272-e807cb17a4b1@suse.cz>
 <CAJ4mKGZ2NjRans3Goj6yb65+2kzkmro3sCA+uRXv8q6xANV=bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50319 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751064AbdFVG0c (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Jun 2017 02:26:32 -0400
In-Reply-To: <CAJ4mKGZ2NjRans3Goj6yb65+2kzkmro3sCA+uRXv8q6xANV=bw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

>> However, as the last jewel rados nightly [1] shows, integration testing will
>> not be possible until we implement a fix for
>> http://tracker.ceph.com/issues/20171
>>
>> Kefu and I looked at that one today - it appears to be a Debian packaging
>> issue which doesn't apply to kraken or master because ceph-create-keys was
>> ripped out in infernalis.
> 
> I'm pretty confused when I look through the ticket. This is apparently
> a new issue; do we have any idea what changed? There seems to be some
> kind of dependency on a running ceph-mds for ceph-create-keys, but the
> cause isn't identified in any way I understand.
> 
> So, uh, what's happening exactly? :)

The short answer is that teuthology was ignoring ceph-create-keys log 
messages by grepping for a certain string, but then Xenial syslog 
suddenly started inserting the PID into the middle of that string.

Kefu opened https://github.com/ceph/teuthology/pull/1084 with a fix.

The larger context is the Debian packaging of the Ceph daemons. In RPM, 
when you install a package containing a ceph daemon, you have to 
explicitly enable/start the corresponding systemd unit file (e.g. 
ceph-mon@.service). In Debian, the mere act of installing the package 
causes the systemd service to start, and this starts the daemon.

So for example when the ceph-mds package is installed in Xenial, the 
"ceph-mds@$HOST.service" file gets started. In jewel, this triggers 
ceph-create-keys which issues that log message when it cannot connect to 
a MON. By the time the cluster gets up and running, lots of these 
messages get logged, but they are harmless.

I have patched my teuthology environment and will proceed with 10.2.8 
integration testing.

Nathan
