From: Sage Weil <sage@newdream.net>
Subject: Re: Bluestore and jemalloc
Date: Fri, 15 Dec 2017 15:29:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1712151527090.2838@piezo.novalocal>
References: <42631468-7CF3-4BBC-8984-24756D6F930F@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-804275665-1513351789=:2838"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:58595 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbdLOP3u (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Dec 2017 10:29:50 -0500
In-Reply-To: <42631468-7CF3-4BBC-8984-24756D6F930F@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike A <mike.almateia@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-804275665-1513351789=:2838
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 15 Dec 2017, Mike A wrote:
> Hello!
> 
> After fix this issue http://tracker.ceph.com/issues/20557 Ceph is still 
> working with jemalloc? Or it’s not possible right now only after will be 
> fix a issue in rocksdb?
> 
> I have a work to create a cluster based on nvme disks with jemalloc 
> enabled configuration. Now I'm worried jemalloc support in ceph about.

I'm not sure about the current status of the bug: I don't know why 
jemalloc and rocksdb were not working together, and I'm not sure whether 
the fix is simple (build option?) or more complex.

It's also not clear whether jemalloc is going to be helpful or that this 
is important.  jemalloc was much better than tcmalloc with 
SimpleMessenger, but the default is now AsyncMessenger and there wasn't 
much of a delta.

Either way, jemalloc is a runtime option, so either it works or it 
doesn't, but the fix is to restart the daemons--there's no risk.

sage
--8323329-804275665-1513351789=:2838--
