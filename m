From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Fri, 17 Oct 2014 06:27:56 -0700
Message-ID: <5441195cf2b6c_26b7b5b314336ac@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:61272 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbaJQN15 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Oct 2014 09:27:57 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

4 new defect(s) introduced to ceph found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 4 of 4 defect(s)


** CID 1247718:  Explicit null dereferenced  (FORWARD_NULL)
/mds/Server.cc: 3184 in Server::handle_client_file_setlock(std::tr1::shared_ptr<MDRequestImpl> &)()
/mds/Server.cc: 3184 in Server::handle_client_file_setlock(std::tr1::shared_ptr<MDRequestImpl> &)()
/mds/Server.cc: 3184 in Server::handle_client_file_setlock(std::tr1::shared_ptr<MDRequestImpl> &)()
/mds/Server.cc: 3184 in Server::handle_client_file_setlock(std::tr1::shared_ptr<MDRequestImpl> &)()

** CID 1247719:  Unintentional integer overflow  (OVERFLOW_BEFORE_WIDEN)
/osdc/Striper.cc: 221 in Striper::get_num_objects(const ceph_file_layout &, unsigned long)()

** CID 1247720:  Unintentional integer overflow  (OVERFLOW_BEFORE_WIDEN)
/osdc/Striper.cc: 225 in Striper::get_num_objects(const ceph_file_layout &, unsigned long)()

** CID 1247721:  Uncaught exception  (UNCAUGHT_EXCEPT)
/rbd.cc: 2071 in main()
/rbd.cc: 2071 in main()


________________________________________________________________________________________________________
*** CID 1247718:  Explicit null dereferenced  (FORWARD_NULL)
/mds/Server.cc: 3184 in Server::handle_client_file_setlock(std::tr1::shared_ptr<MDRequestImpl> &)()
3178       set_lock.pid = req->head.args.filelock_change.pid;
3179       set_lock.type = req->head.args.filelock_change.type;
3180       bool will_wait = req->head.args.filelock_change.wait;
3181     
3182       dout(10) << "handle_client_file_setlock: " << set_lock << dendl;
3183     
>>>     CID 1247718:  Explicit null dereferenced  (FORWARD_NULL)
>>>     Assigning: "lock_state" = "NULL".
3184       ceph_lock_state_t *lock_state = NULL;
3185       bool interrupt = false;
3186     
3187       // get the appropriate lock state
3188       switch (req->head.args.filelock_change.rule) {
3189       case CEPH_LOCK_FLOCK_INTR:
/mds/Server.cc: 3184 in Server::handle_client_file_setlock(std::tr1::shared_ptr<MDRequestImpl> &)()
3178       set_lock.pid = req->head.args.filelock_change.pid;
3179       set_lock.type = req->head.args.filelock_change.type;
3180       bool will_wait = req->head.args.filelock_change.wait;
3181     
3182       dout(10) << "handle_client_file_setlock: " << set_lock << dendl;
3183     
>>>     CID 1247718:  Explicit null dereferenced  (FORWARD_NULL)
>>>     Assigning: "lock_state" = "NULL".
3184       ceph_lock_state_t *lock_state = NULL;
3185       bool interrupt = false;
3186     
3187       // get the appropriate lock state
3188       switch (req->head.args.filelock_change.rule) {
3189       case CEPH_LOCK_FLOCK_INTR:
/mds/Server.cc: 3184 in Server::handle_client_file_setlock(std::tr1::shared_ptr<MDRequestImpl> &)()
3178       set_lock.pid = req->head.args.filelock_change.pid;
3179       set_lock.type = req->head.args.filelock_change.type;
3180       bool will_wait = req->head.args.filelock_change.wait;
3181     
3182       dout(10) << "handle_client_file_setlock: " << set_lock << dendl;
3183     
>>>     CID 1247718:  Explicit null dereferenced  (FORWARD_NULL)
>>>     Assigning: "lock_state" = "NULL".
3184       ceph_lock_state_t *lock_state = NULL;
3185       bool interrupt = false;
3186     
3187       // get the appropriate lock state
3188       switch (req->head.args.filelock_change.rule) {
3189       case CEPH_LOCK_FLOCK_INTR:
/mds/Server.cc: 3184 in Server::handle_client_file_setlock(std::tr1::shared_ptr<MDRequestImpl> &)()
3178       set_lock.pid = req->head.args.filelock_change.pid;
3179       set_lock.type = req->head.args.filelock_change.type;
3180       bool will_wait = req->head.args.filelock_change.wait;
3181     
3182       dout(10) << "handle_client_file_setlock: " << set_lock << dendl;
3183     
>>>     CID 1247718:  Explicit null dereferenced  (FORWARD_NULL)
>>>     Assigning: "lock_state" = "NULL".
3184       ceph_lock_state_t *lock_state = NULL;
3185       bool interrupt = false;
3186     
3187       // get the appropriate lock state
3188       switch (req->head.args.filelock_change.rule) {
3189       case CEPH_LOCK_FLOCK_INTR:

________________________________________________________________________________________________________
*** CID 1247719:  Unintentional integer overflow  (OVERFLOW_BEFORE_WIDEN)
/osdc/Striper.cc: 221 in Striper::get_num_objects(const ceph_file_layout &, unsigned long)()
215     }
216     uint64_t Striper::get_num_objects(const ceph_file_layout& layout, uint64_t size)
217     {
218       __u32 object_size = layout.fl_object_size;
219       __u32 stripe_unit = layout.fl_stripe_unit;
220       __u32 stripe_count = layout.fl_stripe_count;
>>>     CID 1247719:  Unintentional integer overflow  (OVERFLOW_BEFORE_WIDEN)
>>>     Potentially overflowing expression "stripe_count * object_size" with type "unsigned int" (32 bits, unsigned) is evaluated using 32-bit arithmetic before being used in a context which expects an expression of type "uint64_t" (64 bits, unsigned). To avoid overflow, cast either operand to "uint64_t" before performing the multiplication.
221       uint64_t period = stripe_count * object_size;
222       uint64_t num_periods = (size + period - 1) / period;
223       uint64_t remainder_bytes = size % period;
224       uint64_t remainder_objs = 0;
225       if ((remainder_bytes > 0) && (remainder_bytes < stripe_count * stripe_unit))
226         remainder_objs = stripe_count - ((remainder_bytes + stripe_unit - 1) / stripe_unit);

________________________________________________________________________________________________________
*** CID 1247720:  Unintentional integer overflow  (OVERFLOW_BEFORE_WIDEN)
/osdc/Striper.cc: 225 in Striper::get_num_objects(const ceph_file_layout &, unsigned long)()
219       __u32 stripe_unit = layout.fl_stripe_unit;
220       __u32 stripe_count = layout.fl_stripe_count;
221       uint64_t period = stripe_count * object_size;
222       uint64_t num_periods = (size + period - 1) / period;
223       uint64_t remainder_bytes = size % period;
224       uint64_t remainder_objs = 0;
>>>     CID 1247720:  Unintentional integer overflow  (OVERFLOW_BEFORE_WIDEN)
>>>     Potentially overflowing expression "stripe_count * stripe_unit" with type "unsigned int" (32 bits, unsigned) is evaluated using 32-bit arithmetic before being used in a context which expects an expression of type "uint64_t" (64 bits, unsigned). To avoid overflow, cast either operand to "uint64_t" before performing the multiplication.
225       if ((remainder_bytes > 0) && (remainder_bytes < stripe_count * stripe_unit))
226         remainder_objs = stripe_count - ((remainder_bytes + stripe_unit - 1) / stripe_unit);
227       return num_periods * stripe_count - remainder_objs;
228     }
229     
230     // StripedReadResult

________________________________________________________________________________________________________
*** CID 1247721:  Uncaught exception  (UNCAUGHT_EXCEPT)
/rbd.cc: 2071 in main()
2065         return false;
2066       return true;
2067     }
2068     
2069     bool size_set;
2070     
>>>     CID 1247721:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2071     int main(int argc, const char **argv)
2072     {
2073       librados::Rados rados;
2074       librbd::RBD rbd;
2075       librados::IoCtx io_ctx, dest_io_ctx;
2076       librbd::Image image;
/rbd.cc: 2071 in main()
2065         return false;
2066       return true;
2067     }
2068     
2069     bool size_set;
2070     
>>>     CID 1247721:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2071     int main(int argc, const char **argv)
2072     {
2073       librados::Rados rados;
2074       librbd::RBD rbd;
2075       librados::IoCtx io_ctx, dest_io_ctx;
2076       librbd::Image image;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py



