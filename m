From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: mds sync wrlock
Date: Mon, 27 Jun 2011 16:28:38 -0700
Message-ID: <B0DF7127-A5BF-4DAE-A22C-1FD9C284172B@dreamhost.com>
References: <BANLkTin9SkuYVnatyXoKCjHiJevCizKwVA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44609 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab1F0X2k convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2011 19:28:40 -0400
In-Reply-To: <BANLkTin9SkuYVnatyXoKCjHiJevCizKwVA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Jun 27, 2011, at 4:53 AM, huang jun wrote:

> hi,all
> now,we test the directory operation in ceph,and found follow phenomenons:
> we mount ceph on /mnt/test/
> then create dir "/mnt/test/a/b/"
> 1) in dir "b" , use "seq 3000|xargs -i mkdir {}" to create 3000 dirs
> 2) and at some time,make a directory "c" in "a"
> then step 2) returns very slow,from the debug log,we got :
> step 2) will block  until  step 1)  finished
> because  step 2) need a sync wrlock of dir "a", but step 1) got the
> wrlock in predirectory_journal_parents function
> until it finished works .
> so i have few questions:
>  a) why step 1)  got the wrlock of dir "a" ? I think it should just
> hold the wrlock of dir "b",but not dir "a".
>  b) why circularly judge the  variable "stop" value  of all the
> parent directory of dir "b" ?

Hmm. Which locks specifically are getting wrlock'ed in dir a? In general it shouldn't be taking locks there to make files in dir b, although it can happen in various circumstances for certain of the locks.

Also, what versions are you using of the server code and your client?
-Greg