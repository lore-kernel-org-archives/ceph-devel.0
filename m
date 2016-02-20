From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Has rgw recently switched to deque usuage??
Date: Sat, 20 Feb 2016 23:15:44 +0100
Message-ID: <56C8E590.7090609@digiware.nl>
References: <56C87B29.5040005@digiware.nl>
 <1565267399.44124691.1456003985235.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:43391 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947588AbcBTWZb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 20 Feb 2016 17:25:31 -0500
In-Reply-To: <1565267399.44124691.1456003985235.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 20-2-2016 22:33, Matt Benjamin wrote:
> Hi Willem,
> 
> A number of new features have merged, sure, and they make use of new
> primitives.  I haven't compiled with clang recently, mainly due to
> issues linking with gcc-compiled leveldb and rocksdb on Linux
> platforms.  For now, maybe you can send more specific info.
> 
> (I'll be able to try-build on FreeBSD at some point, probably, but
> not in the next day or so due to travel.)

Hi Matt,

It turns out to be all about the order of includes and that Clang not
always sees eye to eye with GCC.
Right now I'm sort of reordering a lot includes rados/rgw headers in the
rgw/*cc files.
Probably too much reordering but first I want it to get it to compile.
:) After that lets see what was really needed.

Save travels,
--WjW

> Matt
> 
> ----- Original Message -----
>> From: "Willem Jan Withagen" <wjw@digiware.nl> To: "Ceph
>> Development" <ceph-devel@vger.kernel.org> Sent: Saturday, February
>> 20, 2016 9:41:45 AM Subject: Has rgw recently switched to deque
>> usuage??
>> 
>> Hi,
>> 
>> With the last rebase I'm getting compilation errors on rgw stuff. 
>> So I was wondering if deque usuage got included recently, or that
>> I'm running into a case where Clang doesn't like the way some code
>> is used. And GCC just compiles fine...
>> 
>> Any answer would be appriciated
>> 
>> --WjW -- To unsubscribe from this list: send the line "unsubscribe
>> ceph-devel" in the body of a message to majordomo@vger.kernel.org 
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
> 

