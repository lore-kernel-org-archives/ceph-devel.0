From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [ceph] what's going on with d_rehash() in splice_dentry()?
Date: Wed, 2 Mar 2016 11:00:01 +0800
Message-ID: <B17B70FF-4B76-4593-9D96-F0298F83AEB3@redhat.com>
References: <20160226174250.GA17997@ZenIV.linux.org.uk> <alpine.DEB.2.11.1603010946290.24758@cpach.fuggernut.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48936 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754970AbcCBDAT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Mar 2016 22:00:19 -0500
In-Reply-To: <alpine.DEB.2.11.1603010946290.24758@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org


> On Mar 1, 2016, at 22:50, Sage Weil <sweil@redhat.com> wrote:
> 
> Hi Al,
> 
> On Fri, 26 Feb 2016, Al Viro wrote:
>> You have, modulo printks and BUG_ON(),
>> {
>>        struct dentry *realdn;
>>        /* dn must be unhashed */
>>        if (!d_unhashed(dn))
>>                d_drop(dn);
>>        realdn = d_splice_alias(in, dn);
>>        if (IS_ERR(realdn)) {
>>                if (prehash)
>>                        *prehash = false; /* don't rehash on error */
>>                dn = realdn; /* note realdn contains the error */
>>                goto out;
>>        } else if (realdn) {
>>                dput(dn);
>>                dn = realdn;
>>        }
>>        if ((!prehash || *prehash) && d_unhashed(dn))
>>                d_rehash(dn);
>> 
>> When d_splice_alias() returns NULL it has hashed the dentry you'd given it;
>> when it returns a different dentry, that dentry is also returned hashed.
>> IOW, d_rehash(dn) in there should never be called.
>> 
>> If you have a case when it _is_ called, you've found a bug somewhere and
>> I'd like to see details.  AFAICS, the whole prehash thing appears to be
>> pointless - even the place where we modify *prehash, since in that case
>> we return ERR_PTR() and the only caller passing non-NULL prehash (&have_lease)
>> buggers off on such return value past all code that would look at have_lease
>> value.
> 
> Right.
> 
>> One possible reading is that you want to prevent hashing in !have_lease
>> case of
>>                        dn = splice_dentry(dn, in, &have_lease);
>> If that's the case, you might have a problem, since it will be hashed no
>> matter what...
> 
> In this case it doesn't actually matter if it is hashed or not, since 
> we will look at the lease state on the dentry before trusting it...
> 
> This code dates back to when Ceph was originally upstreamed, so the 
> history is murky, but I expect at that point I wanted to avoid hashing in 
> the no-lease case.  But I don't think it matters.  We should just remove 
> the prehash argument from splice_dentry entirely.
> 
> Zheng, does that sound right?

Yes. I think we can remove the d_rehash(dn) call and rehash parameter.

Regards
Yan, Zheng 