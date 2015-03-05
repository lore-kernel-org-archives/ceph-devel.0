From: Sage Weil <sage@newdream.net>
Subject: Re: FileStore performance: coalescing operations
Date: Wed, 4 Mar 2015 16:10:53 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1503041607590.25972@cobra.newdream.net>
References: <20150226152807.5b71a93c@doppio> <alpine.DEB.2.00.1503031641550.25972@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33839 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbbCEAKx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Mar 2015 19:10:53 -0500
In-Reply-To: <alpine.DEB.2.00.1503031641550.25972@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Bluemle <andreas.bluemle@itxperts.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 3 Mar 2015, Sage Weil wrote:
> I think we should try to avoid the dups in the first place in the upper 
> layers before resorting to deduping in the FileStore. 

I took a stab at this:

	https://github.com/ceph/ceph/pull/3878

Here's what the txns look like now:

{
    "ops": [
        {
            "op_num": 0,
            "op_name": "omap_setkeys",
            "collection": "0.2_head",
            "oid": "2\/\/head\/\/0",
            "attr_lens": {
                "0000000005.00000000000000000002": 178,
                "_epoch": 4,
                "_info": 729,
                "can_rollback_to": 12,
                "rollback_info_trimmed_to": 12
            }
        },
        {
            "op_num": 1,
            "op_name": "write",
            "collection": "0.2_head",
            "oid": "8b08fa52\/benchmark_data_maetl_15609_object5\/head\/\/0",
            "length": 123,
            "offset": 0,
            "bufferlist length": 123
        },
        {
            "op_num": 2,
            "op_name": "setattr",
            "collection": "0.2_head",
            "oid": "8b08fa52\/benchmark_data_maetl_15609_object5\/head\/\/0",
            "name": "_",
            "length": 269
        },
        {
            "op_num": 3,
            "op_name": "setattr",
            "collection": "0.2_head",
            "oid": "8b08fa52\/benchmark_data_maetl_15609_object5\/head\/\/0",
            "name": "snapset",
            "length": 31
        }
    ]
}

Care to give that a spin and see if it give syou a similar (or better) 
improvement?

sage
