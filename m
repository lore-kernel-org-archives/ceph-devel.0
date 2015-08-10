From: Sage Weil <sage@newdream.net>
Subject: Re: inconsistent pgs
Date: Mon, 10 Aug 2015 05:32:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508100531290.22099@cobra.newdream.net>
References: <CAJnOFAqRjXcuO0bJN8PSLsnnMhBjYMOTJTFY8T+4Z36LaBiMfg@mail.gmail.com> <alpine.DEB.2.00.1508090712130.22099@cobra.newdream.net> <CAJnOFApACz47rukJpf50sY2hBvLoPM1+ZuSoTyaWXykxprrmtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59965 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbbHJMcg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Aug 2015 08:32:36 -0400
In-Reply-To: <CAJnOFApACz47rukJpf50sY2hBvLoPM1+ZuSoTyaWXykxprrmtA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?KOI8-R?B?68/O09TBztTJziDzwcjJzs/X?= <sakhinov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 10 Aug 2015, ?????????? ??????? wrote:
> Posted 2 files
> 
> ceph-1-rbd_data.3ef8442ae8944a.0000000000000aff
> ceph-post-file: 10cddc98-7177-47d8-9a97-4868856f974b
> 
> ceph-7-rbd_data.3ef8442ae8944a.0000000000000aff
> ceph-post-file: f2861c0a-fc9a-4078-b95c-d5ba3cf6057e
> 
> By the way, file names were found like this
> /var/lib/ceph/osd/ceph-1/current/3.d8_head/DIR_8/DIR_D/DIR_2/rbd\udata.3ef8442ae8944a.0000000000000aff__head_CC49F2D8__3
> /var/lib/ceph/osd/ceph-7/current/3.d8_head/DIR_8/DIR_D/DIR_2/DIR_F/rbd\udata.3ef8442ae8944a.0000000000000aff__head_CC49F2D8__3
> There is "rbd\udata." in the prefix, not "rbd_data.". Don't know if it
> relevant to this case or not. Just FYI.

The file contents differ by exactly one bit (0x0a -> 0x0b).  I would 
look at the other PGs that are coming up inconsistent (ceph pg dump | grep 
inconsistent) and see if there is a pattern to which OSDs they map to.  
Maybe you just have a bad disk?

sage


> 
> ??????? ??????????
> ???.: +7 (909) 945-89-42
> 
> 
> 2015-08-09 17:23 GMT+03:00 Sage Weil <sage@newdream.net>:
> > On Sat, 8 Aug 2015, ?????????? ??????? wrote:
> >> Hi!
> >>
> >> I have a large number of inconsistent pgs 229 of 656, and it's
> >> increasing every hour.
> >> I'm using ceph version 0.94.2 (5fb85614ca8f354284c713a2f9c610860720bbf3).
> >>
> >> For example, pg 3.d8:
> >> # ceph health detail | grep 3.d8
> >> pg 3.d8 is active+clean+scrubbing+deep+inconsistent, acting [1,7]
> >>
> >> # grep 3.d8 /var/log/ceph/ceph-osd.1.log | less -S
> >> 2015-08-07 13:10:48.311810 7f5903f7a700 0 log_channel(cluster) log
> >> [INF] : 3.d8 repair starts 2015-08-07 13:12:05.703084 7f5903f7a700 -1
> >> log_channel(cluster) log [ERR] : repair 3.d8
> >> cbd2d0d8/rbd_data.6a5cf474b0dc51.0000000000000b1f/head//3 on disk data
> >> digest 0x6e4d80bf != 0x6fb5b103 2015-08-07 13:13:26.837524
> >> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : repair 3.d8
> >> b5892d8/rbd_data.dbe674b0dc51.00000000000001b9/head//3 on disk data
> >> digest 0x79082779 != 0x9f102f3d 2015-08-07 13:13:44.874725
> >> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : repair 3.d8
> >> ee6dc2d8/rbd_data.e7592ae8944a.0000000000000833/head//3 on disk data
> >> digest 0x63ab49d0 != 0x68778496 2015-08-07 13:14:19.378582
> >> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : repair 3.d8
> >> d93e14d8/rbd_data.3ef8442ae8944a.0000000000000729/head//3 on disk data
> >> digest 0x3cdb1f5c != 0x4e0400c2 2015-08-07 13:23:38.668080
> >> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : 3.d8 repair 4 errors,
> >> 0 fixed 2015-08-07 13:23:38.714668 7f5903f7a700 0 log_channel(cluster)
> >> log [INF] : 3.d8 deep-scrub starts 2015-08-07 13:25:00.656306
> >> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : deep-scrub 3.d8
> >> cbd2d0d8/rbd_data.6a5cf474b0dc51.0000000000000b1f/head//3 on disk data
> >> digest 0x6e4d80bf != 0x6fb5b103 2015-08-07 13:26:18.775362
> >> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : deep-scrub 3.d8
> >> b5892d8/rbd_data.dbe674b0dc51.00000000000001b9/head//3 on disk data
> >> digest 0x79082779 != 0x9f102f3d 2015-08-07 13:26:42.084218
> >> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : deep-scrub 3.d8
> >> ee6dc2d8/rbd_data.e7592ae8944a.0000000000000833/head//3 on disk data
> >> digest 0x59a6e7e0 != 0x68778496 2015-08-07 13:26:56.495207
> >
> > This indicates the stored crc doesn't match the observed crc,
> > and
> >
> >> 7f5903f7a700 -1 log_channel(cluster) log [ERR] : be_compare_scrubmaps:
> >> 3.d8 shard 1: soid
> >> cc49f2d8/rbd_data.3ef8442ae8944a.0000000000000aff/head//3 data_digest
> >> 0x4e20a792 != known data_digest 0xc0e9b2d2 from auth shard 7
> >
> > this indicates two replicas do not match.
> >
> >> 2015-08-07 13:27:12.134765 7f5903f7a700 -1 log_channel(cluster) log
> >> [ERR] : deep-scrub 3.d8
> >> d93e14d8/rbd_data.3ef8442ae8944a.0000000000000729/head//3 on disk data
> >> digest 0x3cdb1f5c != 0x4e0400c2
> >>
> >> osd.7.log is clean for that period of time.
> >> /var/log/dmesg is also clean.
> >
> > This really shouldn't happen, but there has been one recently fixed bug
> > that could have corrupted a replica.  Can you locate two mismatched copies
> > of some object on two different OSDs, and use ceph-post-file so that we
> > can take a look at the actual corruption?  For this PG, for example, the
> > mismatched copies are on osd.1 and osd.7.  On those hosts, you can find
> > the backing file with
> >
> >  find /var/lib/ceph/osd/ceph-1/current/3.d8_head | grep rbd_data.3ef8442ae8944a.0000000000000aff
> >
> > Alternatively, if the data is sensitive, can you diff the hexdump -C
> > output of both files, see what the differing bytes look like, and describe
> > that to us?
> >
> > Thanks!
> > sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
