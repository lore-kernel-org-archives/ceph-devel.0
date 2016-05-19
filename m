From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Initial proposal for bluestore compression control and statistics
Date: Thu, 19 May 2016 20:27:02 +0300
Message-ID: <2ec0367c-ea9e-469e-4a80-b2a242c84f0f@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36401 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753433AbcESR1I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2016 13:27:08 -0400
Received: by mail-lf0-f45.google.com with SMTP id e130so5216687lfe.3
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2016 10:27:07 -0700 (PDT)
Received: from [127.0.0.1] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id jn5sm2518780lbc.24.2016.05.19.10.27.04
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 May 2016 10:27:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi cephers,

please find my initial proposal with regard to bluestore compression 
control and related statistics.

Any comments/thoughts are highly appreciated.

==================================================================

COMPRESSION CONTROL OPTIONS

One can see following means to control  compression at BlueStore level.

1) Per-store setting to enable/disable compression and specify default 
compression method

bluestore_compression = <zlib | snappy> / <force | optional | disable>

E.g.

bluestore_compression = zlib/force

The first token denotes default/applied compression algorithm.
The second one:

'force' - enables compression for any objects

'optional' - burden the caller with the need to enable compression by 
different means (see below)

'disable' - unconditionally disables any compression for the store.

This option is definitely useful for testing/debugging and has probably 
limited use in production.


2) Per-object compression specification. One should be able to 
enable/disable compression for specific object.

Following sub-option can be provided:

   a) Specify compression mode (along with disablement option) at object 
creation

   b) Specify compression mode at arbitrary moment via specific 
method/ioctl call. Compression to be applied for subsequent write requests

   c) Force object compression/decompression at arbitrary moment via 
specific method/ioctl call. Existing object content to be 
compressed/decompressed and appropriate mode to be set for subsequent 
write requests.

   d) Disable compression for short-lived objects if corresponding hint 
has been provided via set_alloc_hint2 call. See PR at 
https://github.com/ceph/ceph/pull/6208/files/306c5e148cd2f538b3b6c8c2a1a3d5f38ef8e15a#r63775941

Along with specific compression algorithm one should be able to specify 
default algorithm selection. E.g. user can specify 'default' compression 
for an object instead of specific 'zlib' or 'snappy' value.

This way one can avoid the need to care about the proper algorithm 
selection for each object.

Default algorithm to be taken from the store setting (see above)

Such an option provides pretty good level of flexibility. Upper level 
can introduce additional logic to control compression this way, e.g. 
enable/disable it for specific pools or dynamically control depending on 
how compressible object content is.

3) Per-write request compression control.

This option provides the highest level of flexibility but is probably an 
overkill.

Any rationales to have it?

==================================================================

PER-STORE STATISTICS

Following statistics parameters to be introduced on per-store basis:

1) Allocated - total amount of data in allocated blobs

2) Stored - actual amount of stored object content, i.e. sum of all 
objects uncompressed content

3) StoredCompressed - amount of stored compressed data

4) StoredCompressedOriginal - original amount of stored compressed data

5) CompressionProcessed - amount of data processed by the compression. 
This differ from 'StoredCompressed' as some data can be finally stored 
uncompressed or removed. Also potentially the parameter can be reset by 
some means.

6) CompressOpsCount - amount of compression operations completed. The 
parameter can be reset by some means.

7) CompressTime - amount of time spent for compression. The parameter 
can be reset by some means.

8) WriteOpsCount - amount of write operations completed. The parameter 
can be reset by some means.

9) WriteTime - amount of time spent for write requests processing. The 
parameter can be reset by some means.

10) WrittenTotal - amount of written data.

11) DecompressionProcessed - amount of data processed by decompression. 
The parameter can be reset by some means.

12) DecompressOpsCount - amount of decompression operations completed. 
The parameter can be reset by some means.

13) DecompressTime - amount of time spent for compression. The parameter 
can be reset by some means.

14) ReadOpsCount - amount of read operations completed. The parameter 
can be reset by some means.

15) ReadTime - amount of time spent for read requests processing. The 
parameter can be reset by some means.

16) ReadTotal - amount of read data. The parameter can be reset by some 
means.

Handling parameters 11)-16) can be a bit tricky as we might want to 
avoid KV updates during reading. Thus we need some means to periodically 
store these parameters or just track them in-memory.

==================================================================

PER-OBJECT STATISTICS NOTES

It might be useful to have per-object statistics similar to the above 
mentioned per-store one. This way upper level can revise compression 
results and adjust the process accordingly.

The drawbacks are onode footprint increase and additional complexities 
for read op handling though.

If collected per-object statistics should be retrieved by using specific 
method/ioctl.

Perhaps we can introduce some object creation flag ( or extend 
alloc_hints or provide an ioctl ) to enable statistics collection for 
specific objects only?

Any thought on the need for that?

==================================================================

ADDITIONAL NOTES

1) It seems helpful to introduce additional means to indicate 
NO-MORE_WRITES event from upper level to BlueStore. This way one 
provides a hint that allows bluestore to trigger some background 
optimization on the object, e.g. garbage collection, defragmentation, etc.


