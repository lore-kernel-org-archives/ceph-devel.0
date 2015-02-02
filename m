From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC] several ceph dentry leaks
Date: Mon, 2 Feb 2015 00:31:24 +0000
Message-ID: <20150202003124.GQ29656@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

	What do you expect to happen when if () is taken in
int ceph_handle_notrace_create(struct inode *dir, struct dentry *dentry)
{
        struct dentry *result = ceph_lookup(dir, dentry, 0);

        if (result && !IS_ERR(result)) {

If result is non-NULL, it means that we have just acquired a new reference
to preexisting dentry (in ceph_finish_lookup()); where do you expect that
reference to be dropped?

Another thing: in ceph_readdir_prepopulate()
                if (!dn->d_inode) {  
                        dn = splice_dentry(dn, in, NULL); 
                        if (IS_ERR(dn)) {
                                err = PTR_ERR(dn);
                                dn = NULL;
                                goto next_item;
                        }
                }
you leak dn if that IS_ERR() ever gets hit - d_splice_alias(d, i) does *not*
drop reference to d in any cases, so splice_dentry() leaves the sum total
of all dentry refcounts unchanged.  And in case when return value is
ERR_PTR(...), this assignment results in a leak.  That one is trival to
fix, but ceph_handle_notrace_create() looks very confusing - if nothing else,
we should _never_ create multiple dentries pointing to directory inode, so
d_instantiate() in there isn't mitigating anything - it's actively breaking
things as far as the rest of the kernel is concerned...  What are you
trying to do there?
