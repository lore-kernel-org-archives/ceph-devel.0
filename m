From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Bucket name restrictions in RGW
Date: Mon, 15 Jun 2015 17:59:17 +0000
Message-ID: <robbat2-20150615T175733-051145265Z@orbis-terrarum.net>
References: <CAPRac-aj5YrKXrxxd_YTM-VJcNmS8j1zw_BToSwSdmd5nhv9cQ@mail.gmail.com>
 <557B2875.1090505@42on.com>
 <robbat2-20150612T220814-235406925Z@orbis-terrarum.net>
 <1505040171.13879951.1434150828495.JavaMail.zimbra@redhat.com>
 <robbat2-20150612T232131-467242919Z@orbis-terrarum.net>
 <557C9185.1050305@42on.com>
 <87lhfmx3f4.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:44211 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754283AbbFOR7S (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 15 Jun 2015 13:59:18 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id C3F42340DAF
	for <ceph-devel@vger.kernel.org>; Mon, 15 Jun 2015 17:59:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <87lhfmx3f4.fsf@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel@vger.kernel.org

On Sun, Jun 14, 2015 at 11:00:23AM +0530,  Abhishek L wrote:
> 
> Wido den Hollander writes:
> 
> > On 06/13/2015 01:29 AM, Robin H. Johnson wrote:
> >> On Fri, Jun 12, 2015 at 07:13:48PM -0400,  Yehuda Sadeh-Weinraub wrote:
> >>> Whatever we end up doing, we need to make it configurable, and also
> >>> keep backward compatibility, so that buckets that were created prior
> >>> to such a change will still remain accessible. Some setups would not
> >>> need this limitation and will find it too restricting so I'm not sure
> >>> that it's really that needed. In short, make it configurable.
> >> Configurable:
> >> - Can we obsolete 'rgw relaxed s3 bucket names', and convert it to a new
> >>   option: 'rgw s3 bucket name create strictness'
> >>   Value '0' => existing 'rgw relaxed s3 bucket names = true' logic
> >>   Value '1' => existing 'rgw relaxed s3 bucket names = false' logic
> >>   Value '2' => compliance with AmazonS3 DNS rules
> 
> Alternatively we could just add an opt `rgw s3 bucket name create
> strictness` (maybe `rgw s3 bucket dns comply` instead) as a bool which
> would set your value '2' logic when both `relaxed s3 bucket names` and
> this value are set, so that we dont break backwards compatibility?
If the NEW option names are unset, then:
default 'create strictness' = 2
default 'access strictness' = (relaxed s3 bucket names) ? 0 : 1

That gets us the new strictness on create AND compatibility with
existing configurations.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
