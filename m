From: Sam Lang <sam.lang@inktank.com>
Subject: Re: Assertion failure in ceph_readlink()
Date: Thu, 01 Nov 2012 20:29:26 -0500
Message-ID: <509321F6.9060200@inktank.com>
References: <5092F9CB.7020501@cs.ucsc.edu> <5093022E.3040604@inktank.com> <CAPrxi595hE+TWXA=9FTg=3aKhEqR+-yuYQYcNFk=u4oi2mL5hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:57631 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759784Ab2KBB3b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 21:29:31 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1419724dak.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 18:29:31 -0700 (PDT)
In-Reply-To: <CAPrxi595hE+TWXA=9FTg=3aKhEqR+-yuYQYcNFk=u4oi2mL5hA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On 11/01/2012 06:22 PM, Noah Watkins wrote:
>>     filepath path(relpath);
>>     Inode *in;
>> -  int r = path_walk(path, &in);
>> +  int r = path_walk(path, &in, false);
>>     if (r < 0)
>>       return r;
>
> Fixes both cases. Thanks!
>

I discovered a few more bugs in path_walk() for the symlink case while 
debugging your problem.  I've pushed fixes and a test case to 
wip-fix-symlinks.
-sam
