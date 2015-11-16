From: Sage Weil <sweil@redhat.com>
Subject: Re: a problem about FileStore::_destroy_collection
Date: Mon, 16 Nov 2015 07:15:02 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511160714420.7964@cobra.newdream.net>
References: <0C3F6DA3760D0C4691E69E5BE224FF495E17E901@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38466 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019AbbKPPPF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 16 Nov 2015 10:15:05 -0500
In-Reply-To: <0C3F6DA3760D0C4691E69E5BE224FF495E17E901@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "yangruifeng.09209@h3c.com" <yangruifeng.09209@h3c.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 16 Nov 2015, yangruifeng.09209@h3c.com wrote:
> an ENOTEMPTY error mybe happen when removing a pg in previous 
> versions?but the error is hidden in new versions?

When did this change?

sage

> _destroy_collection maybe return 0 when get_index or prep_delete return < 0;
> 
> is this intended?
> 
> int FileStore::_destroy_collection(coll_t c) 
> {
>   int r = 0;                             //global r
>   char fn[PATH_MAX];
>   get_cdir(c, fn, sizeof(fn));
>   dout(15) << "_destroy_collection " << fn << dendl;
>   {
>     Index from;
>     int r = get_index(c, &from);            //local r
>     if (r < 0)
>       goto out;
>     assert(NULL != from.index);
>     RWLock::WLocker l((from.index)->access_lock);
> 
>     r = from->prep_delete();
>     if (r < 0)
>       goto out;
>   }
>   r = ::rmdir(fn);
>   if (r < 0) {
>     r = -errno;
>     goto out;
>   }
> 
>  out:
>   // destroy parallel temp collection, too
>   ...
> 
>  out_final:
>   dout(10) << "_destroy_collection " << fn << " = " << r << dendl;
>   return r;
> }
> N????y????b?????v?????{.n??????z??ay????????j???f????????????????:+v??????????zZ+??????"?!?
