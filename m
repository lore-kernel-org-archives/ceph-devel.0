From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH] configure.ac: check for org.junit.rules.ExternalResource
Date: Wed, 9 Jan 2013 13:54:03 -0800
Message-ID: <CAPrxi58_D4PVhMAtABfKiRrXKZv0p4OUSfc+MuVkha0ndWPWxA@mail.gmail.com>
References: <1357767316-27868-1-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f51.google.com ([209.85.212.51]:41461 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932962Ab3AIVyF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 16:54:05 -0500
Received: by mail-vb0-f51.google.com with SMTP id fq11so2028647vbb.24
        for <ceph-devel@vger.kernel.org>; Wed, 09 Jan 2013 13:54:03 -0800 (PST)
In-Reply-To: <1357767316-27868-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

I haven't tested this yet, but I like it. I think several of these
macros can be used to simplify a bit more of the Java config bit. I
also just saw the ax_jni_include_dir macro in the autoconf archive and
it looks like that can help clean-up too.

On Wed, Jan 9, 2013 at 1:35 PM, Danny Al-Gaaf <danny.al-gaaf@bisect.de> wrote:
> The attached patch depends on the set of 6 patches I send some days ago.
> See: http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/11793
>
> Danny Al-Gaaf (1):
>   configure.ac: check for org.junit.rules.ExternalResource
>
>  autogen.sh                |   2 +-
>  configure.ac              |  29 ++++++-------
>  m4/ac_check_class.m4      | 108 ++++++++++++++++++++++++++++++++++++++++++++++
>  m4/ac_check_classpath.m4  |  24 +++++++++++
>  m4/ac_check_rqrd_class.m4 |  26 +++++++++++
>  m4/ac_java_options.m4     |  33 ++++++++++++++
>  m4/ac_prog_jar.m4         |  39 +++++++++++++++++
>  m4/ac_prog_java.m4        |  83 +++++++++++++++++++++++++++++++++++
>  m4/ac_prog_java_works.m4  |  98 +++++++++++++++++++++++++++++++++++++++++
>  m4/ac_prog_javac.m4       |  45 +++++++++++++++++++
>  m4/ac_prog_javac_works.m4 |  36 ++++++++++++++++
>  m4/ac_prog_javah.m4       |  28 ++++++++++++
>  m4/ac_try_compile_java.m4 |  40 +++++++++++++++++
>  m4/ac_try_run_javac.m4    |  41 ++++++++++++++++++
>  14 files changed, 615 insertions(+), 17 deletions(-)
>  create mode 100644 m4/ac_check_class.m4
>  create mode 100644 m4/ac_check_classpath.m4
>  create mode 100644 m4/ac_check_rqrd_class.m4
>  create mode 100644 m4/ac_java_options.m4
>  create mode 100644 m4/ac_prog_jar.m4
>  create mode 100644 m4/ac_prog_java.m4
>  create mode 100644 m4/ac_prog_java_works.m4
>  create mode 100644 m4/ac_prog_javac.m4
>  create mode 100644 m4/ac_prog_javac_works.m4
>  create mode 100644 m4/ac_prog_javah.m4
>  create mode 100644 m4/ac_try_compile_java.m4
>  create mode 100644 m4/ac_try_run_javac.m4
>
> --
> 1.8.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
