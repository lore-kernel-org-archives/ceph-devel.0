From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 18 Feb 2016 12:32:56 -0800
Message-ID: <56c62a78e036b_232cf5b3381441e@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:42750 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946218AbcBRUcm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Feb 2016 15:32:42 -0500
Received: from localhost.localdomain (static-208.69.177.245.nephosdns.com [208.69.177.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtprelay.synopsys.com (Postfix) with ESMTPS id BA2A810C0877
	for <ceph-devel@vger.kernel.org>; Thu, 18 Feb 2016 12:32:41 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

141 new defect(s) introduced to ceph found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 20 of 141 defect(s)


** CID 1353344:  Control flow issues  (UNREACHABLE)
/build/rados.c: 14393 in __pyx_pf_5rados_5Rados_52pg_command()


________________________________________________________________________________________________________
*** CID 1353344:  Control flow issues  (UNREACHABLE)
/build/rados.c: 14393 in __pyx_pf_5rados_5Rados_52pg_command()
14387      *             return (ret, my_outbuf, my_outs)
14388      *         finally:
14389      *             free(_cmd)             # <<<<<<<<<<<<<<
14390      * 
14391      *     def wait_for_latest_osdmap(self):
14392      */
>>>     CID 1353344:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    __pyx_L4_error:
 ...".
14393       /*finally:*/ {
14394         /*exception exit:*/{
14395           __pyx_L4_error:;
14396           __pyx_t_12 = 0; __pyx_t_13 = 0; __pyx_t_14 = 0; __pyx_t_15 = 0; __pyx_t_16 = 0; __pyx_t_17 = 0;
14397           __Pyx_XDECREF(__pyx_t_3); __pyx_t_3 = 0;
14398           __Pyx_XDECREF(__pyx_t_5); __pyx_t_5 = 0;

** CID 1353343:  Control flow issues  (UNREACHABLE)
/build/rados.c: 13830 in __pyx_pf_5rados_5Rados_50osd_command()


________________________________________________________________________________________________________
*** CID 1353343:  Control flow issues  (UNREACHABLE)
/build/rados.c: 13830 in __pyx_pf_5rados_5Rados_50osd_command()
13824      *             return (ret, my_outbuf, my_outs)
13825      *         finally:
13826      *             free(_cmd)             # <<<<<<<<<<<<<<
13827      * 
13828      *     def pg_command(self, pgid, cmd, inbuf, timeout=0):
13829      */
>>>     CID 1353343:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    __pyx_L4_error:
 ...".
13830       /*finally:*/ {
13831         /*exception exit:*/{
13832           __pyx_L4_error:;
13833           __pyx_t_12 = 0; __pyx_t_13 = 0; __pyx_t_14 = 0; __pyx_t_15 = 0; __pyx_t_16 = 0; __pyx_t_17 = 0;
13834           __Pyx_XDECREF(__pyx_t_5); __pyx_t_5 = 0;
13835           __Pyx_XDECREF(__pyx_t_3); __pyx_t_3 = 0;

** CID 1353342:  Control flow issues  (UNREACHABLE)
/build/rados.c: 13306 in __pyx_pf_5rados_5Rados_48mon_command()


________________________________________________________________________________________________________
*** CID 1353342:  Control flow issues  (UNREACHABLE)
/build/rados.c: 13306 in __pyx_pf_5rados_5Rados_48mon_command()
13300      *             return (ret, my_outbuf, my_outs)
13301      *         finally:
13302      *             free(_cmd)             # <<<<<<<<<<<<<<
13303      * 
13304      *     def osd_command(self, osdid, cmd, inbuf, timeout=0):
13305      */
>>>     CID 1353342:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    __pyx_L5_error:
 ...".
13306       /*finally:*/ {
13307         /*exception exit:*/{
13308           __pyx_L5_error:;
13309           __pyx_t_13 = 0; __pyx_t_14 = 0; __pyx_t_15 = 0; __pyx_t_16 = 0; __pyx_t_17 = 0; __pyx_t_18 = 0;
13310           __Pyx_XDECREF(__pyx_t_2); __pyx_t_2 = 0;
13311           __Pyx_XDECREF(__pyx_t_1); __pyx_t_1 = 0;

** CID 1353341:  Control flow issues  (UNREACHABLE)
/build/rados.c: 12433 in __pyx_pf_5rados_5Rados_44get_fsid()


________________________________________________________________________________________________________
*** CID 1353341:  Control flow issues  (UNREACHABLE)
/build/rados.c: 12433 in __pyx_pf_5rados_5Rados_44get_fsid()
12427      *             # including if _PyString_Resize fails (that will free the string
12428      *             # itself and set ret_s to NULL, hence XDECREF).
12429      *             ref.Py_XDECREF(ret_s)             # <<<<<<<<<<<<<<
12430      * 
12431      *     @requires(('ioctx_name', str_type))
12432      */
>>>     CID 1353341:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    __pyx_L4_error:
 ...".
12433       /*finally:*/ {
12434         /*exception exit:*/{
12435           __pyx_L4_error:;
12436           __pyx_t_9 = 0; __pyx_t_10 = 0; __pyx_t_11 = 0; __pyx_t_12 = 0; __pyx_t_13 = 0; __pyx_t_14 = 0;
12437           __Pyx_XDECREF(__pyx_t_2); __pyx_t_2 = 0;
12438           __Pyx_XDECREF(__pyx_t_1); __pyx_t_1 = 0;

** CID 1353340:  Control flow issues  (UNREACHABLE)
/build/rados.c: 12142 in __pyx_pf_5rados_5Rados_42list_pools()


________________________________________________________________________________________________________
*** CID 1353340:  Control flow issues  (UNREACHABLE)
/build/rados.c: 12142 in __pyx_pf_5rados_5Rados_42list_pools()
12136      *                     if name]
12137      *         finally:
12138      *             free(c_names)             # <<<<<<<<<<<<<<
12139      * 
12140      *     def get_fsid(self):
12141      */
>>>     CID 1353340:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    __pyx_L4_error:
 ...".
12142       /*finally:*/ {
12143         /*exception exit:*/{
12144           __pyx_L4_error:;
12145           __pyx_t_14 = 0; __pyx_t_15 = 0; __pyx_t_16 = 0; __pyx_t_17 = 0; __pyx_t_18 = 0; __pyx_t_19 = 0;
12146           __Pyx_XDECREF(__pyx_t_7); __pyx_t_7 = 0;
12147           __Pyx_XDECREF(__pyx_t_6); __pyx_t_6 = 0;

** CID 1353339:  Control flow issues  (UNREACHABLE)
/build/rados.c: 10883 in __pyx_pf_5rados_5Rados_34pool_reverse_lookup()


________________________________________________________________________________________________________
*** CID 1353339:  Control flow issues  (UNREACHABLE)
/build/rados.c: 10883 in __pyx_pf_5rados_5Rados_34pool_reverse_lookup()
10877      * 
10878      *         finally:
10879      *             free(name)             # <<<<<<<<<<<<<<
10880      * 
10881      *     @requires(('pool_name', str_type), ('auid', opt(int)), ('crush_rule', opt(int)))
10882      */
>>>     CID 1353339:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    __pyx_L4_error:
 ...".
10883       /*finally:*/ {
10884         /*exception exit:*/{
10885           __pyx_L4_error:;
10886           __pyx_t_13 = 0; __pyx_t_14 = 0; __pyx_t_15 = 0; __pyx_t_16 = 0; __pyx_t_17 = 0; __pyx_t_18 = 0;
10887           __Pyx_XDECREF(__pyx_t_8); __pyx_t_8 = 0;
10888           __Pyx_XDECREF(__pyx_t_2); __pyx_t_2 = 0;

** CID 1353338:  Control flow issues  (UNREACHABLE)
/build/rados.c: 19157 in __pyx_pf_5rados_12SnapIterator_6__next__()


________________________________________________________________________________________________________
*** CID 1353338:  Control flow issues  (UNREACHABLE)
/build/rados.c: 19157 in __pyx_pf_5rados_12SnapIterator_6__next__()
19151      *             return snap
19152      *         finally:
19153      *             free(name)             # <<<<<<<<<<<<<<
19154      * 
19155      * 
19156      */
>>>     CID 1353338:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    __pyx_L5_error:
 ...".
19157       /*finally:*/ {
19158         /*exception exit:*/{
19159           __pyx_L5_error:;
19160           __pyx_t_11 = 0; __pyx_t_12 = 0; __pyx_t_13 = 0; __pyx_t_14 = 0; __pyx_t_15 = 0; __pyx_t_16 = 0;
19161           __Pyx_XDECREF(__pyx_t_6); __pyx_t_6 = 0;
19162           __Pyx_XDECREF(__pyx_t_5); __pyx_t_5 = 0;

** CID 1353337:  Control flow issues  (UNREACHABLE)
/build/rados.c: 31297 in __pyx_pf_5rados_5Ioctx_58get_xattr()


________________________________________________________________________________________________________
*** CID 1353337:  Control flow issues  (UNREACHABLE)
/build/rados.c: 31297 in __pyx_pf_5rados_5Ioctx_58get_xattr()
31291      *             return ret_buf[:ret]
31292      *         finally:
31293      *             free(ret_buf)             # <<<<<<<<<<<<<<
31294      * 
31295      *     @requires(('oid', str_type))
31296      */
>>>     CID 1353337:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    __pyx_L4_error:
 ...".
31297       /*finally:*/ {
31298         /*exception exit:*/{
31299           __pyx_L4_error:;
31300           __pyx_t_12 = 0; __pyx_t_13 = 0; __pyx_t_14 = 0; __pyx_t_15 = 0; __pyx_t_16 = 0; __pyx_t_17 = 0;
31301           __Pyx_XDECREF(__pyx_t_5); __pyx_t_5 = 0;
31302           __Pyx_XDECREF(__pyx_t_2); __pyx_t_2 = 0;

** CID 1353336:  Control flow issues  (UNREACHABLE)
/build/rados.c: 29709 in __pyx_pf_5rados_5Ioctx_48execute()


________________________________________________________________________________________________________
*** CID 1353336:  Control flow issues  (UNREACHABLE)
/build/rados.c: 29709 in __pyx_pf_5rados_5Ioctx_48execute()
29703      *             # including if _PyString_Resize fails (that will free the string
29704      *             # itself and set ret_s to NULL, hence XDECREF).
29705      *             ref.Py_XDECREF(ret_s)             # <<<<<<<<<<<<<<
29706      * 
29707      *     def get_stats(self):
29708      */
>>>     CID 1353336:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    __pyx_L4_error:
 ...".
29709       /*finally:*/ {
29710         /*exception exit:*/{
29711           __pyx_L4_error:;
29712           __pyx_t_13 = 0; __pyx_t_14 = 0; __pyx_t_15 = 0; __pyx_t_16 = 0; __pyx_t_17 = 0; __pyx_t_18 = 0;
29713           __Pyx_XDECREF(__pyx_t_3); __pyx_t_3 = 0;
29714           __Pyx_XDECREF(__pyx_t_1); __pyx_t_1 = 0;

** CID 1353335:  Control flow issues  (UNREACHABLE)
/build/rados.c: 29119 in __pyx_pf_5rados_5Ioctx_46read()


________________________________________________________________________________________________________
*** CID 1353335:  Control flow issues  (UNREACHABLE)
/build/rados.c: 29119 in __pyx_pf_5rados_5Ioctx_46read()
29113      *             # including if _PyString_Resize fails (that will free the string
29114      *             # itself and set ret_s to NULL, hence XDECREF).
29115      *             ref.Py_XDECREF(ret_s)             # <<<<<<<<<<<<<<
29116      * 
29117      *     @requires(('key', str_type), ('cls', str_type), ('method', str_type), ('data', bytes))
29118      */
>>>     CID 1353335:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    __pyx_L4_error:
 ...".
29119       /*finally:*/ {
29120         /*exception exit:*/{
29121           __pyx_L4_error:;
29122           __pyx_t_14 = 0; __pyx_t_15 = 0; __pyx_t_16 = 0; __pyx_t_17 = 0; __pyx_t_18 = 0; __pyx_t_19 = 0;
29123           __Pyx_XDECREF(__pyx_t_3); __pyx_t_3 = 0;
29124           __Pyx_XDECREF(__pyx_t_1); __pyx_t_1 = 0;

** CID 1353334:  Control flow issues  (UNREACHABLE)
/build/rados.c: 9057 in __pyx_pf_5rados_5Rados_20conf_get()


________________________________________________________________________________________________________
*** CID 1353334:  Control flow issues  (UNREACHABLE)
/build/rados.c: 9057 in __pyx_pf_5rados_5Rados_20conf_get()
9051      */
9052       /*finally:*/ {
9053         /*normal exit:*/{
9054           free(__pyx_v_ret_buf);
9055           goto __pyx_L5;
9056         }
>>>     CID 1353334:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  __pyx_L4_error:
  ;
  _...".
9057         /*exception exit:*/{
9058           __pyx_L4_error:;
9059           __pyx_t_13 = 0; __pyx_t_14 = 0; __pyx_t_15 = 0; __pyx_t_16 = 0; __pyx_t_17 = 0; __pyx_t_18 = 0;
9060           __Pyx_XDECREF(__pyx_t_3); __pyx_t_3 = 0;
9061           __Pyx_XDECREF(__pyx_t_5); __pyx_t_5 = 0;
9062           __Pyx_XDECREF(__pyx_t_9); __pyx_t_9 = 0;

** CID 1353333:  Control flow issues  (UNREACHABLE)
/build/rados.c: 8360 in __pyx_pf_5rados_5Rados_16conf_parse_argv()


________________________________________________________________________________________________________
*** CID 1353333:  Control flow issues  (UNREACHABLE)
/build/rados.c: 8360 in __pyx_pf_5rados_5Rados_16conf_parse_argv()
8354      *             return retargs
8355      *         finally:
8356      *             free(_argv)             # <<<<<<<<<<<<<<
8357      *             free(_remargv)
8358      * 
8359      */
>>>     CID 1353333:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    __pyx_L5_error:
 ...".
8360       /*finally:*/ {
8361         /*exception exit:*/{
8362           __pyx_L5_error:;
8363           __pyx_t_16 = 0; __pyx_t_17 = 0; __pyx_t_18 = 0; __pyx_t_19 = 0; __pyx_t_20 = 0; __pyx_t_21 = 0;
8364           __Pyx_XDECREF(__pyx_t_11); __pyx_t_11 = 0;
8365           __Pyx_XDECREF(__pyx_t_5); __pyx_t_5 = 0;

** CID 1353332:  Control flow issues  (UNREACHABLE)
/build/rados.c: 35757 in __pyx_pf_5rados_5Ioctx_98get_omap_vals_by_keys()


________________________________________________________________________________________________________
*** CID 1353332:  Control flow issues  (UNREACHABLE)
/build/rados.c: 35757 in __pyx_pf_5rados_5Ioctx_98get_omap_vals_by_keys()
35751      *             return it, int(prval)
35752      *         finally:
35753      *             free(_keys)             # <<<<<<<<<<<<<<
35754      * 
35755      *     @requires(('write_op', WriteOp), ('keys', tuple))
35756      */
>>>     CID 1353332:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    __pyx_L4_error:
 ...".
35757       /*finally:*/ {
35758         /*exception exit:*/{
35759           __pyx_L4_error:;
35760           __pyx_t_9 = 0; __pyx_t_10 = 0; __pyx_t_11 = 0; __pyx_t_12 = 0; __pyx_t_13 = 0; __pyx_t_14 = 0;
35761           __Pyx_XDECREF(__pyx_t_3); __pyx_t_3 = 0;
35762           __Pyx_XDECREF(__pyx_t_5); __pyx_t_5 = 0;

** CID 1353331:  Control flow issues  (UNREACHABLE)
/build/rados.c: 25549 in __pyx_pf_5rados_5Ioctx_8aio_read_oncomplete_()


________________________________________________________________________________________________________
*** CID 1353331:  Control flow issues  (UNREACHABLE)
/build/rados.c: 25549 in __pyx_pf_5rados_5Ioctx_8aio_read_oncomplete_()
25543      *                 # including if _PyString_Resize fails (that will free the string
25544      *                 # itself and set ret_s to NULL, hence XDECREF).
25545      *                 ref.Py_XDECREF(ret_s)             # <<<<<<<<<<<<<<
25546      * 
25547      *         completion = self.__get_completion(oncomplete_, None)
25548      */
>>>     CID 1353331:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "{
  {
    __pyx_L4_error:
 ...".
25549       /*finally:*/ {
25550         /*exception exit:*/{
25551           __pyx_L4_error:;
25552           __pyx_t_11 = 0; __pyx_t_12 = 0; __pyx_t_13 = 0; __pyx_t_14 = 0; __pyx_t_15 = 0; __pyx_t_16 = 0;
25553           __Pyx_XDECREF(__pyx_t_7); __pyx_t_7 = 0;
25554           __Pyx_XDECREF(__pyx_t_2); __pyx_t_2 = 0;

** CID 1353330:  Uninitialized variables  (UNINIT)
/build/rados.c: 31283 in __pyx_pf_5rados_5Ioctx_58get_xattr()


________________________________________________________________________________________________________
*** CID 1353330:  Uninitialized variables  (UNINIT)
/build/rados.c: 31283 in __pyx_pf_5rados_5Ioctx_58get_xattr()
31277      *                     break
31278      *             return ret_buf[:ret]             # <<<<<<<<<<<<<<
31279      *         finally:
31280      *             free(ret_buf)
31281      */
31282         __Pyx_XDECREF(__pyx_r);
>>>     CID 1353330:  Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "__pyx_v_ret".
31283         __pyx_t_3 = __Pyx_PyBytes_FromStringAndSize(__pyx_v_ret_buf + 0, __pyx_v_ret - 0); if (unlikely(!__pyx_t_3)) {__pyx_filename = __pyx_f[0]; __pyx_lineno = 2499; __pyx_clineno = __LINE__; goto __pyx_L4_error;}
31284         __Pyx_GOTREF(__pyx_t_3);
31285         __pyx_r = __pyx_t_3;
31286         __pyx_t_3 = 0;
31287         goto __pyx_L3_return;
31288       }

** CID 1353329:  Null pointer dereferences  (REVERSE_INULL)
/build/rados.c: 41695 in __pyx_pf_7cpython_5array_5array___getbuffer__()


________________________________________________________________________________________________________
*** CID 1353329:  Null pointer dereferences  (REVERSE_INULL)
/build/rados.c: 41695 in __pyx_pf_7cpython_5array_5array___getbuffer__()
41689       if (__pyx_v_info != NULL && __pyx_v_info->obj != NULL) {
41690         __Pyx_GOTREF(__pyx_v_info->obj);
41691         __Pyx_DECREF(__pyx_v_info->obj); __pyx_v_info->obj = NULL;
41692       }
41693       goto __pyx_L2;
41694       __pyx_L0:;
>>>     CID 1353329:  Null pointer dereferences  (REVERSE_INULL)
>>>     Null-checking "__pyx_v_info" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
41695       if (__pyx_v_info != NULL && __pyx_v_info->obj == Py_None) {
41696         __Pyx_GOTREF(Py_None);
41697         __Pyx_DECREF(Py_None); __pyx_v_info->obj = NULL;
41698       }
41699       __pyx_L2:;
41700       __Pyx_XDECREF(__pyx_v_item_count);

** CID 1353328:  Resource leaks  (RESOURCE_LEAK)
/build/rados.c: 5461 in __pyx_f_5rados_to_csize_t_array()


________________________________________________________________________________________________________
*** CID 1353328:  Resource leaks  (RESOURCE_LEAK)
/build/rados.c: 5461 in __pyx_f_5rados_to_csize_t_array()
5455       __pyx_L1_error:;
5456       __Pyx_XDECREF(__pyx_t_3);
5457       __Pyx_WriteUnraisable("rados.to_csize_t_array", __pyx_clineno, __pyx_lineno, __pyx_filename, 0);
5458       __pyx_r = 0;
5459       __pyx_L0:;
5460       __Pyx_RefNannyFinishContext();
>>>     CID 1353328:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "__pyx_v_ret" going out of scope leaks the storage it points to.
5461       return __pyx_r;
5462     }
5463     
5464     /* "rados.pyx":491
5465      * 
5466      * 

** CID 1353327:  Resource leaks  (RESOURCE_LEAK)
/build/rados.c: 5571 in __pyx_f_5rados_to_bytes_array()


________________________________________________________________________________________________________
*** CID 1353327:  Resource leaks  (RESOURCE_LEAK)
/build/rados.c: 5571 in __pyx_f_5rados_to_bytes_array()
5565       __pyx_L1_error:;
5566       __Pyx_XDECREF(__pyx_t_3);
5567       __Pyx_WriteUnraisable("rados.to_bytes_array", __pyx_clineno, __pyx_lineno, __pyx_filename, 0);
5568       __pyx_r = 0;
5569       __pyx_L0:;
5570       __Pyx_RefNannyFinishContext();
>>>     CID 1353327:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "__pyx_v_ret" going out of scope leaks the storage it points to.
5571       return __pyx_r;
5572     }
5573     
5574     /* "rados.pyx":501
5575      * 
5576      * 

** CID 1353326:  Resource leaks  (RESOURCE_LEAK)
/build/rados.c: 14463 in __pyx_pf_5rados_5Rados_52pg_command()


________________________________________________________________________________________________________
*** CID 1353326:  Resource leaks  (RESOURCE_LEAK)
/build/rados.c: 14463 in __pyx_pf_5rados_5Rados_52pg_command()
14457       __Pyx_XDECREF(__pyx_v_my_outbuf);
14458       __Pyx_XDECREF(__pyx_v_pgid);
14459       __Pyx_XDECREF(__pyx_v_cmd);
14460       __Pyx_XDECREF(__pyx_v_inbuf);
14461       __Pyx_XGIVEREF(__pyx_r);
14462       __Pyx_RefNannyFinishContext();
>>>     CID 1353326:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "__pyx_v__outs" going out of scope leaks the storage it points to.
14463       return __pyx_r;
14464     }
14465     
14466     /* "rados.pyx":1222
14467      *             free(_cmd)
14468      * 

** CID 1353325:  Resource leaks  (RESOURCE_LEAK)
/build/rados.c: 14463 in __pyx_pf_5rados_5Rados_52pg_command()


________________________________________________________________________________________________________
*** CID 1353325:  Resource leaks  (RESOURCE_LEAK)
/build/rados.c: 14463 in __pyx_pf_5rados_5Rados_52pg_command()
14457       __Pyx_XDECREF(__pyx_v_my_outbuf);
14458       __Pyx_XDECREF(__pyx_v_pgid);
14459       __Pyx_XDECREF(__pyx_v_cmd);
14460       __Pyx_XDECREF(__pyx_v_inbuf);
14461       __Pyx_XGIVEREF(__pyx_r);
14462       __Pyx_RefNannyFinishContext();
>>>     CID 1353325:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "__pyx_v__cmd" going out of scope leaks the storage it points to.
14463       return __pyx_r;
14464     }
14465     
14466     /* "rados.pyx":1222
14467      *             free(_cmd)
14468      * 


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://scan.coverity.com/projects/ceph?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c

