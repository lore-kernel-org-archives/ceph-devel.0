From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: ms_crc_data false
Date: Wed, 8 Apr 2015 22:44:06 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF916641687C@SATLEXDAG01.amd.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9166416855@SATLEXDAG01.amd.com>
 <alpine.DEB.2.00.1504081539090.4469@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0134.outbound.protection.outlook.com ([157.56.110.134]:36576
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753288AbbDHWoN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Apr 2015 18:44:13 -0400
In-Reply-To: <alpine.DEB.2.00.1504081539090.4469@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Wednesday, April 08, 2015 5:40 PM
> To: Deneau, Tom
> Cc: ceph-devel
> Subject: Re: ms_crc_data false
> 
> On Wed, 8 Apr 2015, Deneau, Tom wrote:
> > With 0.93, I tried
> >     ceph tell 'osd.*' injectargs '--ms_crc_data=false' '--
> ms_crc_header=false'
> >
> > and saw the changes reflected in ceph admin-daemon
> >
> > But having done that, perf top still shows time being spent in crc32
> routines.
> > Is there some other parameter that needs changing?
> 
> The osd still does a CRC for the purposes of write journaling.  This can't be
> disabled currently.  You shouldn't see this come up on reads...
> 
> sage

Hmm, I am doing rados bench seq so only reads.

Is this in 0.93 or do I need 0.94?

-- Tom
