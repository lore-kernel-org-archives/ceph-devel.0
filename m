From: Sage Weil <sage@newdream.net>
Subject: Re: Bug #21040
Date: Thu, 7 Dec 2017 18:47:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1712071843250.5536@piezo.novalocal>
References: <42b5b5e6-7cd8-b079-a72e-36e6fa097db7@suse.de> <alpine.DEB.2.11.1712061542030.5536@piezo.novalocal> <700cce26-1c6b-47a5-6419-c741ae2103e8@suse.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1488733753-1512672461=:5536"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:40479 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbdLGSrm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Dec 2017 13:47:42 -0500
In-Reply-To: <700cce26-1c6b-47a5-6419-c741ae2103e8@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@suse.de>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1488733753-1512672461=:5536
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

[Adding ceph-devel]

On Thu, 7 Dec 2017, Igor Fedotov wrote:
> OK, got it. Thanks!
> 
> Here is the initial list of potential breakage cases and repair actions we can
> start with:
> 
> 1) Expected(real) vs. tracked StatFS mismatch. Fix action - update KV to the
> real values.
> 
> 2) Missed shared blob record (but referring blobs are consistent). Fix -
> recreate shared blob record

Should double check the existing checks verify the extents are alloctaed 
by these objects and not any others.  (I think this is the case!)

> 3) Shared blob record is inconsistent (expected != tracked) with referring
> blobs but blobs themselves are consistent). Fix - update shared blob record.
> 
> 4) Bad shared blob record key (get_key_shared_blob() returns an error) -
> remove the record
> 
> 5) Stray shared blob record - remove the record

And, again, verify the extents are consistent (not allocated).
 
> 6) Multiple blobs refer  the same pextent ("extent or a subset is already
> allocated") but their shared_blobs info (including shared flag itself) is
> missed/inconsistent.
> 
>    6.1) Referring blobs have consistent attributes (the same
> collection(pool?), compression/csum flags, csum values etc). Csum values match
> the actual data. Fix - attach properly configured shared_blob and mark blobs
> as shared.
> 
>   6.2) Referring blobs have inconsistent attributes. Don't see the perfect
> path to fix that. May be something like that: split/duplicate intersected
> pextents and update corresponding references to them along with csums while
> leaving other blob attributes as-is?

This is what I was thinking before: allocate new extents and update the 
blobs to point to those (no longer shared) extents.  One or more of the 
objects may then fail a csum, but at least it is confined to the one 
object so the OSD repair can clean it up.

> What do you think? Anything to add?

This is a great list and a fine start! :)

sage


> 
> Igor
> 
> 
> On 12/6/2017 6:43 PM, Sage Weil wrote:
> > Yeah, the bug is fixed, but we don't have a way to repair stores that got
> > into the broken state (due to this or similar bugs).  What I think we need
> > is for fsck(repair=true) to be able to fix it when the sharedblob refs are
> > wrong.
> > 
> > In this case, the bug caused all replicas to be corrupted in teh same way,
> > so there was no clear way for them to recover from the situation.
> > 
> > s
> > 
> > 
> > On Wed, 6 Dec 2017, Igor Fedotov wrote:
> > 
> > > Hi Sage,
> > > 
> > > AFAIR last week you asked me to take a look at the subj
> > > http://tracker.ceph.com/issues/21040
> > > 
> > > I checked available materials and it looks like your suggestion that it
> > > duplicates http://tracker.ceph.com/issues/20983
> > > 
> > > is valid. Probably except the last notes from Wang Guogin who might
> > > experience
> > > a different issue.
> > > 
> > > Would you please clarify if you wanted me to anything else on that bug.
> > > 
> > > 
> > > Thanks,
> > > 
> > > Igor
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> 
> 
--8323329-1488733753-1512672461=:5536--
