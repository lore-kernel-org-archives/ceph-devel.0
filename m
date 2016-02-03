From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Wed, 03 Feb 2016 12:40:34 -0800
Message-ID: <56b265c21dc1a_7889b5b31436225@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:38813 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933519AbcBCUkV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 15:40:21 -0500
Received: from localhost.localdomain (static-208.69.177.245.nephosdns.com [208.69.177.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtprelay.synopsys.com (Postfix) with ESMTPS id 03DF610C0C9A
	for <ceph-devel@vger.kernel.org>; Wed,  3 Feb 2016 12:40:21 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

258 new defect(s) introduced to ceph found with Coverity Scan.
238 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 258 defect(s)


** CID 1351432:  Resource leaks  (CTOR_DTOR_LEAK)
/rocksdb/db/memtable_list.h: 147 in rocksdb::MemTableList::MemTableList(int, int)()


________________________________________________________________________________________________________
*** CID 1351432:  Resource leaks  (CTOR_DTOR_LEAK)
/rocksdb/db/memtable_list.h: 147 in rocksdb::MemTableList::MemTableList(int, int)()
141      public:
142       // A list of memtables.
143       explicit MemTableList(int min_write_buffer_number_to_merge,
144                             int max_write_buffer_number_to_maintain)
145           : imm_flush_needed(false),
146             min_write_buffer_number_to_merge_(min_write_buffer_number_to_merge),
>>>     CID 1351432:  Resource leaks  (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "current_" of "rocksdb::MemTableList" but the destructor and whatever functions it calls do not free it.
147             current_(new MemTableListVersion(&current_memory_usage_,
148                                              max_write_buffer_number_to_maintain)),
149             num_flush_not_started_(0),
150             commit_in_progress_(false),
151             flush_requested_(false) {
152         current_->Ref();

** CID 1351431:  Resource leaks  (CTOR_DTOR_LEAK)
/rocksdb/db/compaction_job.cc: 220 in rocksdb::CompactionJob::CompactionJob(int, rocksdb::Compaction *, const rocksdb::DBOptions &, const rocksdb::EnvOptions &, rocksdb::VersionSet *, std::atomic<bool> *, rocksdb::LogBuffer *, rocksdb::Directory *, rocksdb::Directory *, rocksdb::Statistics *, std::vector<unsigned long, std::allocator<unsigned long>>, unsigned long, std::shared_ptr<rocksdb::Cache>, rocksdb::EventLogger *, bool, bool, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, rocksdb::CompactionJobStats *)()


________________________________________________________________________________________________________
*** CID 1351431:  Resource leaks  (CTOR_DTOR_LEAK)
/rocksdb/db/compaction_job.cc: 220 in rocksdb::CompactionJob::CompactionJob(int, rocksdb::Compaction *, const rocksdb::DBOptions &, const rocksdb::EnvOptions &, rocksdb::VersionSet *, std::atomic<bool> *, rocksdb::LogBuffer *, rocksdb::Directory *, rocksdb::Directory *, rocksdb::Statistics *, std::vector<unsigned long, std::allocator<unsigned long>>, unsigned long, std::shared_ptr<rocksdb::Cache>, rocksdb::EventLogger *, bool, bool, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, rocksdb::CompactionJobStats *)()
214         std::vector<SequenceNumber> existing_snapshots,
215         SequenceNumber earliest_write_conflict_snapshot,
216         std::shared_ptr<Cache> table_cache, EventLogger* event_logger,
217         bool paranoid_file_checks, bool measure_io_stats, const std::string& dbname,
218         CompactionJobStats* compaction_job_stats)
219         : job_id_(job_id),
>>>     CID 1351431:  Resource leaks  (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "compact_" of "rocksdb::CompactionJob" but the destructor and whatever functions it calls do not free it.
220           compact_(new CompactionState(compaction)),
221           compaction_job_stats_(compaction_job_stats),
222           compaction_stats_(1),
223           dbname_(dbname),
224           db_options_(db_options),
225           env_options_(env_options),

** CID 1351430:    (CONSTANT_EXPRESSION_RESULT)
/test/librbd/test_librbd.cc: 2767 in DiffIterateTest_DiffIterateParentDiscard_Test<DiffIterateParams<(bool)0>>::TestBody()()
/test/librbd/test_librbd.cc: 2742 in DiffIterateTest_DiffIterateParentDiscard_Test<DiffIterateParams<(bool)0>>::TestBody()()


________________________________________________________________________________________________________
*** CID 1351430:    (CONSTANT_EXPRESSION_RESULT)
/test/librbd/test_librbd.cc: 2767 in DiffIterateTest_DiffIterateParentDiscard_Test<DiffIterateParams<(bool)0>>::TestBody()()
2761     
2762       interval_set<uint64_t> two;
2763       scribble(image, 10, 102400, &exists, &two);
2764       two = round_diff_interval(two, object_size);
2765     
2766       interval_set<uint64_t> diff;
>>>     CID 1351430:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always false regardless of the values of its operands. This occurs as an argument to a function call.
2767       ASSERT_EQ(0, image.diff_iterate2(NULL, 0, size, true, this->whole_object,
2768                                        iterate_cb, (void *)&diff));
2769       ASSERT_TRUE(two.subset_of(diff));
2770     }
2771     
2772     TEST_F(TestLibRBD, ZeroLengthWrite)
/test/librbd/test_librbd.cc: 2742 in DiffIterateTest_DiffIterateParentDiscard_Test<DiffIterateParams<(bool)0>>::TestBody()()
2736       int order = 0;
2737     
2738       ASSERT_EQ(0, create_image_pp(rbd, ioctx, name.c_str(), size, &order));
2739       ASSERT_EQ(0, rbd.open(ioctx, image, name.c_str(), NULL));
2740     
2741       uint64_t object_size = 0;
>>>     CID 1351430:    (CONSTANT_EXPRESSION_RESULT)
>>>     "this , 0 /* DiffIterateTest<DiffIterateParams<false> >::whole_object */" is always false regardless of the values of its operands. This occurs as the logical operand of if.
2742       if (this->whole_object) {
2743         object_size = 1 << order;
2744       }
2745     
2746       interval_set<uint64_t> exists;
2747       interval_set<uint64_t> one;

** CID 1351429:  Error handling issues  (CHECKED_RETURN)


________________________________________________________________________________________________________
*** CID 1351429:  Error handling issues  (CHECKED_RETURN)
/rocksdb/util/io_posix.cc: 178 in rocksdb::PosixRandomAccessFile::Read(unsigned long, unsigned long, rocksdb::Slice *, char *) const()
172         // An error: return a non-ok status
173         s = IOError(filename_, errno);
174       }
175       if (!use_os_buffer_) {
176         // we need to fadvise away the entire range of pages because
177         // we do not want readahead pages to be cached.
>>>     CID 1351429:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "rocksdb::Fadvise(this->fd_, 0L, 0UL, 4)" without checking return value. It wraps a library function that may fail and return an error code.
178         Fadvise(fd_, 0, 0, POSIX_FADV_DONTNEED);  // free OS pages
179       }
180       return s;
181     }
182     
183     #ifdef OS_LINUX

** CID 1351428:    (CHECKED_RETURN)


________________________________________________________________________________________________________
*** CID 1351428:    (CHECKED_RETURN)
/rocksdb/util/io_posix.cc: 192 in rocksdb::PosixRandomAccessFile::Hint(rocksdb::RandomAccessFile::AccessPattern)()
186     }
187     #endif
188     
189     void PosixRandomAccessFile::Hint(AccessPattern pattern) {
190       switch (pattern) {
191         case NORMAL:
>>>     CID 1351428:    (CHECKED_RETURN)
>>>     Calling "rocksdb::Fadvise(this->fd_, 0L, 0UL, 0)" without checking return value. It wraps a library function that may fail and return an error code.
192           Fadvise(fd_, 0, 0, POSIX_FADV_NORMAL);
193           break;
194         case RANDOM:
195           Fadvise(fd_, 0, 0, POSIX_FADV_RANDOM);
196           break;
197         case SEQUENTIAL:
/rocksdb/util/io_posix.cc: 195 in rocksdb::PosixRandomAccessFile::Hint(rocksdb::RandomAccessFile::AccessPattern)()
189     void PosixRandomAccessFile::Hint(AccessPattern pattern) {
190       switch (pattern) {
191         case NORMAL:
192           Fadvise(fd_, 0, 0, POSIX_FADV_NORMAL);
193           break;
194         case RANDOM:
>>>     CID 1351428:    (CHECKED_RETURN)
>>>     Calling "rocksdb::Fadvise(this->fd_, 0L, 0UL, 1)" without checking return value. It wraps a library function that may fail and return an error code.
195           Fadvise(fd_, 0, 0, POSIX_FADV_RANDOM);
196           break;
197         case SEQUENTIAL:
198           Fadvise(fd_, 0, 0, POSIX_FADV_SEQUENTIAL);
199           break;
200         case WILLNEED:
/rocksdb/util/io_posix.cc: 198 in rocksdb::PosixRandomAccessFile::Hint(rocksdb::RandomAccessFile::AccessPattern)()
192           Fadvise(fd_, 0, 0, POSIX_FADV_NORMAL);
193           break;
194         case RANDOM:
195           Fadvise(fd_, 0, 0, POSIX_FADV_RANDOM);
196           break;
197         case SEQUENTIAL:
>>>     CID 1351428:    (CHECKED_RETURN)
>>>     Calling "rocksdb::Fadvise(this->fd_, 0L, 0UL, 2)" without checking return value. It wraps a library function that may fail and return an error code.
198           Fadvise(fd_, 0, 0, POSIX_FADV_SEQUENTIAL);
199           break;
200         case WILLNEED:
201           Fadvise(fd_, 0, 0, POSIX_FADV_WILLNEED);
202           break;
203         case DONTNEED:
/rocksdb/util/io_posix.cc: 201 in rocksdb::PosixRandomAccessFile::Hint(rocksdb::RandomAccessFile::AccessPattern)()
195           Fadvise(fd_, 0, 0, POSIX_FADV_RANDOM);
196           break;
197         case SEQUENTIAL:
198           Fadvise(fd_, 0, 0, POSIX_FADV_SEQUENTIAL);
199           break;
200         case WILLNEED:
>>>     CID 1351428:    (CHECKED_RETURN)
>>>     Calling "rocksdb::Fadvise(this->fd_, 0L, 0UL, 3)" without checking return value. It wraps a library function that may fail and return an error code.
201           Fadvise(fd_, 0, 0, POSIX_FADV_WILLNEED);
202           break;
203         case DONTNEED:
204           Fadvise(fd_, 0, 0, POSIX_FADV_DONTNEED);
205           break;
206         default:
/rocksdb/util/io_posix.cc: 204 in rocksdb::PosixRandomAccessFile::Hint(rocksdb::RandomAccessFile::AccessPattern)()
198           Fadvise(fd_, 0, 0, POSIX_FADV_SEQUENTIAL);
199           break;
200         case WILLNEED:
201           Fadvise(fd_, 0, 0, POSIX_FADV_WILLNEED);
202           break;
203         case DONTNEED:
>>>     CID 1351428:    (CHECKED_RETURN)
>>>     Calling "rocksdb::Fadvise(this->fd_, 0L, 0UL, 4)" without checking return value. It wraps a library function that may fail and return an error code.
204           Fadvise(fd_, 0, 0, POSIX_FADV_DONTNEED);
205           break;
206         default:
207           assert(false);
208           break;
209       }

** CID 1351427:  Error handling issues  (CHECKED_RETURN)


________________________________________________________________________________________________________
*** CID 1351427:  Error handling issues  (CHECKED_RETURN)
/rocksdb/util/io_posix.cc: 82 in rocksdb::PosixSequentialFile::Read(unsigned long, rocksdb::Slice *, char *)()
76           s = IOError(filename_, errno);
77         }
78       }
79       if (!use_os_buffer_) {
80         // we need to fadvise away the entire range of pages because
81         // we do not want readahead pages to be cached.
>>>     CID 1351427:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "rocksdb::Fadvise(this->fd_, 0L, 0UL, 4)" without checking return value. It wraps a library function that may fail and return an error code.
82         Fadvise(fd_, 0, 0, POSIX_FADV_DONTNEED);  // free OS pages
83       }
84       return s;
85     }
86     
87     Status PosixSequentialFile::Skip(uint64_t n) {

** CID 1351426:  Error handling issues  (CHECKED_RETURN)
/tools/rbd/action/Watch.cc: 88 in rbd::action::watch::do_watch(librados::IoCtx &, librbd::Image &, const char *)()


________________________________________________________________________________________________________
*** CID 1351426:  Error handling issues  (CHECKED_RETURN)
/tools/rbd/action/Watch.cc: 88 in rbd::action::watch::do_watch(librados::IoCtx &, librbd::Image &, const char *)()
82       if (r < 0) {
83         std::cerr << "rbd: watch failed" << std::endl;
84         return r;
85       }
86     
87       std::cout << "press enter to exit..." << std::endl;
>>>     CID 1351426:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "getchar()" without checking return value. This library function may fail and return an error code. [Note: The source code implementation of the function has been overridden by a builtin model.]
88       getchar();
89     
90       r = pp.unwatch2(cookie);
91       if (r < 0) {
92         std::cerr << "rbd: unwatch failed" << std::endl;
93         return r;

** CID 1351425:  Error handling issues  (CHECKED_RETURN)
/tools/rbd/action/Export.cc: 112 in rbd::action::export_full::do_export(librbd::Image &, const char *, bool)()


________________________________________________________________________________________________________
*** CID 1351425:  Error handling issues  (CHECKED_RETURN)
/tools/rbd/action/Export.cc: 112 in rbd::action::export_full::do_export(librbd::Image &, const char *, bool)()
106       } else {
107         max_concurrent_ops = max(g_conf->rbd_concurrent_management_ops, 1);
108         fd = open(path, O_WRONLY | O_CREAT | O_EXCL, 0644);
109         if (fd < 0) {
110           return -errno;
111         }
>>>     CID 1351425:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "posix_fadvise(fd, 0L, 0L, 2)" without checking return value. This library function may fail and return an error code.
112         posix_fadvise(fd, 0, 0, POSIX_FADV_SEQUENTIAL);
113       }
114     
115       utils::ProgressContext pc("Exporting image", no_progress);
116     
117       SimpleThrottle throttle(max_concurrent_ops, false);

** CID 1351424:  Error handling issues  (CHECKED_RETURN)
/tools/rbd/action/Import.cc: 130 in rbd::action::import::do_import(librbd::RBD &, librados::IoCtx &, const char *, const char *, librbd::ImageOptions &, bool)()


________________________________________________________________________________________________________
*** CID 1351424:  Error handling issues  (CHECKED_RETURN)
/tools/rbd/action/Import.cc: 130 in rbd::action::import::do_import(librbd::RBD &, librados::IoCtx &, const char *, const char *, librbd::ImageOptions &, bool)()
124             goto done;
125           }
126           assert(bdev_size >= 0);
127           size = (uint64_t) bdev_size;
128         }
129     
>>>     CID 1351424:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "posix_fadvise(fd, 0L, 0L, 2)" without checking return value. This library function may fail and return an error code.
130         posix_fadvise(fd, 0, 0, POSIX_FADV_SEQUENTIAL);
131       }
132     
133       uint64_t format;
134       r = opts.get(RBD_IMAGE_OPTION_FORMAT, &format);
135       assert(r == 0);

** CID 1351423:  Error handling issues  (CHECKED_RETURN)
/tools/rbd_nbd/rbd-nbd.cc: 725 in do_list_mapped_devices()()


________________________________________________________________________________________________________
*** CID 1351423:  Error handling issues  (CHECKED_RETURN)
/tools/rbd_nbd/rbd-nbd.cc: 725 in do_list_mapped_devices()()
719         int nbd = open_device(path);
720         if (nbd < 0)
721           break;
722         if (ioctl(nbd, NBD_SET_SOCK, fd[0]) != 0)
723           cout << path << std::endl;
724         else
>>>     CID 1351423:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "ioctl" without checking return value (as is done elsewhere 47 out of 55 times).
725           ioctl(nbd, NBD_CLEAR_SOCK);
726         close(nbd);
727         m++;
728       }
729     
730       close(fd[0]);

** CID 1351422:  Error handling issues  (CHECKED_RETURN)
/tools/rbd_nbd/rbd-nbd.cc: 677 in do_unmap()()


________________________________________________________________________________________________________
*** CID 1351422:  Error handling issues  (CHECKED_RETURN)
/tools/rbd_nbd/rbd-nbd.cc: 677 in do_unmap()()
671         cerr << "rbd-nbd: failed to open device: " << devpath << std::endl;
672         return nbd;
673       }
674     
675       if (ioctl(nbd, NBD_DISCONNECT) < 0)
676         cerr << "rbd-nbd: the device is not used" << std::endl;
>>>     CID 1351422:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "ioctl" without checking return value (as is done elsewhere 47 out of 55 times).
677       ioctl(nbd, NBD_CLEAR_SOCK);
678       close(nbd);
679     
680       return 0;
681     }
682     

** CID 1351421:    (CHECKED_RETURN)
/tools/rbd_nbd/rbd-nbd.cc: 594 in do_map()()
/tools/rbd_nbd/rbd-nbd.cc: 639 in do_map()()
/tools/rbd_nbd/rbd-nbd.cc: 648 in do_map()()


________________________________________________________________________________________________________
*** CID 1351421:    (CHECKED_RETURN)
/tools/rbd_nbd/rbd-nbd.cc: 594 in do_map()()
588       r = ioctl(nbd, NBD_SET_SIZE, size);
589       if (r < 0) {
590         r = -errno;
591         goto close_nbd;
592       }
593     
>>>     CID 1351421:    (CHECKED_RETURN)
>>>     Calling "ioctl" without checking return value (as is done elsewhere 47 out of 55 times).
594       ioctl(nbd, NBD_SET_FLAGS, flags);
595     
596       read_only = snapname.empty() ? 0 : 1;
597       r = ioctl(nbd, BLKROSET, (unsigned long) &read_only);
598       if (r < 0) {
599         r = -errno;
/tools/rbd_nbd/rbd-nbd.cc: 639 in do_map()()
633         }
634     
635         {
636           NBDServer server(fd[1], image);
637     
638           server.start();
>>>     CID 1351421:    (CHECKED_RETURN)
>>>     Calling "ioctl" without checking return value (as is done elsewhere 47 out of 55 times).
639           ioctl(nbd, NBD_DO_IT);
640           server.stop();
641         }
642     
643         io_ctx.unwatch2(watcher);
644       }
/tools/rbd_nbd/rbd-nbd.cc: 648 in do_map()()
642     
643         io_ctx.unwatch2(watcher);
644       }
645     
646     close_nbd:
647       if (r < 0) {
>>>     CID 1351421:    (CHECKED_RETURN)
>>>     Calling "ioctl" without checking return value (as is done elsewhere 47 out of 55 times).
648         ioctl(nbd, NBD_CLEAR_SOCK);
649         cerr << "rbd-nbd: failed to map, status: " << cpp_strerror(-r) << std::endl;
650       }
651       close(nbd);
652     close_fd:
653       close(fd[0]);

** CID 1351420:  Error handling issues  (CHECKED_RETURN)
/rgw/rgw_rest_s3.cc: 557 in RGWSetBucketWebsite_ObjStore_S3::get_params()()


________________________________________________________________________________________________________
*** CID 1351420:  Error handling issues  (CHECKED_RETURN)
/rgw/rgw_rest_s3.cc: 557 in RGWSetBucketWebsite_ObjStore_S3::get_params()()
551       }
552     
553       bufferlist bl;
554       bl.append(data, len);
555     
556       RGWXMLDecoder::XMLParser parser;
>>>     CID 1351420:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "init" without checking return value (as is done elsewhere 10 out of 11 times).
557       parser.init();
558     
559       if (!parser.parse(data, len, 1)) {
560         string str(data, len);
561         ldout(s->cct, 5) << "failed to parse xml: " << str << dendl;
562         return -EINVAL;

** CID 1351419:  Error handling issues  (CHECKED_RETURN)
/rocksdb/util/env_posix.cc: 138 in rocksdb::<unnamed>::PosixEnv::SetFD_CLOEXEC(int, const rocksdb::EnvOptions *)()


________________________________________________________________________________________________________
*** CID 1351419:  Error handling issues  (CHECKED_RETURN)
/rocksdb/util/env_posix.cc: 138 in rocksdb::<unnamed>::PosixEnv::SetFD_CLOEXEC(int, const rocksdb::EnvOptions *)()
132         // thread_status_updater_.
133         delete thread_status_updater_;
134       }
135     
136       void SetFD_CLOEXEC(int fd, const EnvOptions* options) {
137         if ((options == nullptr || options->set_fd_cloexec) && fd > 0) {
>>>     CID 1351419:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "fcntl(fd, 2, fcntl(fd, 1) | 1)" without checking return value. This library function may fail and return an error code.
138           fcntl(fd, F_SETFD, fcntl(fd, F_GETFD) | FD_CLOEXEC);
139         }
140       }
141     
142       virtual Status NewSequentialFile(const std::string& fname,
143                                        unique_ptr<SequentialFile>* result,

** CID 1351418:  Error handling issues  (CHECKED_RETURN)
/tools/ceph_monstore_tool.cc: 689 in main::boost_se_guard_t_686::boost_se_body(int &, int &, std::basic_string<char, std::char_traits<char>, std::allocator<char>>&)()


________________________________________________________________________________________________________
*** CID 1351418:  Error handling issues  (CHECKED_RETURN)
/tools/ceph_monstore_tool.cc: 689 in main::boost_se_guard_t_686::boost_se_body(int &, int &, std::basic_string<char, std::char_traits<char>, std::allocator<char>>&)()

** CID 1351417:  Error handling issues  (CHECKED_RETURN)
/tools/rbd/action/Journal.cc: 712 in rbd::action::journal::do_import_journal(librados::IoCtx &, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, bool, bool)()


________________________________________________________________________________________________________
*** CID 1351417:  Error handling issues  (CHECKED_RETURN)
/tools/rbd/action/Journal.cc: 712 in rbd::action::journal::do_import_journal(librados::IoCtx &, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, bool, bool)()
706       } else {
707         if ((fd = open(path.c_str(), O_RDONLY)) < 0) {
708           r = -errno;
709           std::cerr << "rbd: error opening " << path << std::endl;
710           return r;
711         }
>>>     CID 1351417:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "posix_fadvise(fd, 0L, 0L, 2)" without checking return value. This library function may fail and return an error code.
712         posix_fadvise(fd, 0, 0, POSIX_FADV_SEQUENTIAL);
713       }
714     
715       r = JournalImporter(io_ctx, journal_id, fd, no_error, verbose).exec();
716     
717       if (!from_stdin) {

** CID 1351416:  Error handling issues  (CHECKED_RETURN)
/tools/rbd/action/ExportDiff.cc: 134 in rbd::action::export_diff::do_export_diff(librbd::Image &, const char *, const char *, bool, const char *, bool)::boost_se_guard_t_131::boost_se_body(int &, int &, const char *&)()


________________________________________________________________________________________________________
*** CID 1351416:  Error handling issues  (CHECKED_RETURN)
/tools/rbd/action/ExportDiff.cc: 134 in rbd::action::export_diff::do_export_diff(librbd::Image &, const char *, const char *, bool, const char *, bool)::boost_se_guard_t_131::boost_se_body(int &, int &, const char *&)()
128       if (fd < 0)
129         return -errno;
130     
131       BOOST_SCOPE_EXIT((&r) (&fd) (&path)) {
132         close(fd);
133         if (r < 0 && fd != 1) {
>>>     CID 1351416:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "remove(path)" without checking return value. This library function may fail and return an error code.
134           remove(path);
135         }
136       } BOOST_SCOPE_EXIT_END
137     
138       {
139         // header

** CID 1351415:  Error handling issues  (CHECKED_RETURN)
/tools/rbd/action/Journal.cc: 510 in rbd::action::journal::do_export_journal(librados::IoCtx &, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, bool, bool)()


________________________________________________________________________________________________________
*** CID 1351415:  Error handling issues  (CHECKED_RETURN)
/tools/rbd/action/Journal.cc: 510 in rbd::action::journal::do_export_journal(librados::IoCtx &, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, bool, bool)()
504         fd = open(path.c_str(), O_WRONLY | O_CREAT | O_EXCL, 0644);
505         if (fd < 0) {
506           r = -errno;
507           std::cerr << "rbd: error creating " << path << std::endl;
508           return r;
509         }
>>>     CID 1351415:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "posix_fadvise(fd, 0L, 0L, 2)" without checking return value. This library function may fail and return an error code.
510         posix_fadvise(fd, 0, 0, POSIX_FADV_SEQUENTIAL);
511       }
512     
513       r = JournalExporter(io_ctx, journal_id, fd, no_error, verbose).exec();
514     
515       if (!to_stdout) {

** CID 1351414:  Incorrect expression  (BAD_SIZEOF)
/os/bluestore/BlueStore.cc: 1576 in BlueStore::_setup_block_symlink_or_file(std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long)()


________________________________________________________________________________________________________
*** CID 1351414:  Incorrect expression  (BAD_SIZEOF)
/os/bluestore/BlueStore.cc: 1576 in BlueStore::_setup_block_symlink_or_file(std::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::basic_string<char, std::char_traits<char>, std::allocator<char>>, unsigned long)()
1570       uint64_t size)
1571     {
1572       dout(20) << __func__ << " name " << name << " path " << epath
1573     	   << " size " << size << dendl;
1574       int r = 0;
1575       if (epath.length()) {
>>>     CID 1351414:  Incorrect expression  (BAD_SIZEOF)
>>>     Taking the size of pointer arithmetic expression ""spdk:" - 1" is suspicious.
1576         if (!epath.compare(0, sizeof(SPDK_PREFIX-1), SPDK_PREFIX)) {
1577           string symbol_spdk_file = path + "/" + epath;
1578           r = ::symlinkat(symbol_spdk_file.c_str(), path_fd, name.c_str());
1579           if (r < 0) {
1580             r = -errno;
1581             derr << __func__ << " failed to create " << name << " symlink to "

** CID 1248998:    (UNCAUGHT_EXCEPT)
/ceph_mds.cc: 90 in main()
/ceph_mds.cc: 90 in main()


________________________________________________________________________________________________________
*** CID 1248998:    (UNCAUGHT_EXCEPT)
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1248998:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     
/ceph_mds.cc: 90 in main()
84     static void handle_mds_signal(int signum)
85     {
86       if (mds)
87         mds->handle_signal(signum);
88     }
89     
>>>     CID 1248998:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
90     int main(int argc, const char **argv) 
91     {
92       vector<const char*> args;
93       argv_to_vec(argc, argv, args);
94       env_to_vec(args);
95     


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://scan.coverity.com/projects/ceph?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c

