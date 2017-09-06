From: Sage Weil <sweil@redhat.com>
Subject: Re: send more reads on recovery
Date: Wed, 6 Sep 2017 13:25:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709061325350.16664@piezo.novalocal>
References: <4a5ef825-83bb-5e7c-7712-73c0a83dd4ac@gmail.com> <024e050a-fa5a-10c8-8abf-942621e9ab2c@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754357AbdIFNZu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 6 Sep 2017 09:25:50 -0400
In-Reply-To: <024e050a-fa5a-10c8-8abf-942621e9ab2c@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Linux Chips <linux.chips@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, dzafman@redhat.com

On Wed, 6 Sep 2017, Linux Chips wrote:
> Hi david,
> 
> I noticed you closed the bug as "won't fix". though I agree on the reason
> being a corrupted level db. but the osd should not just assert and crash due
> to a corruption in one of the files, which may happen, and had happened many
> times in our cluster, due to many reasons including hdd failures. I have
> already fixed most of the problem with the patch below. the cluster has now
> fully recovered, though there are lots of scrub errors. repair is still in
> progress. I ll report with more info if we have any problem due to this patch.
> while I was testing, I noticed the patch also can send more reads if an error
> should occur in the sub_read.
> 
> while this patch will not fix the underlying reason, but it make the OSD more
> resilient to errors.

This is a tricky issue--we need to be very careful. Yes, if there is a 
well-understood inconsistency, we should ideally repair it.  If there is 
some general corruption, though, we need to very careful about trying to 
scavenge what we can to recover because it won't be clear what the full 
extent or nature of the corruption is.  As an example, if leveldb were to 
have random keys that are missing or stale, that could make one OSD think 
that it has all objects when it really doesn't, and that could then 
propagate to other OSDs during recovery/rebalancing and make things even 
worse.

That's why most of the time, when something isn't right, we simply stop.

On the other hand, if there is a well-understood bug or flaw that 
introduced a certain type of inconsistency, we can build in automatic or 
admin-driven repair.

Then there is a huge range of situations that are somewhere in between...

> I am still willing to complete this if you have anything else to add to or
> note. as I am not that knowledgeable in the internals of the code, there may
> be a better way of doing this, so any directions or comments that may help
> make this better are welcomed.
> 
> also, I am not sure of the form and shape of the a contribution that will get
> accepted. I ll read the docs once we are out of this mess, but notes about
> this are also welcomed.

I think with a repair method such as this, we might incorporate the 
cod upstream, but we would need to hide it behind a config option, 
like osd_danger_repair_ec_foo so that it can be used as a last-ditch 
repair effort but not automatically kick in when some 
similar-looking-but-not-quite-the-same situation arises.

I haven't had time to look at this case closely, but it looks like its 
dealing with differently-sized shards.  Is that due to the EC metadata 
attrs (stored in leveldb) being stale due to the corruption?

Thanks!
sage


> 
> thanks
> 
> On 09/04/2017 03:09 PM, Linux Chips wrote:
> > Hi,
> > 
> > since we had the last issue in our cluster.
> > https://marc.info/?t=150297924500005&r=1&w=2
> > 
> > we had all sorts of files being partially written to disk due to lots of
> > crashes, or not sure for what every reason. we reported it here:
> > http://tracker.ceph.com/issues/21173
> > and probably related or same as this
> > http://tracker.ceph.com/issues/14009
> > we had exactly the same trace and same assert
> > 
> > we had thousands of them, we could remove those corrupted shards manually,
> > but that was not practical.
> > 
> > and being hit by this previously, I decided to try and patch it (my first
> > time patching ceph, so excuse my mistakes) and any comments are welcomed. I
> > basically borrowed code from the redundant/fast read block, and I m not sure
> > if i satisfied the "TODO" above in the same function.
> > 
> > 
> > --- ceph-12.2.0/src/osd/ECBackend.cc    2017-08-28 12:30:20.000000000 -0400
> > +++ ceph-12.2.0/src/osd/ECBackend.cc    2017-09-01 08:55:38.209400108 -0400
> > @@ -402,10 +402,13 @@
> >       target[*i] = &(op.returned_data[*i]);
> >     }
> >     map<int, bufferlist> from;
> > +  uint64_t size = to_read.get<2>().begin()->second.length();
> >     for(map<pg_shard_t, bufferlist>::iterator i = to_read.get<2>().begin();
> >         i != to_read.get<2>().end();
> >         ++i) {
> > -    from[i->first.shard].claim(i->second);
> > +      if (size == i->second.length() ) {
> > +        from[i->first.shard].claim(i->second);
> > +      }
> >     }
> >     dout(10) << __func__ << ": " << from << dendl;
> >     int r = ECUtil::decode(sinfo, ec_impl, from, target);
> > @@ -1247,7 +1250,93 @@
> >     if (rop.in_progress.empty() || is_complete == rop.complete.size()) {
> >       dout(20) << __func__ << " Complete: " << rop << dendl;
> >       rop.trace.event("ec read complete");
> > -    complete_read_op(rop, m);
> > +
> > +    // send more reads if recovery needs them
> > +    bool size_mismatched = false;
> > +    bool sent_for_more = false;
> > +    for (map<hobject_t, read_result_t>::const_iterator iter =
> > +        rop.complete.begin();
> > +      iter != rop.complete.end();
> > +      ++iter) {
> > +      uint64_t total_data_size =
> > iter->second.returned.front().get<2>().begin()->second.length();
> > +      set<int> have;
> > +      for (map<pg_shard_t, bufferlist>::const_iterator j =
> > +          iter->second.returned.front().get<2>().begin();
> > +        j != iter->second.returned.front().get<2>().end();
> > +        ++j) {
> > +
> > +       if ( j->second.length() == total_data_size ) {
> > +         have.insert(j->first.shard);
> > +       } else {
> > +         size_mismatched = true;
> > +         dout(0) << __func__ << " Checking Complete: [ERR] shard " <<
> > j->first.shard << " has mismatched size: " << j->second.length() << " != "
> > << total_data_size << ". " << rop << dendl;
> > +       }
> > +      }
> > +
> > +      // one or more shards have different size. corrupted?! maybe a
> > crashed node or oom kill.
> > +      set<int> want_to_read, dummy_minimum;
> > +      int err;
> > +      if (size_mismatched || true) {   // not sure if we always should
> > check this, may be check for read op errors too
> > +//      if (size_mismatched) {
> > +        get_want_to_read_shards(&want_to_read);
> > +        if ((err = ec_impl->minimum_to_decode(want_to_read, have,
> > &dummy_minimum)) < 0) {
> > +         dout(20) << __func__ << " minimum_to_decode failed,  we only have
> > shards " << have << dendl;
> > +          if (rop.in_progress.empty()) {
> > +         // If we don't have enough copies and we haven't sent reads for
> > all shards
> > +         // we can send the rest of the reads, if any.
> > +           if (!rop.do_redundant_reads) {
> > +             dout(10) << __func__ << ": sending for more reads" << dendl;
> > +             int r = send_all_remaining_reads(iter->first, rop);
> > +             if (r == 0) {
> > +               sent_for_more = true;
> > +               continue;
> > +             }
> > +           // Couldn't read any additional shards so handle as completed
> > with errors
> > +           }
> > +           // We don't want to confuse clients / RBD with objectstore error
> > +           // values in particular ENOENT.  We may have different error
> > returns
> > +           // from different shards, so we'll return minimum_to_decode()
> > error
> > +           // (usually EIO) to reader.  It is likely an error here is due
> > to a
> > +           // damaged pg.
> > +           rop.complete[iter->first].r = err;
> > +         }
> > +        } else {
> > +         dout(20) << __func__ << " minimum_to_decode succeeded " <<
> > dummy_minimum << dendl;
> > +          assert(rop.complete[iter->first].r == 0);
> > +         if (!rop.complete[iter->first].errors.empty()) {
> > +           if (cct->_conf->osd_read_ec_check_for_errors) {
> > +             dout(10) << __func__ << ": Not ignoring errors, use one shard
> > err=" << err << dendl;
> > +             err = rop.complete[iter->first].errors.begin()->second;
> > +              rop.complete[iter->first].r = err;
> > +             dout(10) << __func__ << ": Not ignoring errors 2, use one
> > shard err=" << err << dendl;
> > +           } else {
> > +             get_parent()->clog_warn() << "Error(s) ignored for "
> > +                                      << iter->first << " enough copies
> > available";
> > +             dout(10) << __func__ << " Error(s) ignored for " <<
> > iter->first
> > +                    << " enough copies available" << dendl;
> > +             rop.complete[iter->first].errors.clear();
> > +           }
> > +         }
> > +//       ++is_complete;
> > +        }
> > +      } else {
> > +       dout(10) << __func__ << " Checking Complete: all shards are the same
> > size" << dendl;
> > +      }
> > +    }
> > +    if (!sent_for_more) {
> > +      complete_read_op(rop, m);
> > +    } else {
> > +      dout(10) << __func__ << " readop needed more reads: " << rop <<
> > dendl;
> > +    }
> >     } else {
> >       dout(10) << __func__ << " readop not complete: " << rop << dendl;
> >     }
> > 
> > 
> > 
> > the patch is not perfect, I had few improvements in mind after deployment,
> > but since i deployed the patch to our cluster and we do not want to
> > interrupt the recovery (been recovering for the past 3 days with this
> > patch). so i ll not have the chance to test it again since I could not
> > replicate the same error in a test cluster.
> > truncating any file in our test cluster, or touching it in any way,
> > generated a read error in the sub read op. while I can clearly see the sub
> > read op in the production cluster reporting success with incorrect size! if
> > any one had an idea on how to replicate this i d very much like to finish
> > this patch properly. if you need this in any other form or a pull request i
> > ll be more than happy to do it.
> > 
> > the caveats we saw in this patch until now; if the shard getting compared to
> > is the wrong/corrupted one, the op fail and we get "failed_push" error. and
> > if the primary osd had a corrupted shard, the reconstruction of the chunk
> > will fail and we get
> > FAILED assert(pop.data.length() ==
> > sinfo.aligned_logical_offset_to_chunk_offset(
> > after_progress.data_recovered_to - op.recovery_progress.data_recovered_to))
> > but those are way more less than dealing with every shard.
> > 
> > may be it needs more sophisticated way of knowing which shard to compare to
> > (may be find distinct sizes and count them, then take the largest count)
> > 
> > thanks
> > ali
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
