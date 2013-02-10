From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 01/15] kv_flat_btree_async.cc: use vector instead of
 VLA's
Date: Sat, 9 Feb 2013 21:57:52 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302092155330.11665@cobra.newdream.net>
References: <1360266123-28972-1-git-send-email-danny.al-gaaf@bisect.de> <1360266123-28972-2-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54198 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab3BJF5x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Feb 2013 00:57:53 -0500
In-Reply-To: <1360266123-28972-2-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>

On Thu, 7 Feb 2013, Danny Al-Gaaf wrote:
> Fix "variable length array of non-POD element type" errors caused by
> using librados::ObjectWriteOperation VLAs. (-Wvla)
> 
> Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
> ---
>  src/key_value_store/kv_flat_btree_async.cc | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/src/key_value_store/kv_flat_btree_async.cc b/src/key_value_store/kv_flat_btree_async.cc
> index 96c6cb0..4342e70 100644
> --- a/src/key_value_store/kv_flat_btree_async.cc
> +++ b/src/key_value_store/kv_flat_btree_async.cc
> @@ -1119,9 +1119,9 @@ int KvFlatBtreeAsync::cleanup(const index_data &idata, const int &errno) {
>      //all changes were created except for updating the index and possibly
>      //deleting the objects. roll forward.
>      vector<pair<pair<int, string>, librados::ObjectWriteOperation*> > ops;
> -    librados::ObjectWriteOperation owos[idata.to_delete.size() + 1];
> +    vector<librados::ObjectWriteOperation*> owos(idata.to_delete.size() + 1);

I haven't read much of the surrounding code, but from what is included 
here I don't think this is equivalent... these are just null pointers 
initially, and so

>      for (int i = 0; i <= (int)idata.to_delete.size(); ++i) {
> -      ops.push_back(make_pair(pair<int, string>(0, ""), &owos[i]));
> +      ops.push_back(make_pair(pair<int, string>(0, ""), owos[i]));

this doesn't do anything useful... owos[i] may as well be NULL.  Why not 
make it

vector<librados::ObjectWriteOperation> owos(...)

?

>      }
>      set_up_ops(vector<object_data>(),
>  	vector<object_data>(), &ops, idata, &err);
> @@ -1883,23 +1883,23 @@ int KvFlatBtreeAsync::set_many(const map<string, bufferlist> &in_map) {
>    to_create[to_create.size() - 1].max_kdata =
>        to_delete[to_delete.size() - 1].max_kdata;
>  
> -  librados::ObjectWriteOperation owos[2 + 2 * to_delete.size()
> -                                      + to_create.size()];
> +  vector<librados::ObjectWriteOperation*> owos(2 + 2 * to_delete.size()
> +                                      + to_create.size());

Same thing here...

>    vector<pair<pair<int, string>, librados::ObjectWriteOperation*> > ops;
>  
>  
>    index_data idata;
> -  set_up_prefix_index(to_create, to_delete, &owos[0], &idata, &err);
> +  set_up_prefix_index(to_create, to_delete, owos[0], &idata, &err);
>  
>    if (verbose) cout << "finished making to_create and to_delete. "
>        << std::endl;
>  
>    ops.push_back(make_pair(
>        pair<int, string>(ADD_PREFIX, index_name),
> -      &owos[0]));
> +      owos[0]));
>    for (int i = 1; i < 2 + 2 * (int)to_delete.size() + (int)to_create.size();
>        i++) {
> -    ops.push_back(make_pair(make_pair(0,""), &owos[i]));
> +    ops.push_back(make_pair(make_pair(0,""), owos[i]));
>    }
>  
>    set_up_ops(to_create, to_delete, &ops, idata, &err);
> -- 
> 1.8.1.2
> 
> 
