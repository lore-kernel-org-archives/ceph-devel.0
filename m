From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ceph FS - File Locking Status
Date: Fri, 26 Apr 2013 12:34:11 -0700
Message-ID: <CAPYLRzjHiUBpNjES3vEpYVyC3YA8hHgOw23P6-V4sbJ51L9uCQ@mail.gmail.com>
References: <5fabda9d3f136b2185df714d7f560c98@pl1.haspere.com>
	<21225b3d6dd1317d4af5088fa17ce973@pl1.haspere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:64726 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757168Ab3DZTeM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 15:34:12 -0400
Received: by mail-qe0-f46.google.com with SMTP id nd7so2705476qeb.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 12:34:11 -0700 (PDT)
In-Reply-To: <21225b3d6dd1317d4af5088fa17ce973@pl1.haspere.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: YS3fpFE2ykfB@dyweni.com
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

On Thu, Apr 25, 2013 at 8:01 PM, Dyweni - Ceph-Devel
<YS3fpFE2ykfB@dyweni.com> wrote:
> Hi All (again),
>
> I'm specific interested in POSIX advisory locks...   as referred to by
> SQLite Version 3 (http://www.sqlite.org/lockingv3.html, section 6).
>
> I want to store a set of SQLite database files on a shared Ceph FS, in order
> to coordinate the activities of a number of nodes.  I need to make sure that
> multiple nodes won't be stepping on each other and corrupting these database
> files.
>
>
> ---
> Thanks,
> Dyweni
>
>
>
>
> On 2013-04-25 20:54, Dyweni - Ceph-Devel wrote:
>>
>> Hi All,
>>
>> I ran across Bug # 2825 (http://tracker.ceph.com/issues/2825)
>> tonight.  Is file locking still an issue in the latest stable release
>> (0.60 / 0.61) ?

I'd forgotten about this bug. I don't believe we've done any work on
the POSIX locks since then, although that bug doesn't mention the
kernel version in use and I believe you need both sufficiently new
servers and kernels. Sadly I don't have the time to pull down that
code and check out the current results.

The locking code is *fairly* readable though, if anybody would like to
check it out. The interfaces grew to be messier than I'd like but it
is at least well-isolated from the other MDS invariants, if somebody
wants to check it out.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
