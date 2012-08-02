From: Tommi Virtanen <tv@inktank.com>
Subject: Re: [PATCH] doc: Correct Git URL for clone
Date: Thu, 2 Aug 2012 08:39:12 -0700
Message-ID: <CADvuQRHbVPFT+QTUg8UevenMDFmWxW3BL57RmEGZB-1UisRk2w@mail.gmail.com>
References: <1343904506-3633-1-git-send-email-wido@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43952 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab2HBPjd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Aug 2012 11:39:33 -0400
Received: by vcbfk26 with SMTP id fk26so8339421vcb.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Aug 2012 08:39:33 -0700 (PDT)
In-Reply-To: <1343904506-3633-1-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>, John Wilkins <john.wilkins@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Aug 2, 2012 at 3:48 AM, Wido den Hollander <wido@widodh.nl> wrote:
> Signed-off-by: Wido den Hollander <wido@widodh.nl>
> ---
>  doc/source/clone-source.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/source/clone-source.rst b/doc/source/clone-source.rst
> index e2bc95d..2236b37 100644
> --- a/doc/source/clone-source.rst
> +++ b/doc/source/clone-source.rst
> @@ -9,7 +9,7 @@ Clone the Source
>  ----------------
>  To clone the Ceph source code repository, execute::
>
> -       git clone git@github.com:ceph/ceph.git
> +       git clone git://github.com/ceph/ceph.git

Actually, in the world of github, https://github.com/ceph/ceph.git is
the best option. MITM safe and passes through more firewalls. I
amended the patch to say that, and pushed to master. Thank you for
noticing!

(I'm also rewriting the next paragraph after that, as it's both
cumbersome and actually wrong.)


John, the docs at http://ceph.com/docs/master/source/git/ could still
use improvement -- nobody needs a Github account just to clone a
repository. The "Generate SSH keys" and "Add the key" sections belong
under http://ceph.com/docs/master/source/contributing/ -- which then
again should talk about sending patches to mailing list, doing work in
your own fork on Github, perhaps using Github pull requests, etc. This
is the old school explanation, largely copied over from the Linux
kernel: https://github.com/ceph/ceph/blob/master/SubmittingPatches
