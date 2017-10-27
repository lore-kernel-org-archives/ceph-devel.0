From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Fri, 27 Oct 2017 00:31:05 +0000 (UTC)
Message-ID: <59f27e49144fc_e3c40932c3534a@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.hv1nn.shared.sendgrid.net ([167.89.100.17]:61096 "EHLO
        o2.hv1nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751651AbdJ0AbG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 26 Oct 2017 20:31:06 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0008p1sjc2.sendgrid.net (SG) with ESMTP id Js0vM4zBTKKMZtofnFHu9w
        for <ceph-devel@vger.kernel.org>; Fri, 27 Oct 2017 00:31:05.134 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

15 new defect(s) introduced to ceph found with Coverity Scan.
18 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 15 of 15 defect(s)


** CID 1420321:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 88 in StoreTool::StoreTool(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool)()


________________________________________________________________________________________________________
*** CID 1420321:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/tools/ceph_kvstore_tool.cc: 88 in StoreTool::StoreTool(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, bool)()
82               cerr << "failed to open type " << type << " path " << path << ": "
83                    << cpp_strerror(r) << std::endl;
84               exit(1);
85             }
86             db.reset(db_ptr);
87           }
>>>     CID 1420321:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "db_ptr" going out of scope leaks the storage it points to.
88         }
89       }
90     
91       uint32_t traverse(const string &prefix,
92                         const bool do_crc,
93                         ostream *out) {

** CID 1420322:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/librgw_file_marker.cc: 421 in main()


________________________________________________________________________________________________________
*** CID 1420322:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/librgw_file_marker.cc: 421 in main()
415     }
416     
417     TEST(LibRGW, SHUTDOWN) {
418       librgw_shutdown(rgw_h);
419     }
420     
>>>     CID 1420322:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "testing::internal::<unnamed>::ClassUniqueToAlwaysTrue" is thrown and never caught.
421     int main(int argc, char *argv[])
422     {
423       char *v{nullptr};
424       string val;
425       vector<const char*> args;
426     

** CID 1420323:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/cover.c: 852 in COVER_tryParameters()


________________________________________________________________________________________________________
*** CID 1420323:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/cover.c: 852 in COVER_tryParameters()
846       BYTE *const dict = (BYTE * const)malloc(dictBufferCapacity);
847       U32 *freqs = (U32 *)malloc(ctx->suffixSize * sizeof(U32));
848       if (!COVER_map_init(&activeDmers, parameters.k - parameters.d + 1)) {
849         DISPLAYLEVEL(1, "Failed to allocate dmer map: out of memory\n");
850         goto _cleanup;
851       }
>>>     CID 1420323:  Null pointer dereferences  (FORWARD_NULL)
>>>     Comparing "dict" to null implies that "dict" might be null.
852       if (!dict || !freqs) {
853         DISPLAYLEVEL(1, "Failed to allocate buffers: out of memory\n");
854         goto _cleanup;
855       }
856       /* Copy the frequencies because we need to modify them */
857       memcpy(freqs, ctx->freqs, ctx->suffixSize * sizeof(U32));

** CID 1420324:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/zstd/lib/decompress/zstd_decompress.c: 2085 in ZSTD_initDDict_internal()


________________________________________________________________________________________________________
*** CID 1420324:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/zstd/lib/decompress/zstd_decompress.c: 2085 in ZSTD_initDDict_internal()
2079     
2080     
2081     static size_t ZSTD_initDDict_internal(ZSTD_DDict* ddict, const void* dict, size_t dictSize, ZSTD_dictLoadMethod_e dictLoadMethod)
2082     {
2083         if ((dictLoadMethod == ZSTD_dlm_byRef) || (!dict) || (!dictSize)) {
2084             ddict->dictBuffer = NULL;
>>>     CID 1420324:  Null pointer dereferences  (FORWARD_NULL)
>>>     Assigning: "ddict->dictContent" = "dict".
2085             ddict->dictContent = dict;
2086         } else {
2087             void* const internalBuffer = ZSTD_malloc(dictSize, ddict->cMem);
2088             ddict->dictBuffer = internalBuffer;
2089             ddict->dictContent = internalBuffer;
2090             if (!internalBuffer) return ERROR(memory_allocation);

** CID 1420325:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/compressor/zstd/ZstdCompressor.h: 84 in ZstdCompressor::decompress(ceph::buffer::list::iterator &, unsigned long, ceph::buffer::list&)()


________________________________________________________________________________________________________
*** CID 1420325:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/compressor/zstd/ZstdCompressor.h: 84 in ZstdCompressor::decompress(ceph::buffer::list::iterator &, unsigned long, ceph::buffer::list&)()
78         outbuf.size = dstptr.length();
79         outbuf.pos = 0;
80         ZSTD_DStream *s = ZSTD_createDStream();
81         ZSTD_initDStream(s);
82         while (compressed_len > 0) {
83           if (p.end()) {
>>>     CID 1420325:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "s" going out of scope leaks the storage it points to.
84     	return -1;
85           }
86           ZSTD_inBuffer_s inbuf;
87           inbuf.pos = 0;
88           inbuf.size = p.get_ptr_and_advance(compressed_len, (const char**)&inbuf.src);
89           ZSTD_decompressStream(s, &outbuf, &inbuf);

** CID 1420326:  Null pointer dereferences  (REVERSE_INULL)
/home/brad/working/src/ceph/src/zstd/lib/compress/zstdmt_compress.c: 834 in ZSTDMT_initCStream_usingCDict()


________________________________________________________________________________________________________
*** CID 1420326:  Null pointer dereferences  (REVERSE_INULL)
/home/brad/working/src/ceph/src/zstd/lib/compress/zstdmt_compress.c: 834 in ZSTDMT_initCStream_usingCDict()
828                                          ZSTD_frameParameters fParams,
829                                          unsigned long long pledgedSrcSize)
830     {
831         ZSTD_CCtx_params cctxParams = mtctx->params;
832         cctxParams.cParams = ZSTD_getCParamsFromCDict(cdict);
833         cctxParams.fParams = fParams;
>>>     CID 1420326:  Null pointer dereferences  (REVERSE_INULL)
>>>     Null-checking "cdict" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
834         if (cdict==NULL) return ERROR(dictionary_wrong);   /* method incompatible with NULL cdict */
835         return ZSTDMT_initCStream_internal(mtctx, NULL, 0 /*dictSize*/, ZSTD_dm_auto, cdict,
836                                            cctxParams, pledgedSrcSize);
837     }
838     
839     

** CID 1420327:    (OVERRUN)
/home/brad/working/src/ceph/src/zstd/lib/compress/zstd_compress.c: 1366 in ZSTD_encodeSequences()
/home/brad/working/src/ceph/src/zstd/lib/compress/zstd_compress.c: 1398 in ZSTD_encodeSequences()


________________________________________________________________________________________________________
*** CID 1420327:    (OVERRUN)
/home/brad/working/src/ceph/src/zstd/lib/compress/zstd_compress.c: 1366 in ZSTD_encodeSequences()
1360         if (MEM_32bits()) BIT_flushBits(&blockStream);
1361         BIT_addBits(&blockStream, sequences[nbSeq-1].matchLength, ML_bits[mlCodeTable[nbSeq-1]]);
1362         if (MEM_32bits()) BIT_flushBits(&blockStream);
1363         if (longOffsets) {
1364             U32 const ofBits = ofCodeTable[nbSeq-1];
1365             int const extraBits = ofBits - MIN(ofBits, STREAM_ACCUMULATOR_MIN-1);
>>>     CID 1420327:    (OVERRUN)
>>>     Checking "extraBits" implies that "extraBits" is 0 on the false branch.
1366             if (extraBits) {
1367                 BIT_addBits(&blockStream, sequences[nbSeq-1].offset, extraBits);
1368                 BIT_flushBits(&blockStream);
1369             }
1370             BIT_addBits(&blockStream, sequences[nbSeq-1].offset >> extraBits,
1371                         ofBits - extraBits);
/home/brad/working/src/ceph/src/zstd/lib/compress/zstd_compress.c: 1398 in ZSTD_encodeSequences()
1392                 BIT_addBits(&blockStream, sequences[n].litLength, llBits);
1393                 if (MEM_32bits() && ((llBits+mlBits)>24)) BIT_flushBits(&blockStream);
1394                 BIT_addBits(&blockStream, sequences[n].matchLength, mlBits);
1395                 if (MEM_32bits() || (ofBits+mlBits+llBits > 56)) BIT_flushBits(&blockStream);
1396                 if (longOffsets) {
1397                     int const extraBits = ofBits - MIN(ofBits, STREAM_ACCUMULATOR_MIN-1);
>>>     CID 1420327:    (OVERRUN)
>>>     Checking "extraBits" implies that "extraBits" is 0 on the false branch.
1398                     if (extraBits) {
1399                         BIT_addBits(&blockStream, sequences[n].offset, extraBits);
1400                         BIT_flushBits(&blockStream);                            /* (7)*/
1401                     }
1402                     BIT_addBits(&blockStream, sequences[n].offset >> extraBits,
1403                                 ofBits - extraBits);                            /* 31 */

** CID 1420328:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/rgw/rgw_log.cc: 360 in rgw_log_op(RGWRados *, RGWREST *, req_state *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, OpsLogSocket *)()
/home/brad/working/src/ceph/src/rgw/rgw_log.cc: 363 in rgw_log_op(RGWRados *, RGWREST *, req_state *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, OpsLogSocket *)()
/home/brad/working/src/ceph/src/rgw/rgw_log.cc: 372 in rgw_log_op(RGWRados *, RGWREST *, req_state *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, OpsLogSocket *)()


________________________________________________________________________________________________________
*** CID 1420328:    (FORWARD_NULL)
/home/brad/working/src/ceph/src/rgw/rgw_log.cc: 360 in rgw_log_op(RGWRados *, RGWREST *, req_state *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, OpsLogSocket *)()
354       // legacy apps are still using misspelling referer, such as curl -e option
355       if (s->info.env->exists("HTTP_REFERRER"))
356         set_param_str(s, "HTTP_REFERRER", entry.referrer);
357       else
358         set_param_str(s, "HTTP_REFERER", entry.referrer);
359     
>>>     CID 1420328:    (FORWARD_NULL)
>>>     Passing null pointer "s->info.env->get("REQUEST_METHOD", NULL)" to "basic_string", which dereferences it. [Note: The source code implementation of the function has been overridden by a builtin model.]
360       std::string uri(s->info.env->get("REQUEST_METHOD"));
361       uri.append(" ");
362     
363       uri.append(s->info.env->get("REQUEST_URI"));
364       const char* qs = s->info.env->get("QUERY_STRING");
365       if(qs && (*qs != '\0')) {
/home/brad/working/src/ceph/src/rgw/rgw_log.cc: 363 in rgw_log_op(RGWRados *, RGWREST *, req_state *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, OpsLogSocket *)()
357       else
358         set_param_str(s, "HTTP_REFERER", entry.referrer);
359     
360       std::string uri(s->info.env->get("REQUEST_METHOD"));
361       uri.append(" ");
362     
>>>     CID 1420328:    (FORWARD_NULL)
>>>     Passing null pointer "s->info.env->get("REQUEST_URI", NULL)" to "append", which dereferences it. [Note: The source code implementation of the function has been overridden by a builtin model.]
363       uri.append(s->info.env->get("REQUEST_URI"));
364       const char* qs = s->info.env->get("QUERY_STRING");
365       if(qs && (*qs != '\0')) {
366         uri.append("?");
367         uri.append(qs);
368       }
/home/brad/working/src/ceph/src/rgw/rgw_log.cc: 372 in rgw_log_op(RGWRados *, RGWREST *, req_state *, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, OpsLogSocket *)()
366         uri.append("?");
367         uri.append(qs);
368       }
369     
370       uri.append(" ");
371       uri.append("HTTP/");
>>>     CID 1420328:    (FORWARD_NULL)
>>>     Passing null pointer "s->info.env->get("HTTP_VERSION", NULL)" to "append", which dereferences it. [Note: The source code implementation of the function has been overridden by a builtin model.]
372       uri.append(s->info.env->get("HTTP_VERSION"));
373     
374       entry.uri = std::move(uri);
375     
376       set_param_str(s, "REQUEST_METHOD", entry.op);
377     

** CID 1420329:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/osd/PGBackend.cc: 1043 in PGBackend::be_compare_scrubmaps(const std::map<pg_shard_t, ScrubMap *, std::less<pg_shard_t>, std::allocator<std::pair<const pg_shard_t, ScrubMap *>>> &, const std::set<hobject_t, std::less<hobject_t>, std::allocator<hobject_t>> &, bool, std::map<hobject_t, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>>, std::less<hobject_t>, std::allocator<std::pair<const hobject_t, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>>>>>&, std::map<hobject_t, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>>, std::less<hobject_t>, std::allocator<std::pair<const hobject_t, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>>>>>&, std::map<hobject_t, std::__cxx11::li
 st<pg_shard_t, std::allocator<pg_shard_t>>, std::less<hobject_t>, std::allocator<std::pair<const hobject_t, std::__cxx11::list<pg_shard_t, std::allocator<pg_shard_t>>>>>&, std::map<hobject_t
 , std::pair<boost::optional<unsigned int>, boost::optional<unsigned int>>, std::less<hobject_t>, std::allocator<std::pair<const hobject_t, std::pair<boost::optional<unsigned int>, boost::optional<unsigned int>>>>>&, int &, int &, Scrub::Store *, const spg_t &, const std::vector<int, std::allocator<int>> &, std::basic_ostream<char, std::char_traits<char>>&)()


________________________________________________________________________________________________________
*** CID 1420329:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/osd/PGBackend.cc: 1043 in PGBackend::be_compare_scrubmaps(const std::map<pg_shard_t, ScrubMap *, std::less<pg_shard_t>, std::allocator<std::pair<const pg_shard_t, ScrubMap *>>> &, const std::set<hobject_t, std::less<hobject_t>, std::allocator<hobject_t>> &, bool, std::map<hobject_t, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>>, std::less<hobject_t>, std::allocator<std::pair<const hobject_t, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>>>>>&, std::map<hobject_t, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>>, std::less<hobject_t>, std::allocator<std::pair<const hobject_t, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>>>>>&, std::map<hobject_t, std::__cxx11::li
 st<pg_shard_t, std::allocator<pg_shard_t>>, std::less<hobject_t>, std::allocator<std::pair<const hobject_t, std::__cxx11::list<pg_shard_t, std::allocator<pg_shard_t>>>>>&, std::map<hobject_t
 , std::pair<boost::optional<unsigned int>, boost::optional<unsigned int>>, std::less<hobject_t>, std::allocator<std::pair<const hobject_t, std::pair<boost::optional<unsigned int>, boost::optional<unsigned int>>>>>&, int &, int &, Scrub::Store *, const spg_t &, const std::vector<int, std::allocator<int>> &, std::basic_ostream<char, std::char_traits<char>>&)()
1037     	  (!auth_oi.is_data_digest() || !auth_oi.is_omap_digest())) {
1038     	dout(20) << __func__ << " missing digest on " << *k << dendl;
1039     	update = MAYBE;
1040           }
1041           if (auth_object.digest_present && auth_object.omap_digest_present &&
1042     	  cct->_conf->osd_debug_scrub_chance_rewrite_digest &&
>>>     CID 1420329:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
1043     	  (((unsigned)rand() % 100) >
1044     	   cct->_conf->osd_debug_scrub_chance_rewrite_digest)) {
1045     	dout(20) << __func__ << " randomly updating digest on " << *k << dendl;
1046     	update = MAYBE;
1047           }
1048     

** CID 1420330:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/zdict.c: 967 in ZDICT_trainFromBuffer_unsafe_legacy()


________________________________________________________________________________________________________
*** CID 1420330:  Resource leaks  (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/zstd/lib/dictBuilder/zdict.c: 967 in ZDICT_trainFromBuffer_unsafe_legacy()
961             DISPLAYLEVEL(3, "list %u best segments \n", nb-1);
962             for (u=1; u<nb; u++) {
963                 U32 const pos = dictList[u].pos;
964                 U32 const length = dictList[u].length;
965                 U32 const printedLength = MIN(40, length);
966                 if ((pos > samplesBuffSize) || ((pos + length) > samplesBuffSize))
>>>     CID 1420330:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "dictList" going out of scope leaks the storage it points to.
967                     return ERROR(GENERIC);   /* should never happen */
968                 DISPLAYLEVEL(3, "%3u:%3u bytes at pos %8u, savings %7u bytes |",
969                              u, length, pos, dictList[u].savings);
970                 ZDICT_printHex((const char*)samplesBuffer+pos, printedLength);
971                 DISPLAYLEVEL(3, "| \n");
972         }   }

** CID 1420331:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/test/librgw_file_marker.cc: 217 in LibRGW_MARKER1_SETUP_BUCKET_Test::TestBody()()


________________________________________________________________________________________________________
*** CID 1420331:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/test/librgw_file_marker.cc: 217 in LibRGW_MARKER1_SETUP_BUCKET_Test::TestBody()()
211       st.st_uid = owner_uid;
212       st.st_gid = owner_gid;
213       st.st_mode = 755;
214     
215       (void) rgw_lookup(fs, fs->root_fh, bucket_name.c_str(), &bucket_fh,
216     		    RGW_LOOKUP_FLAG_NONE);
>>>     CID 1420331:  Null pointer dereferences  (FORWARD_NULL)
>>>     Comparing "<unnamed>::bucket_fh" to null implies that "<unnamed>::bucket_fh" might be null.
217       if (! bucket_fh) {
218         if (do_create) {
219           struct stat st;
220     
221           st.st_uid = owner_uid;
222           st.st_gid = owner_gid;

** CID 1420332:  Control flow issues  (DEADCODE)
/home/brad/working/src/ceph/src/zstd/lib/decompress/zstd_decompress.c: 1415 in ZSTD_decompressBlock_internal()


________________________________________________________________________________________________________
*** CID 1420332:  Control flow issues  (DEADCODE)
/home/brad/working/src/ceph/src/zstd/lib/decompress/zstd_decompress.c: 1415 in ZSTD_decompressBlock_internal()
1409         /* isLongOffset must be true if there are long offsets.
1410          * Offsets are long if they are larger than 2^STREAM_ACCUMULATOR_MIN.
1411          * We don't expect that to be the case in 64-bit mode.
1412          * If we are in block mode we don't know the window size, so we have to be
1413          * conservative.
1414          */
>>>     CID 1420332:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach the expression "57" inside this statement: "isLongOffset = (ZSTD_longOf...".
1415         ZSTD_longOffset_e const isLongOffset = (ZSTD_longOffset_e)(MEM_32bits() && (!frame || dctx->fParams.windowSize > (1ULL << STREAM_ACCUMULATOR_MIN)));
1416         /* windowSize could be any value at this point, since it is only validated
1417          * in the streaming API.
1418          */
1419         DEBUGLOG(5, "ZSTD_decompressBlock_internal (size : %u)", (U32)srcSize);
1420     

** CID 1420333:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/librgw_file_marker.cc: 421 in main()


________________________________________________________________________________________________________
*** CID 1420333:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/test/librgw_file_marker.cc: 421 in main()
415     }
416     
417     TEST(LibRGW, SHUTDOWN) {
418       librgw_shutdown(rgw_h);
419     }
420     
>>>     CID 1420333:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "testing::internal::GoogleTestFailureException" is thrown and never caught.
421     int main(int argc, char *argv[])
422     {
423       char *v{nullptr};
424       string val;
425       vector<const char*> args;
426     

** CID 1420334:  Control flow issues  (MISMATCHED_ITERATOR)
/home/brad/working/src/ceph/src/osd/PG.cc: 1166 in PG::calc_ec_acting(std::_Rb_tree_const_iterator<std::pair<const pg_shard_t, pg_info_t>>, unsigned int, const std::vector<int, std::allocator<int>> &, const std::vector<int, std::allocator<int>> &, const std::map<pg_shard_t, pg_info_t, std::less<pg_shard_t>, std::allocator<std::pair<const pg_shard_t, pg_info_t>>> &, bool, std::vector<int, std::allocator<int>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, std::basic_ostream<char, std::char_traits<char>>&)()


________________________________________________________________________________________________________
*** CID 1420334:  Control flow issues  (MISMATCHED_ITERATOR)
/home/brad/working/src/ceph/src/osd/PG.cc: 1166 in PG::calc_ec_acting(std::_Rb_tree_const_iterator<std::pair<const pg_shard_t, pg_info_t>>, unsigned int, const std::vector<int, std::allocator<int>> &, const std::vector<int, std::allocator<int>> &, const std::map<pg_shard_t, pg_info_t, std::less<pg_shard_t>, std::allocator<std::pair<const pg_shard_t, pg_info_t>>> &, bool, std::vector<int, std::allocator<int>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, std::set<pg_shard_t, std::less<pg_shard_t>, std::allocator<pg_shard_t>> *, std::basic_ostream<char, std::char_traits<char>>&)()
1160     	!all_info.find(pg_shard_t(acting[i], shard_id_t(i)))->second.is_incomplete() &&
1161     	all_info.find(pg_shard_t(acting[i], shard_id_t(i)))->second.last_update >=
1162     	auth_log_shard->second.log_tail) {
1163           ss << " selecting acting[i]: " << pg_shard_t(acting[i], shard_id_t(i)) << std::endl;
1164           want[i] = acting[i];
1165         } else if (!restrict_to_up_acting) {
>>>     CID 1420334:  Control flow issues  (MISMATCHED_ITERATOR)
>>>     Comparing "j" from "all_info_by_shard[shard_id_t(i)]" to "all_info_by_shard[shard_id_t(i)]->end()" from "all_info_by_shard[shard_id_t(i)]".
1166           for (set<pg_shard_t>::iterator j = all_info_by_shard[shard_id_t(i)].begin();
1167     	   j != all_info_by_shard[shard_id_t(i)].end();
1168     	   ++j) {
1169     	assert(j->shard == i);
1170     	if (!all_info.find(*j)->second.is_incomplete() &&
1171     	    all_info.find(*j)->second.last_update >=

** CID 1420335:  Code maintainability issues  (UNUSED_VALUE)
/home/brad/working/src/ceph/src/zstd/lib/compress/zstd_compress.c: 890 in ZSTD_resetCCtx_internal()


________________________________________________________________________________________________________
*** CID 1420335:  Code maintainability issues  (UNUSED_VALUE)
/home/brad/working/src/ceph/src/zstd/lib/compress/zstd_compress.c: 890 in ZSTD_resetCCtx_internal()
884     
885                     zc->workSpaceSize = 0;
886                     ZSTD_free(zc->workSpace, zc->customMem);
887                     zc->workSpace = ZSTD_malloc(neededSpace, zc->customMem);
888                     if (zc->workSpace == NULL) return ERROR(memory_allocation);
889                     zc->workSpaceSize = neededSpace;
>>>     CID 1420335:  Code maintainability issues  (UNUSED_VALUE)
>>>     Assigning value from "zc->workSpace" to "ptr" here, but that stored value is overwritten before it can be used.
890                     ptr = zc->workSpace;
891     
892                     /* entropy space */
893                     assert(((size_t)zc->workSpace & 3) == 0);   /* ensure correct alignment */
894                     assert(zc->workSpaceSize >= sizeof(ZSTD_entropyCTables_t));
895                     zc->entropy = (ZSTD_entropyCTables_t*)zc->workSpace;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8Gy1Hbdng86fSmZDL9jyxshdImPQ1FMiQYxMmP8DI4Txz7Y2fx1phrVnOJropkIhIZ1-2FOGbiEsEgwwF1m5W6-2FDacOyhDMwkSxAZVftCFlZGGJXh-2BWXbxHtDutzOkbJNSdaE5M9dCaR1Fc5eCxox2DOoXzpI7rcojbnoY0Eu-2FTfU2KzrHbUlx7lSPONYKptoonc-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8Gy1Hbdng86fSmZDL9jyxshdImPQ1FMiQYxMmP8DI4Tx0lIb1cj000l5U2W71KpZOKrvog3jBOKD-2FSLwGRctsQRAC7eSMh5NFUg-2FTNpEbiZravpq89wcQsrrQh6InKwQr5pSlemLwx2RVSzhYOKo2P69-2FhVs54jIEG1r-2F-2BUkyY8EY2pQJ7gaBYjABJsEpn55sg-3D

