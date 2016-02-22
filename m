From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: RGW include modifications to compile with Clang
Date: Mon, 22 Feb 2016 16:12:08 +0100
Message-ID: <56CB2548.5010906@digiware.nl>
References: <56C87B29.5040005@digiware.nl>
 <1565267399.44124691.1456003985235.JavaMail.zimbra@redhat.com>
 <56C8E590.7090609@digiware.nl>
 <1135436239.44164632.1456013615024.JavaMail.zimbra@redhat.com>
 <56C9958E.5020008@digiware.nl>
 <1358966418.44210231.1456052441419.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:20830 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217AbcBVPMV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 22 Feb 2016 10:12:21 -0500
In-Reply-To: <1358966418.44210231.1456052441419.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 21-2-2016 12:00, Matt Benjamin wrote:
> sure, send github pull request tagged "rgw" when ready
> 

Hi,

It needed some hair pulling....

But the last for commits of #7730 generate a compilable version, for
both FreeBSD/Clang and Linux/GCC, for as far as I can see.

--WjW


