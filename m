From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [patch] ceph: tidy some white space in get_nonsnap_parent()
Date: Thu, 23 Feb 2017 17:42:26 +0100
Message-ID: <CAOi1vP9V8F3z9AAO=-wMKVRKs8LDMLEBn3QM216S=iaVtKehkw@mail.gmail.com>
References: <20170223103852.GA27418@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34922 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdBWQm2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2017 11:42:28 -0500
In-Reply-To: <20170223103852.GA27418@mwanda>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Thu, Feb 23, 2017 at 11:39 AM, Dan Carpenter
<dan.carpenter@oracle.com> wrote:
> The white space here seems slightly messed up.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index fdbc3544e41c..c681762d76e6 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -679,8 +679,9 @@ static void __unregister_request(struct ceph_mds_client *mdsc,
>   * working with them. Once we hit a candidate dentry, we attempt to take a
>   * reference to it, and return that as the result.
>   */
> -static struct inode *get_nonsnap_parent(struct dentry *dentry) { struct inode
> -       *inode = NULL;
> +static struct inode *get_nonsnap_parent(struct dentry *dentry)
> +{
> +       struct inode *inode = NULL;
>
>         while (dentry && !IS_ROOT(dentry)) {
>                 inode = d_inode_rcu(dentry);

Applied.

Thanks,

                Ilya
