From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Bucket name restrictions in RGW
Date: Fri, 12 Jun 2015 23:29:23 +0000
Message-ID: <robbat2-20150612T232131-467242919Z@orbis-terrarum.net>
References: <CAPRac-aj5YrKXrxxd_YTM-VJcNmS8j1zw_BToSwSdmd5nhv9cQ@mail.gmail.com>
 <557B2875.1090505@42on.com>
 <robbat2-20150612T220814-235406925Z@orbis-terrarum.net>
 <1505040171.13879951.1434150828495.JavaMail.zimbra@redhat.com>
Reply-To: ceph-devel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:33787 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755485AbbFLX3Y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Jun 2015 19:29:24 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 8E997340973
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2015 23:29:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1505040171.13879951.1434150828495.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Fri, Jun 12, 2015 at 07:13:48PM -0400,  Yehuda Sadeh-Weinraub wrote:
> Whatever we end up doing, we need to make it configurable, and also
> keep backward compatibility, so that buckets that were created prior
> to such a change will still remain accessible. Some setups would not
> need this limitation and will find it too restricting so I'm not sure
> that it's really that needed. In short, make it configurable.
Configurable:
- Can we obsolete 'rgw relaxed s3 bucket names', and convert it to a new
  option: 'rgw s3 bucket name create strictness'
  Value '0' => existing 'rgw relaxed s3 bucket names = true' logic
  Value '1' => existing 'rgw relaxed s3 bucket names = false' logic
  Value '2' => compliance with AmazonS3 DNS rules

Backwards-Compatibility:
- Make a new option 'rgw s3 bucket name access strictness'
  Same values as above, but used to access buckets, not create new ones.
- Proposed default values:
  rgw s3 bucket name create strictness = 2
  rgw s3 bucket name access strictness = 1

So you can only create DNS-compliant buckets, but still access your
existing non-compliant buckets. Maybe also have keywords of major
releases and 'relaxed' supported in addition to the integer values.

I don't like the names of the config keys, but I'm coming up blank on
something that is shorter while still being immediately clear.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
