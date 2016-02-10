From: kefu chai <tchaikov@gmail.com>
Subject: Re: Jenkins error in running tests ....
Date: Wed, 10 Feb 2016 19:58:15 +0800
Message-ID: <CAJE9aONSEzJVWe4Ows7oNrg403_ucT4vYdvCNEujGr74h7cYqw@mail.gmail.com>
References: <56B9B0A1.6090807@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:34253 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239AbcBJL6Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Feb 2016 06:58:16 -0500
Received: by mail-yw0-f178.google.com with SMTP id h129so12136652ywb.1
        for <ceph-devel@vger.kernel.org>; Wed, 10 Feb 2016 03:58:15 -0800 (PST)
In-Reply-To: <56B9B0A1.6090807@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Willem Jan Withagen <wjw@digiware.nl>

On Tue, Feb 9, 2016 at 5:25 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> https://jenkins.ceph.com/job/ceph-pull-requests/1261/console
>
> .......
> PASS: test/osd/osd-scrub-repair.sh
> make[5]: execvp: /bin/sh: Argument list too long
> make[5]: *** [test-suite.log] Error 127
> make[5]: Leaving directory
> `/home/jenkins-build/build/workspace/ceph-pull-requests/src'
> make[4]: *** [check-TESTS] Error 2
> make[4]: Leaving directory
> `/home/jenkins-build/build/workspace/ceph-pull-requests/src'
> make[3]: *** [check-am] Error 2
>
> I'm assuming that it is not something I did in my code.
> But then again I've been proven wrong....

Willem, seems you are not the only one having this failure in the
jenkins run. i have
the same error in
https://jenkins.ceph.com/job/ceph-pull-requests/1294/console for
my pull request of https://github.com/ceph/ceph/pull/7523 as well.

-- 
Regards
Kefu Chai
