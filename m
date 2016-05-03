From: "Zhou, Yuan" <yuan.zhou@intel.com>
Subject: RE: mon switch from leveldb to rocksdb
Date: Tue, 3 May 2016 05:25:03 +0000
Message-ID: <06681238D8946F44A60AA400760A1CBF023447C8@SHSMSX103.ccr.corp.intel.com>
References: <alpine.DEB.2.11.1605021444320.26967@cpach.fuggernut.com>
 <1707978395.1022.1462224339784@ox.pcextreme.nl>
 <CAFdRU70KCjhemzL2f2YLKotpVxyarag2WWkTQWny42v6q85dTA@mail.gmail.com>
 <alpine.DEB.2.11.1605021745510.26967@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15913 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755321AbcECFZQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2016 01:25:16 -0400
In-Reply-To: <alpine.DEB.2.11.1605021745510.26967@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, "skinjo@redhat.com" <skinjo@redhat.com>
Cc: Wido den Hollander <wido@42on.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage, 

how about the filestore_omap_backend? It's set to leveldb by default now. Would it be set to rocksdb also?

thanks, -yuan

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Tuesday, May 3, 2016 5:47 AM
To: skinjo@redhat.com
Cc: Wido den Hollander <wido@42on.com>; Ceph Development <ceph-devel@vger.kernel.org>
Subject: Re: mon switch from leveldb to rocksdb

On Tue, 3 May 2016, Shinobu Kinjo wrote:
> If possible, it would be much better to make it pluggable so that we 
> select what we want.

Yeah, that is the plan.  The mon_keyvaluedb will select leveldb or rocksdb.  We'd just switch the default over at some point, once we're satisfied with stability.

After thinking about this some more I agree with Wido that the conversion isn't useful enough to bother with.  We can just make new mons use rocksdb, and if someone wants to convert, they can add/remove/replace mons in their cluster to get there.

sage



> 
> On Tue, May 3, 2016 at 6:25 AM, Wido den Hollander <wido@42on.com> wrote:
> >
> >> Op 2 mei 2016 om 20:49 schreef Sage Weil <sweil@redhat.com>:
> >>
> >>
> >> We're thinking about switching the default backend on the mon from 
> >> leveldb to rocksdb.  Rocksdb is better maintained, has a stronger 
> >> feature set, is generally faster, and is linked statically, which 
> >> means we won't be vulnerable to buggy distro packages.
> >>
> >> There is one blocker, though.  Some distro leveldbs name the sst 
> >> files with the .ldb suffix.  (Some don't; very annoying.)  There is 
> >> a unit test in rocksdb that tries to verify that ldb is silently 
> >> renamed to sst, and it passes, but the test is incomplete: the test 
> >> failes to verify that ldb/sst files can actually be read, and it turns out only the 'check'
> >> path (not the normal open and read it path) handles ldb properly.
> >>
> >> Anyway, once that works, rocksdb will magically upgrade from 
> >> leveldb to rocksdb.  Note that once that happens you can't switch 
> >> from rocksdb back to leveldb without recreating the mon.
> >>
> >> Alternatively, we could not worry about upgrading existing leveldb 
> >> instances and just make newly created mons default to rocksdb.
> >>
> >> 1) Thoughts on moving to rocksdb in general?
> >>
> >> 2) Importance of leveldb->rocksdb conversion?
> >>
> >
> > I would not touch this auto conversion at first. I know there is things to gain, but is it enough to gain that it might be worth while potentially corrupting monitors?
> >
> > Is it that LevelDB doesn't handle large cluster load for example? Imho the majority of Ceph clusters is still far below 500 OSDs.
> >
> > Personally I always try to stay away from touching the MONs datastore. Always feels a bit scary.
> >
> > Wido
> >
> >> 3) Anyone want to fix the ldb handling in rocksdb?
> >>
> >> Thanks!
> >> sage
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe 
> >> ceph-devel" in the body of a message to majordomo@vger.kernel.org 
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> > ceph-devel" in the body of a message to majordomo@vger.kernel.org 
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> --
> Email:
> shinobu@linux.com
> GitHub:
> shinobu-x
> Blog:
> Life with Distributed Computational System based on OpenSource
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
