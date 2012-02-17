From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [PATCH] doc: fix snapshot creation/deletion syntax in rbd man
 page (trivial)
Date: Fri, 17 Feb 2012 14:33:58 -0800
Message-ID: <4F3ED5D6.7040506@dreamhost.com>
References: <1329509715-21343-1-git-send-email-florian@hastexo.com> <1329509715-21343-2-git-send-email-florian@hastexo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:36200 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab2BQWd6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Feb 2012 17:33:58 -0500
In-Reply-To: <1329509715-21343-2-git-send-email-florian@hastexo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org

On 02/17/2012 12:15 PM, Florian Haas wrote:
> Creating a snapshot requires using "rbd snap create",
> as opposed to just "rbd create". Also for purposes of
> clarification, add note that removing a snapshot similarly
> requires "rbd snap rm".
>
> Thanks to Josh Durgin for the explanation on IRC.
>
> Signed-off-by: Florian Haas<florian@hastexo.com>
> ---
>   doc/man/8/rbd.rst |    6 +++++-
>   1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/doc/man/8/rbd.rst b/doc/man/8/rbd.rst
> index fbf8e3c..7069e30 100644
> --- a/doc/man/8/rbd.rst
> +++ b/doc/man/8/rbd.rst
> @@ -154,7 +154,11 @@ To delete an rbd image (be careful!)::
>
>   To create a new snapshot::
>
> -       rbd create mypool/myimage@mysnap
> +       rbd snap create mypool/myimage@mysnap
> +
> +To delete a snapshot::
> +
> +       rbd snap rm mypool/myimage@mysnap
>
>   To map an image via the kernel with cephx enabled::
>

Applied, thanks!
