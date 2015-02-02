From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [RFC] several ceph dentry leaks
Date: Mon, 2 Feb 2015 11:23:58 +0800
Message-ID: <CAAM7YAm_ZRtEG3iOGsgY8wYNXYBJhKMQLk=3knqmtef4N8nKKA@mail.gmail.com>
References: <20150202003124.GQ29656@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20150202003124.GQ29656@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Mon, Feb 2, 2015 at 8:31 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>         What do you expect to happen when if () is taken in
> int ceph_handle_notrace_create(struct inode *dir, struct dentry *dentry)
> {
>         struct dentry *result = ceph_lookup(dir, dentry, 0);
>
>         if (result && !IS_ERR(result)) {
>
> If result is non-NULL, it means that we have just acquired a new reference
> to preexisting dentry (in ceph_finish_lookup()); where do you expect that
> reference to be dropped?
>
> Another thing: in ceph_readdir_prepopulate()
>                 if (!dn->d_inode) {
>                         dn = splice_dentry(dn, in, NULL);
>                         if (IS_ERR(dn)) {
>                                 err = PTR_ERR(dn);
>                                 dn = NULL;
>                                 goto next_item;
>                         }
>                 }
> you leak dn if that IS_ERR() ever gets hit - d_splice_alias(d, i) does *not*
> drop reference to d in any cases, so splice_dentry() leaves the sum total
> of all dentry refcounts unchanged.  And in case when return value is
> ERR_PTR(...), this assignment results in a leak.  That one is trival to
> fix, but ceph_handle_notrace_create() looks very confusing - if nothing else,
> we should _never_ create multiple dentries pointing to directory inode, so
> d_instantiate() in there isn't mitigating anything - it's actively breaking
> things as far as the rest of the kernel is concerned...  What are you
> trying to do there?

ceph_handle_notrace_create() is for case: Ceph Metadata server restarted,
client re-sent a request. Ceph MDS found the request has already completed,
so it sent a traceless reply to client. (traceless reply contains no information
for the dentry and the newly created inode). It's hard to handle this case
elegantly, because MDS may have done other operation, which moved the
newly created file/directory to other place.

For multiple dentries pointing to directory inode, maybe we can return an error
(-ENOENT or -ESTALE).

Regards
Yan, Zheng


> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
