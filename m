From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: Has rgw recently switched to deque usuage??
Date: Sat, 20 Feb 2016 16:33:05 -0500 (EST)
Message-ID: <1565267399.44124691.1456003985235.JavaMail.zimbra@redhat.com>
References: <56C87B29.5040005@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:41079 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbcBTVdI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Feb 2016 16:33:08 -0500
In-Reply-To: <56C87B29.5040005@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Willem,

A number of new features have merged, sure, and they make use of new primitives.  I haven't compiled with clang recently, mainly due to issues linking with gcc-compiled leveldb and rocksdb on Linux platforms.  For now, maybe you can send more specific info.

(I'll be able to try-build on FreeBSD at some point, probably, but not in the next day or so due to travel.)

Matt

----- Original Message -----
> From: "Willem Jan Withagen" <wjw@digiware.nl>
> To: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Saturday, February 20, 2016 9:41:45 AM
> Subject: Has rgw recently switched to deque usuage??
> 
> Hi,
> 
> With the last rebase I'm getting compilation errors on rgw stuff.
> So I was wondering if deque usuage got included recently, or that I'm
> running into a case where Clang doesn't like the way some code is used.
> And GCC just compiles fine...
> 
> Any answer would be appriciated
> 
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
