From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Adding compression support for bluestore.
Date: Mon, 15 Feb 2016 19:29:39 +0300
Message-ID: <56C1FCF3.4030505@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34938 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbcBOQ3f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Feb 2016 11:29:35 -0500
Received: by mail-lf0-f43.google.com with SMTP id l143so92343236lfe.2
        for <ceph-devel@vger.kernel.org>; Mon, 15 Feb 2016 08:29:34 -0800 (PST)
Received: from [127.0.0.1] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id fb9sm260034lbc.26.2016.02.15.08.29.32
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Feb 2016 08:29:32 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi guys,
Here is my preliminary overview how one can add compression support 
allowing random reads/writes for bluestore.

Preface:
Bluestore keeps object content using a set of dispersed extents aligned 
by 64K (configurable param). It also permits gaps in object content i.e. 
it prevents storage space allocation for object data regions unaffected 
by user writes.
A sort of following mapping is used for tracking stored object content 
disposition (actual current implementation may differ but representation 
below seems to be sufficient for our purposes):
Extent Map
{
< logical offset 0 -> extent 0 'physical' offset, extent 0 size >
...
< logical offset N -> extent N 'physical' offset, extent N size >
}


Compression support approach:
The aim is to provide generic compression support allowing random object 
read/write.
To do that compression engine to be placed (logically - actual 
implementation may be discussed later) on top of bluestore to 
"intercept" read-write requests and modify them as needed.
The major idea is to split object content into fixed size logical blocks 
( MAX_BLOCK_SIZE,  e.g. 1Mb). Blocks are compressed independently. Due 
to compression each block can potentially occupy smaller store space 
comparing to their original size. Each block is addressed using original 
data offset ( AKA 'logical offset' above ). After compression is applied 
each block is written using the existing bluestore infra. In fact single 
original write request may affect multiple blocks thus it transforms 
into multiple sub-write requests. Block logical offset, compressed block 
data and compressed data length are the parameters for injected 
sub-write requests. As a result stored object content:
a) Has gaps
b) Uses less space if compression was beneficial enough.

Overwrite request handling is pretty simple. Write request data is 
splitted into fully and partially overlapping blocks. Fully overlapping 
blocks are compressed and written to the store (given the extended write 
functionality described below). For partially overwlapping blocks ( no 
more than 2 of them - head and tail in general case)  we need to 
retrieve already stored blocks, decompress them, merge the existing and 
received data into a block, compress it and save to the store using new 
size.
The tricky thing for any written block is that it can be both longer and 
shorter than previously stored one.  However it always has upper limit 
(MAX_BLOCK_SIZE) since we can omit compression and use original block if 
compression ratio is poor. Thus corresponding bluestore extent for this 
block is limited too and existing bluestore mapping doesn't suffer: 
offsets are permanent and are equal to originally ones provided by the 
caller.
The only extension required for bluestore interface is to provide an 
ability to remove existing extents( specified by logical offset, size). 
In other words we need write request semantics extension ( rather by 
introducing an additional extended write method). Currently overwriting 
request can either increase allocated space or leave it unaffected only. 
And it can have arbitrary offset,size parameters pair. Extended one 
should be able to squeeze store space ( e.g. by removing existing 
extents for a block and allocating reduced set of new ones) as well. And 
extended write should be applied to a specific block only, i.e. logical 
offset to be aligned with block start offset and size limited to 
MAX_BLOCK_SIZE. It seems this is pretty simple to add - most of the 
functionality for extent append/removal if already present.

To provide reading and (over)writing compression engine needs to track 
additional block mapping:
Block Map
{
< logical offset 0 -> compression method, compressed block 0 size >
...
< logical offset N -> compression method, compressed block N size >
}
Please note that despite the similarity with the original bluestore 
extent map the difference is in record granularity: 1Mb vs 64Kb. Thus 
each block mapping record might have multiple corresponding extent 
mapping records.

Below is a sample of mappings transform for a pair of overwrites.
1) Original mapping ( 3 Mb were written before, compress ratio 2 for 
each block)
Block Map
{
  0 -> zlib, 512Kb
  1Mb -> zlib, 512Kb
  2Mb -> zlib, 512Kb
}
Extent Map
{
  0 -> 0, 512Kb
  1Mb -> 512Kb, 512Kb
  2Mb -> 1Mb, 512Kb
}
1.5Mb allocated [ 0, 1.5 Mb] range )

1) Result mapping ( after overwriting 1Mb data at 512 Kb offset, 
compress ratio 1 for both affected blocks)
Block Map
{
  0 -> none, 1Mb
  1Mb -> none, 1Mb
  2Mb -> zlib, 512Kb
}
Extent Map
{
  0 -> 1.5Mb, 1Mb
  1Mb -> 2.5Mb, 1Mb
  2Mb -> 1Mb, 512Kb
}
2.5Mb allocated ( [1Mb, 3.5 Mb] range )

2) Result mapping ( after (over)writing 3Mb data at 1Mb offset, compress 
ratio 4 for all affected blocks)
Block Map
{
  0 -> none, 1Mb
  1Mb -> zlib, 256Kb
  2Mb -> zlib, 256Kb
  3Mb -> zlib, 256Kb
}
Extent Map
{
  0 -> 1.5Mb, 1Mb
  1Mb -> 0Mb, 256Kb
  2Mb -> 0.25Mb, 256Kb
  3Mb -> 0.5Mb, 256Kb
}
1.75Mb allocated (  [0Mb-0.75Mb] [1.5 Mb, 2.5 Mb )


Any comments/suggestions are highly appreciated.

Kind regards,
Igor.





