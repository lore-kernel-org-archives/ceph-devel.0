From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 15 Jun 2017 02:50:54 -0700
Message-ID: <5942587e47a2b_101d8c7314915df@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:37761 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750784AbdFOJuz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 15 Jun 2017 05:50:55 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0003p1sjc2.sendgrid.net (SG) with ESMTP id 4XUJFfhJShWp8qLKKyyitw
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jun 2017 09:50:54.331 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

113 new defect(s) introduced to ceph found with Coverity Scan.
12 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 113 defect(s)


** CID 70416:  Uninitialized members  (UNINIT_CTOR)
/usr/include/c++/6.3.1/bits/locale_classes.h: 513 in std::locale::id::id()()


________________________________________________________________________________________________________
*** CID 70416:  Uninitialized members  (UNINIT_CTOR)
/usr/include/c++/6.3.1/bits/locale_classes.h: 513 in std::locale::id::id()()
507         id(const id&);  // Not defined.
508     
509       public:
510         // NB: This class is always a static data member, and thus can be
511         // counted on to be zero-initialized.
512         /// Constructor.
>>>     CID 70416:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "_M_index" is not initialized in this constructor nor in any functions that it calls.
513         id() { }
514     
515         size_t
516         _M_id() const throw();
517       };
518     

** CID 259559:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/boost/boost/graph/detail/edge.hpp: 25 in boost::detail::edge_base<boost::bidirectional_tag, unsigned long>::edge_base()()


________________________________________________________________________________________________________
*** CID 259559:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/boost/boost/graph/detail/edge.hpp: 25 in boost::detail::edge_base<boost::bidirectional_tag, unsigned long>::edge_base()()
19     
20       namespace  detail {
21     
22         template <typename Directed, typename Vertex>
23         struct edge_base
24         {
>>>     CID 259559:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "m_target" is not initialized in this constructor nor in any functions that it calls.
25           inline edge_base() {} 
26           inline edge_base(Vertex s, Vertex d)
27             : m_source(s), m_target(d) { }
28           Vertex m_source;
29           Vertex m_target;
30         };

** CID 972861:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/boost/boost/graph/detail/adjacency_list.hpp: 177 in boost::detail::in_edge_iter<__gnu_cxx::__normal_iterator<boost::detail::stored_edge_iter<unsigned long, std::_List_iterator<boost::list_edge<unsigned long, boost::property<boost::edge_index_t, unsigned long, boost::property<boost::<unnamed>::edge_cast_t, void *(*)(void *), boost::no_property>>>>, boost::property<boost::edge_index_t, unsigned long, boost::property<boost::<unnamed>::edge_cast_t, void *(*)(void *), boost::no_property>>> *, std::vector<boost::detail::stored_edge_iter<unsigned long, std::_List_iterator<boost::list_edge<unsigned long, boost::property<boost::edge_index_t, unsigned long, boost::property<boost::<unnamed>::edge_cast_t, void *(*)(void *), boost::no_property>>>>, boost::property<boost:
 :edge_index_t, unsigned long, boost::property<boost::<unnamed>::edge_cast_t, void *(*)(void *), boost::no_property>>>, std::allocator<boost::detail::stored_edge_iter<unsigned long, std::_Lis
 t_iterator<boost::list_edge<unsigned long, boost::property<boost::edge_index_t, unsigned long, boost::property<boost::<unnamed>::edge_cast_t, void *(*)(void *), boost::no_property>>>>, boost::property<boost::edge_index_t, unsigned long, boost::property<boost::<unnamed>::edge_cast_t, void *(*)(void *), boost::no_property>>>>>>, unsigned long, boost::detail::edge_desc_impl<boost::bidirectional_tag, unsigned long>, long>::in_edge_iter()()


________________________________________________________________________________________________________
*** CID 972861:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/boost/boost/graph/detail/adjacency_list.hpp: 177 in boost::detail::in_edge_iter<__gnu_cxx::__normal_iterator<boost::detail::stored_edge_iter<unsigned long, std::_List_iterator<boost::list_edge<unsigned long, boost::property<boost::edge_index_t, unsigned long, boost::property<boost::<unnamed>::edge_cast_t, void *(*)(void *), boost::no_property>>>>, boost::property<boost::edge_index_t, unsigned long, boost::property<boost::<unnamed>::edge_cast_t, void *(*)(void *), boost::no_property>>> *, std::vector<boost::detail::stored_edge_iter<unsigned long, std::_List_iterator<boost::list_edge<unsigned long, boost::property<boost::edge_index_t, unsigned long, boost::property<boost::<unnamed>::edge_cast_t, void *(*)(void *), boost::no_property>>>>, boost::property<boost:
 :edge_index_t, unsigned long, boost::property<boost::<unnamed>::edge_cast_t, void *(*)(void *), boost::no_property>>>, std::allocator<boost::detail::stored_edge_iter<unsigned long, std::_Lis
 t_iterator<boost::list_edge<unsigned long, boost::property<boost::edge_index_t, unsigned long, boost::property<boost::<unnamed>::edge_cast_t, void *(*)(void *), boost::no_property>>>>, boost::property<boost::edge_index_t, unsigned long, boost::property<boost::<unnamed>::edge_cast_t, void *(*)(void *), boost::no_property>>>>>>, unsigned long, boost::detail::edge_desc_impl<boost::bidirectional_tag, unsigned long>, long>::in_edge_iter()()
171             , EdgeDescriptor
172             , use_default
173             , EdgeDescriptor
174             , Difference
175           > super_t;
176     
>>>     CID 972861:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "m_src" is not initialized in this constructor nor in any functions that it calls.
177           inline in_edge_iter() { }
178           inline in_edge_iter(const BaseIter& i, const VertexDescriptor& src)
179             : super_t(i), m_src(src) { }
180     
181           inline EdgeDescriptor
182           dereference() const

** CID 973186:    (PASS_BY_VALUE)
/usr/include/c++/6.3.1/bits/stl_algobase.h: 291 in std::__copy_move<(bool)0, (bool)0, std::forward_iterator_tag>::__copy_m<boost::program_options::detail::basic_config_file_iterator<wchar_t>, std::back_insert_iterator<std::vector<boost::program_options::basic_option<char>, std::allocator<boost::program_options::basic_option<char>>>>>(T1, T1, T2)()
/usr/include/c++/6.3.1/bits/stl_algobase.h: 291 in std::__copy_move<(bool)0, (bool)0, std::forward_iterator_tag>::__copy_m<boost::program_options::detail::basic_config_file_iterator<char>, std::back_insert_iterator<std::vector<boost::program_options::basic_option<char>, std::allocator<boost::program_options::basic_option<char>>>>>(T1, T1, T2)()


________________________________________________________________________________________________________
*** CID 973186:    (PASS_BY_VALUE)
/usr/include/c++/6.3.1/bits/stl_algobase.h: 291 in std::__copy_move<(bool)0, (bool)0, std::forward_iterator_tag>::__copy_m<boost::program_options::detail::basic_config_file_iterator<wchar_t>, std::back_insert_iterator<std::vector<boost::program_options::basic_option<char>, std::allocator<boost::program_options::basic_option<char>>>>>(T1, T1, T2)()
285     
286       template<bool, bool, typename>
287         struct __copy_move
288         {
289           template<typename _II, typename _OI>
290             static _OI
>>>     CID 973186:    (PASS_BY_VALUE)
>>>     Passing parameter __last of type "boost::program_options::detail::basic_config_file_iterator<wchar_t>" (size 264 bytes) by value.
291             __copy_m(_II __first, _II __last, _OI __result)
292             {
293     	  for (; __first != __last; ++__result, (void)++__first)
294     	    *__result = *__first;
295     	  return __result;
296     	}
/usr/include/c++/6.3.1/bits/stl_algobase.h: 291 in std::__copy_move<(bool)0, (bool)0, std::forward_iterator_tag>::__copy_m<boost::program_options::detail::basic_config_file_iterator<char>, std::back_insert_iterator<std::vector<boost::program_options::basic_option<char>, std::allocator<boost::program_options::basic_option<char>>>>>(T1, T1, T2)()
285     
286       template<bool, bool, typename>
287         struct __copy_move
288         {
289           template<typename _II, typename _OI>
290             static _OI
>>>     CID 973186:    (PASS_BY_VALUE)
>>>     Passing parameter __last of type "boost::program_options::detail::basic_config_file_iterator<char>" (size 264 bytes) by value.
291             __copy_m(_II __first, _II __last, _OI __result)
292             {
293     	  for (; __first != __last; ++__result, (void)++__first)
294     	    *__result = *__first;
295     	  return __result;
296     	}

** CID 973187:    (PASS_BY_VALUE)
/usr/include/c++/6.3.1/bits/cpp_type_traits.h: 408 in std::__miter_base<boost::program_options::detail::basic_config_file_iterator<wchar_t>>(T1)()
/usr/include/c++/6.3.1/bits/cpp_type_traits.h: 408 in std::__miter_base<boost::program_options::detail::basic_config_file_iterator<char>>(T1)()


________________________________________________________________________________________________________
*** CID 973187:    (PASS_BY_VALUE)
/usr/include/c++/6.3.1/bits/cpp_type_traits.h: 408 in std::__miter_base<boost::program_options::detail::basic_config_file_iterator<wchar_t>>(T1)()
402         };
403     
404       // Fallback implementation of the function in bits/stl_iterator.h used to
405       // remove the move_iterator wrapper.
406       template<typename _Iterator>
407         inline _Iterator
>>>     CID 973187:    (PASS_BY_VALUE)
>>>     Passing parameter __it of type "boost::program_options::detail::basic_config_file_iterator<wchar_t>" (size 264 bytes) by value.
408         __miter_base(_Iterator __it)
409         { return __it; }
410     
411     _GLIBCXX_END_NAMESPACE_VERSION
412     } // namespace
413     } // extern "C++"
414     
/usr/include/c++/6.3.1/bits/cpp_type_traits.h: 408 in std::__miter_base<boost::program_options::detail::basic_config_file_iterator<char>>(T1)()
402         };
403     
404       // Fallback implementation of the function in bits/stl_iterator.h used to
405       // remove the move_iterator wrapper.
406       template<typename _Iterator>
407         inline _Iterator
>>>     CID 973187:    (PASS_BY_VALUE)
>>>     Passing parameter __it of type "boost::program_options::detail::basic_config_file_iterator<char>" (size 264 bytes) by value.
408         __miter_base(_Iterator __it)
409         { return __it; }
410     
411     _GLIBCXX_END_NAMESPACE_VERSION
412     } // namespace
413     } // extern "C++"
414     

** CID 973188:    (PASS_BY_VALUE)
/usr/include/c++/6.3.1/bits/stl_algobase.h: 277 in std::__niter_base<boost::program_options::detail::basic_config_file_iterator<wchar_t>>(T1)()
/usr/include/c++/6.3.1/bits/stl_algobase.h: 277 in std::__niter_base<boost::program_options::detail::basic_config_file_iterator<char>>(T1)()


________________________________________________________________________________________________________
*** CID 973188:    (PASS_BY_VALUE)
/usr/include/c++/6.3.1/bits/stl_algobase.h: 277 in std::__niter_base<boost::program_options::detail::basic_config_file_iterator<wchar_t>>(T1)()
271         }
272     
273       // Fallback implementation of the function in bits/stl_iterator.h used to
274       // remove the __normal_iterator wrapper. See copy, fill, ...
275       template<typename _Iterator>
276         inline _Iterator
>>>     CID 973188:    (PASS_BY_VALUE)
>>>     Passing parameter __it of type "boost::program_options::detail::basic_config_file_iterator<wchar_t>" (size 264 bytes) by value.
277         __niter_base(_Iterator __it)
278         { return __it; }
279     
280       // All of these auxiliary structs serve two purposes.  (1) Replace
281       // calls to copy with memmove whenever possible.  (Memmove, not memcpy,
282       // because the input and output ranges are permitted to overlap.)
/usr/include/c++/6.3.1/bits/stl_algobase.h: 277 in std::__niter_base<boost::program_options::detail::basic_config_file_iterator<char>>(T1)()
271         }
272     
273       // Fallback implementation of the function in bits/stl_iterator.h used to
274       // remove the __normal_iterator wrapper. See copy, fill, ...
275       template<typename _Iterator>
276         inline _Iterator
>>>     CID 973188:    (PASS_BY_VALUE)
>>>     Passing parameter __it of type "boost::program_options::detail::basic_config_file_iterator<char>" (size 264 bytes) by value.
277         __niter_base(_Iterator __it)
278         { return __it; }
279     
280       // All of these auxiliary structs serve two purposes.  (1) Replace
281       // calls to copy with memmove whenever possible.  (Memmove, not memcpy,
282       // because the input and output ranges are permitted to overlap.)

** CID 973189:    (PASS_BY_VALUE)
/usr/include/c++/6.3.1/bits/stl_algobase.h: 375 in std::__copy_move_a<(bool)0, boost::program_options::detail::basic_config_file_iterator<wchar_t>, std::back_insert_iterator<std::vector<boost::program_options::basic_option<char>, std::allocator<boost::program_options::basic_option<char>>>>>(T2, T2, T3)()
/usr/include/c++/6.3.1/bits/stl_algobase.h: 375 in std::__copy_move_a<(bool)0, boost::program_options::detail::basic_config_file_iterator<char>, std::back_insert_iterator<std::vector<boost::program_options::basic_option<char>, std::allocator<boost::program_options::basic_option<char>>>>>(T2, T2, T3)()


________________________________________________________________________________________________________
*** CID 973189:    (PASS_BY_VALUE)
/usr/include/c++/6.3.1/bits/stl_algobase.h: 375 in std::__copy_move_a<(bool)0, boost::program_options::detail::basic_config_file_iterator<wchar_t>, std::back_insert_iterator<std::vector<boost::program_options::basic_option<char>, std::allocator<boost::program_options::basic_option<char>>>>>(T2, T2, T3)()
369     	  return __result + _Num;
370     	}
371         };
372     
373       template<bool _IsMove, typename _II, typename _OI>
374         inline _OI
>>>     CID 973189:    (PASS_BY_VALUE)
>>>     Passing parameter __last of type "boost::program_options::detail::basic_config_file_iterator<wchar_t>" (size 264 bytes) by value.
375         __copy_move_a(_II __first, _II __last, _OI __result)
376         {
377           typedef typename iterator_traits<_II>::value_type _ValueTypeI;
378           typedef typename iterator_traits<_OI>::value_type _ValueTypeO;
379           typedef typename iterator_traits<_II>::iterator_category _Category;
380           const bool __simple = (__is_trivial(_ValueTypeI)
/usr/include/c++/6.3.1/bits/stl_algobase.h: 375 in std::__copy_move_a<(bool)0, boost::program_options::detail::basic_config_file_iterator<char>, std::back_insert_iterator<std::vector<boost::program_options::basic_option<char>, std::allocator<boost::program_options::basic_option<char>>>>>(T2, T2, T3)()
369     	  return __result + _Num;
370     	}
371         };
372     
373       template<bool _IsMove, typename _II, typename _OI>
374         inline _OI
>>>     CID 973189:    (PASS_BY_VALUE)
>>>     Passing parameter __last of type "boost::program_options::detail::basic_config_file_iterator<char>" (size 264 bytes) by value.
375         __copy_move_a(_II __first, _II __last, _OI __result)
376         {
377           typedef typename iterator_traits<_II>::value_type _ValueTypeI;
378           typedef typename iterator_traits<_OI>::value_type _ValueTypeO;
379           typedef typename iterator_traits<_II>::iterator_category _Category;
380           const bool __simple = (__is_trivial(_ValueTypeI)

** CID 973190:    (PASS_BY_VALUE)
/usr/include/c++/6.3.1/bits/stl_algobase.h: 420 in std::__copy_move_a2<(bool)0, boost::program_options::detail::basic_config_file_iterator<wchar_t>, std::back_insert_iterator<std::vector<boost::program_options::basic_option<char>, std::allocator<boost::program_options::basic_option<char>>>>>(T2, T2, T3)()
/usr/include/c++/6.3.1/bits/stl_algobase.h: 420 in std::__copy_move_a2<(bool)0, boost::program_options::detail::basic_config_file_iterator<char>, std::back_insert_iterator<std::vector<boost::program_options::basic_option<char>, std::allocator<boost::program_options::basic_option<char>>>>>(T2, T2, T3)()


________________________________________________________________________________________________________
*** CID 973190:    (PASS_BY_VALUE)
/usr/include/c++/6.3.1/bits/stl_algobase.h: 420 in std::__copy_move_a2<(bool)0, boost::program_options::detail::basic_config_file_iterator<wchar_t>, std::back_insert_iterator<std::vector<boost::program_options::basic_option<char>, std::allocator<boost::program_options::basic_option<char>>>>>(T2, T2, T3)()
414     				    _CharT*>::__type
415         __copy_move_a2(istreambuf_iterator<_CharT, char_traits<_CharT> >,
416     		   istreambuf_iterator<_CharT, char_traits<_CharT> >, _CharT*);
417     
418       template<bool _IsMove, typename _II, typename _OI>
419         inline _OI
>>>     CID 973190:    (PASS_BY_VALUE)
>>>     Passing parameter __last of type "boost::program_options::detail::basic_config_file_iterator<wchar_t>" (size 264 bytes) by value.
420         __copy_move_a2(_II __first, _II __last, _OI __result)
421         {
422           return _OI(std::__copy_move_a<_IsMove>(std::__niter_base(__first),
423     					     std::__niter_base(__last),
424     					     std::__niter_base(__result)));
425         }
/usr/include/c++/6.3.1/bits/stl_algobase.h: 420 in std::__copy_move_a2<(bool)0, boost::program_options::detail::basic_config_file_iterator<char>, std::back_insert_iterator<std::vector<boost::program_options::basic_option<char>, std::allocator<boost::program_options::basic_option<char>>>>>(T2, T2, T3)()
414     				    _CharT*>::__type
415         __copy_move_a2(istreambuf_iterator<_CharT, char_traits<_CharT> >,
416     		   istreambuf_iterator<_CharT, char_traits<_CharT> >, _CharT*);
417     
418       template<bool _IsMove, typename _II, typename _OI>
419         inline _OI
>>>     CID 973190:    (PASS_BY_VALUE)
>>>     Passing parameter __last of type "boost::program_options::detail::basic_config_file_iterator<char>" (size 264 bytes) by value.
420         __copy_move_a2(_II __first, _II __last, _OI __result)
421         {
422           return _OI(std::__copy_move_a<_IsMove>(std::__niter_base(__first),
423     					     std::__niter_base(__last),
424     					     std::__niter_base(__result)));
425         }

** CID 973191:    (PASS_BY_VALUE)
/usr/include/c++/6.3.1/bits/stl_algobase.h: 446 in std::copy<boost::program_options::detail::basic_config_file_iterator<wchar_t>, std::back_insert_iterator<std::vector<boost::program_options::basic_option<char>, std::allocator<boost::program_options::basic_option<char>>>>>(T1, T1, T2)()
/usr/include/c++/6.3.1/bits/stl_algobase.h: 446 in std::copy<boost::program_options::detail::basic_config_file_iterator<char>, std::back_insert_iterator<std::vector<boost::program_options::basic_option<char>, std::allocator<boost::program_options::basic_option<char>>>>>(T1, T1, T2)()


________________________________________________________________________________________________________
*** CID 973191:    (PASS_BY_VALUE)
/usr/include/c++/6.3.1/bits/stl_algobase.h: 446 in std::copy<boost::program_options::detail::basic_config_file_iterator<wchar_t>, std::back_insert_iterator<std::vector<boost::program_options::basic_option<char>, std::allocator<boost::program_options::basic_option<char>>>>>(T1, T1, T2)()
440        *
441        *  Note that the end of the output range is permitted to be contained
442        *  within [first,last).
443       */
444       template<typename _II, typename _OI>
445         inline _OI
>>>     CID 973191:    (PASS_BY_VALUE)
>>>     Passing parameter __last of type "boost::program_options::detail::basic_config_file_iterator<wchar_t>" (size 264 bytes) by value.
446         copy(_II __first, _II __last, _OI __result)
447         {
448           // concept requirements
449           __glibcxx_function_requires(_InputIteratorConcept<_II>)
450           __glibcxx_function_requires(_OutputIteratorConcept<_OI,
451     	    typename iterator_traits<_II>::value_type>)
/usr/include/c++/6.3.1/bits/stl_algobase.h: 446 in std::copy<boost::program_options::detail::basic_config_file_iterator<char>, std::back_insert_iterator<std::vector<boost::program_options::basic_option<char>, std::allocator<boost::program_options::basic_option<char>>>>>(T1, T1, T2)()
440        *
441        *  Note that the end of the output range is permitted to be contained
442        *  within [first,last).
443       */
444       template<typename _II, typename _OI>
445         inline _OI
>>>     CID 973191:    (PASS_BY_VALUE)
>>>     Passing parameter __last of type "boost::program_options::detail::basic_config_file_iterator<char>" (size 264 bytes) by value.
446         copy(_II __first, _II __last, _OI __result)
447         {
448           // concept requirements
449           __glibcxx_function_requires(_InputIteratorConcept<_II>)
450           __glibcxx_function_requires(_OutputIteratorConcept<_OI,
451     	    typename iterator_traits<_II>::value_type>)

** CID 1020033:  Memory - corruptions  (ARRAY_VS_SINGLETON)
/home/brad/working/src/ceph/src/boost/libs/container/src/dlmalloc_2_8_6.c: 5303 in dlindependent_calloc()


________________________________________________________________________________________________________
*** CID 1020033:  Memory - corruptions  (ARRAY_VS_SINGLETON)
/home/brad/working/src/ceph/src/boost/libs/container/src/dlmalloc_2_8_6.c: 5303 in dlindependent_calloc()
5297       return dlmemalign(pagesz, (bytes + pagesz - SIZE_T_ONE) & ~(pagesz - SIZE_T_ONE));
5298     }
5299     
5300     void** dlindependent_calloc(size_t n_elements, size_t elem_size,
5301                                 void* chunks[]) {
5302       size_t sz = elem_size; /* serves as 1-element array */
>>>     CID 1020033:  Memory - corruptions  (ARRAY_VS_SINGLETON)
>>>     Taking address with "&sz" yields a singleton pointer.
5303       return ialloc(gm, n_elements, &sz, 3, chunks);
5304     }
5305     
5306     void** dlindependent_comalloc(size_t n_elements, size_t sizes[],
5307                                   void* chunks[]) {
5308       return ialloc(gm, n_elements, sizes, 0, chunks);

** CID 1040644:  Memory - illegal accesses  (UNINIT)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/function.c: 3170 in argument_list_push()


________________________________________________________________________________________________________
*** CID 1040644:  Memory - illegal accesses  (UNINIT)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/function.c: 3170 in argument_list_push()
3164             LISTITER actual_iter = list_begin( actual );
3165             LISTITER const actual_end = list_end( actual );
3166             int j;
3167             for ( j = 0; j < formal[ i ].size; ++j )
3168             {
3169                 struct argument * formal_arg = &formal[ i ].args[ j ];
>>>     CID 1040644:  Memory - illegal accesses  (UNINIT)
>>>     Declaring variable "value" without initializer.
3170                 LIST * value;
3171     
3172                 switch ( formal_arg->flags )
3173                 {
3174                 case ARG_ONE:
3175                     if ( actual_iter == actual_end )

** CID 1040645:    (TAINTED_SCALAR)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/hcache.c: 255 in hcache_init()
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/hcache.c: 276 in hcache_init()


________________________________________________________________________________________________________
*** CID 1040645:    (TAINTED_SCALAR)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/hcache.c: 255 in hcache_init()
249     
250             timestamp_init( &cachedata.time, atoi( object_str( time_secs_str ) ),
251                 atoi( object_str( time_nsecs_str ) ) );
252             cachedata.age = atoi( object_str( age_str ) ) + 1;
253     
254             count = atoi( object_str( includes_count_str ) );
>>>     CID 1040645:    (TAINTED_SCALAR)
>>>     Using tainted variable "count" as a loop boundary.
255             for ( l = L0, i = 0; i < count; ++i )
256             {
257                 OBJECT * const s = read_netstring( f );
258                 if ( !s )
259                 {
260                     err_printf( "invalid %s\n", hcachename );
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/hcache.c: 276 in hcache_init()
270             {
271                 err_printf( "invalid %s\n", hcachename );
272                 goto cleanup;
273             }
274     
275             count = atoi( object_str( hdrscan_count_str ) );
>>>     CID 1040645:    (TAINTED_SCALAR)
>>>     Using tainted variable "count" as a loop boundary.
276             for ( l = L0, i = 0; i < count; ++i )
277             {
278                 OBJECT * const s = read_netstring( f );
279                 if ( !s )
280                 {
281                     err_printf( "invalid %s\n", hcachename );

** CID 1040649:  Code maintainability issues  (SIZEOF_MISMATCH)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/hash.c: 251 in hashrehash()


________________________________________________________________________________________________________
*** CID 1040649:  Code maintainability issues  (SIZEOF_MISMATCH)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/hash.c: 251 in hashrehash()
245         hp->items.nel += hp->items.more;
246     
247         if ( hp->tab.base )
248             BJAM_FREE( (char *)hp->tab.base );
249     
250         hp->tab.nel = hp->items.nel * hp->bloat;
>>>     CID 1040649:  Code maintainability issues  (SIZEOF_MISMATCH)
>>>     Passing argument "hp->tab.nel * 8UL /* sizeof (ITEM **) */" to function "malloc" and then casting the return value to "ITEM **" is suspicious.  In this particular case "sizeof (ITEM **)" happens to be equal to "sizeof (ITEM *)", but this is not a portable assumption.
251         hp->tab.base = (ITEM * *)BJAM_MALLOC( hp->tab.nel * sizeof( ITEM * * ) );
252     
253         memset( (char *)hp->tab.base, '\0', hp->tab.nel * sizeof( ITEM * ) );
254     
255         for ( i = 0; i < hp->items.list; ++i )
256         {

** CID 1040650:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/modules/property-set.c: 164 in property_set_create()
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/modules/property-set.c: 183 in property_set_create()


________________________________________________________________________________________________________
*** CID 1040650:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/modules/property-set.c: 164 in property_set_create()
158             return list_new( object_copy( pos->value ) );
159         }
160         else
161         {
162             OBJECT * rulename = object_new( "new" );
163             OBJECT * varname = object_new( "self.raw" );
>>>     CID 1040650:    (RESOURCE_LEAK)
>>>     Failing to save or free storage allocated by "list_new(object_new("property-set"))" leaks it.
164             LIST * val = call_rule( rulename, frame,
165                 list_new( object_new( "property-set" ) ), 0 );
166             LISTITER iter, end;
167             object_free( rulename );
168             pos->value = object_copy( list_front( val ) );
169             var_set( bindmodule( pos->value ), varname, unique, VAR_SET );
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/modules/property-set.c: 183 in property_set_create()
177                     string message[ 1 ];
178                     string_new( message );
179                     string_append( message, "Invalid property: '" );
180                     string_append( message, str );
181                     string_append( message, "'" );
182                     rulename = object_new( "errors.error" );
>>>     CID 1040650:    (RESOURCE_LEAK)
>>>     Failing to save or free storage allocated by "list_new(object_new(message->value))" leaks it.
183                     call_rule( rulename, frame,
184                         list_new( object_new( message->value ) ), 0 );
185                     /* unreachable */
186                     string_free( message );
187                     object_free( rulename );
188                 }

** CID 1040652:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/execunix.c: 205 in exec_cmd()
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/execunix.c: 207 in exec_cmd()
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/execunix.c: 213 in exec_cmd()
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/execunix.c: 308 in exec_cmd()


________________________________________________________________________________________________________
*** CID 1040652:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/execunix.c: 205 in exec_cmd()
199     
200         /* ignore SIGINT and SIGQUIT */
201         ignore.sa_handler = SIG_IGN;
202         sigemptyset(&ignore.sa_mask);
203         ignore.sa_flags = 0;
204         if (sigaction(SIGINT, &ignore, &saveintr) < 0)
>>>     CID 1040652:    (RESOURCE_LEAK)
>>>     Returning without freeing "shell" leaks the storage that it points to.
205             return;
206         if (sigaction(SIGQUIT, &ignore, &savequit) < 0)
207             return;
208     
209         /* block SIGCHLD */
210         sigemptyset(&chldmask);
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/execunix.c: 207 in exec_cmd()
201         ignore.sa_handler = SIG_IGN;
202         sigemptyset(&ignore.sa_mask);
203         ignore.sa_flags = 0;
204         if (sigaction(SIGINT, &ignore, &saveintr) < 0)
205             return;
206         if (sigaction(SIGQUIT, &ignore, &savequit) < 0)
>>>     CID 1040652:    (RESOURCE_LEAK)
>>>     Returning without freeing "shell" leaks the storage that it points to.
207             return;
208     
209         /* block SIGCHLD */
210         sigemptyset(&chldmask);
211         sigaddset(&chldmask, SIGCHLD);
212         if (sigprocmask(SIG_BLOCK, &chldmask, &savemask) < 0)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/execunix.c: 213 in exec_cmd()
207             return;
208     
209         /* block SIGCHLD */
210         sigemptyset(&chldmask);
211         sigaddset(&chldmask, SIGCHLD);
212         if (sigprocmask(SIG_BLOCK, &chldmask, &savemask) < 0)
>>>     CID 1040652:    (RESOURCE_LEAK)
>>>     Returning without freeing "shell" leaks the storage that it points to.
213             return;
214     
215         if ( ( cmdtab[ slot ].pid = vfork() ) == -1 )
216         {
217             perror( "vfork" );
218             exit( EXITBAD );
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/execunix.c: 308 in exec_cmd()
302         cmdtab[ slot ].closure = closure;
303     
304         /* restore previous signals */
305         sigaction(SIGINT, &saveintr, NULL);
306         sigaction(SIGQUIT, &savequit, NULL);
307         sigprocmask(SIG_SETMASK, &savemask, NULL);
>>>     CID 1040652:    (RESOURCE_LEAK)
>>>     Returning without freeing "shell" leaks the storage that it points to.
308     }
309     
310     #undef EXECCMD_PIPE_READ
311     #undef EXECCMD_PIPE_WRITE
312     
313     

** CID 1040653:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/builtins.c: 1817 in builtin_file_open()
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/builtins.c: 1817 in builtin_file_open()


________________________________________________________________________________________________________
*** CID 1040653:    (RESOURCE_LEAK)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/builtins.c: 1817 in builtin_file_open()
1811         else
1812             fd = open( name, O_RDONLY );
1813     
1814         if ( fd != -1 )
1815         {
1816             sprintf( buffer, "%d", fd );
>>>     CID 1040653:    (RESOURCE_LEAK)
>>>     Handle variable "fd" going out of scope leaks the handle.
1817             return list_new( object_new( buffer ) );
1818         }
1819         return L0;
1820     }
1821     
1822     
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/builtins.c: 1817 in builtin_file_open()
1811         else
1812             fd = open( name, O_RDONLY );
1813     
1814         if ( fd != -1 )
1815         {
1816             sprintf( buffer, "%d", fd );
>>>     CID 1040653:    (RESOURCE_LEAK)
>>>     Handle variable "fd" going out of scope leaks the handle.
1817             return list_new( object_new( buffer ) );
1818         }
1819         return L0;
1820     }
1821     
1822     

** CID 1040654:  Null pointer dereferences  (NULL_RETURNS)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/filesys.c: 440 in file_dirscan_impl()


________________________________________________________________________________________________________
*** CID 1040654:  Null pointer dereferences  (NULL_RETURNS)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/filesys.c: 440 in file_dirscan_impl()
434                  *    insensitive file system
435                  *  - convert the NTFS paths to their long path variants as that
436                  *    file system each file system entity may have a long and a
437                  *    short path variant thus allowing for many different path
438                  *    strings identifying the same file.
439                  */
>>>     CID 1040654:  Null pointer dereferences  (NULL_RETURNS)
>>>     Dereferencing a null pointer "ffq".
440                 (*func)( closure, ffq->name, 1 /* stat()'ed */, &ffq->time );
441             }
442         }
443     }
444     
445     

** CID 1040655:  Memory - illegal accesses  (NO_EFFECT)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/strings.c: 55 in string_new()


________________________________________________________________________________________________________
*** CID 1040655:  Memory - illegal accesses  (NO_EFFECT)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/strings.c: 55 in string_new()
49     {
50         s->value = s->opt;
51         s->size = 0;
52         s->capacity = sizeof( s->opt );
53         s->opt[ 0 ] = 0;
54     #ifndef NDEBUG
>>>     CID 1040655:  Memory - illegal accesses  (NO_EFFECT)
>>>     "memset" argument "-49" loses precision in "memset(s->magic, -49, 4UL)".
55         memset( s->magic, JAM_STRING_MAGIC, sizeof( s->magic ) );
56     #endif
57         assert_invariants( s );
58     }
59     
60     

** CID 1040656:  Error handling issues  (NEGATIVE_RETURNS)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/jam.c: 671 in executable_path()


________________________________________________________________________________________________________
*** CID 1040656:  Error handling issues  (NEGATIVE_RETURNS)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/jam.c: 671 in executable_path()
665     #elif defined(__linux__)
666     # include <unistd.h>
667     char * executable_path( char const * argv0 )
668     {
669         char buf[ 1024 ];
670         ssize_t const ret = readlink( "/proc/self/exe", buf, sizeof( buf ) );
>>>     CID 1040656:  Error handling issues  (NEGATIVE_RETURNS)
>>>     "ret" is passed to a parameter that cannot be negative.
671         return ( !ret || ret == sizeof( buf ) ) ? NULL : strndup( buf, ret );
672     }
673     #elif defined(OS_VMS)
674     # include <unixlib.h>
675     char * executable_path( char const * argv0 )
676     {

** CID 1040657:    (NEGATIVE_RETURNS)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/builtins.c: 1510 in builtin_update_now()
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/builtins.c: 1511 in builtin_update_now()


________________________________________________________________________________________________________
*** CID 1040657:    (NEGATIVE_RETURNS)
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/builtins.c: 1510 in builtin_update_now()
1504         {
1505             /* Flush whatever stdio might have buffered, while descriptions 0 and 1
1506              * still refer to the log file.
1507              */
1508             out_flush( );
1509             err_flush( );
>>>     CID 1040657:    (NEGATIVE_RETURNS)
>>>     "original_stdout" is passed to a parameter that cannot be negative.
1510             dup2( original_stdout, 0 );
1511             dup2( original_stderr, 1 );
1512             close( original_stdout );
1513             close( original_stderr );
1514         }
1515     
/home/brad/working/src/ceph/src/boost/tools/build/src/engine/builtins.c: 1511 in builtin_update_now()
1505             /* Flush whatever stdio might have buffered, while descriptions 0 and 1
1506              * still refer to the log file.
1507              */
1508             out_flush( );
1509             err_flush( );
1510             dup2( original_stdout, 0 );
>>>     CID 1040657:    (NEGATIVE_RETURNS)
>>>     "original_stderr" is passed to a parameter that cannot be negative.
1511             dup2( original_stderr, 1 );
1512             close( original_stdout );
1513             close( original_stderr );
1514         }
1515     
1516         last_update_now_status = status;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8H5-2BXb3AzDpE-2FX6kkp9m8asxgX45OVW6vuYHbSx-2BEW3uQU6-2FrasRM-2Bx7AHFeLmffM2RJCSw94-2F6UxN7GQFFjn8q9Xb7ZpvWJn7lECQZu-2B9ekJ4TlpxNfBH1-2FJmkX3kIfvQf8V-2FpXZ-2BDtAqd2xCFBbktXpl-2BFYgbfZnHSUrglRQoediqSkPjq9sxTsJhCwyPYGw-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8H5-2BXb3AzDpE-2FX6kkp9m8asxgX45OVW6vuYHbSx-2BEW3uQCi114WmghEZQZFOg-2FPrRIl-2BKBYKDX8F4UfvEYhGT1r-2BV47P304TOo9CpSix9HiHl7a3hnsI9FS1OQJuQ-2Ff0-2F74PM-2B3pfSz7BYQjHBjDWnLaleVfbJB4-2FlJ1jOnQNTVRyDAiBA9C-2Blmy3FgvTZdjSw-3D

