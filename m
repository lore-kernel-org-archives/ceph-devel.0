From: Venkateswara Rao Jujjuri <jujjuri@gmail.com>
Subject: Re: newstore performance update
Date: Tue, 28 Apr 2015 17:00:20 -0700
Message-ID: <CAKKTCLX31EBc8oOs6tVVRu4c5prUYD=3G=8fK3pMvLQTM+1iSQ@mail.gmail.com>
References: <554016E2.3000104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36517 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031105AbbD2AAl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Apr 2015 20:00:41 -0400
Received: by oift201 with SMTP id t201so9512226oif.3
        for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 17:00:40 -0700 (PDT)
In-Reply-To: <554016E2.3000104@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks for sharing; newstore numbers look lot better;

Wondering if we have any base line numbers to put things into perspective.
like what is it on XFS or on librados?

JV

On Tue, Apr 28, 2015 at 4:25 PM, Mark Nelson <mnelson@redhat.com> wrote:
> Hi Guys,
>
> Sage has been furiously working away at fixing bugs in newstore and
> improving performance.  Specifically we've been focused on write performance
> as newstore was lagging filestore but quite a bit previously.  A lot of work
> has gone into implementing libaio behind the scenes and as a result
> performance on spinning disks with SSD WAL (and SSD backed rocksdb) has
> improved pretty dramatically. It's now often beating filestore:
>
> http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf
>
> On the other hand, sequential writes are slower than random writes when the
> OSD, DB, and WAL are all on the same device be it a spinning disk or SSD.
> In this situation newstore does better with random writes and sometimes
> beats filestore (such as in the everything-on-spinning disk tests, and when
> IO sizes are small in the everything-on-ssd tests).
>
> Newstore is changing daily so keep in mind that these results are almost
> assuredly going to change.  An interesting area of investigation will be why
> sequential writes are slower than random writes, and whether or not we are
> being limited by rocksdb ingest speed and how.
>
> I've also uploaded a quick perf call-graph I grabbed during the "all-SSD"
> 32KB sequential write test to see if rocksdb was starving one of the cores,
> but found something that looks quite a bit different:
>
> http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf
>
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jvrao
---
First they ignore you, then they laugh at you, then they fight you,
then you win. - Mahatma Gandhi
