From: Jesse Williamson <jwilliamson@suse.com>
Subject: Re: building boost statically
Date: Mon, 2 May 2016 09:18:02 -0700 (PDT)
Message-ID: <alpine.LSU.2.20.1605020916090.21305@ancalagon.suse.com>
References: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com> <CACJqLyYtBQ8N95BHSH48AD-XexCx+QU9XB8djvomH_rer1tn+w@mail.gmail.com> <CALqRxCyQkBPF0t7RcYzhcFZCzEeviAyL+XeQU0Dr+An1Tx5s4Q@mail.gmail.com> <alpine.DEB.2.11.1604292137110.26967@cpach.fuggernut.com>
 <BN3PR02MB1206983484A635905E9B630BE8670@BN3PR02MB1206.namprd02.prod.outlook.com> <alpine.LSU.2.20.1605010807200.21305@ancalagon.suse.com> <alpine.DEB.2.11.1605011113510.26967@cpach.fuggernut.com> <20160502032831.GA8719@ultraspiritum.redhat.com>
 <alpine.LSU.2.20.1605020907510.21305@ancalagon.suse.com> <20160502161449.GA2654@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:58831 "EHLO
	prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbcEBQSI (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 2 May 2016 12:18:08 -0400
In-Reply-To: <20160502161449.GA2654@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Allen Samuels <Allen.Samuels@sandisk.com>, Ken Dreyer <kdreyer@redhat.com>, Haomai Wang <haomai@xsky.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 2 May 2016, Adam C. Emerson wrote:

> If we could manage it, that would be my ideal world. Rather than
> making it A Submodule, say, if we could have cmake examine the system
> boost to see what version it is and, if the version is greater than or
> equal to the required version, just use it. Otherwise just fetch the
> required version and build against it statically.

Auto-fetching would be nice. One caution against just going with 
greater-than is that some libraries in the Boost project introduce 
breaking changes now and again, so being able to go with a specific 
version can be important.

-Jesse

