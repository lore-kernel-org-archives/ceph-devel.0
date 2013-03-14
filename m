From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: CephFS locality API RFC
Date: Thu, 14 Mar 2013 11:33:55 -0700
Message-ID: <AFC48281-A237-442F-A9FA-98861A32E363@cs.ucsc.edu>
References: <2A330211-CC95-42FB-967C-6FAD4E1895DC@cs.ucsc.edu> <697CF5409C9749BBA0F2F86CCBDD2B17@inktank.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:34347 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab3CNSd4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Mar 2013 14:33:56 -0400
Received: by mail-pb0-f51.google.com with SMTP id un15so2627362pbc.10
        for <ceph-devel@vger.kernel.org>; Thu, 14 Mar 2013 11:33:56 -0700 (PDT)
In-Reply-To: <697CF5409C9749BBA0F2F86CCBDD2B17@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Mar 14, 2013, at 11:29 AM, Greg Farnum <greg@inktank.com> wrote:

> On Thursday, March 14, 2013 at 11:14 AM, Noah Watkins wrote:
>> The current CephFS API is used to extract locality information as follows:
>> 
>> First we get a list of OSD IDs:
>> 
>> ceph_get_file_extent_osds(offset) -> [OSD ID]*
>> 
>> Using the OSD IDs we can then query for the CRUSH bucket hierarchy:
>> 
>> ceph_get_osd_crush_location(osd_id) -> path
>> 
>> The path includes hostname information, but we'd still like to get the IP. The current API for doing this is:
>> 
>> ceph_get_file_stripe_address(offset) -> [sockaddr]*
>> 
>> that returns an IP for each OSD holds replicas. The order of the output list should be the same as the the OSD list, but It'd be nice to have a consistent API that deals with OSD id, making the correspondence explicit.
> Agreed. We should probably deprecate the get_file_stripe_address() and make them turn IDs into addresses on their own.

Is there an API deprecation protocol, or just -ENOTSUPP?


>> For instance:
>> 
>> ceph_get_file_stripe_address(osd_id) -> sockaddr
> How about  
> ceph_get_osd_address(osd_id) -> sockaddr
> ;)

Sounds good.

Thanks!