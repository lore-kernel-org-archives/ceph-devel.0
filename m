From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: How to compile Java-Rados.
Date: Fri, 13 Jul 2012 08:04:25 -0700
Message-ID: <CAPrxi59UXDag=h7n8oYNSfE7+hscZJ+eb0XsOFtPPAFas26uZQ@mail.gmail.com>
References: <loom.20120712T065146-882@post.gmane.org>
	<CAPrxi59LMX7aPuG3FrzgAsWS++6kNdi_11DnZQwZifDStdmWYg@mail.gmail.com>
	<loom.20120712T111906-426@post.gmane.org>
	<CAPrxi59yCsE+4iNd3URAFtvwJKus2O+Z0LOouPbL8NVSGC0jsQ@mail.gmail.com>
	<loom.20120713T085715-195@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:54030 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755141Ab2GMPEZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jul 2012 11:04:25 -0400
Received: by ghrr11 with SMTP id r11so3654058ghr.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jul 2012 08:04:25 -0700 (PDT)
In-Reply-To: <loom.20120713T085715-195@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Ramu,

The "libtool --mode=install" hack has apparently stopped working. You
can get around this problem for the time being by copying the library
files you want from src/native/.libs/ into the dist folder.

- Noah

On Fri, Jul 13, 2012 at 12:00 AM, ramu <ramu.freesystems@gmail.com> wrote:
> Hi Noah,
>
> When Iam running ant command Build successful,but in dist folder only
> librados.jar is came ,there is no libjavarados.a.
>
> After i run the ant test ,it is showing error is,
> makedir:
>
> compile-rados:
>
> compile-tests:
>
> jar:
>
> test:
> [junit] Running ClusterStatsTest
> [junit] Tests run: 1, Failures: 0, Errors: 2, Time elapsed: 0.026 sec
>
> BUILD FAILED
> /home/vu/java-rados/build.xml:134: Test ClusterStatsTest failed
>
> Total time: 1 second
>
> Thanks,
> Ramu.
>
>
>
>
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
