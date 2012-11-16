From: Samuel Just <sam.just@inktank.com>
Subject: Re: osd server hardware requirements
Date: Fri, 16 Nov 2012 14:00:25 -0800
Message-ID: <CA+4uBUZ+-47w64NmYCehoLvnEo1EOq5-hRQexOW7LPH0-gbG5Q@mail.gmail.com>
References: <DC700C5A3AE74041B17F41EE35500AB90C8984EC@SACEXCMBX03-PRD.hq.netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:65527 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab2KPWA0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Nov 2012 17:00:26 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so3349876vcb.19
        for <ceph-devel@vger.kernel.org>; Fri, 16 Nov 2012 14:00:26 -0800 (PST)
In-Reply-To: <DC700C5A3AE74041B17F41EE35500AB90C8984EC@SACEXCMBX03-PRD.hq.netapp.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Snider, Tim" <Tim.Snider@netapp.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We've heard that 1ghz+1GB or so per osd is sufficient.  So in your
case, around 8 osds.  It's likely that you could go even a bit
further, since memory is usually more constrained than cpu.  Note that
memory and processor use during recovery can be considerable higher
than during normal operation, so you'll want to test your
configuration under recovery.
-Sam

On Fri, Nov 16, 2012 at 9:40 AM, Snider, Tim <Tim.Snider@netapp.com> wrote:
>
> I'm starting to look at Ceph and was wondering if anyone had a link to more specific OSD server guidelines WRT processor speed and memory requirements.
> My candidate server had an Intel processor  2.13 GHz quad core processor and supports up to 24Gb of memory.
> I'm wondering about the approximate number of OSDs that this type of processor and memory might support. The wording on the hw recommendations webpage: http://ceph.com/docs/master/install/hardware-recommendations/  is fairly generic.
>
> Thanks,
> Tim
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
