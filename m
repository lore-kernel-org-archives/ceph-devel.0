From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: How to compile Java-Rados.
Date: Wed, 11 Jul 2012 22:32:35 -0700
Message-ID: <CAPrxi59LMX7aPuG3FrzgAsWS++6kNdi_11DnZQwZifDStdmWYg@mail.gmail.com>
References: <loom.20120712T065146-882@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49978 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab2GLFcf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 01:32:35 -0400
Received: by yhmm54 with SMTP id m54so2339449yhm.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 22:32:35 -0700 (PDT)
In-Reply-To: <loom.20120712T065146-882@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Ramu,

I just pushed a patch that should fix your compile problems:

  https://github.com/noahdesu/java-rados/commit/0a68aebe2360ca140d470f7dacfc555a618dd976

Note that you may need to change JAVA_HOME in src/native/Makefile.am
for your distribution.

Hope things work for you. The bindings are old, but there isn't any
reason they shouldn't still function correctly.

- Noah

On Wed, Jul 11, 2012 at 9:53 PM, ramu <ramu.freesystems@gmail.com> wrote:
> Hi,
>
> I want to compile java-rados against ceph-0.47.Please help me how to compile
> java-rados.
>
> Thanks,
> Ramu.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
