From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: rgw static-website hosting design WIP: how S3-like should we be
 with endpoint types?
Date: Tue, 9 Jun 2015 16:28:11 +0000
Message-ID: <robbat2-20150609T161412-670559280Z@orbis-terrarum.net>
References: <20150609035221.GA2868@orbis-terrarum.net>
 <919435330.11886213.1433865573139.JavaMail.zimbra@redhat.com>
Reply-To: ceph-devel@vger.kernel.org, jonathan.lacour@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:33669 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355AbbFIQ2M convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jun 2015 12:28:12 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id A2215340817
	for <ceph-devel@vger.kernel.org>; Tue,  9 Jun 2015 16:28:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <919435330.11886213.1433865573139.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, jonathan lacour <jonathan.lacour@dreamhost.com>

On Tue, Jun 09, 2015 at 11:59:33AM -0400,  Yehuda Sadeh-Weinraub wrote:
> A few options (not necessarily mutual exclusive):
>  - anonymous access gets the website endpoint handling, authenticated gets the REST
>  - read operations returns website, write operations handle REST
I have a hybrid of this now:
- non-authenticated GET/HEAD return website.
- everything else is REST as before.

>  - configurable (whether gateway handles either, or which)
Yeah, maybe will do that in a later pass.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
