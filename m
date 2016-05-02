From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: building boost statically
Date: Mon, 2 May 2016 12:31:10 -0400
Message-ID: <20160502163109.GB2654@ultraspiritum.redhat.com>
References: <CACJqLyYtBQ8N95BHSH48AD-XexCx+QU9XB8djvomH_rer1tn+w@mail.gmail.com>
 <CALqRxCyQkBPF0t7RcYzhcFZCzEeviAyL+XeQU0Dr+An1Tx5s4Q@mail.gmail.com>
 <alpine.DEB.2.11.1604292137110.26967@cpach.fuggernut.com>
 <BN3PR02MB1206983484A635905E9B630BE8670@BN3PR02MB1206.namprd02.prod.outlook.com>
 <alpine.LSU.2.20.1605010807200.21305@ancalagon.suse.com>
 <alpine.DEB.2.11.1605011113510.26967@cpach.fuggernut.com>
 <20160502032831.GA8719@ultraspiritum.redhat.com>
 <alpine.LSU.2.20.1605020907510.21305@ancalagon.suse.com>
 <20160502161449.GA2654@ultraspiritum.redhat.com>
 <alpine.LSU.2.20.1605020916090.21305@ancalagon.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34519 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624AbcEBQbO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 2 May 2016 12:31:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1605020916090.21305@ancalagon.suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jesse Williamson <jwilliamson@suse.com>
Cc: Sage Weil <sage@newdream.net>, Allen Samuels <Allen.Samuels@sandisk.com>, Ken Dreyer <kdreyer@redhat.com>, Haomai Wang <haomai@xsky.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 02/05/2016, Jesse Williamson wrote:
> Auto-fetching would be nice. One caution against just going with
> greater-than is that some libraries in the Boost project introduce breaking
> changes now and again, so being able to go with a specific version can be
> important.

Specific range maybe?

Or, if we required an exact match, had CMake print out that it is
going to fetch that version rather than using the system Boost, and we
had an option to override and tell it to use the system Boost anyway
that would be good.

That might be a good compromise between a distribution's desire to use
system packages and our desire not to be on the hook for versions
we've never tested against.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
