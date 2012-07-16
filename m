From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: How to compile Java-Rados.
Date: Mon, 16 Jul 2012 08:54:57 -0700
Message-ID: <CAPrxi5-MZ0WS+-fGds99fOiR4oyVx=e6SEpwpCFMj0f3M7YxfA@mail.gmail.com>
References: <loom.20120712T065146-882@post.gmane.org>
	<CAPrxi59LMX7aPuG3FrzgAsWS++6kNdi_11DnZQwZifDStdmWYg@mail.gmail.com>
	<loom.20120712T111906-426@post.gmane.org>
	<CAPrxi59yCsE+4iNd3URAFtvwJKus2O+Z0LOouPbL8NVSGC0jsQ@mail.gmail.com>
	<loom.20120713T085715-195@post.gmane.org>
	<CAPrxi59UXDag=h7n8oYNSfE7+hscZJ+eb0XsOFtPPAFas26uZQ@mail.gmail.com>
	<loom.20120716T061714-349@post.gmane.org>
	<C20749A7-440C-49D6-8C53-3C756B17E079@cs.ucsc.edu>
	<loom.20120716T072848-760@post.gmane.org>
	<CAPrxi5-dB2_P71zNzvE9hx-zXaC2wtm_KpQ=bA8QaE6qzz7JFw@mail.gmail.com>
	<loom.20120716T092022-386@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53750 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab2GPPzF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jul 2012 11:55:05 -0400
Received: by yhmm54 with SMTP id m54so5435056yhm.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jul 2012 08:55:04 -0700 (PDT)
In-Reply-To: <loom.20120716T092022-386@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

Disregard that last message. Ok, I'm not sure where else EINVAL gets
returned in the configuration path, but I can look into it this
evening. I tested the wrappers on a clean install last night and they
seem to be working for me. Can you turn on debug logging with
CEPH_ARGS (as per Sage's last email)?

On Mon, Jul 16, 2012 at 12:23 AM, ramu <ramu.freesystems@gmail.com> wrote:
> Hi Noah,
>
> I printed the CONF_FILE and file and states,the printed as following,these
> are in ClusterStatsTest.java.
>
> test:
>     [junit] Running ClusterStatsTest
>     [junit] conffile--->/etc/ceph/ceph.conf
>     [junit] state-->CONFIGURING
>     [junit] file--->/etc/ceph/ceph.conf
>     [junit] state-->CONFIGURING
>     [junit] Tests run: 1, Failures: 0, Errors: 1, Time elapsed: 0.123 sec
>
> BUILD FAILED
> /home/ramu/java-rados/build.xml:134: Test ClusterStatsTest failed
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
