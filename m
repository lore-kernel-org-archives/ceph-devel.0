From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: release notes script dependencies
Date: Wed, 6 May 2015 09:57:55 +0530
Message-ID: <CAEw75dOCcdafHQhdc6uv+HsQVnOVE+rD8VdAAYFALFfFSEq2cg@mail.gmail.com>
References: <55491259.4010003@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:36408 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759236AbbEFE1z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 May 2015 00:27:55 -0400
Received: by qcbgy10 with SMTP id gy10so46327787qcb.3
        for <ceph-devel@vger.kernel.org>; Tue, 05 May 2015 21:27:55 -0700 (PDT)
In-Reply-To: <55491259.4010003@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, May 6, 2015 at 12:26 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Abhishek,
>
> It would be useful to add instructions on what dependencies to pull to run http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_write_the_release_notes. Something like
>
> virtualenv /tmp/foo
> . /tmp/foo/bin/activate
> pip install GitPython # I recognized the library from the import ;-)
> pip install ?? # I tried half a dozen but could not find one that matches the import github semantic

The module was githubpy (I agree there are too many of github python
modules around :-)) I added a basic argparser for the script; I've put
it up as a github repo at
https://github.com/theanalyst/ceph-release-helper

Let me know if you're facing any problems using it

Regards
Abhishek
