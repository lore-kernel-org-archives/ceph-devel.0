From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Bucket name restrictions in RGW
Date: Fri, 12 Jun 2015 22:50:48 +0000
Message-ID: <robbat2-20150612T220814-235406925Z@orbis-terrarum.net>
References: <CAPRac-aj5YrKXrxxd_YTM-VJcNmS8j1zw_BToSwSdmd5nhv9cQ@mail.gmail.com>
 <557B2875.1090505@42on.com>
Reply-To: ceph-devel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:59712 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753AbbFLWut (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Jun 2015 18:50:49 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 07A3B340AEF
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2015 22:50:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <557B2875.1090505@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jun 12, 2015 at 08:44:05PM +0200,  Wido den Hollander wrote:
> > In case we plan to support website hosting in future on RGW,
Yes, I'm working on this presently. You can find the work in my fork on
Github, and the scratchpad documentation here:
https://github.com/robbat2/temp-ceph-rgw-static-website-wiki/wiki

> > need to make bucket names DNS compliant. Keeping that in mind, I am
> > thinking about modifying the bucket name rules and applying more
> > restrictions to make them more towards DNS compliant.
> > 
> > Please share your opinion about this.
> I'm in favor. I would even like more strict bucket names, eg a setting
> where you can force all names to lowercase or refuse names with
> uppercase in it. This sometimes gives conflicts with DNS names when
> using lower and uppercase mixed.
Some of the below will be known to the existing posters on this thread,
but as it's probably novel to some people on the list, I include it
anyway. Feel free to jump to the 'Questions' section for the moment.

Background:
-----------
AmazonS3 bucket names were originally used in path style, as the first
argument in the path. Ability to use them in as prefix in the hostname
came later.

In the US-Standard region, you can still create such names even, you
just can't use them with hostname-style access. In other regions, they
are much stricter than the Ceph S3 code presently:
http://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html

Path-style access is still valid, and expected for some cases, esp when
SSL is being used.

Details:
--------
The existing RGW code has 3 sets of validation:
RGWHandler_ObjStore::validate_bucket_name
- length 3..255

RGWHandler_ObjStore_SWIFT::validate_bucket_name
- RGWHandler_ObjStore::validate_bucket_name AND
- does not start with '.' AND
- is valid UTF8 AND
- does not contain any 0xFF bytes

RGWHandler_ObjStore_S3::validate_bucket_name(relaxed_names = true)
- RGWHandler_ObjStore::validate_bucket_name AND
- starts with [a-z0-9] AND
- contains only [-._A-Za-z0-9] AND
- is not an IPv4 address [2]

RGWHandler_ObjStore_S3::validate_bucket_name(relaxed_names = false)
- RGWHandler_ObjStore::validate_bucket_name AND
- starts with [0_-9A-Za-z0-9] AND
- contains only [-._A-Za-z0-9] AND
- is not an IPv4 address [2]

Right now, the AmazonS3 constraints, for new buckets [1] in regions
other than US-Standard, or created via the management console are: (if
they already exist, you can continue to use them)
- length 3..63
- one or more labels, separated with exactly one single period '.'
  - each label must start and end with [a-z0-9]
  - must contain only [-a-z0-9]
- is not an IPv4 address [3]

Questions:
----------

Now that we've got both Ceph's current behavior and currently enforced
S3 constraints documented, we have some questions to decide on.
- Since we've allowed such flexibility in the past, how should we handle
  access to existing non-complaint buckets in future? Right now
  RGWHandler_ObjStore_S3 will reject ANY access to a non-compliant
  bucket name, even if it was created before the restrictions were so
  tight.
- This also applies to creating buckets with 'rgw relaxed s3 bucket
  names' enabled, then turning it off, and trying to access the bucket.
- What happens if you create a bucket via Swift, compliant with Swift
  constraints, and then try to access it via S3? What SHOULD happen?
  I don't use swift at all, so I'm really unsure about this.

Footnotes:
----------
1. I include them because I've seen the older versions, and there
doesn't seem to be way to easily see those again, archive.org doesn't
have it. 
2. looks_like_ip_address will actually reject anything that matches the
   regex of /^([0-9]+\.){3}[0-9]+$/, so if each element is larger than
   255, it will reject it as well.
3. They just say "Bucket names must not be formatted as an IP address
   (e.g., 192.168.5.4)"; they don't clarify edge cases.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
