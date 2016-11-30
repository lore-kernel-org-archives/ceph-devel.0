From: Sage Weil <sage@newdream.net>
Subject: Re: Ceph PG Number
Date: Wed, 30 Nov 2016 14:18:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611301416500.355@piezo.us.to>
References: <CAOmt5rK42=8DcdrkeHgqsY6o2NjaQ+5wWOeZToZNsPd0GtS2ew@mail.gmail.com> <20161130083105.GM26997@predictor>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1808538767-1480515509=:355"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33770 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757063AbcK3OSc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Nov 2016 09:18:32 -0500
In-Reply-To: <20161130083105.GM26997@predictor>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Piotr_Da=B3ek?= <branch@predictor.org.pl>
Cc: Zhen Cao <juehuiconst@gmail.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1808538767-1480515509=:355
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 30 Nov 2016, Piotr Dałek wrote:
> On Wed, Nov 30, 2016 at 04:22:10PM +0800, Zhen Cao wrote:
> > Hi,
> > I am reading the RADOS paper,but i could not understand why more PGs
> > per OSD result in a more balanced distribution.I konw the mapping
> > procedure between oid and osd，but it is neverless difficult to
> > understand for me.
> > Thanks for your help!
> 
> In a nuthshell - because each PG corresponds to multiple objects.
> And because of this, it is possible that some PGs will aggregate more
> objects than other PGs, resulting in lack of acutal balance. Also see here:
> http://docs.ceph.com/docs/jewel/rados/operations/placement-groups/ 

More generally, it's a [pseudo-]random process that puts objects in PGs 
and PGs on OSDs.  If you have a small number of objects, you'll have a 
small number of PG and a large variance (one PG may have 2 objects, 
another 4).  If it's a large number, things will converge toward an 
average (e.g., very close to ~1,000,000 objects per PG).  Same goes for 
PGs distributed to OSDs.  Larger numbers mean a tighter variance.

sage
--8323329-1808538767-1480515509=:355--
