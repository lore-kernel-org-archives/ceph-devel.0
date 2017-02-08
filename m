From: Wido den Hollander <wido@42on.com>
Subject: Re: noout equivalent for temporary OSD rm?
Date: Wed, 8 Feb 2017 15:42:10 +0100 (CET)
Message-ID: <458615874.9455.1486564930377@ox.pcextreme.nl>
References: <CALe9h7d6ftL__1S-mJd6y3GAfDJST1zN+scgqm4gC6T3_qbOiw@mail.gmail.com>
 <alpine.DEB.2.11.1702081419490.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:53663 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbdBHOyB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Feb 2017 09:54:01 -0500
In-Reply-To: <alpine.DEB.2.11.1702081419490.7782@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


> Op 8 februari 2017 om 15:23 schreef Sage Weil <sage@newdream.net>:
> 
> 
> On Wed, 8 Feb 2017, John Spray wrote:
> > So I've just finished upgrading my home cluster OSDs to bluestore by
> > killing them one by one and then letting backfill happen to "new" OSDs
> > on the same drives.  Hooray!
> > 
> > One slightly awkward thing I ran into was that even though I had noout
> > set throughout, during the period between removing the old OSD and
> > adding the "new" one, some PGs would of course get remapped (and start
> > generating backfill IO to third party OSDs).  This does make sense
> > when you think about it (noout doesn't make the cluster magically
> > remember OSDs that have been removed), but is still an undesirable
> > behaviour.
> > 
> > A) Do we currently have a mechanism to tell the cluster "even though I
> > removed this OSD, don't go moving PGs around just yet"?  Should we add
> > one?
> 
> There's 'ceph osd set norebalance'...
> 
> > B) Was there a way for me to avoid this by e.g. skipping the "osd rm
> > X" and "osd crush rm osd.X" that I'm currently doing before adding the
> > new OSD that will take the old OSD's ID?
> 
> This keeps coming up but I don't think we've ever proposed a good 
> solution.  Perhaps the simplest thing is to allow ceph-disk to take an OSD 
> id as an argument.  Normally this is probably a no-no since the OSD might 
> exist elsewhere and have real data on it, and you don't want multiple OSDs 
> with the same id, but we could make this safer by requiring that the 
> OSD be marked 'lost' before it's id can be reused...
> 

Or the OSD should not exist yet? Allowing ceph-disk to re-use a ID and UUID would make it a lot easier when switching from FileStore to BlueStore as well.

ceph-disk --zap-disk -i 0 --uuid XXX-XXXX-XXXX-XXXX prepare /dev/sda

That way you can wipe a existing disk to BlueStore.

Wido

> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
