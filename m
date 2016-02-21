From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Has rgw recently switched to deque usuage??
Date: Sun, 21 Feb 2016 11:46:38 +0100
Message-ID: <56C9958E.5020008@digiware.nl>
References: <56C87B29.5040005@digiware.nl>
 <1565267399.44124691.1456003985235.JavaMail.zimbra@redhat.com>
 <56C8E590.7090609@digiware.nl>
 <1135436239.44164632.1456013615024.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:17071 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115AbcBURzG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 21 Feb 2016 12:55:06 -0500
In-Reply-To: <1135436239.44164632.1456013615024.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 21-2-2016 01:13, Matt Benjamin wrote:
> Hi Willem,
> 
> That's good news, but massive header re-ordering sounds suspicious.  Likely, there are just missing unix headers.

Overnight the build completed.
Now running gmake check.
If that gets to my normal level of PASSED of around 110 of 133 than I
commit the rgw changes and you can find that in my pull to comment about
and we take it from there.

--WjW

