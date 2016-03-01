From: Sage Weil <sweil@redhat.com>
Subject: Re: [ceph] what's going on with d_rehash() in splice_dentry()?
Date: Tue, 1 Mar 2016 09:50:24 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603010946290.24758@cpach.fuggernut.com>
References: <20160226174250.GA17997@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160226174250.GA17997@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, zyan@redhat.com, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Al,

On Fri, 26 Feb 2016, Al Viro wrote:
> You have, modulo printks and BUG_ON(),
> {
>         struct dentry *realdn;
>         /* dn must be unhashed */
>         if (!d_unhashed(dn))
>                 d_drop(dn);
>         realdn = d_splice_alias(in, dn);
>         if (IS_ERR(realdn)) {
>                 if (prehash)
>                         *prehash = false; /* don't rehash on error */
>                 dn = realdn; /* note realdn contains the error */
>                 goto out;
>         } else if (realdn) {
>                 dput(dn);
>                 dn = realdn;
>         }
>         if ((!prehash || *prehash) && d_unhashed(dn))
>                 d_rehash(dn);
> 
> When d_splice_alias() returns NULL it has hashed the dentry you'd given it;
> when it returns a different dentry, that dentry is also returned hashed.
> IOW, d_rehash(dn) in there should never be called.
> 
> If you have a case when it _is_ called, you've found a bug somewhere and
> I'd like to see details.  AFAICS, the whole prehash thing appears to be
> pointless - even the place where we modify *prehash, since in that case
> we return ERR_PTR() and the only caller passing non-NULL prehash (&have_lease)
> buggers off on such return value past all code that would look at have_lease
> value.

Right.
 
> One possible reading is that you want to prevent hashing in !have_lease
> case of
>                         dn = splice_dentry(dn, in, &have_lease);
> If that's the case, you might have a problem, since it will be hashed no
> matter what...

In this case it doesn't actually matter if it is hashed or not, since 
we will look at the lease state on the dentry before trusting it...

This code dates back to when Ceph was originally upstreamed, so the 
history is murky, but I expect at that point I wanted to avoid hashing in 
the no-lease case.  But I don't think it matters.  We should just remove 
the prehash argument from splice_dentry entirely.

Zheng, does that sound right?

Thanks!
sage
