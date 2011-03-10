From: Sage Weil <sage@newdream.net>
Subject: Re: PG::Missing::rm
Date: Thu, 10 Mar 2011 09:56:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1103100955100.27049@cobra.newdream.net>
References: <AANLkTin79SwBJhVyGutV0PXRba7hMR7AF4+UQEWtiUFd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35371 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572Ab1CJRx4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2011 12:53:56 -0500
In-Reply-To: <AANLkTin79SwBJhVyGutV0PXRba7hMR7AF4+UQEWtiUFd@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 10 Mar 2011, Henry Chang wrote:
> Hi all,
> 
> I have another question about the function PG::Missing::rm.
> I wonder if it should be fixed as follows.
> 
> diff --git a/src/osd/PG.cc b/src/osd/PG.cc
> index 4ce3336..29062c8 100644
> --- a/src/osd/PG.cc
> +++ b/src/osd/PG.cc
> @@ -3600,7 +3600,7 @@ void PG::Missing::add(const sobject_t& oid,
> eversion_t need, eversion_t have)
> 
>  void PG::Missing::rm(const sobject_t& oid, eversion_t when)
>  {
> -  if (missing.count(oid) && missing[oid].need < when) {
> +  if (missing.count(oid) && missing[oid].need <= when) {
>      rmissing.erase(missing[oid].need);
>      missing.erase(oid);
>    }
> 
> I am not quite sure what the argument "when" means. However, in
> PG::merge_old_entry, it seems that the object will be removed from
> filestore but left in the missing list due to the if condition in
> missing.rm. As in the following code, although missing.rm is called,
> but it does not "really" remove the obj from the missing list since
> oe.version is equal to missing[oid].need.

Right.  This fix looks correct as well.  

Thanks!
sage

> 
>     if (oe.is_delete()) {
>       dout(20) << "merge_old_entry  had " << oe << " new dne : ok" <<
> dendl;
>     } else {
>       dout(20) << "merge_old_entry  had " << oe << " new dne :
> deleting" << dendl;
>       t.remove(coll, oe.soid);
>       missing.rm(oe.soid, oe.version);
>     }
> 
> -- 
> Henry Chang
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
