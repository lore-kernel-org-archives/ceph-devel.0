From: Ben Rowland <ben.rowland@gmail.com>
Subject: Re: Write Replication on Degraded PGs
Date: Thu, 14 Feb 2013 23:53:05 +0000
Message-ID: <CAEU8emn4FV+00iShH1Jg1CoiC7gu+TkUxnKRiJEW7Vb420Q52A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:40158 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935101Ab3BNXxH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Feb 2013 18:53:07 -0500
Received: by mail-la0-f52.google.com with SMTP id fs12so2809107lab.25
        for <ceph-devel@vger.kernel.org>; Thu, 14 Feb 2013 15:53:05 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

> On 13 Feb 2013 18:16, "Gregory Farnum" <greg@inktank.com> wrote:
> >
> > On Wed, Feb 13, 2013 at 3:40 AM, Ben Rowland <ben.rowland@gmail.com=
> wrote:

> So it sounds from the rest of your post like you'd want to, for each
> pool that RGW uses (it's not just .rgw), run "ceph osd set .rgw
> min_size 2". (and for .rgw.buckets, etc etc)

Thanks, that did the trick. When the number of up OSDs is less than
min_size, writes block for 30s then return http 500. Ceph honours my
crush rule in this case - adding more OSDs to only one of two failure
domains continues to block writes - all well and good!

> > If this is the expected behaviour of Ceph, then it seems to prefer
> > write-availability over read-availability (in this case my data is
> > only stored on 1 OSD, thus a SPOF).  Is there any way to change thi=
s
> > trade-off, e.g. as you can in Cassandra with its write quorums?
>
> I'm not quite sure this is describing it correctly =97 Ceph guarantee=
s
> that anything that's been written to disk will be readable later on,
> and placement groups won't go active if they can't retrieve all data.
> The sort of flexible policies allowed by Cassandra aren't possible
> within Ceph =97 it is a strictly consistent system.

Are objects always readable even if a PG is missing some OSDs, and
where it cannot recover? Example: 2 hosts each with 1 osd, pool
min_size is 2, with a crush rule saying to write to both hosts. I
write a file successfully, then one host goes down, and eventually is
marked 'out'. Is the file readable on the 'up' host (say if I'm
running rgw there?) What if the up host does not have the primary
copy?

=46urthermore, if Ceph is strictly consistent, how would it resolve
possible stale reads? Say, if in the 2 hosts example, the network
connection died, but min_size was set to 1. Would it be possible for
writes to proceed, say making edits to an existing object? Could
readers at the other host see stale data?

Thanks again in advance,

Ben
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
