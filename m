From: Sage Weil <sage@newdream.net>
Subject: Re: uint32_t BlueStore::Extent::logical_offset?
Date: Tue, 22 Nov 2016 21:47:24 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611222146240.11236@piezo.us.to>
References: <8e0b5262-32ef-02a6-6812-a3e82369e9aa@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38263 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754734AbcKVVr6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Nov 2016 16:47:58 -0500
In-Reply-To: <8e0b5262-32ef-02a6-6812-a3e82369e9aa@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 22 Nov 2016, Igor Fedotov wrote:
> Hi Sage,
> 
> 
> I'm wondering why BlueStore::Extent::logical_offset is 32-bit wide.
> 
> IMHO it's to be uint64_t unless we limit onode size to 4Gb.
> 
> Looks like we have implicit truncate when doing set_lextent/new Extent at the
> moment and hence some issues with large onodes are possible.

The max object size enforced in the OSD is ~128 MB (or in that 
neighborhood, if I remember correctly).  We really shouldn't be storing 
individual rados objects that are orders of magnitude larger than that.

sage
