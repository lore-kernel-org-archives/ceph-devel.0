From: Sage Weil <sage@inktank.com>
Subject: Re: Could we introduce launchpad/gerrit for ceph
Date: Thu, 8 Aug 2013 22:05:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308082200400.1479@cobra.newdream.net>
References: <6F3FA899187F0043BA1827A69DA2F7CC01E54E02@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60133 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355Ab3HIFFi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Aug 2013 01:05:38 -0400
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC01E54E02@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Hi,
> ??Now it?s a bit hard for us to track the bugs, review the submits, and 
> track the blueprints. We do have a bug tracking system, but most of the 
> time it doesn?t connect with a github submit link. We have email review 
> , pull requests, and also some internal mechanism inside inktank , we do 
> need a single entrance for doing a submission. We have wiki to track 
> blueprints, but it?s really confusing if you want to know the status of 
> a BP, and also ,the discussion around that BP. Basically I think 
> Openstack did a good job to track all these things, I do really suggest 
> Ceph could also introduce Launchpad for this.

We had a discussion during CDS about this.  The general output of that 
seems to be:

- gerrit workflow has a lot of good things
- gerrit treatment of individual commits vs branches is very unpleasant
- jenkins + gerrit integration is good
- we want build + smoke tests to run automatically prior to merge

- github pull requests are a decent alternative to gerrit if we
  - have build and smoke test output added as comments on teh request
    via the github apis
  - have jenkins running tests on pull requests via the plugin api

The bug tracker vs blueprint discussion also came up.  We are strongly 
considering a switch to jira (+ greenhopper etc) which has an integrated 
blueprint function and much better scrum stuff.

I haven't used launchpad much.  Is that a viable alternative?

sage

