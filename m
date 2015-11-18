From: Sage Weil <sage@newdream.net>
Subject: Re: problem about pgmeta object?
Date: Wed, 18 Nov 2015 05:12:18 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511180511420.7964@cobra.newdream.net>
References: <CALZt5jx2bQKK6yE=bTu96CD=OE7uVGTagfqirHsXh5bNbS2t=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37703 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755800AbbKRNMT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Nov 2015 08:12:19 -0500
In-Reply-To: <CALZt5jx2bQKK6yE=bTu96CD=OE7uVGTagfqirHsXh5bNbS2t=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 18 Nov 2015, Ning Yao wrote:
> Hi, Sage
> 
> pgmeta object is a meta-object (like __head_00000000__2) without
> significant information. It is created when in PG::_init() when
> handling pg_create and split_coll and always exits there during pg's
> life cycle until pg is removed in RemoveWQ. The real content related
> to pgmeta-data is stored in omap. we may just treat pgmeta-object as a
> logical object and not present it physically so that we can avoid
> recursive searching object path by if(hoid.pgmeta())?
> such as:
> int FileStore::_omap_setkeys(coll_t cid, const ghobject_t &hoid,
>     const map<string, bufferlist> &aset,
>     const SequencerPosition &spos) {
>   dout(15) << __func__ << " " << cid << "/" << hoid << dendl;
>   Index index;
>   int r;
>   if(hoid.pgmeta())
>     goto out;
> ***
> ***
> ***
> out:
>   r = object_map->set_keys(hoid, aset, &spos);
>   dout(20) << __func__ << " " << cid << "/" << hoid << " = " << r << dendl;
>   return r;
> }

This seems like a reasonable hack. We never store any byte data in it.  
And if/when that changes, we can change this at the same time.

sage
