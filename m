From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Has rgw recently switched to deque usuage??
Date: Sun, 21 Feb 2016 14:18:29 +0100
Message-ID: <56C9B925.3090104@digiware.nl>
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
Received: from smtp.digiware.nl ([31.223.170.169]:18268 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbcBUSFE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 21 Feb 2016 13:05:04 -0500
In-Reply-To: <1358966418.44210231.1456052441419.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 21-2-2016 12:00, Matt Benjamin wrote:
> sure, send github pull request tagged "rgw" when ready

Second try in
https://github.com/ceph/ceph/pull/7730

First one was on top of all my other FreeBSD changes, so I
tried making a new one passed on my master checkout.
But yoy still get all the other commits.

So you need to look at commit  8c4530f

--WjW


