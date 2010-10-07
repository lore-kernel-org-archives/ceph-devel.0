From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Ceph, make (22nd-sept unstable) fails, and slow write issues.
Date: Thu, 7 Oct 2010 09:17:22 -0700
Message-ID: <AANLkTinFHTi01GCS3K5zZOT+cMfiaZBc0bK-+8pzXN8Q@mail.gmail.com>
References: <AANLkTim6p641hc8OWudCtSiagwi1rC6n9ymjbUBJxDLQ@mail.gmail.com>
	<AANLkTi=QA5n0pXNzFGtHYY7n0tb0TgwskDZVM-1H=RM0@mail.gmail.com>
	<AANLkTinPPeOwQ=DM4U+3OOF9iNUHLsPkeMtP8wGYj+2y@mail.gmail.com>
	<Pine.LNX.4.64.1009232208240.2831@cobra.newdream.net>
	<AANLkTi=7DqSVaBp=dQgcH_B384QGP3vgdXUtGD=t5r6J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49567 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab0JGQRX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Oct 2010 12:17:23 -0400
Received: by qyk10 with SMTP id 10so15885qyk.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Oct 2010 09:17:23 -0700 (PDT)
In-Reply-To: <AANLkTi=7DqSVaBp=dQgcH_B384QGP3vgdXUtGD=t5r6J@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: DongJin Lee <dongjin.lee@auckland.ac.nz>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Thu, Oct 7, 2010 at 3:48 AM, DongJin Lee <dongjin.lee@auckland.ac.nz=
> wrote:
>> Hmmm -- it looks like the scripts are split on whether you have
>> tcmalloc installed in your system, and I don't see any obvious issue=
s
>> when I go over them. Do you have tcmalloc installed? Did you try a
>> "make clean; make" cycle?
>
> Sadly, I still get the error in some of other PCs.
> cosd.cc: In function =91int main(int, const char**)=92:
> cosd.cc:65: error: =91IsHeapProfilerRunning=92 was not declared in th=
is scope
> cosd.cc:310: warning: ignoring return value of =91int chdir(const
> char*)=92, declared with attribute warn_unused_result
> make[2]: *** [cosd-cosd.o] Error 1
Hmmm. I just noticed that IsHeapProfilerRunning is actually the second
tcmalloc profiler function to get referenced in that #if block. Can
you comment out just that one line and let me know if that lets it
compile?
IsHeapProfilerRunning has been in the profiler since 2008, but the
prototype changed this year to return an int instead of a bool, so
maybe your installed libraries and header don't match?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
