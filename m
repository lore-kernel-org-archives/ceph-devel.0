From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: building boost statically
Date: Mon, 2 May 2016 12:14:50 -0400
Message-ID: <20160502161449.GA2654@ultraspiritum.redhat.com>
References: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com>
 <CACJqLyYtBQ8N95BHSH48AD-XexCx+QU9XB8djvomH_rer1tn+w@mail.gmail.com>
 <CALqRxCyQkBPF0t7RcYzhcFZCzEeviAyL+XeQU0Dr+An1Tx5s4Q@mail.gmail.com>
 <alpine.DEB.2.11.1604292137110.26967@cpach.fuggernut.com>
 <BN3PR02MB1206983484A635905E9B630BE8670@BN3PR02MB1206.namprd02.prod.outlook.com>
 <alpine.LSU.2.20.1605010807200.21305@ancalagon.suse.com>
 <alpine.DEB.2.11.1605011113510.26967@cpach.fuggernut.com>
 <20160502032831.GA8719@ultraspiritum.redhat.com>
 <alpine.LSU.2.20.1605020907510.21305@ancalagon.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57158 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836AbcEBQOx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 2 May 2016 12:14:53 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1605020907510.21305@ancalagon.suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jesse Williamson <jwilliamson@suse.com>
Cc: Sage Weil <sage@newdream.net>, Allen Samuels <Allen.Samuels@sandisk.com>, Ken Dreyer <kdreyer@redhat.com>, Haomai Wang <haomai@xsky.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 02/05/2016, Jesse Williamson wrote:
> I think that in the long run, rather than bundling or using bcp, it would be
> nice to have cmake/autoconf let you point to the boost version you'd like to
> use.

If we could manage it, that would be my ideal world. Rather than
making it A Submodule, say, if we could have cmake examine the system
boost to see what version it is and, if the version is greater than or
equal to the required version, just use it. Otherwise just fetch the
required version and build against it statically.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
