From: Loic Dachary <loic@dachary.org>
Subject: Re: udev remove events to mark OSD down/out on disk-pull
Date: Wed, 16 Nov 2016 08:05:42 +0100
Message-ID: <a7537544-798b-bdbe-866c-eae740b4d53b@dachary.org>
References: <20161116033042.68eee001@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60351 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933444AbcKPHFs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Nov 2016 02:05:48 -0500
In-Reply-To: <20161116033042.68eee001@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>, ceph-devel <ceph-devel@vger.kernel.org>

Hi David,

How would you distinguish a udev remove occuring because the disk was pulled from a udev remove occuring because partprobe was run by a user / utility program ?

Cheers

On 16/11/2016 03:30, David Disseldorp wrote:
> Hi,
> 
> I'm currently looking at ways to speed up OSD down/out notifications
> for disk-pull events, and was investigating using udev remove events
> for this.
> 
> IIUC, the outage currently propagates through to the mons via OSD device
> I/O error -> filestore I/O error ->  ceph-osd ceph_abort() -> heartbeat
> failure.
> 
> For the disk-pull case, this should be relatively easy to speed up
> by handling the remove event in 95-ceph-osd.rules with an appropriate
> osd down/out PDU. The problem then becomes maintaining consistent
> information in the udev database (all stashed via IMPORT{program}):
> - cluster / OSD ids
> - appropriate cephx creds
> 
> Before I hack something up for this, I'm interested in what others
> think, and whether anyone has already gone down this path. I seem to
> recall someone attempting to change the ceph-osd behaviour on I/O
> error at some stage.
> 
> Cheers, David
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
