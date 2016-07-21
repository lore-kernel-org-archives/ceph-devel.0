From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: Shrinking the oNode encoding
Date: Thu, 21 Jul 2016 03:56:10 +0000
Message-ID: <BLUPR0201MB152420636B031DFD6A559173E8090@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2nam02on0054.outbound.protection.outlook.com ([104.47.38.54]:60993
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750800AbcGUD4P convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jul 2016 23:56:15 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

As I described earlier, I've written a new serialization framework that is dramatically faster because it relies on pre-allocating the worst-case serialization buffer that's required. It's not quite in a state for a full PR, but it's been written and a good set of unit test cases against it have been written and are working. I hesitate to make a PR out of it until it's actually been used in real-life code. I suspect that some of the interfaces might get tweaked a bit by that activity. I'm encouraging comments about the code which is in my repository http://www.github.com/allensamuels/ceph.git. Look for the files enc_dec.h and test_enc_dec.cc

Here's description of how I propose to use that framework to shrink the oNode. Again, comments appreciated. That work will commence shortly.

--------------------------------

I've pretty much figured out the entire redesign of the oNode serialize/deserialize that should be somewhat more optimal than the current scheme (faster AND smaller).

You'll need to read the code in enc_dec.h, while the details of a enc_dec function are somewhat different than the current scheme (encode separate from decode). The same basic scheme applies, i.e., you enc_dec an object which is responsible for serializing itself. For the primitive types and stl containers, there is already infrastructure to do the work for you. 

A key difference (which will matter below) is that you can extend the container serialization logic with an arbitrary "context" class parameter that you can extend to your own custom coding. This is a critical extension because it allows intra-element differencing. More on this later.

Today, serializing the onode is a two step operation. You serialize the onode together with the blob_map that's a part of it They are in two different objects in memory, but part of the same serialized data stream -- essentially one serialized object. Serializing the oNode consists of serializing a number of ints and some random fields, the map of attribute strings and the lextent map. Finally the blob_map is serialized (appended) to form the final serialized value.

In my new design, both of the oNode and the Blobmap are serialized in a single operation. The trick that we're going to do is to serialize the blobmap as a part of serializing the lextent map.

It's important to understand the relationship between the lextent the blob_maps (yes, there are two of them -- local and shared, 2 into 1 serialization only deals with the local blob_map the global blob_map is handled totally differently and outside of the scope of this optimization.

The core of the idea to save space in the serialized oNode (+blob_map) is to realize that there is a pointer from the lextent entry to the blob_map (blob_id_t). Today, this pointer is serialized as an integer (likely one or two bytes) in the lextent entry as well as being duplicated in the serialized blobmap. We're going to away with that redundancy. Saving at least 2 bytes per lextent entry in the worst-case (which is what Somnath is seeing in the 4K random write tests). More on this in a minute.

Let's look at the lextent entry in detail. It has four fields: key, offset, length and blob_id. For the "dense" random 4K overwrite case (that will get benchmarked :)) and a 4M object size, the current lextent serializes into the following:

~1.98 bytes for the key (the key will range from 0..4M in 4K increments. 32 in 1 byte, 4064 in two bytes => 1.98 average.
1 byte for the offset
1 byte for the length
~1.98 bytes for the blob_id

6 bytes per entry.

However, from a use-case perspective there are some "almost always" values that are worth special-case encoding.

(1) If there are no "holes" in the logical extent space (almost always true), then the key need not be encoded since it's the same as the key of the previous entry + it's length.
(2) The offset within a blob entry is frequently 0 (this happens whenever a you have some data that hasn't yet been partially overwritten).
(3) The length of the lextent entry is often the same as the length of the corresponding blob entry
(4) The length field itself will always be a multiple of 512 and often a multiple of the MAS (min allocation size). The current varint_lowz does a decent job of this, but we can do even better by scaling the values accordingly.
(5) Most blob_ids are local and 1:1 with their corresponding lextent entries. They can be encoded positionally (see below for details).

Thus, based on these "almost always". I would propose that the entire four element entry (key, offset, length, blob_id) be replaced by the following scheme:

There is a leading "control" byte that contains:

1 bit for the "no hole" optimization, i.e., this key is same as previous entry + length and therefore omitted. If key is required, it's encoded next in the buffer.
1 bit for offset is zero or not zero. If not zero, then the length is present next in the stream .
1 bit for the "blob_id" optimization. <see below>

That leaves 5 unsued bits in the control byte -- stay tuned we'll use them when a blob is present.

This leads to best-case encoding of about 1 byte for the lextent entry. In fact if the object has no shared extents and no holes, this encoding always beats the current encoding significantly.

This is a 5K savings in the encoded oNode over the current encoding -- and we haven't looked at the savings that are possible in the blob_map itself.

Now, I'll describe the "blob_id" optimization. Each lextent entry contains a blob_id, which is either global (negative) or local (positive). It it possible that multiple lextent entries can refer to the same blob (at different offsets and lengths), and this will happen whenever you get overlapping overwrites of different sizes. It's important to notice that the actual values of local blob_ids need not be preserved as they are unknown outside of the oNode, they simply are used to connect lextent entries to blobs that are in the same oNode. My optimization will re-write them, but preserve the structure, i.e., the semantic value is the linkage between the lextent and the blob not the numerical value of the blob_id itself.

The easiest way to think about the optimization is to think in terms of lextent entries and recognize that serializing/deserializing an lextent entry may have the side effect of also serializing/deserialing a blob OR a reference to a previous blob.

Here is the pseudo code for encode operation:

map<blob_id,blob_id> rename; // on serialize, this converts "old" blob_id values into "new" blob_id values.
blob_id next_new_blob_id = 1;    

for (auto &l : lextents) { // loop for each lextent.
   .... encode non-blob-id stuff........
   b = <blob_id of this lextent>
   if (b is global) {
      //
      serialize b (as a signed varint :))
      //
   } else if (rename.find(b) != rename.end()) {
      //
      // We've already serialized the blob for this and renamed it. Just use that value
      //
      serialize rename[b] as the "previous" blob_id
   } else {
      //
      // This is the first time we've encountered this blob_id
      //
      rename[b] = next_new_blob_id;
      next_new_blob_id++;
      //
      // Now serialize the blob itself (sans blob_id :))
      //
      ,...enc_dec(blob_map[b]);
   }
}

//
// Likewise the decode is trivial. Each entry either has
//  (1) a global blob_id
//  (2) a local blob_id
//  (3) a serialized blob, which is implicitly named by it's sequence.
//

Now, let's return to the blob itself. As described above, within an oNode, the blob_id need to be encoded (it's encoded positionally). The remaining fields are:

vector<pextents>
compressed length
Flags (an int32 but only a few bits are used)
ref_map
unused_map
checksum_order
checksum_type
vector<char> checksum

The current code makes these fields conditionally present: unused_map, checksum_order, checksum_type checksum_vector, compressed_length and uses bits in the "Flags" to enable/disable those fields.

Several further optimizations are possible:

(1) Most blobs will only have 1 extent.
(2) Most blobs in an oNode will have the same checksum_order and checksum_type
(3) The length of the checksum vector can be deduced from the other fields (pextent length, checksum order). It's not clear to me if the deduced size of the vector matches the actual vector size whether we should assert out or not (IMO, yes).
(4) The refmap is known to be redundant with the lextent information. It never needs to be encoded, just reconstructed as we deserialize (there were emails on this point earlier, it's apparently never been implemented).

Optimizations (1) and (2) can easily be controlled by some of the 5 unused bits in the control word (see above) for the lextent that encodes this blob.

1 bit indicating that there is only a single extent, not a vector of extents.
1 bit indicating that the checksum_present, checksum_order and checksum_type is same as what's present in the oNode itself.

Leaving 3 bits still unused. I *suggest* the following usage:

1 bit that duplicates the flags.is_compressed (i.e., compressed length is present)
1 bit that duplicates the flags.unused_map is present
1 bit to indicate that MORE flags are present (room for expansion) The only time this is present in current code is if checksum information is present but DIFFERENT from the corresponding defaultl values in the oNode.

Let's do an estimate for Somnaths random 4K write situation (with checksums enabled)

Current:
blob_id  ~1.875 bytes (128 in 1 byte, 896 in two bytes) => 1,875 
vector<pextent> 1 byte length, 4 bytes address, 1 byte length => 6 bytes
flags: 1 byte
checksum_order 1 byte
checksum_type  1 byte
vector<char> checksum: 5 bytes (assuming 32-bit checksum)
ref_map: map_size 1 byte, key 1 byte, length 1 byte usecount 1 byte.

Total is ~20 bytes per blob (1K blobs per oNode)

With my encoding scheme:

<a few bits of the control byte already accounted for>
pextent address and length => 5 bytes
checksum 4 bytes

Total is 9 bytes.

Thus for a worst-case oNode in Somnaths random 4K write workload, we see the following numbers:

Current scheme is 6 bytes per lextent and 20 bytes per blob. with 1K lextents/blobs is about 26K

In the new scheme we should be down to 1 + 9 => 10 * 1K => 10K bytes.

Further space savings could be done by:

(a) going with 16-bit checksums
(b) consuming another control byte flag to indicate a pextent size of one MAS.

This would reduce 3 bytes per entry or down to 7K bytes.

Getting the serialized oNode below 8K bytes is important for ZetaScale which uses 8K bTree pages.
