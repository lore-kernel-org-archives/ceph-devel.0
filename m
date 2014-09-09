From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: OSD is crashing while running admin socket
Date: Tue, 9 Sep 2014 01:08:06 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F27839B22@SACMBXIP02.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F27839A9D@SACMBXIP02.sdcorp.global.sandisk.com>
 <CA+4uBUYoCL1WjyX4TkEfRuJgtCWgTD2cyJBab3cOY04gBuae=Q@mail.gmail.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F27839B04@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1409081758480.17200@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0087.outbound.protection.outlook.com ([65.55.169.87]:59600
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754506AbaIIBIN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Sep 2014 21:08:13 -0400
In-Reply-To: <alpine.DEB.2.00.1409081758480.17200@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Samuel Just <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Yeah!!..Looks similar but not entirely..
There is another potential race condition that may cause this.

We are protecting the TrackedOp::events structure only during TrackedOp::mark_event with lock mutex. I couldn't find it anywhere else. The events structure should also be protected during dump and more specifically within _dump().
I am taking care of it as well.

Thanks & Regards
Somnath
-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com] 
Sent: Monday, September 08, 2014 5:59 PM
To: Somnath Roy
Cc: Samuel Just; ceph-devel@vger.kernel.org; ceph-users@lists.ceph.com
Subject: RE: OSD is crashing while running admin socket

On Tue, 9 Sep 2014, Somnath Roy wrote:
> Created the following tracker and assigned to me.
> 
> http://tracker.ceph.com/issues/9384

By the way, this might be the same as or similar to
http://tracker.ceph.com/issues/8885

Thanks!
sage


> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: Samuel Just [mailto:sam.just@inktank.com]
> Sent: Monday, September 08, 2014 5:22 PM
> To: Somnath Roy
> Cc: Sage Weil (sweil@redhat.com); ceph-devel@vger.kernel.org; 
> ceph-users@lists.ceph.com
> Subject: Re: OSD is crashing while running admin socket
> 
> That seems reasonable.  Bug away!
> -Sam
> 
> On Mon, Sep 8, 2014 at 5:11 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> > Hi Sage/Sam,
> >
> >
> >
> > I faced a crash in OSD with latest Ceph master. Here is the log 
> > trace for the same.
> >
> >
> >
> > ceph version 0.85-677-gd5777c4
> > (d5777c421548e7f039bb2c77cb0df2e9c7404723)
> >
> > 1: ceph-osd() [0x990def]
> >
> > 2: (()+0xfbb0) [0x7f72ae6e6bb0]
> >
> > 3: (gsignal()+0x37) [0x7f72acc08f77]
> >
> > 4: (abort()+0x148) [0x7f72acc0c5e8]
> >
> > 5: (__gnu_cxx::__verbose_terminate_handler()+0x155) [0x7f72ad5146e5]
> >
> > 6: (()+0x5e856) [0x7f72ad512856]
> >
> > 7: (()+0x5e883) [0x7f72ad512883]
> >
> > 8: (()+0x5eaae) [0x7f72ad512aae]
> >
> > 9: (ceph::buffer::list::substr_of(ceph::buffer::list const&, 
> > unsigned int, unsigned int)+0x277) [0xa88747]
> >
> > 10: (ceph::buffer::list::write(int, int, std::ostream&) const+0x81) 
> > [0xa89541]
> >
> > 11: (operator<<(std::ostream&, OSDOp const&)+0x1f6) [0x717a16]
> >
> > 12: (MOSDOp::print(std::ostream&) const+0x172) [0x6e5e32]
> >
> > 13: (TrackedOp::dump(utime_t, ceph::Formatter*) const+0x223) 
> > [0x6b6483]
> >
> > 14: (OpTracker::dump_ops_in_flight(ceph::Formatter*)+0xa7) 
> > [0x6b7057]
> >
> > 15: (OSD::asok_command(std::string, std::map<std::string, 
> > boost::variant<std::string, bool, long, double, 
> > std::vector<std::string, std::allocator<std::string> >, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_>, std::less<std::string>, 
> > std::allocator<std::pair<std::string const, 
> > boost::variant<std::string, bool, long, double, 
> > std::vector<std::string, std::allocator<std::string> >, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_> > > >&, std::string,
> > std::ostream&)+0x1d7) [0x612cb7]
> >
> > 16: (OSDSocketHook::call(std::string, std::map<std::string, 
> > boost::variant<std::string, bool, long, double, 
> > std::vector<std::string, std::allocator<std::string> >, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_>, std::less<std::string>, 
> > std::allocator<std::pair<std::string const, 
> > boost::variant<std::string, bool, long, double, 
> > std::vector<std::string, std::allocator<std::string> >, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_, boost::detail::variant::void_, 
> > boost::detail::variant::void_> > > >&, std::string,
> > ceph::buffer::list&)+0x67) [0x67c8b7]
> >
> > 17: (AdminSocket::do_accept()+0x1007) [0xa79817]
> >
> > 18: (AdminSocket::entry()+0x258) [0xa7b448]
> >
> > 19: (()+0x7f6e) [0x7f72ae6def6e]
> >
> > 20: (clone()+0x6d) [0x7f72acccc9cd]
> >
> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
> > needed to interpret this.
> >
> >
> >
> > Steps to reproduce:
> >
> > -----------------------
> >
> >
> >
> > 1.       Run ios
> >
> > 2.       While ios running , run the following command continuously.
> >
> >
> >
> > ?ceph --admin-daemon /var/run/ceph/ceph-osd.0.asok dump_ops_in_flight?
> >
> >
> >
> > 3.       At some point the osd will be crashed.
> >
> >
> >
> > I think I have root caused it..
> >
> >
> >
> > 1.       OpTracker::RemoveOnDelete::operator() is calling
> > op->_unregistered() which clears out message->data() and payload
> >
> > 2.       After that, if optracking is enabled we are calling
> > unregister_inflight_op() which removed the op from the xlist.
> >
> > 3.       Now, while dumping ops, we are calling
> > _dump_op_descriptor_unlocked() from TrackedOP::dump, which tries to 
> > print the message.
> >
> > 4.       So, there is a race condition when it tries to print the message
> > whoes ops (data) field is already cleared.
> >
> >
> >
> > Fix could be, call this op->_unregistered (in case optracking is
> > enabled) after it is removed from xlist.
> >
> >
> >
> > With this fix, I am not getting the crash anymore.
> >
> >
> >
> > If my observation is correct, please let me know. I will raise a bug 
> > and will fix that as part of the overall optracker performance 
> > improvement (I will submit that pull request soon).
> >
> >
> >
> > Thanks & Regards
> >
> > Somnath
> >
> >
> > ________________________________
> >
> > PLEASE NOTE: The information contained in this electronic mail 
> > message is intended only for the use of the designated recipient(s) 
> > named above. If the reader of this message is not the intended 
> > recipient, you are hereby notified that you have received this 
> > message in error and that any review, dissemination, distribution, 
> > or copying of this message is strictly prohibited. If you have 
> > received this communication in error, please notify the sender by 
> > telephone or e-mail (as shown above) immediately and destroy any and 
> > all copies of this message in your possession (whether hard copies or electronically stored copies).
> >
> 
> ________________________________
> 
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> 
> 
