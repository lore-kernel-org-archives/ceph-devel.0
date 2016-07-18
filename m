From: Alfredo Deza <adeza@redhat.com>
Subject: Re: Jenkins build pestered by 'no such option: --disable-pip-version-check'
Date: Mon, 18 Jul 2016 14:48:27 -0400
Message-ID: <CAC-Np1xhGOo9JUcVm=4yqhN7FJJVFwxrGPXs30Rhw6a5ava_sg@mail.gmail.com>
References: <65d919f9-a015-4fe8-b578-b2fc275494de@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36137 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbcGRSsa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jul 2016 14:48:30 -0400
Received: by mail-wm0-f43.google.com with SMTP id f126so114777390wma.1
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jul 2016 11:48:29 -0700 (PDT)
In-Reply-To: <65d919f9-a015-4fe8-b578-b2fc275494de@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jul 18, 2016 at 9:57 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Since somewhere last week all my Jenkins test are aborted this.
> And I was under the assumption that issue would have been fixed?
>
> --WjW
>
> See:
> https://jenkins.ceph.com/job/ceph-pull-requests/9255/console
>
> Running virtualenv with interpreter /usr/bin/python2.7
>
> Usage:
>   pip <command> [options]
>
> no such option: --disable-pip-version-check
>
> Usage:
>   pip <command> [options]
>
> no such option: --disable-pip-version-check
>
> Usage:
>   pip <command> [options]


That seems to be a problem in the code that creates the ceph-disk
virtual environment (python's virtualenv).

That code lives within the Ceph source tree so a fix would need to
happen there (the Jenkins job can't really fix this)

The full error (to make it easier for others to see) is:

New python executable in /tmp/ceph.V2f/ceph-disk-virtualenv/bin/python2.7
Also creating executable in /tmp/ceph.V2f/ceph-disk-virtualenv/bin/python
Installing setuptools, pip...
done.
Running virtualenv with interpreter /usr/bin/python2.7

Usage:
  pip <command> [options]

no such option: --disable-pip-version-check

Usage:
  pip <command> [options]

no such option: --disable-pip-version-check

Usage:
  pip <command> [options]

no such option: --disable-pip-version-check
make[3]: *** [src/ceph-disk/CMakeFiles/ceph-disk] Error 2
make[2]: *** [src/ceph-disk/CMakeFiles/ceph-disk.dir/all] Error 2
make[2]: *** Waiting for unfinished jobs....


> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
