From: Sage Weil <sweil@redhat.com>
Subject: Re: ceph-objectstore-tool import failures
Date: Tue, 7 Jul 2015 10:22:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507071020350.13176@cobra.newdream.net>
References: <alpine.DEB.2.00.1506191923200.31501@cobra.newdream.net> <5584D213.80405@redhat.com> <5584DB0E.3000503@redhat.com> <alpine.DEB.2.00.1507061324440.27973@cobra.newdream.net> <559B0FFD.4090306@redhat.com> <alpine.DEB.2.00.1507070958230.13176@cobra.newdream.net>
 <1261554654.41092991.1436289138746.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46050 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932462AbbGGRWe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 7 Jul 2015 13:22:34 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id B77FB35005F
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2015 17:22:34 +0000 (UTC)
In-Reply-To: <1261554654.41092991.1436289138746.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: David Zafman <dzafman@redhat.com>, ceph-devel@vger.kernel.org

On Tue, 7 Jul 2015, Samuel Just wrote:
> If we think we'll want to persist some temp objects later on, probably 
> better to go ahead and export/import them now.
> 
> Replay isn't relevant here since it happens at a lower level.  The 
> ceph_objectstore_tool does do a kind of split during import since it 
> needs to be able to handle the case where the pg was split between the 
> import and the export.  In the event that temp objects need to persist 
> across intervals, we'll have to solve the problem of splitting the temp 
> objects in the osd as well as in the objectstore tool -- probably by 
> creating a class of persistent temp objects with non-fake hashes taken 
> from the corresponding non-temp object.

Yeah.. I suspect the right thing to do is make the temp object hash match 
the eventual target hash.  We can do this now for the temp recovery 
objects (even though they'll be deleted by the OSD).  Presumably the same 
trick will work for recorded transaction objects too, or whatever 
else...

In any case, for now the cot split can just look at hash like it does with 
the non-temp objects and we're good, right?

sage


> -Sam
> 
> ----- Original Message -----
> From: "Sage Weil" <sweil@redhat.com>
> To: "David Zafman" <dzafman@redhat.com>
> Cc: sjust@redhat.com, ceph-devel@vger.kernel.org
> Sent: Tuesday, July 7, 2015 10:00:09 AM
> Subject: Re: ceph-objectstore-tool import failures
> 
> On Mon, 6 Jul 2015, David Zafman wrote:
> > Why import temp objects when clear_temp_objects() will just remove it on osd
> > start-up?
> 
> For now we could get away with skipping them, but I suspect in the future 
> there will be cases where we want to preserve them across restarts (for 
> example, when recording multi-object transactions that are not yet 
> committed).
> 
> > If we need the temp objects for replay purposes, does it matter if a split has
> > occurred after the original export happened?
> 
> The replay should happen before the export... it's below the ObjectStore 
> interface, so I don't think it matters here.  I'm not sure about the split 
> implications, though.  Does the export/import have to do a split, or does 
> it let the OSD do that after it's imported?
> 
> sage
> 
> > Or can we  just import all temporary objects without regards to split and
> > assume that after replay the clear_temp_objects() will
> > clean them up?
> > 
> > David
> > 
> > 
> > On 7/6/15 1:28 PM, Sage Weil wrote:
> > > On Fri, 19 Jun 2015, David Zafman wrote:
> > > > This ghobject_t which has a pool of -3 is part of the export.   This
> > > > caused
> > > > the assert:
> > > > 
> > > > Read -3/1c/temp_recovering_1.1c_33'50_39_head/head
> > > > 
> > > > This was added by "osd: use per-pool temp poolid for temp objects"
> > > > 18eb2a5fea9b0af74a171c3717d1c91766b15f0c in your branch.
> > > > 
> > > > You should skip it on export or recreate it on import with special
> > > > handling.
> > > Ah, that makes sense.  I think we should include these temp objects in the
> > > export, though, and make cot understand that they are part of the pool.
> > > We moved the "clear temp objects on startup" logic into teh OSD, which I
> > > think will be useful for e.g. multiobject transactions (where we'll want
> > > some objects that are internal/hidden to persist across peering intervals
> > > and restarts).
> > > 
> > > Looking at your wip-temp-zafman, I think the first patch needs to be
> > > dropped: include the temp objects, and I assume the meta one (which
> > > has the pg log and other critical pg metadata).
> > > 
> > > Not sure where to change cot to handle the temp objects though?
> > > 
> > > Thanks!
> > > sage
> > > 
> > > 
> > > 
> > > 
> > > > David
> > > > 
> > > > On 6/19/15 7:38 PM, David Zafman wrote:
> > > > > Have not seen this as an assert before.  Given the code below in
> > > > > do_import()
> > > > > of master branch the assert is impossible (?).
> > > > > 
> > > > >    if (!curmap.have_pg_pool(pgid.pgid.m_pool)) {
> > > > >      cerr << "Pool " << pgid.pgid.m_pool << " no longer exists" <<
> > > > > std::endl;
> > > > >      // Special exit code for this error, used by test code
> > > > >      return 10;  // Positive return means exit status
> > > > >    }
> > > > > 
> > > > > 
> > > > > David
> > > > > 
> > > > > On 6/19/15 7:25 PM, Sage Weil wrote:
> > > > > > Hey David,
> > > > > > 
> > > > > > On this run
> > > > > > 
> > > > > >      /a/sage-2015-06-18_15:51:18-rados-wip-temp---basic-multi/939648
> > > > > > 
> > > > > > ceph-objectstore-tool is failing to import a pg because the pool
> > > > > > doesn't
> > > > > > exist.  It looks like the thrasher is doing an export+import and
> > > > > > racing
> > > > > > with a test that is tearing down a pool.  The crash is
> > > > > > 
> > > > > >    ceph version 9.0.1-955-ge274efa
> > > > > > (e274efa450e99a68c02bcb713c8837d7809f1ec3)
> > > > > >    1: ceph-objectstore-tool() [0xa26335]
> > > > > >    2: (()+0xfcb0) [0x7f10cef18cb0]
> > > > > >    3: (gsignal()+0x35) [0x7f10cd5af425]
> > > > > >    4: (abort()+0x17b) [0x7f10cd5b2b8b]
> > > > > >    5: (__gnu_cxx::__verbose_terminate_handler()+0x11d)
> > > > > > [0x7f10cdf0269d]
> > > > > >    6: (()+0xb5846) [0x7f10cdf00846]
> > > > > >    7: (()+0xb5873) [0x7f10cdf00873]
> > > > > >    8: (()+0xb596e) [0x7f10cdf0096e]
> > > > > >    9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > > > > > const*)+0x259) [0xb0ce09]
> > > > > >    10: (ObjectStoreTool::get_object(ObjectStore*, coll_t,
> > > > > > ceph::buffer::list&, OSDMap&, bool*)+0x143f) [0x64829f]
> > > > > >    11: (ObjectStoreTool::do_import(ObjectStore*, OSDSuperblock&, bool,
> > > > > > std::string)+0x13dd) [0x64a62d]
> > > > > >    12: (main()+0x3017) [0x632037]
> > > > > >    13: (__libc_start_main()+0xed) [0x7f10cd59a76d]
> > > > > >    14: ceph-objectstore-tool() [0x639119]
> > > > > > 
> > > > > > I don't think this is related to my branch.. but maybe?  Have you seen
> > > > > > this?  I rebased onto latest master yesterday.
> > > > > > 
> > > > > > sage
> > > > > -- 
> > > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > > 
> > > > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
