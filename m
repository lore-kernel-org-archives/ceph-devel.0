From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 02 Nov 2017 02:11:34 +0000 (UTC)
Message-ID: <59fa7ed6691fc_21aeef531c6908e@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.hv1nn.shared.sendgrid.net ([167.89.100.17]:32283 "EHLO
        o2.hv1nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751628AbdKBCLf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Nov 2017 22:11:35 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0006p1sjc2.sendgrid.net (SG) with ESMTP id ipRDkdV3Qra5l-fsD_dXfg
        for <ceph-devel@vger.kernel.org>; Thu, 02 Nov 2017 02:11:34.457 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

4 new defect(s) introduced to ceph found with Coverity Scan.
8 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 4 of 4 defect(s)


** CID 1322385:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/test/librados/tier.cc: 2210 in start_flush_read()()


________________________________________________________________________________________________________
*** CID 1322385:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/test/librados/tier.cc: 2210 in start_flush_read()()
2204     {
2205       //cout << " starting read" << std::endl;
2206       ObjectReadOperation op;
2207       op.stat(NULL, NULL, NULL);
2208       librados::AioCompletion *completion = completions.getCompletion();
2209       completion->set_complete_callback(0, flush_read_race_cb);
>>>     CID 1322385:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "aio_operate" without checking return value (as is done elsewhere 61 out of 76 times).
2210       read_ioctx->aio_operate("foo", completion, &op, NULL);
2211     }
2212     
2213     void flush_read_race_cb(completion_t cb, void *arg)
2214     {
2215       //cout << " finished read" << std::endl;

** CID 1420533:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/rbd_mirror/image_sync/test_mock_ObjectCopyRequest.cc: 59 in rbd::mirror::image_sync::<unnamed>::scribble(librbd::ImageCtx *, int, unsigned long, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *)()
/home/brad/working/src/ceph/src/test/rbd_mirror/image_sync/test_mock_ObjectCopyRequest.cc: 60 in rbd::mirror::image_sync::<unnamed>::scribble(librbd::ImageCtx *, int, unsigned long, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *)()


________________________________________________________________________________________________________
*** CID 1420533:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/rbd_mirror/image_sync/test_mock_ObjectCopyRequest.cc: 59 in rbd::mirror::image_sync::<unnamed>::scribble(librbd::ImageCtx *, int, unsigned long, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *)()
53     
54     void scribble(librbd::ImageCtx *image_ctx, int num_ops, size_t max_size,
55                   interval_set<uint64_t> *what)
56     {
57       uint64_t object_size = 1 << image_ctx->order;
58       for (int i=0; i<num_ops; i++) {
>>>     CID 1420533:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
59         uint64_t off = rand() % (object_size - max_size + 1);
60         uint64_t len = 1 + rand() % max_size;
61     
62         bufferlist bl;
63         bl.append(std::string(len, '1'));
64     
/home/brad/working/src/ceph/src/test/rbd_mirror/image_sync/test_mock_ObjectCopyRequest.cc: 60 in rbd::mirror::image_sync::<unnamed>::scribble(librbd::ImageCtx *, int, unsigned long, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *)()
54     void scribble(librbd::ImageCtx *image_ctx, int num_ops, size_t max_size,
55                   interval_set<uint64_t> *what)
56     {
57       uint64_t object_size = 1 << image_ctx->order;
58       for (int i=0; i<num_ops; i++) {
59         uint64_t off = rand() % (object_size - max_size + 1);
>>>     CID 1420533:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
60         uint64_t len = 1 + rand() % max_size;
61     
62         bufferlist bl;
63         bl.append(std::string(len, '1'));
64     
65         int r = image_ctx->io_work_queue->write(off, len, std::move(bl), 0);

** CID 1420534:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/home/brad/working/src/ceph/src/test/rbd_mirror/image_sync/test_mock_ObjectCopyRequest.cc: 57 in rbd::mirror::image_sync::<unnamed>::scribble(librbd::ImageCtx *, int, unsigned long, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *)()


________________________________________________________________________________________________________
*** CID 1420534:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/home/brad/working/src/ceph/src/test/rbd_mirror/image_sync/test_mock_ObjectCopyRequest.cc: 57 in rbd::mirror::image_sync::<unnamed>::scribble(librbd::ImageCtx *, int, unsigned long, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *)()
51     
52     namespace {
53     
54     void scribble(librbd::ImageCtx *image_ctx, int num_ops, size_t max_size,
55                   interval_set<uint64_t> *what)
56     {
>>>     CID 1420534:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>>     Potentially overflowing expression "1 << image_ctx->order" with type "int" (32 bits, signed) is evaluated using 32-bit arithmetic, and then used in a context that expects an expression of type "uint64_t" (64 bits, unsigned).
57       uint64_t object_size = 1 << image_ctx->order;
58       for (int i=0; i<num_ops; i++) {
59         uint64_t off = rand() % (object_size - max_size + 1);
60         uint64_t len = 1 + rand() % max_size;
61     
62         bufferlist bl;

** CID 1420535:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 3337 in scribble(librbd::Image &, int, int, bool, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *)()
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 3338 in scribble(librbd::Image &, int, int, bool, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *)()
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 3339 in scribble(librbd::Image &, int, int, bool, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *)()


________________________________________________________________________________________________________
*** CID 1420535:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 3337 in scribble(librbd::Image &, int, int, bool, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *)()
3331     {
3332       uint64_t size;
3333       image.size(&size);
3334       interval_set<uint64_t> exists_at_start = *exists;
3335     
3336       for (int i=0; i<n; i++) {
>>>     CID 1420535:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3337         uint64_t off = rand() % (size - max + 1);
3338         uint64_t len = 1 + rand() % max;
3339         if (!skip_discard && rand() % 4 == 0) {
3340           ASSERT_EQ((int)len, image.discard(off, len));
3341           interval_set<uint64_t> w;
3342           w.insert(off, len);
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 3338 in scribble(librbd::Image &, int, int, bool, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *)()
3332       uint64_t size;
3333       image.size(&size);
3334       interval_set<uint64_t> exists_at_start = *exists;
3335     
3336       for (int i=0; i<n; i++) {
3337         uint64_t off = rand() % (size - max + 1);
>>>     CID 1420535:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3338         uint64_t len = 1 + rand() % max;
3339         if (!skip_discard && rand() % 4 == 0) {
3340           ASSERT_EQ((int)len, image.discard(off, len));
3341           interval_set<uint64_t> w;
3342           w.insert(off, len);
3343     
/home/brad/working/src/ceph/src/test/librbd/test_librbd.cc: 3339 in scribble(librbd::Image &, int, int, bool, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *, interval_set<unsigned long, std::map<unsigned long, unsigned long, std::less<unsigned long>, std::allocator<std::pair<const unsigned long, unsigned long>>>> *)()
3333       image.size(&size);
3334       interval_set<uint64_t> exists_at_start = *exists;
3335     
3336       for (int i=0; i<n; i++) {
3337         uint64_t off = rand() % (size - max + 1);
3338         uint64_t len = 1 + rand() % max;
>>>     CID 1420535:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3339         if (!skip_discard && rand() % 4 == 0) {
3340           ASSERT_EQ((int)len, image.discard(off, len));
3341           interval_set<uint64_t> w;
3342           w.insert(off, len);
3343     
3344           // the zeroed bit no longer exists...


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8HeCrD0Y0xkOU6LLITVBcFEFqYqLBS8hlnLxSJy2-2Bm832RFzT5wKhWaZI5NStxkqKm-2BlQQAscxS6kzKhDbumPkyGnnxMThiuZdv-2BIiSKVvKnNn3Fi7042Stusxgpz0ta9KFUiJi4RSRWnECmwQSl9jfc4eo1o9pyQskFmfqaP-2BWtbLmjm6wPL-2FW6fchHohYkNc-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8HeCrD0Y0xkOU6LLITVBcFEFqYqLBS8hlnLxSJy2-2Bm837YtBikoQpRLd4ik-2B-2BR4QztMsBii3uiDdbr8Ix7BE9lbqlqdDiUFpUNjJBtA58LZPOuKx0upytuMSl3XWKLre-2BPBFT-2BETg598Dn6pUqjWFHb0AM2C3YYq-2FQNhUP3aMRbwDZCXwKDlbxRZxraCwYelnE-3D

