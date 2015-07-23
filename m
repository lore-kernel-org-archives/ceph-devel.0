From: Dan Mick <dmick@redhat.com>
Subject: Re: hello, I am confused about a question of rbd
Date: Thu, 23 Jul 2015 14:24:43 -0700
Message-ID: <55B15B9B.2020103@redhat.com>
References: <7B5C2F2226F8AF419D625C6097AD814C5E265628@H3CMLB12-EX.srv.huawei-3com.com> <1804564100.2788995.1437656606063.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34014 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964770AbbGWVYo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 Jul 2015 17:24:44 -0400
In-Reply-To: <1804564100.2788995.1437656606063.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>, zhengbin 08747 <zhengbin.08747@h3c.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Why not zero?

If the answer is "it can't be used", then, what arbitrary minimum size
is too small?

(also, given that resize exists, it can be used for storage after a resize.)

On 07/23/2015 06:03 AM, Jason Dillaman wrote:
> According to the git history, support for zero MB images for the create/resize commands was explicitly added by commit 08f47a4.  Dan Mick or Josh Durgin could probably better explain the history behind the change since it was before my time.
> 

