From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Ceph status for Wheezy
Date: Mon, 2 Jul 2012 14:13:15 -0700
Message-ID: <CAC-hyiFto=rtR+2A-z=id4SC1npLneR7qvPAZEBEzkE=UZba6g@mail.gmail.com>
References: <1341122210.10000.46.camel@julia>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63955 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553Ab2GBVNR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 17:13:17 -0400
Received: by bkwj10 with SMTP id j10so1107354bkw.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 14:13:16 -0700 (PDT)
In-Reply-To: <1341122210.10000.46.camel@julia>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Cc: Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Jun 30, 2012 at 10:56 PM, Laszlo Boszormenyi (GCS)
<gcs@debian.hu> wrote:
> Hi Sage,
>
> As previously noted, using leveldb caused some trouble with Ceph could
> be included in Wheezy or not.
> I've proposed that the supported architectures should be limited in Ceph
> and leveldb to the ones the latter supports. I got a release critical
> bugreport[1] that it should be reversed. Alessio Treglia, the leveldb
> maintainer in Debian wrote the following:
> "I'm going to test leveldb on powerpc and then I'll report my results
> to upstream.
> Hence I cannot promise it will be ready in time for Wheezy, of course
> I'll upload a patch as soon as a fix becomes available.".
>
> Upstream was asked[2], noted that it fails on big-endian architectures,
> but no answer until now.
>
> Then, as it was previously announced, the freeze of Wheezy started some
> hours ago[3].
>
> Soon, after that Julien Cristau, one of our Release Assistant noted
> about Ceph doesn't build on all architectures due to leveldb:
> "Unless this gets fixed we'll have to remove ceph from wheezy.  Which
> means qemu and qemu-kvm need to drop their build-deps on ceph packages.
> They can always be re-added if/when leveldb/ceph are fixed.".
>
> It seems everything is up to leveldb upstream/maintainer now. It is
> fixed in time on big-endian machines or the package will be limited to
> little-endian machines as I wanted to do with Ceph.
>
> But please look into the reason why Ceph fails to build on ia64[4].
> Also, how 0.48 goes? Will it contain big differences to 0.47.2? As you
> can read, even 0.47.2 is in question for Wheezy. But would you propose
> 0.48 for inclusion when it's released?
>
> Fingers crossed. Regards,
> Laszlo/GCS
> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=677626
> [2] http://code.google.com/p/leveldb/issues/detail?id=84
> [3] https://lists.debian.org/debian-devel-announce/2012/06/msg00009.html
> [4] https://buildd.debian.org/status/fetch.php?pkg=ceph&arch=ia64&ver=0.47.2-1&stamp=1340802492
>


I looked into why leveldb fails to build on big endian, and the reason
seems quite trivial. The bloom_test unitest passes different input due
to endianity, and the result is not as expected due to statistical
difference of the input; there are more false positive. I played with
it a bit, and when transforming the input to little endian it passed.
I also got the same failure on a little endian machine when I
transformed it to big endian. There are two solutions, one is to bump
up the expected false positives to a higher number (e.g., 3% instead
of 2%):

diff --git a/util/bloom_test.cc b/util/bloom_test.cc
index 4a6ea1b..61323af 100644
--- a/util/bloom_test.cc
+++ b/util/bloom_test.cc
@@ -139,7 +139,7 @@ TEST(BloomTest, VaryingLengths) {
       fprintf(stderr, "False positives: %5.2f%% @ length = %6d ;
bytes = %6d\n",
               rate*100.0, length, static_cast<int>(FilterSize()));
     }
-    ASSERT_LE(rate, 0.02);   // Must not be over 2%
+    ASSERT_LE(rate, 0.03);   // Must not be over 2%
     if (rate > 0.0125) mediocre_filters++;  // Allowed, but not too often
     else good_filters++;
   }



Another option is to transform data to little endian:


diff --git a/util/bloom_test.cc b/util/bloom_test.cc
index 4a6ea1b..6de7acc 100644
--- a/util/bloom_test.cc
+++ b/util/bloom_test.cc
@@ -5,6 +5,7 @@
 #include "leveldb/filter_policy.h"

 #include "util/logging.h"
+#include "util/coding.h"
 #include "util/testharness.h"
 #include "util/testutil.h"

@@ -12,8 +13,22 @@ namespace leveldb {

 static const int kVerbose = 1;

+static inline void EncodeFixed(char *buf, int32_t val)
+{
+    EncodeFixed32(buf, val);
+}
+
+static inline void EncodeFixed(char *buf, int64_t val)
+{
+    EncodeFixed64(buf, val);
+}
+
 static Slice Key(int i, char* buffer) {
-  memcpy(buffer, &i, sizeof(i));
+  if (port::kLittleEndian) {
+    memcpy(buffer, &i, sizeof(i));
+  } else {
+    EncodeFixed(buffer, i);
+  }
   return Slice(buffer, sizeof(i));
 }


I also had some issues with other tests, but all those problems
appeared to be due to the buggy std atomic implementation on older
gcc.

Yehuda
