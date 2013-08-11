From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: Blueprint: inline data support (step 2)
Date: Sun, 11 Aug 2013 12:29:12 +0800
Message-ID: <52071318.9060200@ubuntukylin.com>
References: <51F855D9.6070306@ubuntukylin.com> <alpine.DEB.2.00.1308091105340.14125@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:47354 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749Ab3HKE3S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Aug 2013 00:29:18 -0400
In-Reply-To: <alpine.DEB.2.00.1308091105340.14125@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,
   I am on holiday, actually including the CDS day:)
   I will take care of it later. Thanks for your comments.

Cheers,
Li Wang

On 08/10/2013 02:18 AM, Sage Weil wrote:
> Hi Li,
>
> Thanks for discussing this at the summit!  As I mentioned, I think email
> will be the easiest way to detail my suggestion for handling the shared
> writer or read/write case.  The notes from the summit are at
>
>    http://pad.ceph.com/p/mds-inline-data
>
> For the single-writer case, it is simple enough for the client to simply
> dirty the buffer with the inline data and write it out with everything
> else.  When it flushes the cap back to the MDS there will be some marker
> (inline_version = 0?) indicating that the data is no longer inlined.
>
> For the multi-writer case:
>
> We normally do reads and writes synchronously to the OSD for simplicity.
> Everything gets ordered there at the object.  I think we can do the same
> for inline data: if there are shared writers, we uninline the data and
> fall back to storing the data in the usual way.
>
> Each writer will have a copy of the *initial* inline data, issued by the
> MDS when they got the capability allowing them to write (or read).
>
> On the *first* read or write operation, the client will first send an
> operation to the object that looks like
>
>    ObjectOperation m;
>    m.create(true);   // exclusive create; fails if object exists
>    m.write_full(initial_inline_data);
>    objecter->mutate(...);
>
> The first client whose op reaches the osd will effectively un-inline the
> data; any others will be no-ops.  This will be immediately followed by
> the actual read or write operation that they are trying to do.
>
> As long as the inline_data size is smaller than the file layout stripe
> unit, this will always be the first object.
>
> When the caps are released to the MDS, if *any* of the clients indicate
> that they uninlined the object, it is uninlined.  (Some clients may not
> have done any IO.)  If a client fails, we need to make the recovery path
> see if the object exists and, if so, drop the inline data.
>
> The one wrinkle I see in this is that the m.create(true) call above isn't
> quite right; the first object will often exist because of the backtrace
> information that the MDS is maintaining (for NFS and future fsck).  We
> need to replace that with some explicit flag on the object that the data
> is inlined, which means some tricky updates and an m.cmpxattr() call.
> Alternatively (and more simply), we can just check if the object has size
> 0.  There isn't a rados op that lets us do that right now, but it is
> pretty simple to add.  cmpsize() or similar.
>
> What do you think?
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
