From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: building boost statically
Date: Sun, 1 May 2016 23:28:32 -0400
Message-ID: <20160502032831.GA8719@ultraspiritum.redhat.com>
References: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com>
 <CACJqLyYtBQ8N95BHSH48AD-XexCx+QU9XB8djvomH_rer1tn+w@mail.gmail.com>
 <CALqRxCyQkBPF0t7RcYzhcFZCzEeviAyL+XeQU0Dr+An1Tx5s4Q@mail.gmail.com>
 <alpine.DEB.2.11.1604292137110.26967@cpach.fuggernut.com>
 <BN3PR02MB1206983484A635905E9B630BE8670@BN3PR02MB1206.namprd02.prod.outlook.com>
 <alpine.LSU.2.20.1605010807200.21305@ancalagon.suse.com>
 <alpine.DEB.2.11.1605011113510.26967@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51757 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736AbcEBD2j (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 1 May 2016 23:28:39 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1605011113510.26967@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Jesse Williamson <jwilliamson@suse.com>, Allen Samuels <Allen.Samuels@sandisk.com>, Ken Dreyer <kdreyer@redhat.com>, Haomai Wang <haomai@xsky.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/05/2016, Sage Weil wrote:
> Given that this is the only piece we want immediately (that i know of), 
> that there would be significant work to either pull boost inline as a 
> submodule *or* to build and ship a proper package, let's go the bcp route 
> for now.
> 
> Jesse, is this something you can tackle?
> 

I'm not sure if I like this idea. There are other places where I've
wanted to use something newer than the boost on Trusty Tahr/RHEL7, like
the newer intrusive_ptr. Some other people have mentioned wishing for
newer boost functionality, too.

If we're going to bundle anything at all, I'd rather we bundle the
whole thing so we get the full advantage of trying to swallow the extra
capacity. BCP sounds like we're signing up for just as much work and
maintenance burden and doesn't give us the full benefit.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
