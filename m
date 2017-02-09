From: Abhishek L <abhishek@suse.com>
Subject: Re: GPG signing of upstream release tags
Date: Thu, 09 Feb 2017 21:32:10 +0100
Message-ID: <87inojxfzp.fsf@suse.com>
References: <20170209160345.1cf38e78@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:56632 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932144AbdBIUxN (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Thu, 9 Feb 2017 15:53:13 -0500
In-reply-to: <20170209160345.1cf38e78@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


David Disseldorp writes:

> Hi,
>
> TL;DR: release tags should be GPG signed, to allow for downstream source
>        verification.
>
> Upstream Ceph releases are currently tagged in Git by the Jenkins Build
> Slave User following successful testing. Since v11.0.0/v10.0.5/v0.94.3,
> these tags have not been GPG signed, so downstream consumers have no
> reliable way of verifying that the source they have matches the reviewed
> and tested upstream release source.
>
> Release announcements also (AFAICT) make no mention of the tag's
> corresponding SHA-1 commit hash.
>
> IMO, failing to offer users/packagers a means of verification places too
> much trust in Github[1], and could again lead to an incident similar in
> severity to the previous ceph.com / download.inktank.com intrusion[2]
> detected in 2015.

+1, I'll add the commit sha1 as well while doing the release
announcements. Remind me if I don't.
>
> To address this, I propose that:
> - *All* future upstream releases tags and tarballs are GPG signed by the
>   release manager.
> - The signing key used by the release manager is signed by Sage's GPG
>   key, and / or keys of other Core Team members.
> - The public key is available on Ceph.com.
> - Downstream users / packagers are instructed to verify their sources.

Currently the git tag is done via a jenkins job (which I believe calls
ansible) to do the git tag + deb package versions, since we already sign
the deb pacakges with the release key, maybe Andrew/Alfredo can comment
on how easy it would be to add gpg signing of git tags itself in the
jenkins tag workflow itself?

Best,
Abhishek
