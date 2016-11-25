From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 24 Nov 2016 23:55:08 -0800
Message-ID: <5837ee5cd0d8_24227b5318181f@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o5.24nn.shared.sendgrid.net ([50.31.63.1]:18078 "EHLO
        o5.24nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750703AbcKYIBq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 25 Nov 2016 03:01:46 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0004p1sjc2.sendgrid.net (SG) with ESMTP id DQ-l109yR7aqCoJ5ypFMdw
        for <ceph-devel@vger.kernel.org>; Fri, 25 Nov 2016 07:55:08.091 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

571 new defect(s) introduced to ceph found with Coverity Scan.
477 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 571 defect(s)


** CID 241636:  Security best practices violations  (SECURE_TEMP)
/home/brad/working/src/ceph/src/lua/src/liolib.c: 282 in io_tmpfile()


________________________________________________________________________________________________________
*** CID 241636:  Security best practices violations  (SECURE_TEMP)
/home/brad/working/src/ceph/src/lua/src/liolib.c: 282 in io_tmpfile()
276       return (p->f == NULL) ? luaL_fileresult(L, 0, filename) : 1;
277     }
278     
279     
280     static int io_tmpfile (lua_State *L) {
281       LStream *p = newfile(L);
>>>     CID 241636:  Security best practices violations  (SECURE_TEMP)
>>>     "tmpfile" creates files with predictable names, which is unsafe.
282       p->f = tmpfile();
283       return (p->f == NULL) ? luaL_fileresult(L, 0, NULL) : 1;
284     }
285     
286     
287     static FILE *getiofile (lua_State *L, const char *findex) {

** CID 241637:  Security best practices violations  (SECURE_TEMP)
/home/brad/working/src/ceph/src/lua/src/loslib.c: 158 in os_tmpname()


________________________________________________________________________________________________________
*** CID 241637:  Security best practices violations  (SECURE_TEMP)
/home/brad/working/src/ceph/src/lua/src/loslib.c: 158 in os_tmpname()
152     }
153     
154     
155     static int os_tmpname (lua_State *L) {
156       char buff[LUA_TMPNAMBUFSIZE];
157       int err;
>>>     CID 241637:  Security best practices violations  (SECURE_TEMP)
>>>     Calling "mkstemp" without securely setting umask first.
158       lua_tmpnam(buff, err);
159       if (err)
160         return luaL_error(L, "unable to generate a unique filename");
161       lua_pushstring(L, buff);
162       return 1;
163     }

** CID 703209:  Error handling issues  (NEGATIVE_RETURNS)
/home/brad/working/src/ceph/src/googletest/googletest/src/gtest-port.cc: 980 in testing::internal::CapturedStream::CapturedStream(int)()


________________________________________________________________________________________________________
*** CID 703209:  Error handling issues  (NEGATIVE_RETURNS)
/home/brad/working/src/ceph/src/googletest/googletest/src/gtest-port.cc: 980 in testing::internal::CapturedStream::CapturedStream(int)()
974         char name_template[] = "/tmp/captured_stream.XXXXXX";
975     #  endif  // GTEST_OS_LINUX_ANDROID
976         const int captured_fd = mkstemp(name_template);
977         filename_ = name_template;
978     # endif  // GTEST_OS_WINDOWS
979         fflush(NULL);
>>>     CID 703209:  Error handling issues  (NEGATIVE_RETURNS)
>>>     "captured_fd" is passed to a parameter that cannot be negative.
980         dup2(captured_fd, fd_);
981         close(captured_fd);
982       }
983     
984       ~CapturedStream() {
985         remove(filename_.c_str());

** CID 703274:  Security best practices violations  (SECURE_TEMP)
/home/brad/working/src/ceph/src/googletest/googletest/src/gtest-port.cc: 976 in testing::internal::CapturedStream::CapturedStream(int)()


________________________________________________________________________________________________________
*** CID 703274:  Security best practices violations  (SECURE_TEMP)
/home/brad/working/src/ceph/src/googletest/googletest/src/gtest-port.cc: 976 in testing::internal::CapturedStream::CapturedStream(int)()
970         // other OEM-customized locations. Never rely on these, and always
971         // use /sdcard.
972         char name_template[] = "/sdcard/gtest_captured_stream.XXXXXX";
973     #  else
974         char name_template[] = "/tmp/captured_stream.XXXXXX";
975     #  endif  // GTEST_OS_LINUX_ANDROID
>>>     CID 703274:  Security best practices violations  (SECURE_TEMP)
>>>     Calling "mkstemp" without securely setting umask first.
976         const int captured_fd = mkstemp(name_template);
977         filename_ = name_template;
978     # endif  // GTEST_OS_WINDOWS
979         fflush(NULL);
980         dup2(captured_fd, fd_);
981         close(captured_fd);

** CID 716871:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/test/multi_stress_watch.cc: 157 in main()


________________________________________________________________________________________________________
*** CID 716871:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/test/multi_stress_watch.cc: 157 in main()
151       }
152       ret = cluster.conf_parse_env(NULL);
153       if (ret) {
154         std::cerr << "Error " << ret << " in cluster.conf_read_env" << std::endl;
155         return ret;
156       }
>>>     CID 716871:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "connect" without checking return value (as is done elsewhere 21 out of 24 times).
157       cluster.connect();
158     
159       if (type == "rep")
160         test_replicated(cluster, pool_name, obj_name);
161       else if (type == "ec")
162         test_erasure(cluster, pool_name, obj_name);
163     
164       sem_destroy(&sem);
165       return 0;

** CID 716938:  Insecure data handling  (INTEGER_OVERFLOW)
/home/brad/working/src/ceph/src/auth/Crypto.cc: 61 in get_random(unsigned long, unsigned long)()


________________________________________________________________________________________________________
*** CID 716938:  Insecure data handling  (INTEGER_OVERFLOW)
/home/brad/working/src/ceph/src/auth/Crypto.cc: 61 in get_random(unsigned long, unsigned long)()
55     
56     uint64_t get_random(uint64_t min_val, uint64_t max_val)
57     {
58       uint64_t r;
59       get_random_bytes((char *)&r, sizeof(r));
60       r = min_val + r % (max_val - min_val + 1);
>>>     CID 716938:  Insecure data handling  (INTEGER_OVERFLOW)
>>>     Overflowed or truncated value (or a value computed from an overflowed or truncated value) "r" used as return value.
61       return r;
62     }
63     
64     
65     // ---------------------------------------------------
66     

** CID 717145:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/ceph_fuse.cc: 70 in main()


________________________________________________________________________________________________________
*** CID 717145:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/ceph_fuse.cc: 70 in main()
64     "                    use root_directory as the mounted root, rather than the full Ceph tree.\n"
65     "\n";
66       fuse_usage();
67       generic_client_usage();
68     }
69     
>>>     CID 717145:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **, char const **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
70     int main(int argc, const char **argv, const char *envp[]) {
71       int filer_flags = 0;
72       //cerr << "ceph-fuse starting " << myrank << "/" << world << std::endl;
73       vector<const char*> args;
74       argv_to_vec(argc, argv, args);
75       if (args.empty()) {

** CID 717147:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/ceph_mds.cc: 88 in main()


________________________________________________________________________________________________________
*** CID 717147:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/ceph_mds.cc: 88 in main()
82     static void handle_mds_signal(int signum)
83     {
84       if (mds)
85         mds->handle_signal(signum);
86     }
87     
>>>     CID 717147:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
88     int main(int argc, const char **argv) 
89     {
90       vector<const char*> args;
91       argv_to_vec(argc, argv, args);
92       env_to_vec(args);
93     

** CID 717336:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/osd/ClassHandler.h: 72 in ClassHandler::ClassData::ClassData()()


________________________________________________________________________________________________________
*** CID 717336:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/osd/ClassHandler.h: 72 in ClassHandler::ClassData::ClassData()()
66         set<ClassData *> missing_dependencies; /* only missing dependencies */
67     
68         ClassMethod *_get_method(const char *mname);
69     
70         ClassData() : status(CLASS_UNKNOWN), 
71     		  handler(NULL),
>>>     CID 717336:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "whitelisted" is not initialized in this constructor nor in any functions that it calls.
72     		  handle(NULL) {}
73         ~ClassData() { }
74     
75         ClassMethod *register_method(const char *mname, int flags, cls_method_call_t func);
76         ClassMethod *register_cxx_method(const char *mname, int flags, cls_method_cxx_call_t func);
77         void unregister_method(ClassMethod *method);

** CID 717379:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rgw/rgw_op.h: 174 in RGWGetObj::RGWGetObj()()


________________________________________________________________________________________________________
*** CID 717379:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/rgw/rgw_op.h: 174 in RGWGetObj::RGWGetObj()()
168         first_block = 0;
169         last_block = 0;
170         q_ofs = 0;
171         q_len = 0;
172         first_data = true;
173         cur_ofs = 0;
>>>     CID 717379:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "rgwx_stat" is not initialized in this constructor nor in any functions that it calls.
174      }
175     
176       bool prefetch_data();
177     
178       void set_get_data(bool get_data) {
179         this->get_data = get_data;

** CID 727970:  Concurrent data access violations  (MISSING_LOCK)
/home/brad/working/src/ceph/src/key_value_store/kv_flat_btree_async.cc: 1874 in KvFlatBtreeAsync::set_many(const std::map<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::list, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::list>>> &)()


________________________________________________________________________________________________________
*** CID 727970:  Concurrent data access violations  (MISSING_LOCK)
/home/brad/working/src/ceph/src/key_value_store/kv_flat_btree_async.cc: 1874 in KvFlatBtreeAsync::set_many(const std::map<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::list, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::list>>> &)()
1868         }
1869     
1870         big_map.insert(to_delete[to_delete.size() - 1].omap.begin(),
1871     	to_delete[to_delete.size() - 1].omap.end());
1872       }
1873     
>>>     CID 727970:  Concurrent data access violations  (MISSING_LOCK)
>>>     Accessing "this->client_index" without holding lock "Mutex._m". Elsewhere, "KvFlatBtreeAsync.client_index" is accessed with "Mutex._m" held 4 out of 6 times (4 of these accesses strongly imply that it is necessary).
1874       to_create.push_back(object_data(
1875     	to_string(client_name, client_index++)));
1876       to_create[0].min_kdata = to_delete[0].min_kdata;
1877     
1878       for(map<string, bufferlist>::iterator it = big_map.begin();
1879           it != big_map.end(); ++it) {

** CID 736293:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 1065 in boost::function<void (int)>::function<boost::_bi::bind_t<void, boost::_mfi::mf3<void, librados::TestWatchNotify, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ceph::buffer::list &, unsigned long>, boost::_bi::list4<boost::_bi::value<librados::TestWatchNotify *>, boost::_bi::value<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, boost::_bi::value<ceph::buffer::list>, boost::_bi::value<unsigned long>>>>(T1, boost::enable_if_c<(!(boost::is_integral<T1>::value)), int>::type)()


________________________________________________________________________________________________________
*** CID 736293:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 1065 in boost::function<void (int)>::function<boost::_bi::bind_t<void, boost::_mfi::mf3<void, librados::TestWatchNotify, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ceph::buffer::list &, unsigned long>, boost::_bi::list4<boost::_bi::value<librados::TestWatchNotify *>, boost::_bi::value<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, boost::_bi::value<ceph::buffer::list>, boost::_bi::value<unsigned long>>>>(T1, boost::enable_if_c<(!(boost::is_integral<T1>::value)), int>::type)()
1059     
1060     public:
1061     
1062       function() : base_type() {}
1063     
1064       template<typename Functor>
>>>     CID 736293:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter f of type "boost::_bi::bind_t<void, boost::_mfi::mf3<void, librados::TestWatchNotify, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const &, ceph::buffer::list &, unsigned long>, boost::_bi::list4<boost::_bi::value<librados::TestWatchNotify *>, boost::_bi::value<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > >, boost::_bi::value<ceph::buffer::list>, boost::_bi::value<unsigned long> > >" (size 152 bytes) by value.
1065       function(Functor f
1066     #ifndef BOOST_NO_SFINAE
1067                ,typename boost::enable_if_c<
1068                               !(is_integral<Functor>::value),
1069                            int>::type = 0
1070     #endif

** CID 736294:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 917 in boost::function1<void, int>::assign_to<boost::_bi::bind_t<void, boost::_mfi::mf3<void, librados::TestWatchNotify, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ceph::buffer::list &, unsigned long>, boost::_bi::list4<boost::_bi::value<librados::TestWatchNotify *>, boost::_bi::value<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, boost::_bi::value<ceph::buffer::list>, boost::_bi::value<unsigned long>>>>(T1)()


________________________________________________________________________________________________________
*** CID 736294:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 917 in boost::function1<void, int>::assign_to<boost::_bi::bind_t<void, boost::_mfi::mf3<void, librados::TestWatchNotify, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ceph::buffer::list &, unsigned long>, boost::_bi::list4<boost::_bi::value<librados::TestWatchNotify *>, boost::_bi::value<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, boost::_bi::value<ceph::buffer::list>, boost::_bi::value<unsigned long>>>>(T1)()
911               get_vtable()->base.manager(f.functor, this->functor,
912                                          boost::detail::function::clone_functor_tag);
913           }
914         }
915     
916         template<typename Functor>
>>>     CID 736294:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter f of type "boost::_bi::bind_t<void, boost::_mfi::mf3<void, librados::TestWatchNotify, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const &, ceph::buffer::list &, unsigned long>, boost::_bi::list4<boost::_bi::value<librados::TestWatchNotify *>, boost::_bi::value<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > >, boost::_bi::value<ceph::buffer::list>, boost::_bi::value<unsigned long> > >" (size 152 bytes) by value.
917         void assign_to(Functor f)
918         {
919           using boost::detail::function::vtable_base;
920     
921           typedef typename boost::detail::function::get_function_tag<Functor>::type tag;
922           typedef boost::detail::function::BOOST_FUNCTION_GET_INVOKER<tag> get_invoker;

** CID 736295:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 718 in boost::function1<void, int>::function1<boost::_bi::bind_t<void, boost::_mfi::mf3<void, librados::TestWatchNotify, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ceph::buffer::list &, unsigned long>, boost::_bi::list4<boost::_bi::value<librados::TestWatchNotify *>, boost::_bi::value<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, boost::_bi::value<ceph::buffer::list>, boost::_bi::value<unsigned long>>>>(T1, boost::enable_if_c<(!(boost::is_integral<T1>::value)), int>::type)()


________________________________________________________________________________________________________
*** CID 736295:  Performance inefficiencies  (PASS_BY_VALUE)
/boost/include/boost/function/function_template.hpp: 718 in boost::function1<void, int>::function1<boost::_bi::bind_t<void, boost::_mfi::mf3<void, librados::TestWatchNotify, const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> &, ceph::buffer::list &, unsigned long>, boost::_bi::list4<boost::_bi::value<librados::TestWatchNotify *>, boost::_bi::value<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, boost::_bi::value<ceph::buffer::list>, boost::_bi::value<unsigned long>>>>(T1, boost::enable_if_c<(!(boost::is_integral<T1>::value)), int>::type)()
712     
713         BOOST_FUNCTION_FUNCTION() : function_base() { }
714     
715         // MSVC chokes if the following two constructors are collapsed into
716         // one with a default parameter.
717         template<typename Functor>
>>>     CID 736295:  Performance inefficiencies  (PASS_BY_VALUE)
>>>     Passing parameter f of type "boost::_bi::bind_t<void, boost::_mfi::mf3<void, librados::TestWatchNotify, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const &, ceph::buffer::list &, unsigned long>, boost::_bi::list4<boost::_bi::value<librados::TestWatchNotify *>, boost::_bi::value<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > >, boost::_bi::value<ceph::buffer::list>, boost::_bi::value<unsigned long> > >" (size 152 bytes) by value.
718         BOOST_FUNCTION_FUNCTION(Functor BOOST_FUNCTION_TARGET_FIX(const &) f
719     #ifndef BOOST_NO_SFINAE
720                                 ,typename boost::enable_if_c<
721                                  !(is_integral<Functor>::value),
722                                             int>::type = 0
723     #endif // BOOST_NO_SFINAE

** CID 742176:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/googletest/googletest/src/gtest-port.cc: 985 in testing::internal::CapturedStream::~CapturedStream()()


________________________________________________________________________________________________________
*** CID 742176:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/googletest/googletest/src/gtest-port.cc: 985 in testing::internal::CapturedStream::~CapturedStream()()
979         fflush(NULL);
980         dup2(captured_fd, fd_);
981         close(captured_fd);
982       }
983     
984       ~CapturedStream() {
>>>     CID 742176:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "remove(this->filename_.c_str())" without checking return value. This library function may fail and return an error code.
985         remove(filename_.c_str());
986       }
987     
988       std::string GetCapturedString() {
989         if (uncaptured_fd_ != -1) {
990           // Restores the original stream.

** CID 742182:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/googletest/googletest/src/gtest-port.cc: 936 in testing::internal::CapturedStream::CapturedStream(int)()


________________________________________________________________________________________________________
*** CID 742182:  Resource leaks  (CTOR_DTOR_LEAK)
/home/brad/working/src/ceph/src/googletest/googletest/src/gtest-port.cc: 936 in testing::internal::CapturedStream::CapturedStream(int)()
930     #if GTEST_HAS_STREAM_REDIRECTION
931     
932     // Object that captures an output stream (stdout/stderr).
933     class CapturedStream {
934      public:
935       // The ctor redirects the stream to a temporary file.
>>>     CID 742182:  Resource leaks  (CTOR_DTOR_LEAK)
>>>     The constructor allocates field "uncaptured_fd_" of "testing::internal::CapturedStream" but the destructor and whatever functions it calls do not free it.
936       explicit CapturedStream(int fd) : fd_(fd), uncaptured_fd_(dup(fd)) {
937     # if GTEST_OS_WINDOWS
938         char temp_dir_path[MAX_PATH + 1] = { '\0' };  // NOLINT
939         char temp_file_path[MAX_PATH + 1] = { '\0' };  // NOLINT
940     
941         ::GetTempPathA(sizeof(temp_dir_path), temp_dir_path);

** CID 742242:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/googletest/googletest/src/gtest_main.cc: 34 in main()


________________________________________________________________________________________________________
*** CID 742242:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/googletest/googletest/src/gtest_main.cc: 34 in main()
28     // OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
29     
30     #include <stdio.h>
31     
32     #include "gtest/gtest.h"
33     
>>>     CID 742242:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "testing::internal::<unnamed>::ClassUniqueToAlwaysTrue" is thrown and never caught.
34     GTEST_API_ int main(int argc, char **argv) {
35       printf("Running main() from gtest_main.cc\n");
36       testing::InitGoogleTest(&argc, argv);
37       return RUN_ALL_TESTS();

** CID 742243:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/googletest/googletest/src/gtest_main.cc: 34 in main()


________________________________________________________________________________________________________
*** CID 742243:  Error handling issues  (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/googletest/googletest/src/gtest_main.cc: 34 in main()
28     // OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
29     
30     #include <stdio.h>
31     
32     #include "gtest/gtest.h"
33     
>>>     CID 742243:  Error handling issues  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "testing::internal::GoogleTestFailureException" is thrown and never caught.
34     GTEST_API_ int main(int argc, char **argv) {
35       printf("Running main() from gtest_main.cc\n");
36       testing::InitGoogleTest(&argc, argv);
37       return RUN_ALL_TESTS();

** CID 751307:  Uninitialized members  (UNINIT_CTOR)
/boost/include/boost/asio/detail/buffer_sequence_adapter.hpp: 115 in boost::asio::detail::buffer_sequence_adapter<boost::asio::const_buffer, boost::asio::detail::consuming_buffers<boost::asio::const_buffer, boost::asio::const_buffers_1>>::buffer_sequence_adapter(const boost::asio::detail::consuming_buffers<boost::asio::const_buffer, boost::asio::const_buffers_1> &)()


________________________________________________________________________________________________________
*** CID 751307:  Uninitialized members  (UNINIT_CTOR)
/boost/include/boost/asio/detail/buffer_sequence_adapter.hpp: 115 in boost::asio::detail::buffer_sequence_adapter<boost::asio::const_buffer, boost::asio::detail::consuming_buffers<boost::asio::const_buffer, boost::asio::const_buffers_1>>::buffer_sequence_adapter(const boost::asio::detail::consuming_buffers<boost::asio::const_buffer, boost::asio::const_buffers_1> &)()
109         for (; iter != end && count_ < max_buffers; ++iter, ++count_)
110         {
111           Buffer buffer(*iter);
112           init_native_buffer(buffers_[count_], buffer);
113           total_buffer_size_ += boost::asio::buffer_size(buffer);
114         }
>>>     CID 751307:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member field "buffers_.iov_len" is not initialized in this constructor nor in any functions that it calls.
115       }
116     
117       native_buffer_type* buffers()
118       {
119         return buffers_;
120       }

** CID 751308:  Uninitialized members  (UNINIT_CTOR)
/boost/include/boost/asio/detail/consuming_buffers.hpp: 54 in boost::asio::detail::consuming_buffers_iterator<boost::asio::const_buffer, const boost::asio::const_buffer *>::consuming_buffers_iterator()()


________________________________________________________________________________________________________
*** CID 751308:  Uninitialized members  (UNINIT_CTOR)
/boost/include/boost/asio/detail/consuming_buffers.hpp: 54 in boost::asio::detail::consuming_buffers_iterator<boost::asio::const_buffer, const boost::asio::const_buffer *>::consuming_buffers_iterator()()
48       typedef std::forward_iterator_tag iterator_category;
49     
50       // Default constructor creates an end iterator.
51       consuming_buffers_iterator()
52         : at_end_(true)
53       {
>>>     CID 751308:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "max_size_" is not initialized in this constructor nor in any functions that it calls.
54       }
55     
56       // Construct with a buffer for the first entry and an iterator
57       // range for the remaining entries.
58       consuming_buffers_iterator(bool at_end, const Buffer& first,
59           Buffer_Iterator begin_remainder, Buffer_Iterator end_remainder,


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8E0eKxoWGBuHkFwxOZeOe5PI-2Bbcsr6tQSnc9tVa3u-2FbK4gI5-2Bj1KFhVT-2FqKt3ST-2BS5C2G-2FR-2Fg4esuav13LzJjeBVhJ7JiW5se2WO3seQh7vRlquG0-2F5D05IZe-2BWcgsJ4hURDuUGMWFAczNEXWTvVpjvncidzDEV-2B372GG603Vyhn8kX5mdNESPnPfiiKi5kbt4-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8E0eKxoWGBuHkFwxOZeOe5PI-2Bbcsr6tQSnc9tVa3u-2FbKxaLdtQjVCT5IYYfJWC2tbsa7HfgSYE3-2Fqr1UXcDtJ-2BoNSM86-2BbOfMmTgjTw2k1aQ5J2qq58FagkPQtnbwiwp7YP1v4SiRamBj7ZIOb3SgKRA-2FdU1d6r8dO-2B4jsbcC2LQx12Ozi4AgqnjxXlYPw-2FwL8-3D

