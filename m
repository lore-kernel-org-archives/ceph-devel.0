From: Gregory Farnum <greg@inktank.com>
Subject: Re: How to know the Rados pools path.
Date: Thu, 16 Aug 2012 09:10:35 -0700
Message-ID: <CAPYLRzgYqR7RPuE6o-SzL4kGYMZdPDpRquQsqy4mnPSaaLPSSQ@mail.gmail.com>
References: <loom.20120816T141547-773@post.gmane.org>
	<502CF312.7030008@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34589 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752093Ab2HPQKg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Aug 2012 12:10:36 -0400
Received: by lagy9 with SMTP id y9so1558644lag.19
        for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 09:10:35 -0700 (PDT)
In-Reply-To: <502CF312.7030008@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ramu <ramu.freesystems@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thursday, August 16, 2012, Wido den Hollander wrote:
>
> On 08/16/2012 02:20 PM, ramu wrote:
>>
>> Hi,
>>
>>        Iam creating rados pools from java-rados,it's creating the pool fine.
>> I don't know this pool location on disks,please help me to know the location
>> of rados pool(means path).It is showing the list of pools from the command
>> "rados lspools".But there is not showing the path.
>>
>
> Why do you want to know the pool location?
>
> First, there is no such hardcoded location. On the disk of an OSD you'll find directories for each PG with their files in them, but I wouldn't recommended digging in there.


To expand on this a little: a pool does not exist in a single
location. It's sharded into placement groups (PGs), which are then
distributed across the OSDs -- but they can and do move in response to
changing cluster conditions. :)

If you mean that you're trying to mount a rados pool in linux, it
doesn't work like that. RADOS pools are closer to S3 buckets than to a
LUN or a filesystem volume...
-Greg
