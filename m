From: Jesse Williamson <jwilliamson@suse.com>
Subject: RE: building boost statically
Date: Sun, 1 May 2016 08:08:32 -0700 (PDT)
Message-ID: <alpine.LSU.2.20.1605010807200.21305@ancalagon.suse.com>
References: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com> <CACJqLyYtBQ8N95BHSH48AD-XexCx+QU9XB8djvomH_rer1tn+w@mail.gmail.com> <CALqRxCyQkBPF0t7RcYzhcFZCzEeviAyL+XeQU0Dr+An1Tx5s4Q@mail.gmail.com> <alpine.DEB.2.11.1604292137110.26967@cpach.fuggernut.com>
 <BN3PR02MB1206983484A635905E9B630BE8670@BN3PR02MB1206.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from prv3-mh.provo.novell.com ([137.65.250.26]:42914 "EHLO
	prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbcEAPIo (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Sun, 1 May 2016 11:08:44 -0400
In-Reply-To: <BN3PR02MB1206983484A635905E9B630BE8670@BN3PR02MB1206.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Sage Weil <sage@newdream.net>, Ken Dreyer <kdreyer@redhat.com>, Haomai Wang <haomai@xsky.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 30 Apr 2016, Allen Samuels wrote:

> Let's not wait.
>
> As another option. If all we're looking for is "small_vector", then I 
> looked at taking the equivalent out of the Folly library a while ago. It 
> looked like it would be relatively easy to hack up the one header file 
> to make it standalone.

There's a utility in boost, "bcp", that might be useful:

http://www.boost.org/doc/libs/1_60_0/tools/bcp/doc/html/index.html

-Jesse
