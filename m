From: "Martin Ettl" <ettl.martin@gmx.de>
Subject: Re: [cppcheck] suggested a few performance improvements
Date: Wed, 24 Mar 2010 21:08:52 +0100
Message-ID: <20100324200852.307830@gmx.net>
References: <20100322203502.295370@gmx.net>
	<Pine.LNX.4.64.1003221348030.21746@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMX30783126946133243323"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.1003221348030.21746@cobra.newdream.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

--========GMX30783126946133243323
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

attached to this mail, there is the output of scan with cppcheck. Cppcheck reports few issues about post and pre incrementation of iterators (post increment is faster) and const correctness,e.g:

class A
{
   public:
          bool IsOk() {return state;} // <-- cppcheck complains about a missing cont declaration
   bool state;
};

solution:
class A
{
   public:
          bool IsOk() const {return state;} 
   bool state;
};


One other main stylistic issue is that it is allowed to deallocate a NULL Pointer
e.g:

int *p = NULL;
delete p;

is totally legal.



I hope this is usefull for you?

Best regards

Ettl Martin




Hi,

of course, i can mail the whole output to you, if you wish? But i suggest to run it on yourself using the following commandline command:

Download cppcheck at http://sourceforge.net/projects/cppcheck/
cppcheck --enable=all [src-directory]

Best regards

Martin



-------- Original-Nachricht --------
> Datum: Mon, 22 Mar 2010 13:49:37 -0700 (PDT)
> Von: Sage Weil <sage@newdream.net>
> An: Martin Ettl <ettl.martin@gmx.de>
> CC: ceph-devel@lists.sourceforge.net
> Betreff: Re: [ceph-devel] [cppcheck] suggested a few performance improvements

> Hi Martin,
> 
> On Mon, 22 Mar 2010, Martin Ettl wrote:
> > i have checked the current git head with cppcheck ( a static code 
> > analysis tool, http://sourceforge.net/projects/cppcheck/). It is an 
> > allready very powerfull tool that makes some suggestions, how to improve
> > performance of the code.
> > 
> > Here is a snipped of the scan:
> > ....
> > [./src/mds/MDSMap.h:236]: (possible style) Pre-Incrementing variable 'p'
> is preferred to Post-Incrementing
> > [./src/mds/MDSMap.h:256]: (possible style) Pre-Incrementing variable 'p'
> is preferred to Post-Incrementing
> > [./src/mds/MDSMap.h:263]: (possible style) Pre-Incrementing variable 'p'
> is preferred to Post-Incrementing
> > [./src/mds/MDSMap.h:280]: (possible style) Pre-Incrementing variable 'p'
> is preferred to Post-Incrementing
> > [./src/mds/MDSMap.h:291]: (possible style) Pre-Incrementing variable 'p'
> is preferred to Post-Incrementing
> > [./src/include/LogEntry.h:100]: (possible style) Pre-Incrementing
> variable 'p' is preferred to Post-Incrementing
> > [./src/ceph.cc:317]: (possible style) Pre-Incrementing variable 'p' is
> preferred to Post-Incrementing
> > [./src/mds/MDSMap.h:247]: (possible style) Use failed.empty() instead of
> failed.size() to guarantee fast code.
> > ....
> > 
> > 
> > Please refer the attached patch that chanes a few of this suggestions.
> > What do you think about this? Does it boost the performance?
> 
> I don't think it'll affect performance in these cases, but stylistically 
> it's an improvement, so I'll apply it.
> 
> Did cppcheck have anything else to say?
> 
> Thanks!
> sage

-- 
GMX DSL: Internet, Telefon und Entertainment für nur 19,99 EUR/mtl.!
http://portal.gmx.net/de/go/dsl02

-- 
Sicherer, schneller und einfacher. Die aktuellen Internet-Browser -
jetzt kostenlos herunterladen! http://portal.gmx.net/de/go/chbrowser

--========GMX30783126946133243323
Content-Type: text/plain; charset="iso-8859-15"; name="ceph.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="ceph.txt"

[/home/oem/Desktop/source_to_check/ceph/src/active/utility.h:46]: (possible error) Memory leak: monmap
[/home/oem/Desktop/source_to_check/ceph/src/active/activemaster.cc:65]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/active/activemaster.cc:75]: (possible style) Pre-Incrementing variable 'j' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/fusetrace/fusetrace_ll.cc:1122]: (style) Variable 'err' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/fusetrace/fusetrace_ll.cc:1164]: (style) The scope of the variable err can be reduced
[/home/oem/Desktop/source_to_check/ceph/src/active/msgtestclient.cc:49]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/active/msgtestclient.cc:91]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/active/msgtestclient.cc:103]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/active/msgtestclient.cc:374]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/active/msgtestclient.cc:385]: (possible style) Pre-Incrementing variable 'j' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/auth/AuthClientHandler.h:78]: (style) The function 'AuthClientHandler::get_global_id' can be const
[/home/oem/Desktop/source_to_check/ceph/src/auth/Crypto.cc:153]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/auth/Crypto.cc:188]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/auth/ExportControl.cc:345]: (style) The scope of the variable ret can be reduced
[/home/oem/Desktop/source_to_check/ceph/src/auth/ExportControl.cc:403]: (style) Member variable not initialized in the constructor 'ExportAddrEntry::valid'
[/home/oem/Desktop/source_to_check/ceph/src/auth/ExportControl.cc:148]: (style) Unused private function 'GroupEntry::parse_single_addr'
[/home/oem/Desktop/source_to_check/ceph/src/auth/ExportControl.cc:52]: (style) The function 'Subnet::is_valid' can be const
[/home/oem/Desktop/source_to_check/ceph/src/auth/ExportControl.cc:155]: (style) The function 'GroupEntry::get_readonly' can be const
[/home/oem/Desktop/source_to_check/ceph/src/auth/ExportControl.cc:340]: (possible error) Memory leak: subnet
[/home/oem/Desktop/source_to_check/ceph/src/auth/ExportControl.cc:43]: (possible error) Memory leak: Subnet::orig_str
[/home/oem/Desktop/source_to_check/ceph/src/auth/ExportControl.cc:426]: (error) Uninitialized variable: props
[/home/oem/Desktop/source_to_check/ceph/src/auth/KeyRing.cc:41]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/auth/cephx/CephxKeyServer.h:240]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/cauthtool.cc:148]: (style) The scope of the variable other can be reduced
[/home/oem/Desktop/source_to_check/ceph/src/common/Mutex.h:38]: (possible style) Member variable not initialized in the constructor 'Mutex::nlock'
[/home/oem/Desktop/source_to_check/ceph/src/common/Mutex.h:38]: (possible style) Member variable not initialized in the constructor 'Mutex::backtrace'
[/home/oem/Desktop/source_to_check/ceph/src/common/Mutex.h:38]: (possible style) Member variable not initialized in the constructor 'Mutex::lockdep'
[/home/oem/Desktop/source_to_check/ceph/src/common/Mutex.h:38]: (possible style) Member variable not initialized in the constructor 'Mutex::recursive'
[/home/oem/Desktop/source_to_check/ceph/src/common/Mutex.h:38]: (possible style) Member variable not initialized in the constructor 'Mutex::id'
[/home/oem/Desktop/source_to_check/ceph/src/common/Mutex.h:38]: (possible style) Member variable not initialized in the constructor 'Mutex::name'
[/home/oem/Desktop/source_to_check/ceph/src/common/Mutex.h:37]: (possible style) Member variable 'Mutex::nlock' is not assigned a value in 'Mutex::operator='
[/home/oem/Desktop/source_to_check/ceph/src/common/Mutex.h:37]: (possible style) Member variable 'Mutex::_m' is not assigned a value in 'Mutex::operator='
[/home/oem/Desktop/source_to_check/ceph/src/common/Mutex.h:37]: (possible style) Member variable 'Mutex::backtrace' is not assigned a value in 'Mutex::operator='
[/home/oem/Desktop/source_to_check/ceph/src/common/Mutex.h:37]: (possible style) Member variable 'Mutex::lockdep' is not assigned a value in 'Mutex::operator='
[/home/oem/Desktop/source_to_check/ceph/src/common/Mutex.h:37]: (possible style) Member variable 'Mutex::recursive' is not assigned a value in 'Mutex::operator='
[/home/oem/Desktop/source_to_check/ceph/src/common/Mutex.h:37]: (possible style) Member variable 'Mutex::id' is not assigned a value in 'Mutex::operator='
[/home/oem/Desktop/source_to_check/ceph/src/common/Mutex.h:37]: (possible style) Member variable 'Mutex::name' is not assigned a value in 'Mutex::operator='
[/home/oem/Desktop/source_to_check/ceph/src/common/Mutex.h:37]: (style) The function 'Mutex::operator=' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/Mutex.h:79]: (style) The function 'Mutex::is_locked' can be const
[/home/oem/Desktop/source_to_check/ceph/src/msg/msg_types.h:276]: (style) The function 'entity_inst_t::ceph_entity_inst' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/Clock.h:79]: (style) The function 'Clock::recent_now' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/Clock.h:83]: (style) The function 'Clock::realify' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:94]: (style) The function 'ConfFile::get_filename' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:118]: (style) The function 'ConfFile::set_post_process_func' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:67]: (possible error) Memory leak: ConfFile::filename
[/home/oem/Desktop/source_to_check/ceph/src/msg/msg_types.h:184]: (style) Unreachable code below a 'return'
[/home/oem/Desktop/source_to_check/ceph/src/msg/msg_types.h:187]: (style) Unreachable code below a 'return'
[/home/oem/Desktop/source_to_check/ceph/src/include/buffer.h:116]: (style) Member variable not initialized in the constructor 'raw::data'
[/home/oem/Desktop/source_to_check/ceph/src/include/buffer.h:698]: (possible style) Member variable 'list::last_p' is not assigned a value in 'list::operator='
[/home/oem/Desktop/source_to_check/ceph/src/include/buffer.h:698]: (possible style) Member variable 'list::append_buffer' is not assigned a value in 'list::operator='
[/home/oem/Desktop/source_to_check/ceph/src/include/buffer.h:133]: (style) The function 'buffer::raw::is_page_aligned' can be const
[/home/oem/Desktop/source_to_check/ceph/src/include/buffer.h:136]: (style) The function 'buffer::buffer::raw::is_n_page_sized' can be const
[/home/oem/Desktop/source_to_check/ceph/src/include/buffer.h:500]: (style) The function 'buffer::ptr::clean' can be const
[/home/oem/Desktop/source_to_check/ceph/src/include/utime.h:47]: (style) The function 'utime_t::is_zero' can be const
[/home/oem/Desktop/source_to_check/ceph/src/include/types.h:370]: (style) The function 'SnapContext::empty' can be const
[/home/oem/Desktop/source_to_check/ceph/src/include/cstring.h:52]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/include/cstring.h:65]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/include/cstring.h:73]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/include/cstring.h:81]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/include/cstring.h:118]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/include/object.h:152]: (style) Function parameter 'l' is passed by value. It could be passed by reference instead.
[/home/oem/Desktop/source_to_check/ceph/src/include/object.h:152]: (style) Function parameter 'r' is passed by value. It could be passed by reference instead.
[/home/oem/Desktop/source_to_check/ceph/src/include/object.h:155]: (style) Function parameter 'l' is passed by value. It could be passed by reference instead.
[/home/oem/Desktop/source_to_check/ceph/src/include/object.h:155]: (style) Function parameter 'r' is passed by value. It could be passed by reference instead.
[/home/oem/Desktop/source_to_check/ceph/src/include/object.h:158]: (style) Function parameter 'l' is passed by value. It could be passed by reference instead.
[/home/oem/Desktop/source_to_check/ceph/src/include/object.h:158]: (style) Function parameter 'r' is passed by value. It could be passed by reference instead.
[/home/oem/Desktop/source_to_check/ceph/src/include/object.h:161]: (style) Function parameter 'l' is passed by value. It could be passed by reference instead.
[/home/oem/Desktop/source_to_check/ceph/src/include/object.h:161]: (style) Function parameter 'r' is passed by value. It could be passed by reference instead.
[/home/oem/Desktop/source_to_check/ceph/src/include/object.h:164]: (style) Function parameter 'l' is passed by value. It could be passed by reference instead.
[/home/oem/Desktop/source_to_check/ceph/src/include/object.h:164]: (style) Function parameter 'r' is passed by value. It could be passed by reference instead.
[/home/oem/Desktop/source_to_check/ceph/src/include/object.h:167]: (style) Function parameter 'l' is passed by value. It could be passed by reference instead.
[/home/oem/Desktop/source_to_check/ceph/src/include/object.h:167]: (style) Function parameter 'r' is passed by value. It could be passed by reference instead.
[/home/oem/Desktop/source_to_check/ceph/src/include/object.h:170]: (style) Function parameter 'o' is passed by value. It could be passed by reference instead.
[/home/oem/Desktop/source_to_check/ceph/src/common/Thread.h:39]: (style) C-style pointer casting
[/home/oem/Desktop/source_to_check/ceph/src/ceph.cc:361]: (style) C-style pointer casting
[/home/oem/Desktop/source_to_check/ceph/src/ceph.cc:364]: (style) C-style pointer casting
[/home/oem/Desktop/source_to_check/ceph/src/ceph.cc:367]: (style) C-style pointer casting
[/home/oem/Desktop/source_to_check/ceph/src/ceph.cc:244]: (style) Variable 'sent' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/ceph.cc:615]: (style) The scope of the variable cmd can be reduced
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.h:475]: (style) Member variable not initialized in the constructor 'Inode::auth_cap'
[/home/oem/Desktop/source_to_check/ceph/src/common/Cond.h:33]: (possible style) Member variable 'Cond::_c' is not assigned a value in 'Cond::operator='
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.h:171]: (style) The function 'MetaRequest::get_op' can be const
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.h:172]: (style) The function 'MetaRequest::get_tid' can be const
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.h:176]: (style) The function 'MetaRequest::is_write' can be const
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.h:599]: (style) The function 'Inode::caps_dirty' can be const
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.h:715]: (style) The function 'Fh::is_lazy' can be const
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.h:778]: (style) The function 'DirResult::at_end' can be const
[/home/oem/Desktop/source_to_check/ceph/src/msg/Message.h:283]: (style) The function 'Message::get_recv_stamp' can be const
[/home/oem/Desktop/source_to_check/ceph/src/msg/Message.h:298]: (style) The function 'Message::get_type' can be const
[/home/oem/Desktop/source_to_check/ceph/src/msg/Message.h:301]: (style) The function 'Message::get_tid' can be const
[/home/oem/Desktop/source_to_check/ceph/src/msg/Messenger.h:63]: (style) The function 'Messenger::get_myname' can be const
[/home/oem/Desktop/source_to_check/ceph/src/msg/Messenger.h:70]: (style) The function 'Messenger::get_default_send_priority' can be const
[/home/oem/Desktop/source_to_check/ceph/src/msg/SimpleMessenger.h:269]: (style) The function 'Pipe::get_out_seq' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mon/MonMap.h:43]: (style) The function 'MonMap::get_epoch' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/Cond.h:33]: (style) The function 'Cond::operator=' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/Thread.h:46]: (style) The function 'Thread::is_started' can be const
[/home/oem/Desktop/source_to_check/ceph/src/cfuse.cc:74]: (style) Upon exception there is memory leak: messenger
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.h:414]: (possible error) Memory leak: Inode::dir
[/home/oem/Desktop/source_to_check/ceph/src/msg/Messenger.h:67]: (style) Function parameter 'm' is passed by value. It could be passed by reference instead.
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.h:535]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.h:554]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.h:567]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.h:578]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.h:587]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/msg/Messenger.h:95]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/msg/Messenger.h:106]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/msg/Messenger.h:112]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/msg/Messenger.h:119]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/msg/Messenger.h:127]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/msg/Messenger.h:137]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/common/Timer.h:103]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/common/Timer.h:106]: (possible style) Pre-Incrementing variable 'sit' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/osd_types.h:1117]: (style) Member variable not initialized in the constructor 'SnapSet::head_exists'
[/home/oem/Desktop/source_to_check/ceph/src/messages/MMonObserveNotify.h:28]: (style) Member variable not initialized in the constructor 'MMonObserveNotify::is_latest'
[/home/oem/Desktop/source_to_check/ceph/src/osd/osd_types.h:350]: (style) The function 'eversion_t::ceph_eversion' can be const
[/home/oem/Desktop/source_to_check/ceph/src/osd/OSDMap.h:374]: (style) The function 'OSDMap::exists' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mds/MDSMap.h:182]: (style) The function 'MDSMap::get_max_filesize' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mds/MDSMap.h:231]: (style) The function 'MDSMap::get_mds_set' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mds/MDSMap.h:243]: (style) The function 'MDSMap::get_failed_mds_set' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mds/MDSMap.h:250]: (style) The function 'MDSMap::get_stopped_mds_set' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ceph.cc:294]: (style) Upon exception there is memory leak: m
[/home/oem/Desktop/source_to_check/ceph/src/osd/osd_types.h:396]: (style) Function parameter 'e' is passed by value. It could be passed by reference instead.
[/home/oem/Desktop/source_to_check/ceph/src/mon/PGMap.h:113]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/mon/PGMap.h:123]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/mon/PGMap.h:228]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/mon/PGMap.h:249]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/mon/PGMap.h:272]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/osd_types.h:641]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/OSDMap.h:285]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/OSDMap.h:364]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/OSDMap.h:368]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/OSDMap.h:477]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/OSDMap.h:484]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/OSDMap.h:490]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/OSDMap.h:497]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/OSDMap.h:503]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/OSDMap.h:511]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/OSDMap.h:527]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/OSDMap.h:531]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/OSDMap.h:536]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/OSDMap.h:540]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/OSDMap.h:549]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/OSDMap.h:553]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/OSDMap.h:639]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/mds/MDSMap.h:222]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/mds/MDSMap.h:236]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/mds/MDSMap.h:256]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/mds/MDSMap.h:263]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/mds/MDSMap.h:280]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/mds/MDSMap.h:291]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/include/LogEntry.h:100]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/ceph.cc:317]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/mds/MDSMap.h:247]: (possible style) Use failed.empty() instead of failed.size() to guarantee fast code.
[/home/oem/Desktop/source_to_check/ceph/src/ceph.cc:383]: (possible style) Use pending_cmd.empty() instead of pending_cmd.size() to guarantee fast code.
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:100]: (style) C-style pointer casting
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:313]: (style) C-style pointer casting
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:1258]: (style) C-style pointer casting
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:1261]: (style) C-style pointer casting
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:1266]: (style) C-style pointer casting
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:1273]: (style) C-style pointer casting
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:1276]: (style) C-style pointer casting
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:1279]: (style) C-style pointer casting
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:1991]: (style) C-style pointer casting
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:814]: (style) Variable 'nojournal' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:1308]: (style) Variable 'frommds' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:2131]: (style) Variable 'trimmed' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:2631]: (style) Variable 'kick_writers' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:4583]: (style) Upon exception there is memory leak: onfinish
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:3675]: (error) Resource leak: r
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:183]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:223]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:238]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:796]: (possible style) Pre-Incrementing variable 'q' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:1328]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:1371]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:1606]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:1910]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:1945]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:2187]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:2275]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:2333]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:2388]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:2413]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:2427]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:2516]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:2933]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:2962]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:5135]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:5142]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/Client.cc:5898]: (possible style) Use osds.empty() instead of osds.size() to guarantee fast code.
[/home/oem/Desktop/source_to_check/ceph/src/client/SyntheticClient.cc:283]: (style) C-style pointer casting
[/home/oem/Desktop/source_to_check/ceph/src/client/SyntheticClient.cc:622]: (style) The scope of the variable sarg1 can be reduced
[/home/oem/Desktop/source_to_check/ceph/src/client/Trace.h:42]: (style) Member variable not initialized in the constructor 'Trace::_line'
[/home/oem/Desktop/source_to_check/ceph/src/client/SyntheticClient.cc:258]: (style) Member variable not initialized in the constructor 'SyntheticClient::sub_s'
[/home/oem/Desktop/source_to_check/ceph/src/client/Trace.h:47]: (style) The function 'Trace::get_line' can be const
[/home/oem/Desktop/source_to_check/ceph/src/client/SyntheticClient.h:216]: (style) The function 'SyntheticClient::compose_path' can be const
[/home/oem/Desktop/source_to_check/ceph/src/client/SyntheticClient.cc:322]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/SyntheticClient.cc:1436]: (possible style) Pre-Incrementing variable 'fi' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/SyntheticClient.cc:1442]: (possible style) Pre-Incrementing variable 'fi' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/SyntheticClient.cc:1448]: (possible style) Pre-Incrementing variable 'fi' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/SyntheticClient.cc:1454]: (possible style) Pre-Incrementing variable 'fi' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/SyntheticClient.cc:1476]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/SyntheticClient.cc:1535]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/SyntheticClient.cc:1594]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/SyntheticClient.cc:2779]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/SyntheticClient.cc:2650]: (possible style) Use subdirs.empty() instead of subdirs.size() to guarantee fast code.
[/home/oem/Desktop/source_to_check/ceph/src/client/Trace.cc:41]: (style) Upon exception fs becomes a dead pointer
[/home/oem/Desktop/source_to_check/ceph/src/client/hadoop/CephFSInterface.cc:97]: (error) Mismatching allocation and deallocation: path
[/home/oem/Desktop/source_to_check/ceph/src/client/hadoop/CephFSInterface.cc:98]: (error) Mismatching allocation and deallocation: path
[/home/oem/Desktop/source_to_check/ceph/src/client/hadoop/CephFSInterface.cc:102]: (error) Mismatching allocation and deallocation: path
[/home/oem/Desktop/source_to_check/ceph/src/client/hadoop/CephFSInterface.cc:352]: (error) Mismatching allocation and deallocation: buf
[/home/oem/Desktop/source_to_check/ceph/src/client/hadoop/CephFSInterface.cc:354]: (error) Mismatching allocation and deallocation: buf
[/home/oem/Desktop/source_to_check/ceph/src/client/hadoop/CephFSInterface.cc:370]: (error) Mismatching allocation and deallocation: buf
[/home/oem/Desktop/source_to_check/ceph/src/client/hadoop/CephFSInterface.cc:684]: (error) Mismatching allocation and deallocation: address
[/home/oem/Desktop/source_to_check/ceph/src/client/hadoop/CephFSInterface.cc:686]: (error) Mismatching allocation and deallocation: address
[/home/oem/Desktop/source_to_check/ceph/src/client/hadoop/CephFSInterface.cc:694]: (error) Mismatching allocation and deallocation: address
[/home/oem/Desktop/source_to_check/ceph/src/client/hadoop/CephFSInterface.cc:388]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/client/hypertable/CephBroker.h:51]: (style) C-style pointer casting
[/home/oem/Desktop/source_to_check/ceph/src/client/hypertable/CephBroker.cc:409]: (error) Mismatching allocation and deallocation: buf
[/home/oem/Desktop/source_to_check/ceph/src/client/hypertable/CephBroker.cc:411]: (error) Mismatching allocation and deallocation: buf
[/home/oem/Desktop/source_to_check/ceph/src/client/hypertable/CephBroker.cc:426]: (error) Mismatching allocation and deallocation: buf
[/home/oem/Desktop/source_to_check/ceph/src/client/test_ioctls.c:64]: (error) Resource leak: fd
[/home/oem/Desktop/source_to_check/ceph/src/cls_acl.cc:25]: (style) Unused variable: i
[/home/oem/Desktop/source_to_check/ceph/src/cls_acl.cc:40]: (style) Unused variable: i
[/home/oem/Desktop/source_to_check/ceph/src/cls_crypto.cc:26]: (style) Unused variable: i
[/home/oem/Desktop/source_to_check/ceph/src/cls_crypto.cc:50]: (style) Unused variable: i
[/home/oem/Desktop/source_to_check/ceph/src/mds/mdstypes.h:803]: (style) The class 'inode_load_vec_t' has no constructor. Member variables not initialized.
[/home/oem/Desktop/source_to_check/ceph/src/mds/mdstypes.h:380]: (style) The function 'inode_t::get_layout_size_increment' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mds/mdstypes.h:1191]: (style) The function 'MDSCacheObject::get_num_ref' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mds/mdstypes.h:1244]: (style) The function 'MDSCacheObject::print_pin_set' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mds/mdstypes.h:1316]: (style) The function 'MDSCacheObject::get_replica_nonce' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mds/Capability.h:143]: (style) The function 'Capability::pending' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mds/Capability.h:144]: (style) The function 'Capability::issued' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mds/Capability.h:250]: (style) The function 'Capability::get_mseq' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mds/Capability.h:252]: (style) The function 'Capability::get_last_sent' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mds/Capability.h:253]: (style) The function 'Capability::get_last_issue_stamp' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mds/Capability.h:259]: (style) The function 'Capability::get_cap_id' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mds/Capability.h:263]: (style) The function 'Capability::is_suppress' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mds/Capability.h:267]: (style) The function 'Capability::is_stale' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mds/Capability.h:271]: (style) The function 'Capability::get_client' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mds/Capability.h:274]: (style) The function 'Capability::wanted' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mds/Capability.h:280]: (style) The function 'Capability::get_last_seq' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mds/Capability.h:281]: (style) The function 'Capability::get_last_issue' can be const
[/home/oem/Desktop/source_to_check/ceph/src/cmds.cc:112]: (possible error) Memory leak: mds
[/home/oem/Desktop/source_to_check/ceph/src/mds/mdstypes.h:768]: (style) Function parameter 'df' is passed by value. It could be passed by reference instead.
[/home/oem/Desktop/source_to_check/ceph/src/mds/SessionMap.h:258]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/mds/SessionMap.h:265]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/mon/Paxos.h:228]: (style) Member variable not initialized in the constructor 'Paxos::num_last'
[/home/oem/Desktop/source_to_check/ceph/src/mon/Session.h:34]: (style) Member variable not initialized in the constructor 'Subscription::onetime'
[/home/oem/Desktop/source_to_check/ceph/src/mon/MonitorStore.h:29]: (style) Member variable not initialized in the constructor 'MonitorStore::lock_fd'
[/home/oem/Desktop/source_to_check/ceph/src/mon/Paxos.h:103]: (style) The function 'Paxos::is_recovering' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mon/Paxos.h:104]: (style) The function 'Paxos::is_active' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mon/Paxos.h:105]: (style) The function 'Paxos::is_updating' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mon/Paxos.h:259]: (style) The function 'Paxos::get_version' can be const
[/home/oem/Desktop/source_to_check/ceph/src/mon/MonCaps.h:46]: (style) The function 'MonCaps::get_str' can be const
[/home/oem/Desktop/source_to_check/ceph/src/include/CompatSet.h:71]: (style) The function 'CompatSet::readable' can be const
[/home/oem/Desktop/source_to_check/ceph/src/cmon.cc:175]: (possible error) Memory leak: messenger
[/home/oem/Desktop/source_to_check/ceph/src/mon/Session.h:76]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/common/ClassHandler.h:36]: (style) Member variable not initialized in the constructor 'ClassMethod::flags'
[/home/oem/Desktop/source_to_check/ceph/src/common/ClassHandler.h:68]: (style) Member variable not initialized in the constructor 'ClassData::handler'
[/home/oem/Desktop/source_to_check/ceph/src/common/ClassHandler.h:68]: (style) Member variable not initialized in the constructor 'ClassData::osd'
[/home/oem/Desktop/source_to_check/ceph/src/common/ClassHandler.h:69]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/common/ClassHandler.cc:112]: (style) Unreachable code below a 'return'
[/home/oem/Desktop/source_to_check/ceph/src/common/ClassHandler.cc:30]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/common/ClassHandler.cc:163]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:213]: (style) Variable 'last_delim' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:216]: (style) The scope of the variable last_delim can be reduced
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:59]: (style) The function 'ConfSection::get_name' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:956] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:97]: (style) The function 'ConfFile::read' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:956] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:98]: (style) The function 'ConfFile::read' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:961] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:99]: (style) The function 'ConfFile::read' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:967] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:99]: (style) The function 'ConfFile::read' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:961] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:100]: (style) The function 'ConfFile::read' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:967] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:100]: (style) The function 'ConfFile::read' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:973] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:101]: (style) The function 'ConfFile::read' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:978] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:102]: (style) The function 'ConfFile::read' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:983] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:103]: (style) The function 'ConfFile::read' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:988] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:104]: (style) The function 'ConfFile::read' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:993] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:106]: (style) The function 'ConfFile::write' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:998] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:106]: (style) The function 'ConfFile::write' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:993] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:107]: (style) The function 'ConfFile::write' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:998] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:107]: (style) The function 'ConfFile::write' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:1003] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:108]: (style) The function 'ConfFile::write' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:1008] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:108]: (style) The function 'ConfFile::write' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:1003] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:109]: (style) The function 'ConfFile::write' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:1008] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:109]: (style) The function 'ConfFile::write' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:1013] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:110]: (style) The function 'ConfFile::write' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:1018] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:111]: (style) The function 'ConfFile::write' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:1023] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:112]: (style) The function 'ConfFile::write' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:1028] -> [/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.h:113]: (style) The function 'ConfFile::write' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:605]: (error) Memory leak: line
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:301]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:312]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:460]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:462]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:464]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:466]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:468]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/common/ConfUtils.cc:470]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/common/MemoryModel.h:30]: (style) The function 'MemoryModel::snap::get_total' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/MemoryModel.h:31]: (style) The function 'MemoryModel::MemoryModel::snap::get_rss' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/MemoryModel.h:32]: (style) The function 'MemoryModel::MemoryModel::MemoryModel::snap::get_heap' can be const
[/home/oem/Desktop/source_to_check/ceph/src/common/Mutex.cc:115]: (error) Memory leak: bt
[/home/oem/Desktop/source_to_check/ceph/src/common/Mutex.cc:151]: (possible error) Memory leak: bt
[/home/oem/Desktop/source_to_check/ceph/src/common/Mutex.cc:101]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/common/Mutex.cc:130]: (possible style) Pre-Incrementing variable 'q' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/common/Timer.cc:82]: (possible style) Pre-Incrementing variable 'cit' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/common/Timer.cc:101]: (possible style) Pre-Incrementing variable 'cit' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/common/Timer.cc:195]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/common/Timer.cc:198]: (possible style) Pre-Incrementing variable 'q' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/common/WorkQueue.h:126]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/common/WorkQueue.cc:68]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/common/WorkQueue.cc:81]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/common/buffer.cc:83]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/common/cas.cc:21]: (style) Variable 'err' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/common/debug.cc:45]: (possible error) Dangerous usage of strncat. Tip: the 3rd parameter means maximum number of characters to append
[/home/oem/Desktop/source_to_check/ceph/src/common/debug.cc:56]: (possible error) Dangerous usage of strncat. Tip: the 3rd parameter means maximum number of characters to append
[/home/oem/Desktop/source_to_check/ceph/src/common/lockdep.cc:154]: (error) Memory leak: bt
[/home/oem/Desktop/source_to_check/ceph/src/common/lockdep.cc:190]: (possible error) Memory leak: bt
[/home/oem/Desktop/source_to_check/ceph/src/common/lockdep.cc:58]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/common/lockdep.cc:62]: (possible style) Pre-Incrementing variable 'q' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/common/lockdep.cc:140]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/common/lockdep.cc:169]: (possible style) Pre-Incrementing variable 'q' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/config.cc:1038]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/PG.h:826]: (style) The function 'PG::get_log_write_pos' can be const
[/home/oem/Desktop/source_to_check/ceph/src/osd/PG.h:445]: (style) The function 'PG::OndiskLog::length' can be const
[/home/oem/Desktop/source_to_check/ceph/src/cosd.cc:136]: (style) Upon exception there is memory leak: messenger
[/home/oem/Desktop/source_to_check/ceph/src/cosd.cc:152]: (possible error) Memory leak: messenger
[/home/oem/Desktop/source_to_check/ceph/src/cosd.cc:149]: (possible error) Memory leak: messenger_hb
[/home/oem/Desktop/source_to_check/ceph/src/cosd.cc:165]: (possible error) Memory leak: osd
[/home/oem/Desktop/source_to_check/ceph/src/osd/PG.h:375]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/PG.h:587]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osd/OSD.h:481]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/crush.h:358]: (style) C-style pointer casting
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/bucket_movement.cc:14]: (style) Variable 'bad' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/Bucket.h:54]: (style) Member variable not initialized in the constructor 'Bucket::weight'
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/Bucket.h:54]: (style) Member variable not initialized in the constructor 'Bucket::type'
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/Bucket.h:54]: (style) Member variable not initialized in the constructor 'Bucket::parent'
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/Bucket.h:54]: (style) Member variable not initialized in the constructor 'Bucket::id'
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/Bucket.h:135]: (style) Member variable not initialized in the constructor 'UniformBucket::item_weight'
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/Hash.h:36]: (style) The function 'Hash::get_seed' can be const
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/Bucket.h:247]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/Bucket.h:380]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/Bucket.h:476]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/Bucket.h:512]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/Bucket.h:541]: (possible style) Pre-Incrementing variable 's' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/crush.h:126]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/crush.h:144]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/crush.h:212]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/crush.h:453]: (possible style) Pre-Incrementing variable 'pc' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/crush.h:505]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/cluster_movement.cc:61]: (style) Variable 'bad' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/cluster_movement_remove.cc:195]: (style) Variable 'ndisks' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/cluster_movement_rush.cc:61]: (style) Variable 'bad' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/creeping_failure.cc:54]: (style) Variable 'adjustsum' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/creeping_failure.cc:54]: (style) Variable 'afteroverloadsum' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/creeping_failure.cc:54]: (style) Variable 'chooses' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/creeping_failure.cc:54]: (style) Variable 'overloadsum' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/creeping_failure.cc:54]: (style) Variable 'pg_med' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/creeping_failure.cc:270]: (style) Variable 'var' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/creeping_failure_variance.cc:275]: (style) Variable 'var' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/depth_variance.cc:47]: (style) Variable 'bad' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/depth_variance.cc:179]: (style) Variable 'var' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/mixed.cc:50]: (style) Variable 'bad' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/mixed.cc:50]: (style) Variable 'chooses' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/mixed.cc:293]: (style) Variable 'var' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/movement.cc:202]: (style) Variable 'ndisks' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/movement_failed.cc:88]: (style) Variable 'olddisks' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/movement_failed.cc:225]: (style) Variable 'n' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/movement_failed.cc:225]: (style) Variable 'ndisks' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/movement_failed.cc:193]: (possible style) Pre-Incrementing variable 'it' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/overload.cc:54]: (style) Variable 'chooses' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/overload.cc:54]: (style) Variable 'pg_med' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/overload.cc:322]: (style) Variable 'var' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/overload_variance.cc:275]: (style) Variable 'var' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/crush.old/test/t.cc:24]: (possible error) Memory leak: b
[/home/oem/Desktop/source_to_check/ceph/src/crush/builder.c:54]: (style) The scope of the variable oldsize can be reduced
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:74]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:75]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:76]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:81]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:82]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:83]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:84]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:85]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:90]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:91]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:96]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:97]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:98]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:99]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:100]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:136]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:143]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:146]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:147]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crush/crush.c:148]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/crushtool.cc:682]: (style) Variable 'clobber' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/csyn.cc:70]: (style) Upon exception there is memory leak: client
[/home/oem/Desktop/source_to_check/ceph/src/csyn.cc:77]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/dumpjournal.cc:54]: (style) C-style pointer casting
[/home/oem/Desktop/source_to_check/ceph/src/dumpjournal.cc:57]: (style) C-style pointer casting
[/home/oem/Desktop/source_to_check/ceph/src/osdc/Journaler.h:188]: (style) The function 'Journaler::_is_reading' can be const
[/home/oem/Desktop/source_to_check/ceph/src/osdc/Journaler.h:240]: (style) The function 'Journaler::is_active' can be const
[/home/oem/Desktop/source_to_check/ceph/src/osdc/Journaler.h:241]: (style) The function 'Journaler::get_error' can be const
[/home/oem/Desktop/source_to_check/ceph/src/osdc/Objecter.h:476]: (style) Upon exception there is memory leak: fin
[/home/oem/Desktop/source_to_check/ceph/src/osdc/Objecter.h:732]: (possible error) Memory leak: g
[/home/oem/Desktop/source_to_check/ceph/src/osdc/Objecter.h:763]: (possible error) Memory leak: gack
[/home/oem/Desktop/source_to_check/ceph/src/osdc/Objecter.h:763]: (possible error) Memory leak: gcom
[/home/oem/Desktop/source_to_check/ceph/src/osdc/Filer.h:209]: (possible error) Memory leak: gack
[/home/oem/Desktop/source_to_check/ceph/src/osdc/Filer.h:209]: (possible error) Memory leak: gcom
[/home/oem/Desktop/source_to_check/ceph/src/osdc/Filer.h:239]: (possible error) Memory leak: gack
[/home/oem/Desktop/source_to_check/ceph/src/osdc/Filer.h:239]: (possible error) Memory leak: gcom
[/home/oem/Desktop/source_to_check/ceph/src/osdc/Filer.h:268]: (possible error) Memory leak: gack
[/home/oem/Desktop/source_to_check/ceph/src/osdc/Filer.h:268]: (possible error) Memory leak: gcom
[/home/oem/Desktop/source_to_check/ceph/src/osdc/Objecter.h:727]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osdc/Objecter.h:751]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osdc/Objecter.h:754]: (possible style) Pre-Incrementing variable 'bit' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osdc/Filer.h:200]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osdc/Filer.h:233]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/osdc/Filer.h:263]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/os/FileStore.h:100]: (style) Member variable not initialized in the constructor 'FileStore::snapdir_fd'
[/home/oem/Desktop/source_to_check/ceph/src/os/Fake.h:156]: (style) The function 'FakeAttrs::FakeAttrSet::getattrs' can be const
[/home/oem/Desktop/source_to_check/ceph/src/os/ObjectStore.h:137]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/os/JournalingObjectStore.h:113]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/os/Fake.h:41]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/os/Fake.h:111]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/dupstore.cc:55]: (possible style) Pre-Incrementing variable 'q' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/Table.h:883]: (error) Invalid number of character ({) when these macros are defined: ''.
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/Table.h:883]: (error) Invalid number of character ({) when these macros are defined: 'EBOFS_DEBUG_BTREE'.
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BlockDevice.cc:851]: (style) C-style pointer casting
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BlockDevice.cc:269]: (style) Variable 'r' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BlockDevice.cc:274]: (style) The scope of the variable bytes can be reduced
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/types.h:184]: (style) The function 'ebofs_super::is_valid_magic' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BlockDevice.cc:448]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BlockDevice.cc:467]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BlockDevice.cc:528]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BlockDevice.cc:655]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BlockDevice.cc:693]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.cc:166]: (style) The scope of the variable bad can be reduced
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.h:475]: (style) Member variable not initialized in the constructor 'BufferCache::poison_commit'
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.h:320]: (style) The function 'ObjectCache::get_object_id' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.h:487]: (style) The function 'BufferCache::get_trimmable' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.h:562]: (style) The function 'BufferCache::get_stat_tx' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.h:563]: (style) The function 'BufferCache::get_stat_rx' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.h:564]: (style) The function 'BufferCache::get_stat_dirty' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.h:565]: (style) The function 'BufferCache::get_stat_clean' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.h:566]: (style) The function 'BufferCache::get_stat_partial' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.h:573]: (style) The function 'BufferCache::get_unflushed' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.h:587]: (style) The function 'BufferCache::get_num_partials' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/Onode.h:112]: (style) Redundant condition. It is safe to deallocate a NULL pointer
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.h:194]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.h:229]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.h:250]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.h:431]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/Onode.h:512]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.cc:28]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.cc:248]: (possible style) Pre-Incrementing variable 'q' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.cc:292]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.cc:836]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.cc:956]: (possible style) Pre-Incrementing variable 'p' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/BufferCache.cc:607]: (possible style) Use exv.empty() instead of exv.size() to guarantee fast code.
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/Table.h:883]: (error) Invalid number of character ({) when these macros are defined: 'DARWIN'.
[/home/oem/Desktop/source_to_check/ceph/src/osd/OSDCaps.h:26] -> [/home/oem/Desktop/source_to_check/ceph/src/mon/MonCaps.h:28]: (style) Typedef 'rwx_t' hides typedef with same name
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/nodes.h:110]: (style) The function 'Node::size' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/nodes.h:111]: (style) The function 'Node::set_size' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/nodes.h:115]: (style) The function 'Node::set_type' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/nodes.h:116]: (style) The function 'Node::is_index' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/nodes.h:117]: (style) The function 'Node::is_leaf' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/nodes.h:121]: (style) The function 'Node::is_dirty' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/nodes.h:122]: (style) The function 'Node::is_clean' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/nodes.h:162]: (style) The function 'NodePool::make_nodeid' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/nodes.h:191]: (style) The function 'NodePool::get_num_free' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/nodes.h:192]: (style) The function 'NodePool::get_num_dirty' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/nodes.h:193]: (style) The function 'NodePool::get_num_limbo' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/nodes.h:194]: (style) The function 'NodePool::get_num_clean' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/nodes.h:195]: (style) The function 'NodePool::get_num_total' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/nodes.h:196]: (style) The function 'NodePool::get_num_used' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/nodes.h:453]: (style) The function 'NodePool::commit_finish' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/Table.h:44]: (style) The function 'Table<pobject_t,ebofs_inode_ptr>::get_root' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/Table.h:45]: (style) The function 'Table<pobject_t,ebofs_inode_ptr>::get_num_keys' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/Table.h:46]: (style) The function 'Table<pobject_t,ebofs_inode_ptr>::get_depth' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/Table.h:119]: (style) The function 'Table<pobject_t,ebofs_inode_ptr>::Nodeptr::init_index' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/Table.h:44]: (style) The function 'Table<uint64_t,uint64_t>::get_root' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/Table.h:45]: (style) The function 'Table<uint64_t,uint64_t>::get_num_keys' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/Table.h:46]: (style) The function 'Table<uint64_t,uint64_t>::get_depth' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/Table.h:119]: (style) The function 'Table<uint64_t,uint64_t>::Nodeptr::init_index' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/Table.h:44]: (style) The function 'Table<coll_t,ebofs_inode_ptr>::get_root' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/Table.h:45]: (style) The function 'Table<coll_t,ebofs_inode_ptr>::get_num_keys' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/Table.h:46]: (style) The function 'Table<coll_t,ebofs_inode_ptr>::get_depth' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/Table.h:119]: (style) The function 'Table<coll_t,ebofs_inode_ptr>::Nodeptr::init_index' can be const
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/Ebofs.h:90]: (possible error) Memory leak: Ebofs::journalfn
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/Cnode.h:79]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/ebofs/nodes.h:435]: (possible style) Pre-Incrementing variable 'i' is preferred to Post-Incrementing
[/home/oem/Desktop/source_to_check/ceph/src/fakefuse.cc:132]: (style) Upon exception there is memory leak: messenger
[/home/oem/Desktop/source_to_check/ceph/src/fakefuse.cc:138]: (possible error) Memory leak: messenger
[/home/oem/Desktop/source_to_check/ceph/src/mon/MonCaps.h:28] -> [/home/oem/Desktop/source_to_check/ceph/src/osd/OSDCaps.h:26]: (style) Typedef 'rwx_t' hides typedef with same name
[/home/oem/Desktop/source_to_check/ceph/src/fakesyn.cc:56]: (style) Variable 'start' is assigned a value that is never used
[/home/oem/Desktop/source_to_check/ceph/src/fakesyn.cc:132]: (style) Upon exception there is memory leak: messenger
[/home/oem/Desktop/source_to_check/ceph/src/fakesyn.cc:138]: (possible error) Memory leak: messenger

--========GMX30783126946133243323
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--========GMX30783126946133243323
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--========GMX30783126946133243323--
