From: Sage Weil <sage@newdream.net>
Subject: Re: FileStore performance: coalescing operations
Date: Tue, 3 Mar 2015 17:05:50 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1503031641550.25972@cobra.newdream.net>
References: <20150226152807.5b71a93c@doppio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54737 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757566AbbCDBFv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Mar 2015 20:05:51 -0500
In-Reply-To: <20150226152807.5b71a93c@doppio>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Bluemle <andreas.bluemle@itxperts.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 26 Feb 2015, Andreas Bluemle wrote:
> Hi,
> 
> during the performance weely meeting, I had mentioned
> my experiences concerning the transaction structure
> for write requests at the level of the FileStore.
> Such a transaction not only contains the OP_WRITE
> operation to the object in the file system, but also
> a series of OP_OMAP_SETKEYS and OP_SETATTR operations.
> 
> Find attached a README and source code patch, which
> describe a prototype for coalescing the OP_OMAP_SETKEYS
> operations and the performance impact f this change.

I think we should try to avoid the dups in the first place in the upper 
layers before resorting to deduping in the FileStore. 

Here's a sample transaction:

{
    "ops": [
        {
            "op_num": 0,
            "op_name": "omap_setkeys",
            "collection": "0.3_head",
            "oid": "3\/\/head\/\/0",
            "attr_lens": {
                "0000000005.00000000000000000057": 180
            }
        },

^ PG::append_log

        {
            "op_num": 1,
            "op_name": "omap_setkeys",
            "collection": "0.3_head",
            "oid": "3\/\/head\/\/0",
            "attr_lens": {
                "_epoch": 4,
                "_info": 729
            }
        },

^^ these two come from PG::_write_info()

        {
            "op_num": 2,
            "op_name": "omap_setkeys",
            "collection": "0.3_head",
            "oid": "3\/\/head\/\/0",
            "attr_lens": {
                "0000000005.00000000000000000057": 180,
                "can_rollback_to": 12,
                "rollback_info_trimmed_to": 12
            }
        },

^ PG::_write_log()

I think the log ones are easy to combine.. in fact I think we saw a pull 
request from somone reently that does this?

The _write_info() one is probably a slightly bigger challenge, but only 
slightly, given that both of these are called from

void PG::write_if_dirty(ObjectStore::Transaction& t)
{
  if (dirty_big_info || dirty_info)
    write_info(t);
  pg_log.write_log(t, coll, pgmeta_oid);
}


        {
            "op_num": 3,
            "op_name": "write",
            "collection": "0.3_head",
            "oid": "b2082803\/benchmark_data_maetl_20149_object474\/head\/\/0",
            "length": 123,
            "offset": 0,
            "bufferlist length": 123
        },

necessary

        {
            "op_num": 4,
            "op_name": "setattr",
            "collection": "0.3_head",
            "oid": "b2082803\/benchmark_data_maetl_20149_object474\/head\/\/0",
            "name": "_",
            "length": 271
        },

this too

        {
            "op_num": 5,
            "op_name": "setattr",
            "collection": "0.3_head",
            "oid": "b2082803\/benchmark_data_maetl_20149_object474\/head\/\/0",
            "name": "snapset",
            "length": 31
        }

We have a PR that avoids this second setattr when the value isn't 
changing, but at the moment the consensus is that it's complex and 
probably not worth merging.  It's also a much cheaper operation, so I 
suggest we fix the omap calls first and then compare performance w/ and 
w/o the snapset xattr changes to see how significant it is.

    ]
}

Thanks!
sage

