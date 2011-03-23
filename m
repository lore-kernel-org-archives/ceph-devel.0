From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: write completion strategy (ack/commit questions)
Date: Wed, 23 Mar 2011 11:40:58 -0700
Message-ID: <3F0201EF1C7C47AAB9E078FAA67803C6@gmail.com>
References: <AANLkTimRxtTAbJ+DyzhEz=3khbv33oohvd6H8HywTeoV@mail.gmail.com>
 <Pine.LNX.4.64.1103231120280.19930@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44353 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150Ab1CWSlD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Mar 2011 14:41:03 -0400
Received: by iwn34 with SMTP id 34so8837946iwn.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Mar 2011 11:41:02 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1103231120280.19930@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Brian Chrisman <brchrisman@gmail.com>

Just a note:
Sage's thesis makes a big deal out of the fact that you can get a rados ack using only in-memory ops. Since the switch away from ebofs, you need to be in parallel journaling mode to get that speed boost and you can only be in parallel mode if you're using btrfs. So if you're using ext* or some other file system you're not going to get faster results anyway.
-Greg
On Wednesday, March 23, 2011 at 11:35 AM, Sage Weil wrote: 
> On Wed, 23 Mar 2011, Brian Chrisman wrote:
> > Regarding section 5.3 of this paper (section titled 'Data Safety')
> > http://www.usenix.org/events/osdi06/tech/full_papers/weil/weil_html/
> > 
> > I've had some discussions recently about what kind of data consistency
> > we can achieve.
> > > From discussions on this list/IRC, it's clear that right now ceph,
> > with a reasonable crushmap, requires an on-disk write to each of two
> > nodes (either a journal or fs write is acceptable) before returning a
> > write completion.
> > The referred section suggests that there may be a way to have a client
> > notified of a write-to-cache-completion instead when the written data
> > is cached on two nodes (but not yet committed to disk) via the 'ack'.
> > 
> > If these acks aren't exposed/used at the ceph layer, are they exposed
> > via librbd, libceph, or librados?
> 
> They are exposed by librados explicitly.
> 
> At the fs layer (libceph, kernel client), the ack is used only when 
> multiple clients are r/w on the same file and i/o goes synchronous. In 
> that case, a write(2) will return when we get the ack and the write is 
> serialized. (A subsequent fsync(2) on the fd won't return until we get 
> the commit.) If the OSD fails before we get the commit, we will resubmit 
> the original write to the new/recovered OSD with the version number we got 
> previously so that the writes will be reapplied in order. This gives you 
> less-horrible shared write performance while preserving the posix 
> write ordering semantics (*).
> 
> For writeback, the fs always waits for the commit.
> 
> Does that answer your question? If you're interested in relaxing safety 
> for _all_ writes, that's something that could be added to the protocol, 
> but I wouldn't recommend it. :)
> 
> sage
> 
> 
> (*) There is one residual issue here when a write spans an object 
> boundary; two racing overlapping writes can get ordered differently on the 
> two different objects. Either locking or a multi-object transaction 
> mechanisms in rados is needed to resolve this. 
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 

