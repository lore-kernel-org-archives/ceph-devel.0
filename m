From: Sage Weil <sweil@redhat.com>
Subject: Re: BlueFS per counter
Date: Thu, 13 Oct 2016 19:18:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610131914530.19763@piezo.us.to>
References: <BY2PR02MB396B782E390FC09E10A8E97F4DC0@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756654AbcJMTUj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 13 Oct 2016 15:20:39 -0400
In-Reply-To: <BY2PR02MB396B782E390FC09E10A8E97F4DC0@BY2PR02MB396.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "Mark Nelson (mnelson@redhat.com)" <mnelson@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 13 Oct 2016, Somnath Roy wrote:
> Sage,
> I found the following counters are tracking (from _flush_range()) the number of WAL and SST writes happening in rocksdb. Based on the today's discussion on characterizing rocksdb write pattern, isn't these two counters are helpful ?
> 
> l_bluefs_bytes_written_wal
> l_bluefs_bytes_written_sst

Maybe, but I *think* want we want to know is how much wal data is ending 
up in the level0 (or later) sst files.  I don't think there is a way to do 
that except to go and look at the level0 files and see how many key/value 
data has the wal prefix ("L\0").  I don't think it's even very easy to 
tell from bluefs files which sst files are l0.. probably need to parse the 
manifest to see that.  This should be possible by exporting the bluefs 
data, though, which should be possible with the ceph-bluefs-tool.

sage
