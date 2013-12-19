From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: enable old OSD snapshot to re-join a cluster
Date: Thu, 19 Dec 2013 05:32:53 -0200
Message-ID: <or8uvh70t6.fsf@livre.home>
References: <orr4kbgbn3.fsf@livre.home>
	<CAPYLRzjG3ws-TJt+XOv0vp-oRuOZti+b1yjBZw_shhmdQE9F4g@mail.gmail.com>
	<orbo0faevz.fsf@livre.home>
	<CAPYLRzg6XCBu4B7P0o25q6oULVUQBzF8Jp4u2ONHtFeeAmqYjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:51381 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab3LSHdY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Dec 2013 02:33:24 -0500
In-Reply-To: <CAPYLRzg6XCBu4B7P0o25q6oULVUQBzF8Jp4u2ONHtFeeAmqYjA@mail.gmail.com>
	(Gregory Farnum's message of "Wed, 18 Dec 2013 11:39:45 -0800")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Dec 18, 2013, Gregory Farnum <greg@inktank.com> wrote:

> On Tue, Dec 17, 2013 at 3:36 AM, Alexandre Oliva <oliva@gnu.org> wrote:
>> Here's an updated version of the patch, that makes it much faster than
>> the earlier version, particularly when the gap between the latest osdmap
>> known by the osd and the earliest osdmap known by the cluster is large.

> Is this actually still necessary in the latest dumpling and emperor
> branches?

I can't tell for sure, I don't recall when I last rolled back to an old
snapshot without this kind of patch.

> I thought sufficiently-old OSDs would go through backfill with the new
> PG members in order to get up-to-date without copying all the data.

That much is true, for sure.  The problem was getting to that point.

If the latest osdmap known by the osd snapshot turns out to be older
than the earliest map known by the monitors, the osd would give up
because it couldn't make the ends meet: no incremental osdmaps were
available in the cluster, and the osd refused to jump over gaps in the
osdmap sequence.  That's why I fudged the unavailable intermediate
osdmaps as clones of the latest one known by the osd: then it would
apply the incremental changes as nops until it got to an actual newer
map, in which it would notice a number of changes, apply them all, and
get on its happy way towards recovery over each of the newer osdmaps ;-)

I can give a try without the patch if you tell me there's any chance the
osd might now be able to jump over gaps in the osdmap sequence.  That
said, the posted patch, ugly as it is, is meant as a stopgap rather than
as a proper solution; dealing with osdmap gaps rather than dying would
be surely a more desirable implementation.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
