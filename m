From: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Subject: RE: Could we introduce launchpad/gerrit for ceph
Date: Fri, 9 Aug 2013 13:58:02 +0000
Message-ID: <6F3FA899187F0043BA1827A69DA2F7CC01E55325@SHSMSX102.ccr.corp.intel.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC01E54E02@SHSMSX102.ccr.corp.intel.com>
 <alpine.DEB.2.00.1308082200400.1479@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:16716 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568Ab3HIN6S convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Aug 2013 09:58:18 -0400
In-Reply-To: <alpine.DEB.2.00.1308082200400.1479@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I do think Launchpad is a mature alternative since there are big successful story such like Ubuntu and Openstack :)
OpenStack has already use it for years, and seems everyone happy with it, I am also happy with it, but I am not familiar with jira so I cannot do a comparison. 

Is there any estimate date or plan for when we will introduce these stuff?
-----Original Message-----
From: Sage Weil [mailto:sage@inktank.com] 
Sent: Friday, August 09, 2013 1:06 PM
To: Chen, Xiaoxi
Cc: ceph-devel@vger.kernel.org
Subject: Re: Could we introduce launchpad/gerrit for ceph

> Hi,
> ??Now it?s a bit hard for us to track the bugs, review the submits, 
> and track the blueprints. We do have a bug tracking system, but most 
> of the time it doesn?t connect with a github submit link. We have 
> email review , pull requests, and also some internal mechanism inside 
> inktank , we do need a single entrance for doing a submission. We have 
> wiki to track blueprints, but it?s really confusing if you want to 
> know the status of a BP, and also ,the discussion around that BP. 
> Basically I think Openstack did a good job to track all these things, 
> I do really suggest Ceph could also introduce Launchpad for this.

We had a discussion during CDS about this.  The general output of that seems to be:

- gerrit workflow has a lot of good things
- gerrit treatment of individual commits vs branches is very unpleasant
- jenkins + gerrit integration is good
- we want build + smoke tests to run automatically prior to merge

- github pull requests are a decent alternative to gerrit if we
  - have build and smoke test output added as comments on teh request
    via the github apis
  - have jenkins running tests on pull requests via the plugin api

The bug tracker vs blueprint discussion also came up.  We are strongly considering a switch to jira (+ greenhopper etc) which has an integrated blueprint function and much better scrum stuff.

I haven't used launchpad much.  Is that a viable alternative?

sage

